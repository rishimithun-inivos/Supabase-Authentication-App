import 'package:flutter/material.dart';
import 'package:supabase_authentication_trial/pages/account_screen.dart';
import 'package:supabase_authentication_trial/pages/login_screen.dart';
import 'package:supabase_authentication_trial/pages/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'database_sample/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://fpjqdlxdxsxbhyezyaur.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZwanFkbHhkeHN4Ymh5ZXp5YXVyIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDAxMDQ0NDAsImV4cCI6MjAxNTY4MDQ0MH0.8ULcSwrE0TomXzVNbFAn1qeZ610256atdLeah58A2jc',
    authFlowType: AuthFlowType.pkce,
  );
  runApp(MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/account': (context) => AccountScreen(),
      },
    );
  }
}
