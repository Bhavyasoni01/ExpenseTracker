import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/pages/home_page.dart';
import 'package:notes_app/pages/settings.dart';
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
  


    runApp(MyApp());

}


class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const MyApp({super.key, this.savedThemeMode});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Navigation(),
    );
  }
}
