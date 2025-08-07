import 'package:flutter/material.dart';
import 'package:notes_app/pages/login_page.dart';
import 'package:notes_app/utils/my_button.dart';

class OtpPage extends StatelessWidget {
  final otpcontroller = TextEditingController();
   OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/appbackground1.png'),
        fit: BoxFit.cover)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 60,),
                    
                     Center( 
                       child: Padding(
                         padding: const EdgeInsets.only(left: 5),
                         child: Image.asset('assets/images/done.png',
                         height: 250,
                          ),
                         ),
                        ),

                        const SizedBox(height: 20,),
                  const SizedBox(height: 15,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Done, you will recieve email with instructions on how to reset your password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  SizedBox(height: 50,),

                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage())),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: MyButton(buttontext: 'Continue'),
                    ),
                  )
                  
                  
                  ],
                  ),
                ),
              ),
     ),

    );
  }
}