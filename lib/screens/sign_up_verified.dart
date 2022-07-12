import 'package:bpbd_jatim/components/button.dart';
import 'package:bpbd_jatim/screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpVerified extends StatelessWidget {
  const SignUpVerified({ Key? key }) : super(key: key);

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
              SvgPicture.asset("assets/images/sign_up_verified.svg"),
              const SizedBox(height: 30,),
              const Text("Congratulations, you have successfully registered", textAlign: TextAlign.center,),
              const SizedBox(height: 20,),
              Text("please log in, by clicking the button below", style: TextStyle(
                color: Theme.of(context).colorScheme.primary
              )),
              const SizedBox(height: 25,),
              Button(
                press: () => {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => SignIn()))
                },
                text: "Back to login",
              )
            ],
          ),
        ),
      ),
    );
  }
}