import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  late final StreamSubscription<AuthState> authSubscription;

  @override
  void initState() {
    super.initState();
    authSubscription = supabase.auth.onAuthStateChange.listen((event) {
      final session = event.session;
      if (session != null) {
        Navigator.of(context).pushReplacementNamed(
          '/account',
        );
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    authSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              label: Text('Email'),
            ),
          ),
          SizedBox(height: 12),
          ElevatedButton(
            onPressed: () async {
              try {
                final email = emailController.text.trim();
                await supabase.auth.signInWithOtp(
                  email: email,
                  emailRedirectTo:
                      'io.supabase.flutterquickstart://login-callback/',
                );

                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Check your inbox'),
                    ),
                  );
                }
              } on AuthException catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      e.toString(),
                    ),
                  ),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      e.toString(),
                    ),
                  ),
                );
              }
            },
            child: Text(
              'Login',
            ),
          ),
        ],
      ),
    );
  }
}
