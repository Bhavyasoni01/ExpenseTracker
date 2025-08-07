import 'package:supabase_flutter/supabase_flutter.dart';


class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<AuthResponse> signInWithEmailPassword(String email, String password)  async{
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password);
  }

  Future<AuthResponse> signUpWithEmailPassword(String email, String password)  async{
    return await _supabase.auth.signUp(
      email: email,
      password: email,);
  }

  Future<void> signOut() async{
    await _supabase.auth.signOut();
  }

  String? getCurrentemail(){
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }


  Future<void> forgetPassword(String email) async{
    await _supabase.auth.resetPasswordForEmail(email);
  }



}
