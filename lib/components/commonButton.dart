
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  String buttonText;
  Color? customColor;
  Function()? onPress;
  CommonButton(this.buttonText, this.customColor,this.onPress,{super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: customColor,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPress,
          minWidth: 200.0,
          height: 42.0,
          child:  Text(
              buttonText,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}