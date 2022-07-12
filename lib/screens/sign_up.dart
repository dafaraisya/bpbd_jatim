import 'dart:convert';

import 'package:bpbd_jatim/screens/verify_otp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bpbd_jatim/components/button.dart';
import 'package:bpbd_jatim/screens/sign_in.dart';
import 'package:email_auth/email_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Color secondaryColor = const Color(0xFF8F959D);
  bool isFirstFormSigned = false;
  Widget? formBody;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController agencyController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();

  String? roleCategory = 'Pilih Role User';

  int width = 0; 

  Future sendEmailOTP(fromName, toName, toEmail) async{
    const serviceId = 'service_m6nom88';
    const templateId = 'template_m1lgcz9';
    const userId = 'zYSAjXOegqvtH_KMk';

    var rng = Random();
    var OTPCode = rng.nextInt(900000) + 100000;

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json' 
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'from_name': fromName,
          'to_name': toName,
          'otp_code': OTPCode,
          'to_email': toEmail,
        }
      })
    );

    if(response.body == 'OK') {
      Navigator.push(context, MaterialPageRoute(builder: (_) => VerifyOTP(
        username: usernameController.text,
        agency: agencyController.text,
        phoneNumber: phoneNumberController.text,
        email: emailController.text,
        password: passwordController.text,
        privilege: roleCategory!,
        OTPCode: OTPCode.toString()
      )));
    } else {
      EasyLoading.showInfo('Failed');
    }
    
  }

  Widget firstForm() {
    return Column(
      children: [
        // Email
        Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Text(
              'Email',
              style: TextStyle(color: secondaryColor),
            )),
        Container(
          padding: const EdgeInsets.all(10),
          child: TextField(
            style: TextStyle(color: secondaryColor),
            controller: emailController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintText: 'Enter email address'),
          ),
        ),
        // Username
        Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(
              'Username',
              style: TextStyle(color: secondaryColor),
            )),
        Container(
          padding: const EdgeInsets.all(10),
          child: TextField(
            style: TextStyle(color: secondaryColor),
            controller: usernameController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintText: 'Enter Username'),
          ),
        ),
        // Agency
        Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(
              'Agency',
              style: TextStyle(color: secondaryColor),
            )),
        Container(
          padding: const EdgeInsets.all(10),
          child: TextField(
            style: TextStyle(color: secondaryColor),
            controller: agencyController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintText: 'Enter Agency'),
          ),
        ),
        // Phone Number
        Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(
              'Phone Number',
              style: TextStyle(color: secondaryColor),
            )),
        Container(
          padding: const EdgeInsets.all(10),
          child: TextField(
            style: TextStyle(color: secondaryColor),
            controller: phoneNumberController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintText: 'Enter phone number'),
          ),
        ),
        // Phone Number
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Text(
            'Select Role',
            style: TextStyle(color: secondaryColor),
          )
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          child: DecoratedBox(
            decoration: BoxDecoration( 
              color:const Color.fromARGB(255, 255, 255, 255).withOpacity(0.25), 
              borderRadius: BorderRadius.circular(8.0), 
              border: Border.all(color: Colors.grey)
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: DropdownButton<String>(
                isExpanded: true,
                value: roleCategory,
                style: const TextStyle(  
                  color: Colors.black, 
                  fontSize: 16
                ),
                onChanged: (newValue) {
                  setState(() {
                    roleCategory = newValue!;
                    formBody = firstForm();
                  });
                },
                items: const [
                  DropdownMenuItem(
                    child: Text('Pilih Role User'),
                    value: 'Pilih Role User',
                  ),
                  DropdownMenuItem(
                    child: Text('Pengguna Umum'),
                    value: 'user',
                  ),
                  DropdownMenuItem(
                    child: Text('Instansi'),
                    value: 'instansi',
                  ),
                ] 
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Button(
              press: () {
                if (emailController.text.isEmpty) {
                  EasyLoading.showInfo('Fill email field!');
                  return;
                }

                if (usernameController.text.isEmpty) {
                  EasyLoading.showInfo('Fill username field!');
                  return;
                }

                if (agencyController.text.isEmpty) {
                  EasyLoading.showInfo('Fill agency field!');
                  return;
                }

                if (phoneNumberController.text.isEmpty) {
                  EasyLoading.showInfo('Fill phone number field!');
                  return;
                }

                setState(() {
                  formBody = secondForm();
                  isFirstFormSigned = true;
                });
              },
              text: 'Next',
            )),
      ],
    );
  }

  Widget secondForm() {
    return Column(
      children: [
        // Password
        Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Text(
              'Password',
              style: TextStyle(color: secondaryColor),
            )),
        Container(
          padding: const EdgeInsets.all(10),
          child: TextField(
            obscureText: true,
            style: TextStyle(color: secondaryColor),
            controller: passwordController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintText: 'Enter your password'),
          ),
        ),
        // Confirm Password
        Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(
              'Confirm Password',
              style: TextStyle(color: secondaryColor),
            )),
        Container(
          padding: const EdgeInsets.all(10),
          child: TextField(
            obscureText: true,
            style: TextStyle(color: secondaryColor),
            controller: passwordConfirmationController,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                hintText: 'Enter password again'),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Button(
              press: () async {
                if (passwordController.text.isEmpty) {
                  EasyLoading.showInfo('Fill password field!');
                  return;
                }

                if (passwordConfirmationController.text.isEmpty) {
                  EasyLoading.showInfo('Fill password confirmation field!');
                  return;
                }

                if (passwordController.text !=
                    passwordConfirmationController.text) {
                  EasyLoading.showInfo('Password doesn\'t match!');
                  return;
                }

                sendEmailOTP('BPBD Jatim Apps', usernameController.text, emailController.text);
              },
              text: 'Register',
            )),
      ],
    );
  }
  late EmailAuth emailAuth;

  @override
  void initState() {
    super.initState();
    formBody = firstForm();
    // emailAuth = new EmailAuth(
    //   sessionName: "Sample session",
    // );

    /// Configuring the remote server
    // emailAuth.config(remoteServerConfiguration);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width.toInt();
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
              child: Container(
                color: Colors.transparent,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.all(10),
                            child: Text('Register',
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
                            child: Text('Please sign up to continue',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface))),
                        formBody!,
                        Row(
                          children: <Widget>[
                            Text('Have an account?',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary)),
                            TextButton(
                              child: Text('Login',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary)),
                              onPressed: () {
                                //signin screen
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => SignIn()));
                              },
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                      ],
                    )),
              ),
            ),
            isFirstFormSigned
                ? Container(
                    padding: const EdgeInsets.fromLTRB(10, 40, 0, 0),
                    height: 80,
                    width: 80,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          formBody = firstForm();
                          isFirstFormSigned = false;
                        });
                      },
                      child: Positioned.fill(
                        child: SvgPicture.asset("assets/icons/back_black.svg",
                            alignment: Alignment.topLeft),
                      ),
                    ),
                  )
                : Container(),
          ],
        ));
  }
}
