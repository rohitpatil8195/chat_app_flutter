import 'package:flash_chat_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../components/commonButton.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id= 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth=FirebaseAuth.instance;
  late String email;
 late String password;
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
                decoration:kCommonInputDecoration.copyWith(hintText:'Enter your email.'),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                 obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                 setState(() {
                   password=value;
                 });
                },
                decoration: kCommonInputDecoration.copyWith(hintText:'Enter your password.')
              ),
              const SizedBox(
                height: 24.0,
              ),
              CommonButton(
                'Register',
                Colors.blueAccent,
                    ()async{
                  setState(() {
                    showSpinner=true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if(newUser!= null){
                       Navigator.pushNamed(context, ChatScreen.id);
                    }
                    setState(() {
                      showSpinner=false;
                    });
                  }catch(e){
                    setState(() {
                      showSpinner=false;
                    });
                    print(e);
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
