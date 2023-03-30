import 'package:flutter/material.dart';

import '../components/commonButton.dart';
import '../constants.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id= 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: Container(
                height: 100.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration:kCommonInputDecoration.copyWith(hintText:'Enter your email.'),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration: kCommonInputDecoration.copyWith(hintText:'Enter your password.')
            ),
            const SizedBox(
              height: 24.0,
            ),
            CommonButton(
              'Register',
              Colors.blueAccent,
                  (){},
            ),
          ],
        ),
      ),
    );
  }
}
