import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/user_image.png'), // Replace with actual image
              ),
              const SizedBox(height: 16),
              const Text(
                'Leah Diane',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'leah.diane@gmail.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Navigate to Edit Profile screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(118, 36, 177, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.location_on, color: Colors.purple),
                      title: const Text('Address', style: TextStyle(color: Colors.black)),
                      subtitle: Text('123 Main St, Bugolobi Lule Ug', style: TextStyle(color: Colors.grey[600])),
                    ),
                    ListTile(
                      leading: const Icon(Icons.phone, color: Colors.purple),
                      title: const Text('Phone', style: TextStyle(color: Colors.black)),
                      subtitle: Text('+256 776 567 890', style: TextStyle(color: Colors.grey[600])),
                    ),
                    ListTile(
                      leading: const Icon(Icons.calendar_today, color: Colors.purple),
                      title: const Text('Date of Birth', style: TextStyle(color: Colors.black)),
                      subtitle: Text('January 1, 1990', style: TextStyle(color: Colors.grey[600])),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
