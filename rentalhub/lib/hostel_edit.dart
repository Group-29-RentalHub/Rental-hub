import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'hostel_lists.dart';

class EditHostelPage extends StatefulWidget {
  final String hostelId; // Assuming you pass the hostel ID to fetch existing data

  const EditHostelPage({super.key, required this.hostelId});

  @override
  _EditHostelPageState createState() => _EditHostelPageState();
}

class _EditHostelPageState extends State<EditHostelPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _numberOfRoomsController = TextEditingController();
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
  final Map<String, bool> _selectedRoomTypes = {};
  final Map<String, TextEditingController> _roomTypePrices = {};
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
      _selectedRoomTypes[roomType] = false;
      _roomTypePrices[roomType] = TextEditingController();
    }
    _loadHostelData();
  }

  Future<void> _loadHostelData() async {
    try {
      final doc = await FirebaseFirestore.instance.collection('hostels').doc(widget.hostelId).get();
      final data = doc.data();

      if (data != null) {
        _nameController.text = data['name'] ?? '';
        _locationController.text = data['location'] ?? '';
        _numberOfRoomsController.text = data['number_of_rooms'].toString();
        _contactNumberController.text = data['contact_number'] ?? '';
        _descriptionController.text = data['description'] ?? '';
        _managerNameController.text = data['manager_name'] ?? '';
        _dobController.text = data['dob'] ?? '';
        _ninController.text = data['nin'] ?? '';
        _selectedHostelGender = data['hostel_gender'];
        _selectedGender = data['gender'];

        // Set amenities
        _amenities.forEach((key, _) {
          _amenities[key] = data['amenities'][key] ?? false;
        });

        // Set room types and prices
        if (data['room_types'] != null) {
          data['room_types'].forEach((roomType, price) {
            _selectedRoomTypes[roomType] = true;
            _roomTypePrices[roomType]?.text = price.toString();
          });
        }

        // Load existing images (if any)
        setState(() {
          _images.addAll(data['images'].map<File>((url) => File(url)).toList());
        });
      }
    } catch (e) {
      // Handle error
      print('Error loading hostel data: $e');
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
        _contactNumberController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _images.isEmpty ||
        _managerNameController.text.isEmpty ||
        _dobController.text.isEmpty ||
        _ninController.text.isEmpty || 
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

    // Ensure all selected room types have prices
    for (String roomType in _roomTypes) {
      if (_selectedRoomTypes[roomType] == true && _roomTypePrices[roomType]!.text.isEmpty) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Form Submission Failed'),
            content: Text('Please enter a price for $roomType.'),
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

      Map<String, double> roomTypePrices = {};
      _roomTypes.forEach((roomType) {
        if (_selectedRoomTypes[roomType] == true) {
          roomTypePrices[roomType] = double.parse(_roomTypePrices[roomType]!.text);
        }
      });

      await FirebaseFirestore.instance.collection('hostels').doc(widget.hostelId).update({
        'name': _nameController.text,
        'location': _locationController.text,
        'number_of_rooms': int.parse(_numberOfRoomsController.text),
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
        'room_types': roomTypePrices,
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Hostel details updated successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HostelListingsPage(),
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
          title: const Text('Update Failed'),
          content: Text('Failed to update hostel details. Please try again. Error: $e'),
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
        title: const Text('Edit Hostel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Profile Image
            GestureDetector(
              onTap: _pickProfileImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!)
                    : null,
                child: _profileImage == null
                    ? const Icon(Icons.camera_alt, size: 50)
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            // Hostel Name
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Hostel Name'),
            ),
            // Location
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: 'Location'),
            ),
            // Number of Rooms
            TextField(
              controller: _numberOfRoomsController,
              decoration: const InputDecoration(labelText: 'Number of Rooms'),
              keyboardType: TextInputType.number,
            ),
            // Contact Number
            TextField(
              controller: _contactNumberController,
              decoration: const InputDecoration(labelText: 'Contact Number'),
            ),
            // Description
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            // Manager Name
            TextField(
              controller: _managerNameController,
              decoration: const InputDecoration(labelText: 'Manager Name'),
            ),
            // Date of Birth
            TextField(
              controller: _dobController,
              decoration: const InputDecoration(labelText: 'Date of Birth'),
              keyboardType: TextInputType.datetime,
            ),
            // National ID Number
            TextField(
              controller: _ninController,
              decoration: const InputDecoration(labelText: 'National ID Number'),
            ),
            // Hostel Gender
            DropdownButtonFormField<String>(
              value: _selectedHostelGender,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedHostelGender = newValue;
                });
              },
              items: <String>['Boys', 'Girls', 'Mixed'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Hostel Gender'),
            ),
            // Room Types
            ..._roomTypes.map((roomType) {
              return CheckboxListTile(
                title: Text(roomType),
                value: _selectedRoomTypes[roomType] ?? false,
                onChanged: (bool? value) {
                  setState(() {
                    _selectedRoomTypes[roomType] = value ?? false;
                  });
                },
                subtitle: _selectedRoomTypes[roomType] ?? false
                    ? TextField(
                        controller: _roomTypePrices[roomType],
                        decoration: InputDecoration(
                          labelText: 'Price for $roomType',
                          prefixText: 'UGX ',
                        ),
                        keyboardType: TextInputType.number,
                      )
                    : null,
              );
            }).toList(),
            // Amenities
            ..._amenities.keys.map((amenity) {
              return CheckboxListTile(
                title: Text(amenity),
                value: _amenities[amenity],
                onChanged: (bool? value) {
                  setState(() {
                    _amenities[amenity] = value ?? false;
                  });
                },
              );
            }).toList(),
            // Images
            if (_images.isNotEmpty)
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _images.map((image) {
                  return Stack(
                    children: [
                      Image.file(image, width: 100, height: 100, fit: BoxFit.cover),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              _images.remove(image);
                            });
                          },
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ElevatedButton(
              onPressed: _pickImages,
              child: const Text('Pick Images'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _submitForm,
              child: _isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
