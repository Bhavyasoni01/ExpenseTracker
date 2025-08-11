import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
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
  

    final savedThemeMode  =await AdaptiveTheme.getThemeMode();

    runApp(MyApp(savedThemeMode: savedThemeMode));

}


class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const MyApp({super.key, this.savedThemeMode});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0
        )), 
      dark: ThemeData(useMaterial3: true,
      brightness: Brightness.dark,
      colorSchemeSeed: Colors.blue,
      scaffoldBackgroundColor: Colors.grey[900],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        elevation: 0
      )),
      initial: savedThemeMode ?? AdaptiveThemeMode.dark, 
      builder: (theme, darkTheme) => MaterialApp(
        home: Navigation(),
        theme: theme,
        darkTheme: darkTheme,
      ),
    );
  }
}
