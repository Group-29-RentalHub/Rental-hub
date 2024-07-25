import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'hostel_lists.dart';

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
  final TextEditingController _managerNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _ninController = TextEditingController();

  String? _selectedHostelGender;
  final List<String> _roomTypes = [
    'Double Self-Contained',
    'Double Non-Self-Contained',
    'Single Self-Contained',
    'Single Non-Self-Contained',
  ];
  final Map<String, bool?> _selectedRoomTypes = {};
  String? _selectedGender;
  File? _profileImage;
  final Map<String, bool> _amenities = {
    'Wi-Fi': false,
    'Laundry Service': false,
    'Cafeteria': false,
    'Parking': false,
    'Security': false,
  };
  final List<File> _images = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    for (String roomType in _roomTypes) {
      _selectedRoomTypes[roomType] = null; // Initialize as null for tristate
    }
  }

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        _images.addAll(pickedFiles.map((file) => File(file.path)).toList());
      });
    }
  }

  Future<void> _pickProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
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
      }
    } catch (e) {
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
        _images.isEmpty ||
        _managerNameController.text.isEmpty ||
        _dobController.text.isEmpty ||
        _ninController.text.isEmpty ||
        _selectedGender == null ||
        _profileImage == null ||
        _selectedHostelGender == null ||
        !_selectedRoomTypes.values.any((value) => value == true)) {
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

    setState(() {
      _isLoading = true;
    });

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('No user is signed in.');
      }

      String userId = user.uid;

      List<String> imageUrls = await _uploadImages(userId);

      final storage = FirebaseStorage.instance.ref();
      String profileImageUrl = '';
      if (_profileImage != null) {
        String profileImageName = DateTime.now().millisecondsSinceEpoch.toString();
        Reference ref = storage.child('profile_images/$userId/$profileImageName');
        await ref.putFile(_profileImage!);
        profileImageUrl = await ref.getDownloadURL();
      }

      await FirebaseFirestore.instance.collection('hostels').add({
        'name': _nameController.text,
        'location': _locationController.text,
        'number_of_rooms': int.parse(_numberOfRoomsController.text),
        'price_per_room': double.parse(_pricePerRoomController.text),
        'contact_number': _contactNumberController.text,
        'description': _descriptionController.text,
        'amenities': _amenities,
        'userId': userId,
        'images': imageUrls,
        'manager_name': _managerNameController.text,
        'dob': _dobController.text,
        'gender': _selectedGender,
        'profile_image': profileImageUrl,
        'nin': _ninController.text,
        'hostel_gender': _selectedHostelGender,
        'room_types': _selectedRoomTypes,
      });

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
                ); 
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
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
    } finally {
      setState(() {
        _isLoading = false;
      });
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
              const Text(
                'Hostel Gender',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Male'),
                      value: 'Male',
                      groupValue: _selectedHostelGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedHostelGender = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Female'),
                      value: 'Female',
                      groupValue: _selectedHostelGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedHostelGender = value;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Mixed'),
                      value: 'Mixed',
                      groupValue: _selectedHostelGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedHostelGender = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Room Types',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              ..._roomTypes.map((roomType) {
                return CheckboxListTile(
                  title: Text(roomType),
                  value: _selectedRoomTypes[roomType] ?? false,
                  onChanged: (bool? value) {
                    setState(() {
                      _selectedRoomTypes[roomType] = value;
                    });
                  },
                );
              }).toList(),
              const SizedBox(height: 16.0),
              const Text(
                'Personal Information',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              _buildTextInput(_managerNameController, 'Manager Name', Icons.person),
              _buildTextInput(_dobController, 'Date of Birth (YYYY-MM-DD)', Icons.calendar_today),
              _buildTextInput(_ninController, 'National ID Number', Icons.credit_card),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _pickProfileImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(70, 0, 119, 1), // Theme color
                ),
                child: const Text('Pick Profile Image'),
              ),
              const SizedBox(height: 16.0),
              _profileImage == null
                  ? const Text('No profile image selected')
                  : Image.file(_profileImage!),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(70, 0, 119, 1), // Theme color
                ),
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextInput(
    TextEditingController controller,
    String labelText,
    IconData icon, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
      ),
    );
  }
}
