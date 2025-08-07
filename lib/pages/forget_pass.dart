import 'package:flutter/material.dart';
import 'package:notes_app/auth/auth_service.dart';
import 'package:notes_app/pages/login_page.dart';
import 'package:notes_app/pages/otp_page.dart';
import 'package:notes_app/utils/my_button.dart';
import 'package:notes_app/utils/my_text_field.dart';

class ForgetPassPage extends StatefulWidget {


  const ForgetPassPage({super.key});

  @override
  State<ForgetPassPage> createState() => _ForgetPassPageState();
}

class _ForgetPassPageState extends State<ForgetPassPage> {
  final forgetpasscontroller = TextEditingController();

    final authService = AuthService();


    String? emailcheck;

    String? checkEmail(String email){
      if (email.isEmpty) {
      return 'Email cannot be empty';
    }
    if (!email.contains('@')) {
      return 'Please enter a valid email address';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return 'Please enter a valid email format';
    }
    return null;

    }

    bool validateEmail(){
      setState(() {
        emailcheck = checkEmail(forgetpasscontroller.text);
      });
      return emailcheck == null;
    }


    void forgetpasword()async{
      if(emailcheck==null){
        final email = forgetpasscontroller.text;

        try {
          await authService.forgetPassword(email);

          Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpPage()));

          
        } catch (e) {
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error  $e')));
          
        }

      }
    }

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
                    SizedBox(height: 40,),
                    
                     Center( 
                       child: Padding(
                         padding: const EdgeInsets.only(left: 5),
                         child: Image.asset('assets/images/forgetpass.png',
                         height: 250,
                          ),
                         ),
                        ),

                        const SizedBox(height: 20,),


                    Text("Forget Your Password?",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 1, 69, 255),
                    shadows: [
                      Shadow(
                          color: Colors.black54,
                          offset: Offset(0.3, 0.3),
                          blurRadius: 3,
                        ),
                      ],
                  ),),


                  const SizedBox(height: 15,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Enter the mail id associated with your account to reset your password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  SizedBox(height: 20,),

                  Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 20),
                   child: MyTextField(
                    onChanged: (value) =>validateEmail(),
                    errorText: emailcheck,
                    textEditingController: forgetpasscontroller,
                    textInputType: null,
                    icon: Icon(Icons.mail,
                    color: Colors.grey[700],
                    ),
                    hintText: 'Email Address',
                    obsText: false,
                    showpass: null,
                   ),
                 ),

                 const SizedBox(height: 30,),

                 GestureDetector(
                  onTap: forgetpasword,
                   child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: MyButton(
                      buttontext: 'Continue',
                    ),
                                   ),
                 ),

                const SizedBox(height: 30,),


                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text('Remember your password?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                    const SizedBox(width: 5,),
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage())),
                      child: Text('Login',
                      
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue[900], 
                        fontWeight: FontWeight.w500
                      ),),
                    )
                  ],
                )


                      ],
                  ),
                ),
              ),
     ),

    );
  }
}