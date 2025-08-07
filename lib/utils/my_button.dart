import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String buttontext;
  const MyButton({super.key,
  required this.buttontext});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 2, 57, 255),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.3),
        blurRadius: 6.0,
        spreadRadius: 2.0,
        offset: Offset(0, 3),
      ),
        ],
      ),
      
      child: Center(
        child: Text(buttontext,
        style: TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w700
        ),),
      ),

    );
  }
}