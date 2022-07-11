import 'dart:async';
import 'dart:io';

import 'package:bpbd_jatim/components/app_card.dart';
import 'package:bpbd_jatim/components/app_grid.dart';
import 'package:bpbd_jatim/components/button.dart';
import 'package:bpbd_jatim/screens/admin/detail_disaster.dart';
import 'package:bpbd_jatim/screens/dashboard.dart';
import 'package:bpbd_jatim/screens/instansi/detail_disaster.dart';
import 'package:bpbd_jatim/screens/user/detail_disaster_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:bpbd_jatim/globals.dart' as globals;
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

double latitude = 0.0;
double longitude = 0.0;

class DisasterData extends StatefulWidget {
  const DisasterData({Key? key}) : super(key: key);

  @override
  State<DisasterData> createState() => _DisasterDataState();
}

class _DisasterDataState extends State<DisasterData> {
  Timestamp? birthDate;
  bool birthDateFilled = false; 
  DateTime selectedBirthDate = DateTime.now();
  String imageText = 'Foto Bencana';
  File? imageFile;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  final PanelController _pc = PanelController();

  final disasterNameController = TextEditingController();
  final addressController = TextEditingController();
  final dateController = TextEditingController();
  final timeHourController = TextEditingController();
  final descriptionController = TextEditingController();
  final statusController = TextEditingController();

  String disasterCategory = 'Pilih Kategori Bencana';

  List<List<String>> itemList = [];

  @override
  void initState() {
    latitude = 0.0;
    longitude = 0.0;
    super.initState();
  }

  @override
  void dispose() {
    disasterNameController.dispose();
    addressController.dispose();
    dateController.dispose();
    timeHourController.dispose();
    descriptionController.dispose();
    statusController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate (date) {      
      dynamic dateData = date;
      final birthDate = DateTime.fromMicrosecondsSinceEpoch(dateData.microsecondsSinceEpoch);
      String formattedDate = DateFormat('dd MMMM yyyy').format(birthDate);
      return formattedDate;
    }

    Future pickImage(ImageSource source) async {
      final pickedFile = await ImagePicker().pickImage(source: source);
      setState(() {
        if (pickedFile != null) {
          imageFile = File(pickedFile.path);
          imageText = basename(imageFile!.path);
        }
      });
      return imageFile;
    }

    Future uploadPhoto(File imageFile, DateTime date, String newDocumentId) async {
      String fileName = basename(imageFile.path);
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child(fileName + DateTime.now().toString());
      UploadTask uploadTask = ref.putFile(imageFile);
      await uploadTask.whenComplete(() {
        ref.getDownloadURL().then((fileUrl){
          firestore.collection('disasters').doc(newDocumentId).update({
            'disasterName': disasterNameController.text,
            'address': addressController.text,
            'latitude': latitude,
            'longitude': longitude,
            'date': Timestamp.fromDate(date),
            'timeHour': timeHourController.text,
            'description': descriptionController.text,
            'status': statusController.text,
            'disasterImage' : fileUrl,
            'disasterCategory' : disasterCategory,
            'donations' : [],
            'resourcesHelp' : [],
            'totalDonation' : 0
          })
          .then((value) {
            _pc.close();
            Navigator.push(context, MaterialPageRoute(builder: (_) => const Dashboard()));
          })
          .catchError((error) => print("Failed : $error"));
        });
      });
    }
    
    Future<void> createDisasterData() async {
      DateTime date = DateTime.parse(dateController.text);

      try {
        await firestore.collection('disasters').add({
          'disasterName': disasterNameController.text,
          'address': addressController.text,
          'latitude': latitude,
          'longitude': longitude,
          'date': Timestamp.fromDate(date),
          'timeHour': timeHourController.text,
          'description': descriptionController.text,
          'status': statusController.text,
          'disasterImage' : '',
          'disasterCategory' : disasterCategory,
          'donations' : [],
          'resourcesHelp' : [],
          'totalDonation' : 0
        })
        .then((value) => (uploadPhoto(imageFile!, date, value.id)))
        .catchError((error) => EasyLoading.showInfo("Failed"));
      } catch (_) {
        EasyLoading.showInfo('Failed');
        return;
      }
    }

    Future<bool> _requestPermission(Permission permission) async{
      if(await permission.isGranted) {
        return true;
      } else {
        var result = await permission.request();
        if(result == PermissionStatus.granted) {
          return true;
        } else {
          return false;
        }
      }
    }

    Future<void> downloadExcelFormat() async{
      QuerySnapshot allDisasterData = await firestore.collection('disasters').get();

      final xlsio.Workbook workbook = xlsio.Workbook();
      final xlsio.Worksheet sheet = workbook.worksheets[0];
      sheet.getRangeByName('A1').setText('No.');
      sheet.getRangeByName('B1').setText('Nama Bencana');
      sheet.getRangeByName('C1').setText('Kategori Bencana');
      sheet.getRangeByName('D1').setText('Alamat Bencana');
      sheet.getRangeByName('E1').setText('Tanggal Bencana');
      sheet.getRangeByName('F1').setText('Jam Bencana');
      sheet.getRangeByName('G1').setText('Deskripsi Bencana');
      sheet.getRangeByName('I1').setText('Total Donasi');
      sheet.getRangeByName('J1').setText('status');

      for (int i = 0; i < allDisasterData.docs.length; i++) {
        sheet.getRangeByName('A${i+2}').setText("${i+1}");
        sheet.getRangeByName('B${i+2}').setText(allDisasterData.docs[i]["disasterName"].toString());
        sheet.getRangeByName('C${i+2}').setText(allDisasterData.docs[i]["disasterCategory"].toString());
        sheet.getRangeByName('D${i+2}').setText(allDisasterData.docs[i]["address"].toString());
        sheet.getRangeByName('E${i+2}').setText(formattedDate(allDisasterData.docs[i]["date"]));
        sheet.getRangeByName('F${i+2}').setText(allDisasterData.docs[i]["timeHour"].toString());
        sheet.getRangeByName('G${i+2}').setText(allDisasterData.docs[i]["description"].toString());
        sheet.getRangeByName('I${i+2}').setText(allDisasterData.docs[i]["totalDonation"].toString());
        sheet.getRangeByName('J${i+2}').setText(allDisasterData.docs[i]["status"].toString());
      }  

      final List<int> bytes = workbook.saveAsStream();
      workbook.dispose();

      Directory? directory;
      try {
        if(await _requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory();
          String newPath = "";
          List<String> folders = directory!.path.split("/");
          for(int x = 1; x < folders.length; x++) {
            String folder = folders[x];
            if(folder != "Android") {
              newPath += "/"+folder;
            } else {
              break;
            }
          }
          newPath = newPath+"/DataBencanaBPBDJatim";
          directory = Directory(newPath);
        } 

        if(!await directory!.exists()) {
          await directory.create(recursive: true);
        }
      } catch(e) {
        EasyLoading.showInfo('Failed');
      }

      final File file = File(directory!.path+"/data_bencana.xlsx");
      await file.writeAsBytes(bytes, flush: true).then((value) => {
        OpenFile.open(directory!.path+"/data_bencana.xlsx")
      });
    }

    void _onTap(String documentId) {
      if(globals.privilege == 'admin') {
        Navigator.push(context, MaterialPageRoute(builder: (_) => DetailDisaster(documentId: documentId)));
      } else if (globals.privilege == 'user') {
        Navigator.push(context, MaterialPageRoute(builder: (_) => DetailDisasterUser(documentId: documentId)));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (_) => DetailDisasterInstansi(documentId: documentId)));
      }
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 16),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => {
                          Navigator.pop(context)
                        },
                        child: SvgPicture.asset("assets/icons/back_black.svg"),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 16.0),
                        child: Text(
                          'Data Bencana',
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.surface),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 16),
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: 128,
                    height: 36,
                    child: OutlinedButton(
                      onPressed: () {
                        downloadExcelFormat();
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Download Data",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                                  color: Theme.of(context).colorScheme.surface,
                                  fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(28, 16, 28, 16),
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                          .collection('disasters')
                          .snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot>snapshot) {
                          if(snapshot.hasData) {
                            return AppGrid(
                              widgetList: List.generate(snapshot.data!.docs.length, (index) => 
                                AppCard(
                                  imageUrl: snapshot.data!.docs[index]["disasterImage"],
                                  title: snapshot.data!.docs[index]["disasterName"],
                                  street: snapshot.data!.docs[index]["address"],
                                  date: formattedDate(snapshot.data!.docs[index]["date"]),
                                  onTap: () {
                                    _onTap(snapshot.data!.docs[index].id);
                                  }
                                )
                              ),
                            );
                          }

                          return(const Text('Data Not Found'));
                        },
                      ),
                    )
                  ],
                )),
                Container(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
                  width: double.infinity,
                  child: Button(
                    press: () => _pc.open(),
                    text: "Tambah Data",
                  ),
                )
              ]),
            ),
          ),
          SlidingUpPanel(
            maxHeight: MediaQuery.of(context).size.height * 0.6,
            panel: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        height: 5,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFFC4C4C4),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 8),
                            child: InkWell(
                              onTap: () => _pc.close(),
                              child: Icon(
                                Icons.close,
                                color: Theme.of(context).colorScheme.surface,
                                size: 28,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              "Tambah Data Bencana",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.black26,
                    height: 20,
                    thickness: 2,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: ListView(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 18),
                            child: TextField(
                              style: const TextStyle(color: Colors.black),
                              controller: disasterNameController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor:
                                      const Color(0xFFC4C4C4).withOpacity(0.25),
                                  // prefixIcon: const Icon(Icons.star),
                                  // prefixIconColor: Colors.amber,
                                  hintText: "Nama Bencana"),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 18),
                            child: TextField(
                              style: const TextStyle(color: Colors.black),
                              controller: dateController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor:
                                      const Color(0xFFC4C4C4).withOpacity(0.25),
                                  hintText: "Tanggal Bencana (tahun-bulan-tanggal)"),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 18),
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              child: Row(
                                children: [
                                  Text(
                                    imageText,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(color: Color(0xff686868), fontSize: 16),
                                  ),
                                ],
                              ),
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        side: BorderSide(color: const Color(0xFFC4C4C4).withOpacity(0.25)))),
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
                                backgroundColor: MaterialStateProperty.all(const Color(0xFFC4C4C4).withOpacity(0.25)),
                                textStyle: MaterialStateProperty.all(
                                  const TextStyle(fontWeight: FontWeight.w400,),
                                )
                              ),
                              onPressed: () async{
                                await pickImage(ImageSource.gallery);
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 18),
                            child: TextField(
                              style: const TextStyle(color: Colors.black),
                              controller: timeHourController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor:
                                      const Color(0xFFC4C4C4).withOpacity(0.25),
                                  // prefixIcon: const Icon(Icons.star),
                                  // prefixIconColor: Colors.amber,
                                  hintText: "Waktu Bencana (Jam:Menit)"),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 18),
                            child: TextField(
                              style: const TextStyle(color: Colors.black),
                              controller: addressController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor:
                                      const Color(0xFFC4C4C4).withOpacity(0.25),
                                  // prefixIcon: const Icon(Icons.star),
                                  // prefixIconColor: Colors.amber,
                                  hintText: "Alamat Bencana"),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 18),
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              child: Row(
                                children:[
                                  Text(
                                    latitude == 0.0 ? 'Choose Location' : latitude.toString() + longitude.toString(),
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(color: Color(0xff686868), fontSize: 16),
                                  ),
                                ],
                              ),
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        side: BorderSide(color: const Color(0xFFC4C4C4).withOpacity(0.25)))),
                                padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
                                backgroundColor: MaterialStateProperty.all(const Color(0xFFC4C4C4).withOpacity(0.25)),
                                textStyle: MaterialStateProperty.all(
                                  const TextStyle(fontWeight: FontWeight.w400,),
                                )
                              ),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (_) => const PickLocation()));
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 18),
                            child: TextField(
                              autofocus: true,
                              style: const TextStyle(color: Colors.black),
                              controller: descriptionController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor:
                                      const Color(0xFFC4C4C4).withOpacity(0.25),
                                  // prefixIcon: const Icon(Icons.star),
                                  // prefixIconColor: Colors.amber,
                                  hintText: "Deskripsi"),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 18),
                            child: TextField(
                              style: const TextStyle(color: Colors.black),
                              controller: statusController,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor:
                                      const Color(0xFFC4C4C4).withOpacity(0.25),
                                  // prefixIcon: const Icon(Icons.star),
                                  // prefixIconColor: Colors.amber,
                                  hintText: "Status"),
                            ),
                          ),
                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                              .collection("disasterCategories")
                              .snapshots(),
                            builder: (context, AsyncSnapshot<QuerySnapshot>snapshot) {
                              if(snapshot.hasData) {
                                return DecoratedBox(
                                  decoration: BoxDecoration( 
                                    color:const Color(0xFFC4C4C4).withOpacity(0.25), 
                                    borderRadius: BorderRadius.circular(4), 
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 14.0),
                                    child: DropdownButton<String>(
                                      value: disasterCategory,
                                      style: const TextStyle(  
                                        color: Colors.black, 
                                        fontSize: 16
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          disasterCategory = newValue!;
                                        });
                                      },
                                      items: List.generate(snapshot.data!.docs.length, (index) => DropdownMenuItem(
                                          child: Text(snapshot.data!.docs[index]["categoryName"]),
                                          value: snapshot.data!.docs[index]["categoryName"],
                                      )),
                                    ),
                                  ),
                                );
                              }
                              return ( const Text('Data Not Found'));
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: SizedBox(
                              width: double.infinity,
                              child: Button(
                                press: () {
                                  createDisasterData();
                                },
                                text: "Tambah Data",
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            minHeight: 0,
            controller: _pc,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          ),
        ],
      ),
    );
  }
}

class PickLocation extends StatefulWidget {
  const PickLocation({ Key? key }) : super(key: key);

  @override
  State<PickLocation> createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _markers = {};

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(-7.248647582171617, 112.75179487496213),
    zoom: 14.4746,
  );

  void _onAddMarkerButtonPressed(LatLng latlang) {
    // loadAddress(latlang);
    // _latLng = latlang;
    setState(() {
      _markers.add(Marker(
        markerId: const MarkerId('_disasterLocation'),
        position: latlang,
        infoWindow: const InfoWindow(
          title: 'location that you choose',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
      latitude = latlang.latitude;
      longitude = latlang.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: _markers,
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onTap: (latlang){
          if(_markers.length>=1)
            {
              _markers.clear();
            }

          _onAddMarkerButtonPressed(latlang);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.orange,
        onPressed: () => {
          Navigator.pop(context)
        },
        label: const Text('Choose Location!'),
        icon: const Icon(Icons.location_on),
      ),
    );
  }
}