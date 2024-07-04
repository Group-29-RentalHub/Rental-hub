import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromRGBO(116, 62, 155, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/user_image.png'), // Replace with actual image
            ),
            SizedBox(height: 16),
            Text(
              'Leah Diane',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'leah.diane@gmail.com',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigate to Edit Profile screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(118, 36, 177, 1),
              ),
              child: Text(
                'Edit Profile',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 32),
            Expanded(
              child: ListView(
                children: [
                  Center(
                    child: Container(
                      width: 300, // Adjust the width as needed
                      child: ListTile(
                        leading: Icon(Icons.location_on),
                        title: Text('Address'),
                        subtitle: Text('123 Main St, Bugolobi Lule Ug'),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 300, // Adjust the width as needed
                      child: ListTile(
                        leading: Icon(Icons.phone),
                        title: Text('Phone'),
                        subtitle: Text('+256 776 567 890'),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 300, // Adjust the width as needed
                      child: ListTile(
                        leading: Icon(Icons.calendar_today),
                        title: Text('Date of Birth'),
                        subtitle: Text('January 1, 1990'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
