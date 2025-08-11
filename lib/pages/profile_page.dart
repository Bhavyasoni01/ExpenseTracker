import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/auth/auth_service.dart';
import 'package:notes_app/components/tiles_profile.dart';
import 'package:notes_app/pages/settings.dart';

class ProfilePage extends StatefulWidget {
const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final authService =AuthService();

  void signOut()async{
    await authService.signOut();
  } 
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          children: [
            //heder
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xFF4FC3F7), Color(0xFF9C27B0), Color(0xFFE91E63),   
          ],
          tileMode: TileMode.clamp,
          begin: Alignment.topRight,
          end: Alignment.bottomRight),
              ),
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Text('Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),),
                  SizedBox(height: 30,),

                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white),

                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Icon(CupertinoIcons.person_fill,
                      size: 50,
                      color: Colors.grey[600],),
                    ),
                  ),

                  const SizedBox(height: 19,),
                  Text('Username',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),),
                  
                  SizedBox(height: 30,),
                ],

              ),
            ),

            SizedBox(height: 30,),

            //Menuuuu

            Padding(padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                // Settings tile

                TilesProfile(
                  icon: Icons.settings, 
                  title: 'Settings', 
                  subtitle: 'App Prefrences', 
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
                  },
                ),

                SizedBox(height: 15,),

                //Appp INfo tile

                TilesProfile(
                  icon: Icons.info,
                  title: 'App Info',
                  subtitle: 'Version, terms and Privacy Policy',
                  onTap: () {},
                ),

                  SizedBox(height: 15,),

                  TilesProfile(
                  icon: CupertinoIcons.question_circle_fill,
                  title: 'Help and Support',
                  subtitle: 'Get Help and support',
                  onTap: () {},
                ),

                SizedBox(height: 40,),

               

              ],
            ),),
            
          ],
        ),
      )),
    );
  }
}