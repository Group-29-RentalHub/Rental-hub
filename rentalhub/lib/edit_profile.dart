import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'models/userprofile.dart'; // Ensure this path is correct

class EditProfile extends StatefulWidget {
  final String userId;

  const EditProfile({Key? key, required this.userId}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  bool _isUpdating = false; // Flag to track the loading state

  late String _name;
  late String _email;
  late String _address;
  late String _phone;
  late String _dateOfBirth;
  String? _imageUrl; // URL of the uploaded image

  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(widget.userId).get();
    final userProfile = UserProfile.fromFirestore(doc);

    setState(() {
      _name = userProfile.name;
      _email = userProfile.email;
      _address = userProfile.address;
      _phone = userProfile.phone;
      _dateOfBirth = userProfile.dateOfBirth;
      _imageUrl = userProfile.imageUrl; // Load the image URL
    });
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      setState(() {
        _isUpdating = true; // Set the flag to true
      });

      try {
        await FirebaseFirestore.instance.collection('users').doc(widget.userId).update({
          'name': _name,
          'email': _email,
          'address': _address,
          'phone': _phone,
          'dateOfBirth': _dateOfBirth,
          'imageUrl': _imageUrl, // Update the image URL
        });

        Navigator.pop(context);
      } catch (e) {
        // Handle error if necessary
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update profile: $e')),
        );
      } finally {
        setState(() {
          _isUpdating = false; // Set the flag to false
        });
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final Uint8List file = await pickedFile.readAsBytes(); // Read as bytes
      final fileName = DateTime.now().toIso8601String(); // Unique name for the file
      final ref = FirebaseStorage.instance.ref().child('profile_images/$fileName');

      try {
        await ref.putData(file);
        final downloadUrl = await ref.getDownloadURL();
        setState(() {
          _imageUrl = downloadUrl; // Save the image URL
        });
      } catch (e) {
        // Handle error if necessary
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload image: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isUpdating
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    const Text('Updating Profile....'),
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: _imageUrl != null
                              ? NetworkImage(_imageUrl!)
                              : const AssetImage('assets/default_profile.png') as ImageProvider,
                          child: const Align(
                            alignment: Alignment.bottomRight,
                            child: Icon(Icons.camera_alt, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildTextField('Name', _name, (value) => _name = value ?? ''),
                      _buildTextField('Email', _email, (value) => _email = value ?? ''),
                      _buildTextField('Address', _address, (value) => _address = value ?? ''),
                      _buildTextField('Phone', _phone, (value) => _phone = value ?? ''),
                      _buildTextField('Date of Birth', _dateOfBirth, (value) => _dateOfBirth = value ?? ''),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _updateProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(118, 36, 177, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Save Changes',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildTextField(String label, String initialValue, void Function(String?) onSaved) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200], // Very light grey background
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
        child: TextFormField(
          initialValue: initialValue,
          decoration: InputDecoration(
            labelText: label,
            border: InputBorder.none, // No border
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0), // Adjust padding
          ),
          onSaved: onSaved,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            return null;
          },
        ),
      ),
    );
  }
}
