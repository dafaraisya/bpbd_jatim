import 'package:bpbd_jatim/components/button.dart';
import 'package:bpbd_jatim/screens/dashboard.dart';
import 'package:bpbd_jatim/screens/sign_up.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  void login(email, password, context) async {
    if(email == 'admin@gmail.com' && password =='admin123') {
      globals.isAdmin = true;
      Navigator.push(context, MaterialPageRoute(builder: (_) => const Dashboard()));
    } else if (email == 'user@gmail.com' && password =='user123') {
      globals.isAdmin = false;
      Navigator.push(context, MaterialPageRoute(builder: (_) => const Dashboard()));
    } else {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
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
                    child: Text(
                      'Login',
                      style: Theme.of(context).textTheme.headline4?.copyWith(color: Theme.of(context).colorScheme.primary)
                    )),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Please sign in to continue',
                      style: Theme.of(context).textTheme.headline6?.copyWith(color: Theme.of(context).colorScheme.surface)
                    )),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Email',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Theme.of(context).colorScheme.secondary),
                    )),
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: TextField(
                      style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                      controller: emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        hintText: 'Enter email address'
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Password',
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Theme.of(context).colorScheme.secondary),
                    )),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      obscureText: true,
                      style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        hintText: 'Enter password'
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                      onPressed: () {
                        //forgot password screen
                      },
                      child: Text('Forgot Password?', style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Theme.of(context).colorScheme.secondary),),
                    ),
                  ),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Button(
                      press: () => login(emailController.text, passwordController.text, context), 
                      text: 'Login',)
                  ),
                  Row(
                    children: <Widget>[
                      Text('Do not have an account yet?', style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Theme.of(context).colorScheme.secondary)),
                      TextButton(
                        child: Text(
                          'Register',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Theme.of(context).colorScheme.primary)
                        ),
                        onPressed: () {
                          //signup screen
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUp()));
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
      )
    );
  }
}