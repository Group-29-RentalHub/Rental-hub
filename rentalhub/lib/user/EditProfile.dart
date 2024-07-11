import 'package:flutter/material.dart';


class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(10))),
              ),
            ),
            SizedBox(height: 3),
            
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(10))),
              ),
            ),
            // Add more TextFields or DropdownButtons for other profile information
            ElevatedButton(
              onPressed: () {
                // Add logic to save the edited profile information
              },
              child: Text('Save Profile'),
            ),
          ],
        ),
      ),
    );
  }
}