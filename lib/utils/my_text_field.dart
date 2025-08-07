import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {

  final Widget? icon;
  final String hintText;
  final bool obsText;
  final Widget? showpass;
  final TextInputType? textInputType;
  final TextEditingController textEditingController;
  final String? errorText;
  final Function(String)? onChanged;

  const MyTextField({super.key,
  required this.icon,
  required this.hintText,
  required this.obsText,
  required this.showpass,
  required this.textEditingController,
  required this.onChanged,
  required this.errorText,

  required this.textInputType});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obsText,
      keyboardType: textInputType,
      controller: textEditingController,
      onChanged: onChanged,

      decoration: InputDecoration(
        errorText: errorText,
        
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          
        ),
        focusColor: Colors.grey[500],
        prefixIcon: icon,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey[800],
          fontWeight: FontWeight.w500
        ),
        suffixIcon: showpass,
        
      ),
    );
  }
}