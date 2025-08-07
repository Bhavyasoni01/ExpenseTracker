import 'package:flutter/material.dart';

class LoginTile extends StatelessWidget {
  final String logoText;
  final String logo;
  const LoginTile({super.key,
  required this.logoText,
  required this.logo});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      height: 50,
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color.fromRGBO(242, 242, 249, 1),
        boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 3.0,
        spreadRadius: 2.0,
        offset: Offset(0, 3),
      ),
    ],
      ),
    
      child: Row(
        children: [
          Padding(padding: EdgeInsetsGeometry.only(left: 10)),
           Image.asset(logo,
      cacheHeight: 30,),
      const SizedBox(width: 10,),
    
      Center(
        child: Text(logoText,
        style: TextStyle(
          fontSize: 18
        ),),
      )
        ],
      ),
    
      
    
    );
  }
}