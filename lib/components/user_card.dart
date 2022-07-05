import 'package:bpbd_jatim/components/label.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class UserCard extends StatelessWidget {
  final String documentId;
  final String name;
  final String role;
  final String email;
  final String phone;

  const UserCard({
    Key? key,
    required this.documentId,
    required this.name,
    required this.role,
    required this.email,
    required this.phone,
  }) : super(key: key);

  Future<void> deleteAccount() async{
    try {
      FirebaseFirestore.instance
        .collection('users')
        .doc(documentId)
        .delete();
    } catch (error) {
      EasyLoading.showInfo("Failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return (
      Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                deleteAccount();
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
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.headline6?.copyWith(
                          color: Theme.of(context).colorScheme.surface),
                    ),
                    Label(
                      text: role,
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.mail,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        email,
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
                    Icon(
                      Icons.phone,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        phone,
                        style: Theme.of(context).textTheme.headline6?.copyWith(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ],
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
          width: double.infinity,
        )
      )
    );
  }
}
