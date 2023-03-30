import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_app/constants.dart';
import 'package:flash_chat_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../components/commonButton.dart';

class LoginScreen extends StatefulWidget {
  static const String id= 'login_screen';


  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;
  final _auth=FirebaseAuth.instance;
  bool? showSpinner=false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
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
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                onChanged: (value) {
                 setState(() {
                   email=value;
                 });
                },
                decoration:kCommonInputDecoration.copyWith(hintText:'Enter your email.')
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  textAlign: TextAlign.center,
                onChanged: (value) {
                  password=value;
                },
                decoration:kCommonInputDecoration.copyWith(hintText:'Enter your password.')
              ),
              const SizedBox(
                height: 24.0,
              ),
              CommonButton(
                'Log In',
                Colors.lightBlueAccent,
                    ()async{
                      setState(() {
                        showSpinner=true;
                      });
                   try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      Navigator.pushNamed(context, ChatScreen.id);
                    }else{
                        print('please enter correct password');
                    }
                    setState(() {
                      showSpinner=false;
                    });
                  }catch(e){
                    print(e);
                    setState(() {
                      showSpinner=false;
                    });
                  }
                    },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
