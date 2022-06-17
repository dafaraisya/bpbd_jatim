import 'dart:convert';

import 'package:bpbd_jatim/components/button.dart';
import 'package:bpbd_jatim/screens/user/donation/finalization.dart';
import 'package:bpbd_jatim/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/payment_list.dart';

class Confirmation extends StatefulWidget {
  final PaymentList paymentMethod;
  final String? disasterId;
  final String? disasterName;
  final int? donationAmount;
  final String? note;

  const Confirmation({
    Key? key, 
    this.paymentMethod = PaymentList.linkAja,
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
      onError: (e) => print("Error getting document: $e"),
    );
  }

  Future<void> updateDisasterDonation(String documentId) async {
    await getDisasterData();
    int totalDonation = dataDisaster!['totalDonation'] + widget.donationAmount;
    FirebaseFirestore.instance
      .collection("disasters")
      .doc(widget.disasterId)
      .update({
        'disasterName': dataDisaster!['disasterName'],
        'address': dataDisaster!['address'],
        'date': dataDisaster!['date'],
        'timeHour': dataDisaster!['timeHour'],
        'description': dataDisaster!['description'],
        'status': dataDisaster!['status'],
        'disasterImage' : dataDisaster!['disasterImage'],
        'disasterCategory' : dataDisaster!['disasterCategory'],
        'donations' : FieldValue.arrayUnion([documentId]),
        'resourcesHelp' : dataDisaster!['resourcesHelp'],
        'totalDonation' : totalDonation
      }).then((value) {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const Finalization()));
      }).catchError((error) => print("Failed : $error"));
  }

  Future<void> createDonation(BuildContext context) async {
    // final donationProvider = DonationProvider();
    // print(donationProvider.disasterName);
    // print(donationProvider.accountId);
    // print(donationProvider.accountName);
    // print(donationProvider.donationAmount);
    // print(donationProvider.note);
    try {
      await FirebaseFirestore.instance.collection('donations').add({
        'disasterName': widget.disasterName,
        'accountId' : user!.id,
        'accountName' : user!.username,
        'donationAmount' : widget.donationAmount,
        'date' : Timestamp.now(),
        'note' : widget.note
      }).then((value) async {
        updateDisasterDonation(value.id);
      });
    } catch (_) {
      EasyLoading.showInfo('Failed');
      return;
    }
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/' + getAsset(widget.paymentMethod)),
                  const SizedBox(width: 10),
                  Text(
                    '( Dicek Otomatis )',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              Container(
                height: 1,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 5),
                color: Colors.black,
              ),
              Text(
                'No. e-wallet',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '087861130080',
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  InkWell(
                    onTap: () {
                      Clipboard.setData(
                          const ClipboardData(text: '087861130080'));
                    },
                    child: Text(
                      'Salin',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            color: const Color(0xFF00B8D1),
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              Button(
                press: () {
                  createDonation(context);
                  // Provider.of<DonationProvider>(context, listen: false).changeIndex(3);
                },
                text: 'Konfirmasi',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
