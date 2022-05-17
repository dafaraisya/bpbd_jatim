import 'package:bpbd_jatim/components/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> { 
  Color secondaryColor = const Color(0xFF8F959D);
  bool isFirstFormSigned = false;
  Widget? formBody;

  Widget firstForm() {
    TextEditingController emailController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController agencyController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    return Column(
      children: [
        // Email
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Text(
            'Email',
            style: TextStyle(color: secondaryColor),
          )
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: TextField(
            style: TextStyle(color: secondaryColor),
            controller: emailController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              hintText: 'Enter email address'
            ),
          ),
        ),
        // Username
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Text(
            'Username',
            style: TextStyle(color: secondaryColor),
          )
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: TextField(
            style: TextStyle(color: secondaryColor),
            controller: usernameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              hintText: 'Enter Username'
            ),
          ),
        ),
        // Agency
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Text(
            'Agency',
            style: TextStyle(color: secondaryColor),
          )
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: TextField(
            style: TextStyle(color: secondaryColor),
            controller: agencyController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              hintText: 'Enter Agency'
            ),
          ),
        ),
        // Phone Number
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Text(
            'Phone Number',
            style: TextStyle(color: secondaryColor),
          )
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: TextField(
            style: TextStyle(color: secondaryColor),
            controller: phoneNumberController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              hintText: 'Enter phone number'
            ),
          ),
        ),
        const SizedBox(height: 30,),
        Container(
          height: 50,
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Button(
            press: () => { 
              setState(() {
                formBody = secondForm();
                isFirstFormSigned = true;
              })
            },
            text: 'Next',
          )
        ),
      ],
    );
  }

  Widget secondForm() {
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    return Column(
      children: [
        // Password
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Text(
            'Password',
            style: TextStyle(color: secondaryColor),
          )
        ),
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
              hintText: 'Enter your password'
            ),
          ),
        ),
        // Confirm Password
        Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Text(
            'Confirm Password',
            style: TextStyle(color: secondaryColor),
          )
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: TextField(
            obscureText: true,
            style: TextStyle(color: secondaryColor),
            controller: confirmPasswordController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              hintText: 'Enter password again'
            ),
          ),
        ),
        const SizedBox(height: 30,),
        Container(
          height: 50,
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Button(
            press: () => { 
              setState(() {
                formBody = secondForm();
              })
            },
            text: 'Register',
          )
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    formBody = firstForm();
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
                        child: Text('Register', style: Theme.of(context).textTheme.headline4?.copyWith(color: Theme.of(context).colorScheme.primary))),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.all(10),
                        child: Text('Please sign up to continue',style: Theme.of(context).textTheme.headline6?.copyWith(color: Theme.of(context).colorScheme.surface))
                      ),
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
                              //signup screen
                            },
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.center,
                      ),
                    ],
                  )
                ),
              ),
            ),
            isFirstFormSigned ? 
            Container(
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
                  child: SvgPicture.asset(
                    "assets/icons/back_arrow_black.svg", 
                    alignment: Alignment.topLeft
                  ),
                ),
              ),
            ) : Container(),
          ],
        ));
  }
}