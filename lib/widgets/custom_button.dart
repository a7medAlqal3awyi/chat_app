import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   CustomButton({Key? key,required this.txt,this.onTap}) ;
   VoidCallback? onTap;
String ? txt;
  @override
  Widget build(BuildContext context) {
    return   GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        width: double.infinity,
        height: 60,
        child:Center(
          child: Text(txt!),
        ),
      ),
    );
  }
}

