// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';


// void signIn(){

// }
// class GoogleSigin extends StatelessWidget {
  
//    GoogleSigin({super.key});

//     final supabase = Supabase.instance.client;


//   @override
//   Widget build(BuildContext context) {
    
//     return const Placeholder();
//   }
// }
// Future<AuthResponse> _googleSignIn() async {

//   const webClientId = '449643691720-eh16klpu7ttni3euh7q612eivna1uaqk.apps.googleusercontent.com';

//   const iosClientId = '449643691720-i8n7t781f6eevdr767p66brkrmad2b0v.apps.googleusercontent.com';

//   final GoogleSignIn signIn = GoogleSignIn.instance;;
//   final googleUser = await .signIn();
//   final googleAuth = await googleUser!.authentication;
//   final accessToken = googleAuth.accessToken;
//   final idToken = googleAuth.idToken;

//   if (accessToken == null) {
//     throw 'No Access Token found.';
//   }
//   if (idToken == null) {
//     throw 'No ID Token found.';
//   }

//   await supabase.auth.signInWithIdToken(
//     provider: OAuthProvider.google,
//     idToken: idToken,
//     accessToken: accessToken,
//   );
// }