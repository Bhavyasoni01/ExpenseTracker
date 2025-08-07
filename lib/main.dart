import 'package:flutter/material.dart';
import 'package:notes_app/services/hive_services.dart';
import 'package:notes_app/utils/navigation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: ('url here'),

    anonKey: 'anonKey Here',
  );

  await HiveService.init();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Navigation(),
    );
    
    
    
    
    
    
    
    }
}
