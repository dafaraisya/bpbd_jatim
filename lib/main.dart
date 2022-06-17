
import 'dart:convert';

import 'package:bpbd_jatim/screens/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bpbd_jatim/providers/donation_provider.dart';
import 'package:bpbd_jatim/screens/sign_in.dart';
import 'package:bpbd_jatim/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'globals.dart' as globals;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late SharedPreferences preferences;
  dynamic user = null;

  void getUserData() async {
    preferences = await SharedPreferences.getInstance();
    if (preferences.getString('user') != null) {
      setState((){
        user = preferences.getString('user') != null ? jsonDecode(preferences.getString("user")!) : null;
        if(user['privilege'] == 'admin') {
          globals.isAdmin = true;
        } else {
          globals.isAdmin = false;
        }
      });
    }
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DonationProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme,      
        builder: EasyLoading.init(),
        home: user != null ? (user['privilege'] == 'admin' ? const Dashboard() : const Dashboard()) : SignIn(),
      ),
    );
  }
}
