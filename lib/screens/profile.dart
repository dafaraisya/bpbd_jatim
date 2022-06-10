import 'package:flutter/material.dart';
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
          globals.isAdmin ? const Padding(
            padding: EdgeInsets.only(top: 18),
            child: Text(
              'BPBD Jawa Timur',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black),
            ),
          ) : const Padding(
            padding: EdgeInsets.only(top: 18),
            child: Text(
              'Samuel prasetya',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black),
            ),
          ),
          globals.isAdmin ? const Align(
            alignment: Alignment.center,
            child: Text(
              'Admin',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w300),
            ),
          ) : const Align(
            alignment: Alignment.center,
            child: Text(
              'User',
              style: TextStyle(
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
