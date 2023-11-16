import 'package:flutter/material.dart';

import '../main.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController hospitalNameController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    hospitalNameController.dispose();
    super.dispose();
  }

  Future<void> getInitialProfile() async {
    final userId = supabase.auth.currentUser!.id;
    final data =
        await supabase.from('profiles').select().eq('id', userId).single();
    setState(() {
      userNameController.text = data['username'];
      hospitalNameController.text = data['hospitalname'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Account',
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(12),
        children: [
          TextFormField(
            controller: userNameController,
            decoration: InputDecoration(
              label: Text(
                'Username',
              ),
            ),
          ),
          SizedBox(height: 12),
          TextFormField(
            controller: hospitalNameController,
            decoration: InputDecoration(
              label: Text(
                'Hospital Name',
              ),
            ),
          ),
          SizedBox(height: 12),
          ElevatedButton(
            onPressed: () async {
              final userName = userNameController.text.trim();
              final hospitalName = hospitalNameController.text.trim();
              final userId = supabase.auth.currentUser!.id;
              await supabase.from('profiles').update(
                {
                  'username': userName,
                  'hospitalname': hospitalName,
                },
              ).eq(
                'id',
                userId,
              );
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Your data has been saved',
                    ),
                  ),
                );
              }
            },
            child: Text(
              'Save',
            ),
          ),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}
