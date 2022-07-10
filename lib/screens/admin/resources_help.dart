import 'package:bpbd_jatim/components/label_verify.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResourcesHelp extends StatelessWidget {
  const ResourcesHelp({ Key? key }) : super(key: key);

  Future<void> updateDisaster(String disasterId, String accountName, String personnel, String totalPersonnel) async{
    try {
      await FirebaseFirestore.instance
        .collection('disasters')
        .doc(disasterId)
        .update({
          'resourcesHelp': FieldValue.arrayUnion([{
            'accountName': accountName,
            'personnel' : personnel,
            'totalPersonnel' : totalPersonnel
          }])
        }).then((value) => {
          EasyLoading.showSuccess('Accepted')
        });
    } catch(e) {
      EasyLoading.showInfo("Failed");
    }
  }

  Future<void> acceptVerification(String documentId, String disasterId, String accountName, String personnel, String totalPersonnel) async{
    try {
      await FirebaseFirestore.instance
        .collection('resourcesHelp')
        .doc(documentId)
        .update({
          'status': 'Accept'
        }).then((value) => {
          updateDisaster(disasterId, accountName, personnel, totalPersonnel)
        });
    }catch(e) {
      EasyLoading.showInfo('Failed');
    }
  }

  Future<void> rejectVerification (String documentId) async{
    try {
      await FirebaseFirestore.instance
        .collection('resourcesHelp')
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
                      'Data Sumber Bantuan',
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
                  .collection('resourcesHelp')
                  .snapshots(),
                builder: ( context, AsyncSnapshot<QuerySnapshot>snapshot ) {
                  if(snapshot.hasData) {
                    return ListView(
                      children: List.generate(snapshot.data!.docs.length, (index) {
                        return Container(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            children: [
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
                                      'Bencana : ',
                                      style: Theme.of(context).textTheme.headline6?.copyWith(
                                          color: Theme.of(context).colorScheme.secondary),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 16.0),
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
                                      'Personnel : ',
                                      style: Theme.of(context).textTheme.headline6?.copyWith(
                                          color: Theme.of(context).colorScheme.secondary),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 16.0),
                                      child: Text(
                                        snapshot.data!.docs[index]['personnel'],
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
                                      'Total Personnel : ',
                                      style: Theme.of(context).textTheme.headline6?.copyWith(
                                          color: Theme.of(context).colorScheme.secondary),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 16.0),
                                      child: Text(
                                        snapshot.data!.docs[index]['totalPersonnel'],
                                        style: Theme.of(context).textTheme.headline6?.copyWith(
                                            color: Theme.of(context).colorScheme.secondary),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              snapshot.data!.docs[index]['status'] == 'Waiting Verification' ? Container(
                                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16.0),
                                child: Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        acceptVerification(
                                          snapshot.data!.docs[index].id,
                                          snapshot.data!.docs[index]['disasterId'],
                                          snapshot.data!.docs[index]['accountName'],
                                          snapshot.data!.docs[index]['personnel'],
                                          snapshot.data!.docs[index]['totalPersonnel'],
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