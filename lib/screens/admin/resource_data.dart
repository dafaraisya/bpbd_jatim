import 'dart:io';

import 'package:bpbd_jatim/components/button.dart';
import 'package:bpbd_jatim/screens/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:path/path.dart';

class ResourceData extends StatefulWidget {
  const ResourceData({Key? key}) : super(key: key);

  @override
  State<ResourceData> createState() => _ResourceDataState();
}

class _ResourceDataState extends State<ResourceData> {
  final PanelController _pc1 = PanelController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  String imageText = 'Upload Gambar';
  File? imageFile;
  
  TextEditingController resourcesNameController = TextEditingController();
  TextEditingController resourcesStatusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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

    Future uploadPhoto(File imageFile, String newDocumentId) async {
      String fileName = basename(imageFile.path);
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child(fileName + DateTime.now().toString());
      UploadTask uploadTask = ref.putFile(imageFile);
      await uploadTask.whenComplete(() {
        ref.getDownloadURL().then((fileUrl){
          firestore.collection('resources').doc(newDocumentId).update({
            'resourcesName': resourcesNameController.text,
            'resourcesImage': fileUrl,
            'status': resourcesStatusController.text
          })
          .then((value) {
            _pc1.close();
            Navigator.push(context, MaterialPageRoute(builder: (_) => const Dashboard()));
          })
          .catchError((error) => print("Failed : $error"));
        });
      });
    }

    Future<void> createResourcesData() async {
      try {
        await firestore.collection('resources').add({
          'resourcesName': resourcesNameController.text,
          'resourcesImage': '',
          'status': resourcesStatusController.text,
        })
        .then((value) => (uploadPhoto(imageFile!, value.id)))
        .catchError((error) => print("Failed : $error"));
      } catch (_) {
        EasyLoading.showInfo('Failed');
        return;
      }
    }

    void _onDownloadButtonPressed() {}
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                            'Data sumber daya',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.surface),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      width: 148,
                      height: 36,
                      child: OutlinedButton(
                        onPressed: _onDownloadButtonPressed,
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
                                    color:
                                        Theme.of(context).colorScheme.surface),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                        .collection('resources')
                        .snapshots(),
                      builder: (context, AsyncSnapshot<QuerySnapshot>snapshot) {
                        if(snapshot.hasData) {
                          return ListView(
                            children: List.generate(snapshot.data!.docs.length, (index) => ResourceCard(
                              assetPath: snapshot.data!.docs[index]['resourcesImage'],
                              resourcesName: snapshot.data!.docs[index]['resourcesName'],
                            )),
                          );
                        }
                        return const Text('Data tidak ditemukan');
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Button(
                      text: 'Tambah data',
                      press: () => _pc1.open(),
                    ),
                  ),
                ],
              ),
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
                              onTap: () => _pc1.close(),
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
                              "Tambah Sumber Daya",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.black26,
                    height: 32,
                    thickness: 2,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 18),
                          child: TextField(
                            controller: resourcesNameController,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 18),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor:
                                  const Color(0xFFC4C4C4).withOpacity(0.25),
                              hintText: "Nama Sumber Daya"),
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
                            controller: resourcesStatusController,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 18),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor:
                                  const Color(0xFFC4C4C4).withOpacity(0.25),
                              hintText: "Status"),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Button(
                            press: () {
                              createResourcesData();
                            },
                            text: "Tambah Data",
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            minHeight: 0,
            controller: _pc1,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          ),
        ],
      ),
    );
  }
}

class ResourceCard extends StatelessWidget {
  const ResourceCard({Key? key, required this.assetPath, required this.resourcesName}) : super(key: key);

  final String assetPath;
  final String resourcesName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 47,
                  width: 44,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(assetPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      resourcesName,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Aktif',
                      style: Theme.of(context).textTheme.caption?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            const CustomSwitch(),
          ],
        ),
      ),
    );
  }
}

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({Key? key}) : super(key: key);

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool status = false;

  @override
  Widget build(BuildContext context) {
    return FlutterSwitch(
      width: 32.0,
      height: 15.0,
      toggleSize: 11.0,
      activeToggleColor: Theme.of(context).colorScheme.primary,
      activeColor: const Color(0xFFD5DBE1),
      inactiveColor: const Color(0xFFD5DBE1),
      value: status,
      borderRadius: 30.0,
      padding: 3.0,
      onToggle: (val) {
        setState(() {
          status = val;
        });
      },
    );
  }
}
