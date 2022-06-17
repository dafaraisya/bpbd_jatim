import 'package:bpbd_jatim/components/button.dart';
import 'package:bpbd_jatim/components/user_card.dart';
import 'package:bpbd_jatim/screens/sign_up.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountData extends StatelessWidget {
  const AccountData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _onDownloadButtonPressed() {}

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
                        'Data akun',
                        style: Theme.of(context).textTheme.headline5?.copyWith(
                            color: Theme.of(context).colorScheme.surface),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: 128,
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
                        style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: Theme.of(context).colorScheme.surface),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                    .collection('users')
                    .snapshots(),
                  builder: ( context, AsyncSnapshot<QuerySnapshot>snapshot ) {
                    if(snapshot.hasData) {
                      return ListView(
                        children: List.generate(snapshot.data!.docs.length, (index) => UserCard(
                          name: snapshot.data!.docs[index]['username'], 
                          role: snapshot.data!.docs[index]['privilege'], 
                          email: snapshot.data!.docs[index]['email'], 
                          phone: snapshot.data!.docs[index]['phone'], 
                          onTap: () {}
                        )),
                        // children: [
                        //   UserCard(
                        //       name: "BPBD Jatim",
                        //       role: "Admin",
                        //       email: "bpbdjatim@gmail.com",
                        //       phone: "0856 - 5658 - 8975",
                        //       onTap: _onDownloadButtonPressed),
                        //   UserCard(
                        //       name: "Relawan Sidoarjo",
                        //       role: "User",
                        //       email: "relawan@gmail.com",
                        //       phone: "0856 - 5658 - 8975",
                        //       onTap: _onDownloadButtonPressed),
                        //   UserCard(
                        //       name: "TNI AD",
                        //       role: "User",
                        //       email: "TNIADRI@gmail.com",
                        //       phone: "0856 - 5658 - 8975",
                        //       onTap: _onDownloadButtonPressed),
                        //   UserCard(
                        //       name: "Polrestabes Surabaya",
                        //       role: "User",
                        //       email: "Polressby@gmail.com",
                        //       phone: "0856 - 5658 - 8975",
                        //       onTap: _onDownloadButtonPressed),
                        // ],
                      );
                    }
                    return const Text('Data tidak ditemuka');
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                width: double.infinity,
                child: Button(
                  press: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUp())),
                  text: "Tambah Data",
                ),
              )
            ]),
          ),
        ));
  }
}
