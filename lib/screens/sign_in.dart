import 'dart:convert';

import 'package:bpbd_jatim/components/button.dart';
import 'package:bpbd_jatim/screens/dashboard.dart';
import 'package:bpbd_jatim/screens/sign_up.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../globals.dart' as globals;

class SignIn extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> signIn(String email, String password, BuildContext context) async {
    if (email.isEmpty) {
      EasyLoading.showInfo('Fill Email');
      return;
    }

    if (password.isEmpty) {
      EasyLoading.showInfo('Fill Email');
      return;
    }

    try {
      final signInResult = await firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();

      if (signInResult.docs.isEmpty) {
        EasyLoading.showInfo('Email or password was invalid');
        return;
      }

      SharedPreferences preferences = await SharedPreferences.getInstance();

      Map<String, dynamic> user = {
        'id': signInResult.docs.first.id,
        ...signInResult.docs.first.data()
      };

      await preferences.setString('user', jsonEncode(user));

      if (user['privilege'] == 'admin') {
        globals.isAdmin = true;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => const Dashboard()),
            ModalRoute.withName('/'));
      } else {
        globals.isAdmin = false;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => const Dashboard()),
            ModalRoute.withName('/'));
      }
    } catch (_) {
      EasyLoading.showInfo('Sign in failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/images/sign_in_background.png",
                alignment: Alignment.topRight,
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 100.0, 8.0, 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.all(10),
                        child: Text('signIn',
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary))),
                    Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.all(10),
                        child: Text('Please sign in to continue',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .surface))),
                    Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Email',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                        )),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                        controller: emailController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            hintText: 'Enter email address'),
                      ),
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Password',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                        )),
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        obscureText: true,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                        controller: passwordController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            hintText: 'Enter password'),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {
                          //forgot password screen
                        },
                        child: Text(
                          'Forgot Password?',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                    ),
                    Button(
                      press: () => signIn(emailController.text,
                          passwordController.text, context),
                      text: 'signIn',
                    ),
                    Row(
                      children: <Widget>[
                        Text('Do not have an account yet?',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary)),
                        TextButton(
                          child: Text('Register',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary)),
                          onPressed: () {
                            //signup screen
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const SignUp()));
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
