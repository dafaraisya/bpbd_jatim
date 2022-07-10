import 'package:bpbd_jatim/components/label_verify.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DonationData extends StatefulWidget {
  const DonationData({ Key? key }) : super(key: key);

  @override
  State<DonationData> createState() => _DonationDataState();
}

class _DonationDataState extends State<DonationData> {
  Map<String, dynamic>? dataDisaster;

  Future getDisasterData(String documentId, String disasterId, int donationAmount) async {
    // final docRef = FirebaseFirestore.instance.collection("disasters").doc(disasterId);
    // docRef.get().then(
    //   (DocumentSnapshot doc) {
    //     dataDisaster = doc.data() as Map<String, dynamic>;
    //     print(dataDisaster);
    //   },
    //   onError: (e) => EasyLoading.showInfo('Failed'),
    // );
    try {
      DocumentSnapshot docRef = await FirebaseFirestore.instance.collection('disasters').doc(disasterId).get();
      dataDisaster = docRef.data() as Map<String, dynamic>;
      updateDisaster(documentId, disasterId, donationAmount);
    } catch (e) {
      EasyLoading.showInfo('Failed');
    }
  }

  Future<void> updateDisaster(String documentId, String disasterId, int donationAmount) async{
    int totalDonation = dataDisaster!['totalDonation'] + donationAmount;
    FirebaseFirestore.instance
      .collection("disasters")
      .doc(disasterId)
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
        EasyLoading.showSuccess('Accepted');
      }).catchError((error) {
        EasyLoading.showInfo('Failed');
      });
  }

  Future<void> acceptVerification(String documentId, String disasterId, int donationAmount) async{
    try {
      await FirebaseFirestore.instance
        .collection('donations')
        .doc(documentId)
        .update({
          'status': 'Accept'
        }).then((value) => {
          getDisasterData(documentId, disasterId, donationAmount)
        });
    }catch(e) {
      EasyLoading.showInfo('Failed');
    }
  }

  Future<void> rejectVerification (String documentId) async{
    try {
      await FirebaseFirestore.instance
        .collection('donations')
        .doc(documentId)
        .update({
          'status': 'Reject'
        });
    }catch(e) {
      EasyLoading.showInfo('Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(children: [
            Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset("assets/icons/back_black.svg"),  
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Data Donasi',
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                          color: Theme.of(context).colorScheme.surface),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                  .collection('donations')
                  .orderBy('date', descending: true)
                  .snapshots(),
                builder: ( context, AsyncSnapshot<QuerySnapshot>snapshot ) {
                  if(snapshot.hasData) {
                    return ListView(
                      children: List.generate(snapshot.data!.docs.length, (index) {
                        return Container(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      snapshot.data!.docs[index]['accountName'],
                                      style: Theme.of(context).textTheme.headline6?.copyWith(
                                          color: Theme.of(context).colorScheme.surface),
                                    ),
                                    LabelVerify(
                                      text: snapshot.data!.docs[index]['status'],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'Bencana :',
                                      style: Theme.of(context).textTheme.headline6?.copyWith(
                                          color: Theme.of(context).colorScheme.secondary),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        snapshot.data!.docs[index]['disasterName'],
                                        style: Theme.of(context).textTheme.headline6?.copyWith(
                                            color: Theme.of(context).colorScheme.secondary),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16.0),
                                child: Row(
                                  children: [
                                    Text(
                                      'donasi :',
                                      style: Theme.of(context).textTheme.headline6?.copyWith(
                                          color: Theme.of(context).colorScheme.secondary),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        'Rp.' + snapshot.data!.docs[index]['donationAmount'].toString(),
                                        style: Theme.of(context).textTheme.headline6?.copyWith(
                                            color: Theme.of(context).colorScheme.secondary),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (_) => DonationImage(
                                          donationImage: snapshot.data!.docs[index]['donationImage'],
                                        )));
                                      }, 
                                      child: const Text('Lihat Bukti Pembayaran')
                                    ),
                                  ],
                                ),
                              ),
                              // Container(
                              //   child: Image.network(snapshot.data!.docs[index]['donationImage']),
                              // ),
                              snapshot.data!.docs[index]['status'] == 'Waiting Verification' ? Container(
                                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16.0),
                                child: Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        acceptVerification(
                                          snapshot.data!.docs[index].id,
                                          snapshot.data!.docs[index]['disasterId'],
                                          snapshot.data!.docs[index]['donationAmount'],
                                        );
                                      }, 
                                      child: const Text('Accept'),
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Colors.green)
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          rejectVerification(snapshot.data!.docs[index].id);
                                        }, 
                                        child: const Text('Reject'),
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all(Colors.red)
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ) : Container(),
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
                          width: double.infinity,
                        );
                      }),
                    );
                  }
                  return const Text('Data tidak ditemukan');
                },
              ),
            ),
          ]),
        ),
      )
    );
  }
}

class DonationImage extends StatelessWidget {
  final String? donationImage;

  const DonationImage({ Key? key, this.donationImage }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.network(donationImage!),
    );
  }
}