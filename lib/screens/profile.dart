import 'dart:convert';

import 'package:bpbd_jatim/screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../globals.dart' as globals;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isSwitched = false;  

  void toggleSwitch(bool value) {  
    if(isSwitched == false)  
    {  
      setState(() {  
        isSwitched = true;    
      });  
    }  
    else  
    {  
      setState(() {  
        isSwitched = false;  
      });  
    }  
  }  

  void signOut(BuildContext context) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove('user');
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SignIn()));
  }

  late SharedPreferences preferences;
  dynamic user = null;

  void getUserData() async {
    preferences = await SharedPreferences.getInstance();
    if (preferences.getString('user') != null) {
      setState((){
        user = preferences.getString('user') != null ? jsonDecode(preferences.getString("user")!) : null;
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
    return Scaffold(
      body: Column(
        children: [
          globals.isAdmin ? Container(
            padding: const EdgeInsets.only(top: 100),
            alignment: Alignment.center,
            child: adminProfilePic()
          ) : Container(
            padding: const EdgeInsets.only(top: 100),
            alignment: Alignment.center,
            child: userProfilePic()
          ),
          globals.isAdmin ? Padding(
            padding: const EdgeInsets.only(top: 18),
            child: Text(
              user != null ? user['username'] : 'Memuat...',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black),
            ),
          ) : Padding(
            padding: const EdgeInsets.only(top: 18),
            child: Text(
              user != null ? user['username'] : 'Memuat...',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black),
            ),
          ),
          globals.isAdmin ? Align(
            alignment: Alignment.center,
            child: Text(
              user != null ? user['privilege'] : 'Memuat...',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w300),
            ),
          ) : Align(
            alignment: Alignment.center,
            child: Text(
              user != null ? user['privilege'] : 'Memuat...',
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w300),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 0, 0),
            child: profileInfo(Icons.vpn_key_rounded, "Account"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                profileInfo(Icons.notifications_outlined, "Notification"),
                const Spacer(),
                Switch(
                  onChanged: toggleSwitch,  
                  value: isSwitched,  
                  activeColor: Colors.blue,  
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: profileInfo(Icons.live_help_outlined, "Help"),
          ),
          InkWell(
            onTap: () => {
              signOut(context)
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: profileInfo(Icons.logout_outlined, "Sign Out"),
            ),
          ),
        ],
      ),
    );
  }

  Container profileInfo(leadingIcon, infoText) {
    return Container(
      color: Colors.transparent,
      child: Column(children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          IconButton(
            icon: Icon(
              leadingIcon,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () => {},
          ),
          const Padding(padding: EdgeInsets.only(left: 20.0)),
          Text(
            infoText,
            style: const TextStyle(color: Colors.black, fontSize: 15),
          ),
        ],
      ),
    ]));
  }

  SizedBox adminProfilePic() {
    return const SizedBox(
      height: 150,
      width: 150,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: AssetImage('assets/images/admin_profile_photo.png')
      )
    );
  }

  SizedBox userProfilePic() {
    return const SizedBox(
      height: 150,
      width: 150,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: AssetImage('assets/images/user_profile_photo.png')
      )
    );
  }
}
