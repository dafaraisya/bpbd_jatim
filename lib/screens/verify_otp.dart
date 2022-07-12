import 'package:bpbd_jatim/components/button.dart';
import 'package:bpbd_jatim/screens/sign_in.dart';
import 'package:bpbd_jatim/screens/sign_up_verified.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

TextEditingController otpController = TextEditingController();

class VerifyOTP extends StatelessWidget {
  final String? username;
  final String? agency;
  final String? phoneNumber;
  final String? email;
  final String? password;
  final String? privilege;
  final String? OTPCode;


  const VerifyOTP({ 
    Key? key, 
    this.username,  
    this.agency,
    this.phoneNumber,
    this.email,
    this.password,
    this.privilege,
    this.OTPCode
  }) : super(key: key);

  Future<void> signUp(String username, String agency, String phoneNumber, String email, String privilege, String password, BuildContext context) async {
    if (username.isEmpty ||
        agency.isEmpty ||
        phoneNumber.isEmpty ||
        email.isEmpty ||
        privilege.isEmpty ||
        password.isEmpty ) {
      EasyLoading.showInfo('Fill all the field!');
      return;
    }

    try {
      await FirebaseFirestore.instance
      .collection('users').add({
        'username': username,
        'agency': agency,
        'phone': phoneNumber,
        'email': email,
        'password': password,
        'privilege': privilege
      });
    } catch (_) {
      EasyLoading.showInfo('Sign Up failed');
      return;
    }

    Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUpVerified()));
  }

  void verifyOTP(BuildContext context) async{
    if(otpController.text == OTPCode) {
      signUp(username!, agency!, phoneNumber!, email!, privilege!, password!, context);
    } else {
      EasyLoading.showInfo('Wrong OTP');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20,80,20,0),
          child: Column(
            children: [
              const Text("OTP Verification", textAlign: TextAlign.center, style: TextStyle(
                fontSize: 20,
              ),),
              const SizedBox(height: 30,),
              const Text("Please check your email to get the OTP code for your account", textAlign: TextAlign.center,),
              const SizedBox(height: 30,),
              TextField(
                style: const TextStyle(color: Colors.black),
                controller: otpController,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: "Fill the OTP here...",
                ),
              ),
              const SizedBox(height: 20,),
              Text("send activation code again", style: TextStyle(
                color: Theme.of(context).colorScheme.primary
              )),
              const SizedBox(height: 25,),
              Button(
                press: () => {
                  verifyOTP(context)
                },
                text: "Verify OTP",
              )
            ],
          ),
        ),
      ),
    );
  }
}