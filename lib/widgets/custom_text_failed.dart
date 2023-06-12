
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
   CustomTextFormField({Key? key,required this.labelText,this.prefixIcon,this.type,this.onChanged}) ;

  String? labelText;
  Widget? prefixIcon;
   TextInputType?type;
   Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data){
        if(data!.isEmpty){
          return 'this field must\'t not be empty ';
        }
      },
      onChanged:onChanged ,
      keyboardType: type,
      style: TextStyle(
        color: Colors.white
      ),
      decoration: InputDecoration(
        prefixIcon:prefixIcon ,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white
              )
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white
              )
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            // borderSide: BorderSide.none
          ),
          labelText:labelText ,
          labelStyle: TextStyle(
            color: Colors.white,

          )),

    );
  }
}
