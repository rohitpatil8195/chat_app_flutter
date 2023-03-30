import 'package:flash_chat_app/constants.dart';
import 'package:flutter/material.dart';

import '../components/commonButton.dart';

class LoginScreen extends StatefulWidget {
  static const String id= 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

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
              decoration:kCommonInputDecoration.copyWith(hintText:'Enter your email.')
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              onChanged: (value) {
                //Do something with the user input.
              },
              decoration:kCommonInputDecoration.copyWith(hintText:'Enter your password.')
            ),
            const SizedBox(
              height: 24.0,
            ),
            CommonButton(
              'Log In',
              Colors.lightBlueAccent,
                  (){},
            ),
          ],
        ),
      ),
    );
  }
}
