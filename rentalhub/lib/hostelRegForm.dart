import 'package:flutter/material.dart';
import 'package:halls/hostel_lists.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HostelRegistrationPage extends StatefulWidget {
  const HostelRegistrationPage({super.key});

  @override
  _HostelRegistrationPageState createState() => _HostelRegistrationPageState();
}

class _HostelRegistrationPageState extends State<HostelRegistrationPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _numberOfRoomsController = TextEditingController();
  final TextEditingController _pricePerRoomController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final Map<String, bool> _amenities = {
    'Wi-Fi': false,
    'Laundry Service': false,
    'Cafeteria': false,
    'Parking': false,
    'Security': false,
  };

  final List<File> _images = [];

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        _images.addAll(pickedFiles.map((file) => File(file.path)).toList());
      });
    }
  }

  Future<List<String>> _uploadImages(String userId) async {
    final storage = FirebaseStorage.instance.ref();
    List<String> imageUrls = [];
    try {
      for (File image in _images) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference ref = storage.child('hostel_images/$userId/$fileName');
        
        await ref.putFile(image);
        String downloadUrl = await ref.getDownloadURL();
        imageUrls.add(downloadUrl);
        //print('doneeeeeeeeeeeee');
      }
    } catch (e) {
      // Handle upload errors
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Image Upload Failed'),
          content: Text('Failed to upload images. Please try again. Error: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return [];
    }
    return imageUrls;
  }

  Future<void> _submitForm() async {
    if (_nameController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _numberOfRoomsController.text.isEmpty ||
        _pricePerRoomController.text.isEmpty ||
        _contactNumberController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _images.isEmpty) {
      // Display error if fields are empty
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Form Submission Failed'),
          content: const Text('Please fill in all fields and upload at least one image.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('No user is signed in.');
      }

      String userId = user.uid;
      
      // Upload images and get URLs
      List<String> imageUrls = await _uploadImages(userId);

      // Save form data to Firestore
      await FirebaseFirestore.instance.collection('hostels').add({
        'name': _nameController.text,
        'location': _locationController.text,
        'number_of_rooms': int.parse(_numberOfRoomsController.text),
        'price_per_room': double.parse(_pricePerRoomController.text),
        'contact_number': _contactNumberController.text,
        'description': _descriptionController.text,
        'amenities': _amenities,
        'userId': userId,
        'images': imageUrls, // Include image URLs
      });

      // Show success message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Hostel registration successful!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HostelsListPage(),
                ),
              ); // Optionally pop to previous page
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      // Handle errors
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Submission Failed'),
          content: Text('Failed to submit form. Please try again. Error: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hostel Registration', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromRGBO(70, 0, 119, 1), // Theme color
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextInput(_nameController, 'Hostel Name', Icons.home),
              _buildTextInput(_locationController, 'Location', Icons.location_on),
              _buildTextInput(_numberOfRoomsController, 'Number of Rooms', Icons.meeting_room,
                  keyboardType: TextInputType.number),
              _buildTextInput(_pricePerRoomController, 'Price per Room', Icons.attach_money,
                  keyboardType: TextInputType.number),
              _buildTextInput(_contactNumberController, 'Contact Number', Icons.phone,
                  keyboardType: TextInputType.phone),
              _buildTextInput(_descriptionController, 'Description', Icons.description,
                  keyboardType: TextInputType.multiline),
              const SizedBox(height: 16.0),
              const Text(
                'Amenities',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              ..._amenities.keys.map((String key) {
                return SwitchListTile(
                  title: Text(key),
                  value: _amenities[key]!,
                  onChanged: (bool value) {
                    setState(() {
                      _amenities[key] = value;
                    });
                  },
                );
              }),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _pickImages,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(70, 0, 119, 1), // Theme color
                ),
                child: const Text('Pick Images', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 16.0),
              _images.isEmpty
                  ? const Text('No images selected')
                  : SizedBox(
                      height: 100.0,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _images.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Stack(
                            children: [
                              Image.file(_images[index]),
                              Positioned(
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _images.removeAt(index);
                                    });
                                  },
                                  child: const Icon(Icons.remove_circle, color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(70, 0, 119, 1), // Theme color
                ),
                child: const Text('Submit', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextInput(TextEditingController controller, String label, IconData icon,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
      ),
    );
  }
}
