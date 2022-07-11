import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:bpbd_jatim/components/button.dart';
import 'package:bpbd_jatim/screens/user/donation/finalization.dart';
import 'package:bpbd_jatim/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Confirmation extends StatefulWidget {
  final String? disasterId;
  final String? disasterName;
  final int? donationAmount;
  final String? note;

  const Confirmation({
    Key? key, 
    this.disasterId,
    this.disasterName,
    this.donationAmount,
    this.note
  }) : super(key: key);

  @override
  State<Confirmation> createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  User? user;
  String imageText = 'Klik untuk Upload Bukti Pembayaran';
  File? imageFile;

  getSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    user = User.fromJson(jsonDecode(preferences.getString('user')!));
  }

  @override
   void initState() {
    getSharedPreferences();
    getDisasterData();
    super.initState();
  }

  Map<String, dynamic>? dataDisaster;

  Future<void> getDisasterData() async {
    final docRef = FirebaseFirestore.instance.collection("disasters").doc(widget.disasterId);
    docRef.get().then(
      (DocumentSnapshot doc) {
        dataDisaster = doc.data() as Map<String, dynamic>;
      },
      onError: (e) => EasyLoading.showInfo(e),
    );
  }

  // Future<void> updateDisasterDonation(String documentId) async {
  //   await getDisasterData();
  //   int totalDonation = dataDisaster!['totalDonation'] + widget.donationAmount;
  //   FirebaseFirestore.instance
  //     .collection("disasters")
  //     .doc(widget.disasterId)
  //     .update({
  //       'disasterName': dataDisaster!['disasterName'],
  //       'address': dataDisaster!['address'],
  //       'date': dataDisaster!['date'],
  //       'timeHour': dataDisaster!['timeHour'],
  //       'description': dataDisaster!['description'],
  //       'status': dataDisaster!['status'],
  //       'disasterImage' : dataDisaster!['disasterImage'],
  //       'disasterCategory' : dataDisaster!['disasterCategory'],
  //       'donations' : FieldValue.arrayUnion([documentId]),
  //       'resourcesHelp' : dataDisaster!['resourcesHelp'],
  //       'totalDonation' : totalDonation
  //     }).then((value) {
  //       Navigator.push(context, MaterialPageRoute(builder: (_) => const Finalization()));
  //     }).catchError((error) => EasyLoading.showInfo('Failed'));
  // }

  Future<void> createDonation(BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('donations').add({
        'disasterId': widget.disasterId,
        'disasterName': widget.disasterName,
        'accountId' : user!.id,
        'accountName' : user!.username,
        'donationAmount' : widget.donationAmount,
        'date' : Timestamp.now(),
        'note' : widget.note,
        'status' : 'Waiting Verification'
      }).then((value) async {
        uploadPhoto(imageFile!, value.id, context);
        // updateDisasterDonation(value.id);
        
      });
    } catch (_) {
      EasyLoading.showInfo('Failed');
      return;
    }
  }

  Future uploadPhoto(File imageFile, String donationId, BuildContext context) async {
      String fileName = basename(imageFile.path);
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child(fileName + DateTime.now().toString());
      UploadTask uploadTask = ref.putFile(imageFile);
      await uploadTask.whenComplete(() {
        ref.getDownloadURL().then((fileUrl){
          FirebaseFirestore.instance
          .collection('donations').doc(donationId).update({
            'donationImage' : fileUrl
          })
          .then((value) {
            EasyLoading.showSuccess('Success');
            Navigator.push(context, MaterialPageRoute(builder: (_) => const Finalization()));
          })
          .catchError((error) {
            EasyLoading.showSuccess('Failed');
          });
        });
      });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset("assets/icons/back_black.svg"),
              ),
              Container(
                margin: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Donasi',
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: Theme.of(context).colorScheme.surface),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Upload Bukti Pembayaran', style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),),
                const SizedBox(height: 20,),
                imageFile != null ? 
                Image.file(
                  imageFile! ,
                  fit: BoxFit.cover,
                ) : Container(),
                Container(
                  margin: const EdgeInsets.only(bottom: 18),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            imageText,
                            textAlign: TextAlign.left,
                            style: const TextStyle(color: Color(0xff686868), fontSize: 16),
                          ),
                        )
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
                  height: 1,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  color: Colors.black,
                ),
                const SizedBox(height: 30),
                Button(
                  press: () {
                    createDonation(context);
                    // Provider.of<DonationProvider>(context, listen: false).changeIndex(3);
                  },
                  text: 'Konfirmasi',
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
