import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:rentalhub/user/EditProfile.dart';




class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _image;

  Future<void> _getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white, 
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              GestureDetector(
              onTap: _getImageFromGallery,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[200],
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null
                    ? Icon(
                        Icons.camera_alt,
                        size: 50,
                        color: Colors.grey[800],
                      )
                    : null,
              ),
            ),
            // SizedBox(height: 20),
            // Text(
            //   'Tap to change profile picture',
            //   style: TextStyle(fontSize: 16),),
              //CircleAvatar(
                //radius: 50,
                //backgroundImage: AssetImage('assets/user_image.png'), // Replace with actual image
              //),
              SizedBox(height: 16),
              Text(
                'Leah Diane',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              
              SizedBox(height: 8),
              Text(
                'leah.diane@gmail.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                   context,
                     MaterialPageRoute(builder: (context) => EditProfilePage()),
    );
                  // Navigate to Edit Profile screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(118, 36, 177, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
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
                    ListTile(
                      leading: Icon(Icons.location_on, color: Colors.purple),
                      title: Text('Address', style: TextStyle(color: Colors.black)),
                      subtitle: Text('123 Main St, Bugolobi Lule Ug', style: TextStyle(color: Colors.grey[600])),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone, color: Colors.purple),
                      title: Text('Phone', style: TextStyle(color: Colors.black)),
                      subtitle: Text('+256 776 567 890', style: TextStyle(color: Colors.grey[600])),
                    ),
                    ListTile(
                      leading: Icon(Icons.calendar_today, color: Colors.purple),
                      title: Text('Date of Birth', style: TextStyle(color: Colors.black)),
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
