import 'package:bpbd_jatim/components/label.dart';
import 'package:bpbd_jatim/screens/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

class DetailDisaster extends StatefulWidget {
  final String documentId;

  const DetailDisaster({ Key? key, required this.documentId }) : super(key: key);

  @override
  State<DetailDisaster> createState() => _DetailDisasterState();
}

class _DetailDisasterState extends State<DetailDisaster> {
  String formattedDate (date) {      
    dynamic dateData = date;
    final birthDate = DateTime.fromMicrosecondsSinceEpoch(dateData.microsecondsSinceEpoch);
    String formattedDate = DateFormat('dd MMMM yyyy').format(birthDate);
    return formattedDate;
  }

  TextEditingController accountNameController = TextEditingController();
  TextEditingController personnelController = TextEditingController();
  TextEditingController totalPersonnelController = TextEditingController();
  String? accountName;
  String? personnel;
  String? totalPersonnel;
  String status = '';

  Future<void> createResourcesHelp() async {
    try {
      await firestore
        .collection('disasters')
        .doc(widget.documentId)
        .update({
          'resourcesHelp': FieldValue.arrayUnion([{
            'accountName': accountName,
            'personnel' : personnel,
            'totalPersonnel' : totalPersonnel
          }])
        }).then((value) => {
          getDocument()
        });
    } catch (_) {
      EasyLoading.showInfo('Failed');
      return;
    }
  }

  Future<void> createCategoryDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tambah Sumber Bantuan'),
          content: SizedBox(
            height: 150.0,
            child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      accountName = value;
                    });
                  },
                  style: const TextStyle(
                    color: Colors.black
                  ),
                  controller: accountNameController,
                  decoration: const InputDecoration(hintText: "Masukkan Instansi Pemberi Bantuan",),
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      personnel = value;
                    });
                  },
                  style: const TextStyle(
                    color: Colors.black
                  ),
                  controller: personnelController,
                  decoration: const InputDecoration(hintText: "Masukkan Bentuk Bantuan",),
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      totalPersonnel = value;
                    });
                  },
                  style: const TextStyle(
                    color: Colors.black
                  ),
                  controller: totalPersonnelController,
                  decoration: const InputDecoration(hintText: "Masukkan Jumlah Bentuk Bantuan",),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              color: Theme.of(context).colorScheme.secondaryContainer,
              textColor: Colors.white,
              child: const Text('Batalkan'),
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
              },
            ),
            FlatButton(
              color: Theme.of(context).colorScheme.primary,
              textColor: Colors.white,
              child: const Text('Masukkan'),
              onPressed: () {
                createResourcesHelp();
                Navigator.pop(context);
              },
            ),

          ],
        );
      });
  }

  Future<void> updateStatus(String currentStatus) async{
    currentStatus == 'Aktif' ? status = 'Tidak Aktif' : status = 'Aktif';
    try {
      await firestore
        .collection('disasters')
        .doc(widget.documentId)
        .update({
          'status': status
        });
    } catch (_) {
      EasyLoading.showInfo('Failed');
      return;
    }
  }

  Future<void> deleteDisaster(BuildContext context) async{
    try {
      await firestore
        .collection('disasters')
        .doc(widget.documentId)
        .delete()
        .then((value) => {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const Dashboard()))
        });
    } catch (_) {
      EasyLoading.showInfo('Failed');
      return;
    }
  }
  String disasterImage = '';
  String address = '';
  String date = '';
  String description = '';
  String disasterName = '';
  String timeHour = '';
  String totalDonation = '';
  List donations = [];
  List resourcesHelp = [];

  Future<void> getDocument() async{
    DocumentSnapshot disasterDocument = await firestore.collection("disasters").doc(widget.documentId).get();
    setState(() {
      disasterImage = (disasterDocument.data() as dynamic)['disasterImage']; 
      address = (disasterDocument.data() as dynamic)['address']; 
      date = formattedDate((disasterDocument.data() as dynamic)['date']); 
      description = (disasterDocument.data() as dynamic)['description']; 
      disasterName = (disasterDocument.data() as dynamic)['disasterName']; 
      status = (disasterDocument.data() as dynamic)['status']; 
      timeHour = (disasterDocument.data() as dynamic)['timeHour']; 
      totalDonation = (disasterDocument.data() as dynamic)['totalDonation'].toString(); 
      donations = (disasterDocument.data() as dynamic)['donations']; 
      resourcesHelp = (disasterDocument.data() as dynamic)['resourcesHelp']; 
    });
  }

  @override
  void initState() {
    getDocument();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: firestore
          .collection('disasters')
          .doc(widget.documentId)
          .snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return Stack(
              children: [
                DetailImage(imageUrl: disasterImage,),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height *.65,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)
                      ),
                      color: Color.fromARGB(255, 255, 255, 255)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ListView(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(disasterName, style: Theme.of(context).textTheme.headline5,),
                              PopupMenuButton(
                                color: const Color.fromARGB(255, 253, 13, 13),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15.0))
                                ),
                                itemBuilder: (_) => [
                                  PopupMenuItem(
                                    onTap: () {
                                      deleteDisaster(context);
                                    },
                                    child: Row(
                                      children: const [
                                        Icon(Icons.delete, color: Colors.white,),
                                        Text(' Delete')
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(address, style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Theme.of(context).colorScheme.secondary)),
                          const SizedBox(height: 30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Deskripsi', style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Theme.of(context).colorScheme.secondary)),
                              InkWell(
                                onTap: () {
                                  updateStatus(status);
                                  // updateStatus((snapshot.data as dynamic)['status']);
                                },
                                child: Label(text: status,),
                              )
                            ],
                          ),
                          const SizedBox(height: 20,),
                          Text(description, textAlign: TextAlign.justify,),
                          const SizedBox(height: 15,),
                          Row(
                            children: [
                              Icon(
                                Icons.date_range,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              const SizedBox(width: 10,),
                              Text(
                                date,
                                style: const TextStyle(color: Colors.black, fontSize: 15),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              const SizedBox(width: 10,),
                              Text(
                                timeHour + ' WIB',
                                style: const TextStyle(color: Colors.black, fontSize: 15),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Sumber Bantuan', style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Theme.of(context).colorScheme.secondary)),
                              InkWell(
                                onTap: () {
                                  createCategoryDialog(context);
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add_circle_outline,
                                      size: 16,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Tambah Data',
                                      style: Theme.of(context).textTheme.caption?.copyWith(
                                            color: Theme.of(context).colorScheme.primary,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          resourcesHelp.length > 0 ?
                          Column(
                            children: List.generate(resourcesHelp.length, (index) => SumberBantuan(
                              documentId: widget.documentId,
                              accountName: resourcesHelp[index]['accountName'],
                              personnel: resourcesHelp[index]['personnel'],
                              totalPersonnel: resourcesHelp[index]['totalPersonnel'],
                            ))
                          ) : (
                            Text('Data tidak ditemukan', textAlign: TextAlign.center, style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Theme.of(context).colorScheme.secondary))
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Donasi Pengguna', style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Theme.of(context).colorScheme.secondary)),
                              Text('Rp.' + totalDonation, style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Theme.of(context).colorScheme.primary)),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Column(
                            children: List.generate(donations.length, (index) => DonasiPengguna(
                              documentId: donations[index],
                            )),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          }
          return (const Text('Data tidak ditemukan'));
        },
      ),
    );
  }
}

class DetailImage extends StatelessWidget {
  final String? imageUrl;

  const DetailImage({ Key? key, this.imageUrl }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 270,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(imageUrl!),
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: SvgPicture.asset(
                        "assets/icons/back_black.svg",
                        height: 30,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}


class SumberBantuan extends StatefulWidget {
  final String? documentId;
  final String? accountName;
  final String? personnel;
  final String? totalPersonnel;

  const SumberBantuan({ 
    Key? key, 
    this.documentId,
    this.accountName, 
    this.personnel, 
    this.totalPersonnel 
  }) : super(key: key);

  @override
  State<SumberBantuan> createState() => _SumberBantuanState();
}

class _SumberBantuanState extends State<SumberBantuan> {
  TextEditingController editAccountNameController = TextEditingController();
  TextEditingController editPersonnelController = TextEditingController();
  TextEditingController editTotalPersonnelController = TextEditingController();
  String? editAccountName;
  String? editPersonnel;
  String? editTotalPersonnel;

  @override
  void initState() {
    editAccountNameController.text = widget.accountName!;
    editPersonnelController.text = widget.personnel!;
    editTotalPersonnelController.text = widget.totalPersonnel!;
    super.initState();
  }

  Future<void> deleteResourcesHelp() async {
    try {
      await firestore
        .collection('disasters')
        .doc(widget.documentId)
        .update({
          'resourcesHelp': FieldValue.arrayRemove([
            {
              'accountName': widget.accountName,
              'personnel' : widget.personnel,
              'totalPersonnel' : widget.totalPersonnel
            }
          ])
        }).then((value) => {
          Navigator.pop(context)
        });
    } catch (_) {
      EasyLoading.showInfo('Failed');
      return;
    }
  }

  Future<void> updateResourcesHelp() async {
    try {
      await firestore
        .collection('disasters')
        .doc(widget.documentId)
        .update({
          'resourcesHelp': FieldValue.arrayUnion([{
            'accountName': editAccountNameController.text,
            'personnel' : editPersonnelController.text,
            'totalPersonnel' : editTotalPersonnelController.text
          }])
        }).then((value) => {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const Dashboard()))
        });
    } catch (_) {
      EasyLoading.showInfo('Failed');
      return;
    }
  }

  Future<void> updateResourcesDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ubah Sumber Bantuan'),
          content: SizedBox(
            height: 150.0,
            child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      editAccountName = value;
                    });
                  },
                  style: const TextStyle(
                    color: Colors.black
                  ),
                  controller: editAccountNameController,
                  decoration: const InputDecoration(hintText: "Masukkan Instansi Pemberi Bantuan",),
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      editPersonnel = value;
                    });
                  },
                  style: const TextStyle(
                    color: Colors.black
                  ),
                  controller: editPersonnelController,
                  decoration: const InputDecoration(hintText: "Masukkan Bentuk Bantuan",),
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      editTotalPersonnel = value;
                    });
                  },
                  style: const TextStyle(
                    color: Colors.black
                  ),
                  controller: editTotalPersonnelController,
                  decoration: const InputDecoration(hintText: "Masukkan Jumlah Bentuk Bantuan",),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              color: Theme.of(context).colorScheme.secondaryContainer,
              textColor: Colors.white,
              child: const Text('Batalkan'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            FlatButton(
              color: Theme.of(context).colorScheme.primary,
              textColor: Colors.white,
              child: const Text('Simpan'),
              onPressed: () {
                deleteResourcesHelp();
                updateResourcesHelp();
                Navigator.pop(context);
              },
            ),

          ],
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              updateResourcesDialog(context);
            },
            backgroundColor:const Color.fromARGB(255, 8, 214, 241),
            foregroundColor: Colors.white,
            icon: Icons.mode_edit_outlined,
          ),
          SlidableAction(
            onPressed: (context) {
              deleteResourcesHelp();
            },
            backgroundColor: const Color.fromARGB(255, 246, 94, 109),
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.only(top: 10.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                widget.accountName!,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: Theme.of(context).colorScheme.surface),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                widget.personnel! + ' : ' + widget.totalPersonnel! + ' personil',
                style: Theme.of(context).textTheme.caption?.copyWith(
                    color: Theme.of(context).colorScheme.secondary),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: const Divider(
                color: Color.fromARGB(123, 143, 149, 157),
                thickness: 1,
                height: 0,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DonasiPengguna extends StatelessWidget {
  final String? documentId;

  const DonasiPengguna({ Key? key, this.documentId }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.15))
      ),
      padding: const EdgeInsets.all(10.0),
      child: StreamBuilder(
        stream: firestore
          .collection('donations')
          .doc(documentId)
          .snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    (snapshot.data as dynamic)['accountName'],
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                        color: Theme.of(context).colorScheme.surface),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Rp.' + (snapshot.data as dynamic)['donationAmount'].toString(),
                        style: Theme.of(context).textTheme.caption?.copyWith(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
          return const Text('Data tidak ditemukan');
        },
      ),
    );
  }
}