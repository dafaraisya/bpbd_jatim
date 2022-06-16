import 'package:bpbd_jatim/components/label.dart';
import 'package:bpbd_jatim/screens/user/donation/donation_dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../../components/button.dart';

class DetailDisasterUser extends StatelessWidget {
  final String documentId;

  const DetailDisasterUser({ Key? key, required this.documentId }) : super(key: key);
  
  String formattedDate (date) {      
    dynamic dateData = date;
    final birthDate = DateTime.fromMicrosecondsSinceEpoch(dateData.microsecondsSinceEpoch);
    String formattedDate = DateFormat('dd MMMM yyyy').format(birthDate);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
          .collection('disasters')
          .doc(documentId)
          .snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return Stack(
              children: [
                DetailImage(imageUrl: (snapshot.data as dynamic)['disasterImage']),
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
                              Text((snapshot.data as dynamic)['disasterName'], style: Theme.of(context).textTheme.headline5,),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: Colors.grey)
                                  ),
                                  child: const Icon(Icons.more_horiz_outlined),
                                ),
                              )
                            ],
                          ),
                          Text((snapshot.data as dynamic)['address'], style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Theme.of(context).colorScheme.secondary)),
                          const SizedBox(height: 30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Deskripsi', style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Theme.of(context).colorScheme.secondary)),
                              Label(text: (snapshot.data as dynamic)['status'],)
                            ],
                          ),
                          const SizedBox(height: 20,),
                          Text((snapshot.data as dynamic)['description'], textAlign: TextAlign.justify,),
                          const SizedBox(height: 15,),
                          Row(
                            children: [
                              Icon(
                                Icons.date_range,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              const SizedBox(width: 10,),
                              Text(
                                formattedDate((snapshot.data as dynamic)['date']),
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
                                (snapshot.data as dynamic)['timeHour'] + ' WIB',
                                style: const TextStyle(color: Colors.black, fontSize: 15),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Sumber Bantuan', style: Theme.of(context).textTheme.subtitle2?.copyWith(color: Theme.of(context).colorScheme.secondary)),
                              Row(
                                children: [
                                  Icon(
                                    Icons.add_circle_outline,
                                    size: 16,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10,),
                          Column(
                            children: List.generate((snapshot.data as dynamic)['resourcesHelp'].length, (index) => SumberBantuan(
                              accountName: (snapshot.data as dynamic)['resourcesHelp'][index]['accountName'],
                              personnel: (snapshot.data as dynamic)['resourcesHelp'][index]['personnel'],
                              totalPersonnel: (snapshot.data as dynamic)['resourcesHelp'][index]['totalPersonnel'],
                            ))
                          ),
                          const SizedBox(height: 20,),
                          Button(
                            press: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const DonationDashboard()));
                            },
                            text: 'Berikan Donasi',
                          ),
                          const SizedBox(height: 20,),
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


class SumberBantuan extends StatelessWidget {
  final String? accountName;
  final String? personnel;
  final String? totalPersonnel;

  const SumberBantuan({ Key? key, this.accountName, this.personnel, this.totalPersonnel }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {},
            backgroundColor:const Color.fromARGB(255, 8, 214, 241),
            foregroundColor: Colors.white,
            icon: Icons.mode_edit_outlined,
          ),
          SlidableAction(
            onPressed: (context) {},
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
                accountName!,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: Theme.of(context).colorScheme.surface),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                personnel! + ' : ' + totalPersonnel! + 'personil',
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
        stream: FirebaseFirestore.instance
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
                    // InkWell(
                    //   onTap: () {},
                    //   child: Text(
                    //     'Lihat bukti >',
                    //     style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    //         color: Theme.of(context).colorScheme.primary),
                    //   ),
                    // )
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