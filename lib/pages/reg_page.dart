import 'package:flutter/material.dart';
import 'package:notes_app/auth/auth_service.dart';
import 'package:notes_app/pages/login_page.dart';
import 'package:notes_app/utils/my_button.dart';
import 'package:notes_app/utils/my_text_field.dart';


class RegPage extends StatefulWidget {
  const RegPage({super.key});

  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {

  final newmailcontroller = TextEditingController();
  final newpasscontroller = TextEditingController();
  final confirmpasscontroller = TextEditingController();
  final authService = AuthService();

  String? mailError;
  String? passError;

  String? checkEmail(String email){
    if(email.isEmpty){
      return 'Email cannot be empty';
    }
    if(!email.contains('@')){
      return 'Please enter a valid email address';
    }
    if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)){
      return 'Please enter a valid email format';
    }
    return null;
  }

  String? checkPass(String password){
    if(password.isEmpty){
      return 'Password field cannot be empty';
    }
    if(password.length <6 ){
      return 'Password must be atleast contain 6 characters';
    }
    return null;
  }


  void validateEmail(){
    setState(() {
      mailError = checkEmail(newmailcontroller.text);
    });
  }
  void validatepass(){
    setState(() {
      passError = checkEmail(newpasscontroller.text);
    });
  }

  bool validateEverything(){
    setState(() {
      mailError = checkEmail(newmailcontroller.text);
      passError =checkPass(newpasscontroller.text);
    });
    return mailError == null && passError == null;
  }

  

  Future signUp() async{
    final email = newmailcontroller.text;
    final password = newpasscontroller.text;

    if(newpasscontroller.text == confirmpasscontroller.text){
      
      try {
  await authService.signUpWithEmailPassword(
    email, password);
} on Exception catch (e) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error  $e')));
}
  } else{
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Password doesn\'t  match')));
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
                  SizedBox(height: 10,),
                  
                   Center( 
                     child: Padding(
                       padding: const EdgeInsets.only(left: 5),
                       child: Image.asset('assets/images/signuplogo1.png',
                       height: 250,
                        ),
                       ),
                      ),

                      const SizedBox(height: 20,),

                      Text("Sign Up",
                  style: TextStyle(
                    fontSize: 30,
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



                  Text('Create a new account to continue',
                 style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[700],
                  
                  fontWeight: FontWeight.w600
                 ),
                 ),

                 SizedBox(height: 20,),
            
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 20),
                   child: MyTextField(
                    onChanged: (value) =>validateEverything(),
                    errorText: mailError,
                    textEditingController: newmailcontroller,
                    textInputType: null,
                    icon: Icon(Icons.mail,
                    color: Colors.grey[700],
                    ),
                    hintText: 'Email Address',
                    obsText: false,
                    showpass: null,
                   ),
                 ),

                 const SizedBox(height: 20,),

                  Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 20),
                   child: MyTextField(
                    onChanged: (value) =>validateEverything(),
                    errorText: passError,
                    textEditingController: newpasscontroller,
                    textInputType: null,
                    icon: Icon(Icons.password,
                    color: Colors.grey[700],
                    ),
                    hintText: 'Enter Password',
                    obsText: true,
                    showpass: IconButton(onPressed: (){}, icon: Icon(Icons.remove_red_eye_rounded)),
                   ),
                 ),

                 const SizedBox(height: 20,),

                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 20),
                   child: MyTextField(
                    onChanged: null,
                    errorText: null,
                    textEditingController: confirmpasscontroller,
                    textInputType: null,
                    icon: Icon(Icons.password,
                    color: Colors.grey[700],
                    ),
                    hintText: 'Confirm Password',
                    obsText: false,
                    showpass: null,
                   ),
                 ),


                 const SizedBox(height: 40,),
      
                GestureDetector(
                  onTap: signUp,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: MyButton(
                      buttontext: 'Sign Up',
                    ),
                  ),
                ),

                const SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Text('Already have an account?',
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