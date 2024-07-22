import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:halls/services/authentication.dart';
import 'hall.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthMethod _authMethod = AuthMethod();
  late User? _user;

  @override
  void initState() {
    super.initState();
    _user = _authMethod.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      automaticallyImplyLeading: false,
        title: const Text('Profile'),
        backgroundColor: Colors.green,
      ),
      body: _user != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${_user!.displayName ?? 'No name provided'}',
                      style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 10),
                  Text('Email: ${_user!.email}',
                      style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 10),
                  // Add more fields as needed
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      await _authMethod.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Hall()),
                      );
                    },
                    child: const Text('RETURN TO HOMESCREEN'),
                  ),
                ],
              ),
            )
          : const Center(child: Text('User data not found')),
    );
  }
}
