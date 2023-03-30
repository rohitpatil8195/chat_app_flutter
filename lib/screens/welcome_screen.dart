import 'package:flash_chat_app/screens/login_screen.dart';
import 'package:flash_chat_app/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../components/commonButton.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id= 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{

  late Animation animation;
  late AnimationController controller;
   Color? val;
  // @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller=AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
      //upperBound: 1.0
    );
   // animation=CurvedAnimation(parent: controller, curve: Curves.decelerate);
    // controller.reverse(from: 1);
    controller.forward();
    // animation.addStatusListener((status) {
    //   print(status);
    //   if(status==AnimationStatus.completed){
    //     controller.reverse(from: 1.0);
    //   }else if(status==AnimationStatus.dismissed){
    //     controller.forward();
    //   }
    // });
    animation=ColorTween(begin: Colors.blueGrey,end: Colors.white).animate(controller);
    controller.addListener(() {
      setState((){
     //   val=animation.value*100;
        val=animation.value;
      });
    });

    @override
    void dispose() {
      controller.dispose();
      super.dispose();
    }

  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: val,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
             // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    // height:val,
                    height: 60,
                    alignment: Alignment.center,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
               DefaultTextStyle(
                  style: const TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w900,
                      color: Colors.lightBlue,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText('Flash Chat'),
                    ],
                    onTap: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            CommonButton(
              'Log In',
              Colors.lightBlueAccent,
              (){Navigator.pushNamed(context, LoginScreen.id);},
            ),

            CommonButton(
              'Register',
              Colors.blueAccent,
                  (){Navigator.pushNamed(context, RegistrationScreen.id);},
            ),
          ],
        ),
      ),
    );
  }
}


