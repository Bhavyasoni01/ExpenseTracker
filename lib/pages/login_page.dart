import 'package:flutter/material.dart';
import 'package:notes_app/auth/auth_service.dart';
import 'package:notes_app/pages/forget_pass.dart';
import 'package:notes_app/pages/reg_page.dart';
import 'package:notes_app/utils/login_tile.dart';
import 'package:notes_app/utils/my_button.dart';
import 'package:notes_app/utils/my_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  final authService = AuthService();

  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

  

  String? emailError;
  String? passwordError;

  String? validateEmail(String email){
    if(email.isEmpty){
      return 'Email Cannot be empty';
    }
    if(!email.contains('@')){
      return 'Please enter a valid email address';
    }
    if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)){
      return 'Please enter a valid email format';
    }
    return null;
  }

  String? validatePassword(String password){
    if(password.isEmpty){
      return 'Password field cannot be empty';
    }
    if(password.length < 6){
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  bool checkEverything(){
    setState(() {
      emailError = validateEmail(emailcontroller.text);
      passwordError = validatePassword(passwordcontroller.text);
    });
    return emailError == null && passwordError ==null;
  }
  
  

  Future signIn()async{

    final email = emailcontroller.text;
    final password = passwordcontroller.text;

    showDialog(context: context, builder: (context){
      return Center(child: CircularProgressIndicator()); 
    });

    if (checkEverything()) {
  try {
    
  
    await authService.signInWithEmailPassword(
    email , 
    password );
    
  } catch (e) {
  
    if(e.toString().contains('invalid_credentials')){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Incorrect email or password")));
      Navigator.of(context).pop();
      return;
    } 
    else      
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error $e'),
    dismissDirection: DismissDirection.down,));
    
  }
} else {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter Valid email or password"
  ),
  duration: Duration(milliseconds: 100),));
}

    Navigator.of(context).pop();
    
  }

  bool showPass = false;
  




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
                SizedBox(height: 20,),
                
                 Center(
                  
                   child: Padding(
                     padding: const EdgeInsets.only(left: 20),
                     child: Image.asset('assets/images/imagelogo.png',
                     height: 250,
                     ),
                   ),
                 ),
            
                  SizedBox(height: 20,),
            
                  Text("Sign In",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[600]
                  ),),
            
                 SizedBox(height: 20,),
            
                 Text('Enter valid username & password to continue',
                 style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w700
                 ),
                 ),
            
                 SizedBox(height: 20,),
            
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 20),
                   child: MyTextField(
                    onChanged: (value) =>checkEverything(),
                    textEditingController: emailcontroller,
                    errorText: emailError ,
                    textInputType: TextInputType.emailAddress,
                    icon: Icon(Icons.mail,
                    color: Colors.grey[700],
                    ),
                    hintText: 'Email Address',
                    obsText: false,
                    showpass: null,
                   ),
                 ),
            
                 SizedBox(height: 20,),
            
            
                Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 20),
                   child: Focus(
                     child: MyTextField(
                      onChanged: (value) =>checkEverything(),
                      textEditingController: passwordcontroller,
                      errorText: passwordError,
                      textInputType: TextInputType.text,
                      icon: Icon(Icons.password,
                      color: Colors.grey[700],
                      ),
                      hintText: 'Password',
                      obsText: showPass,
                      showpass: IconButton(onPressed: (){
                        setState(() {
                          showPass = !showPass;
                        });
                      }, icon: Icon(showPass? Icons.remove_red_eye_rounded : Icons.visibility_off)),
                     ),
                   ),
                 ),
      
                 const SizedBox(height: 10,),
      
                 Padding(
                   padding: const EdgeInsets.only(right: 20),
                   child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPassPage())),
                        child: Text('Forget Password?',
                        style: TextStyle(
                          color: Colors.blue[900],
                          fontWeight: FontWeight.w500
                        ),),
                      )
                    ],
                   ),
                 ),
      
                const SizedBox(height: 20,),
      
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: GestureDetector(
                    onTap: signIn,
                    child: MyButton(
                      buttontext: 'Login',
                    ),
                  ),
                ),
      
                const SizedBox(height: 20,),
      
                  Padding(
                    padding: const EdgeInsets.only(left: 100,
                    right: 100),
                    child: Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 2,
                            color: Colors.grey[400],
                          ),
                        ),
                    
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text('or continue with',style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500
                            ),),
                          ),
                    
                         Expanded(
                          child: Divider(
                            thickness: 2,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
      
      
                  const SizedBox(height: 20,),
      
                  Row(
                    children: [
                      Padding(padding: EdgeInsetsGeometry.only(left: 50)),
                      Center(
                        child: GestureDetector(
                          onTap:(){

                          } ,
                          child: LoginTile(
                            logo: 'assets/images/google.png',
                            logoText: 'Google',
                          ),
                        ),
                      ),
      
                      const SizedBox(width: 10,),
                      Center(child: LoginTile(logoText: 'Facebook', logo: 'assets/images/facebook.png'))
                    ],
                  ),
      
                  const SizedBox(height: 20,),
      
      
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don\'t have an account ? ',
                      style: TextStyle(fontSize: 16,
                      fontWeight: FontWeight.w500),),
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>RegPage())),
                        child: Text('Register Now',
                        style: TextStyle(fontSize: 16,
                        color: Colors.blue[900],
                        fontWeight: FontWeight.w500),),
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