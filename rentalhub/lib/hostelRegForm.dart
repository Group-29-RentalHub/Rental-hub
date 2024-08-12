import 'package:flutter/material.dart';
import 'package:halls/hostelnotifier.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; 
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
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
  LatLng _selectedLocation = LatLng(0.3152, 32.5816);
  @override
  void initState() {
    super.initState();
    for (String roomType in _roomTypes) {
      _selectedRoomTypes[roomType] = false; // Initialize as false for two-state
      _roomTypePrices[roomType] = TextEditingController();
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

    Map<String, dynamic> hostelData = {
      'name': _nameController.text,
      'location': GeoPoint(_selectedLocation.latitude, _selectedLocation.longitude),
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
      'createdAt': FieldValue.serverTimestamp(), 
    };

    final hostelRef = await FirebaseFirestore.instance.collection('hostels').add(hostelData);
    final hostel = await hostelRef.get();

    if (hostel.exists) {
      notifyUsersOnNewHostel(hostel.data() as Map<String, dynamic>);
    }

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
                  builder: (context) => const HostelListingsPage(),
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
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextInput(_nameController, 'Hostel Name', Icons.home),
               _buildTextInput(_numberOfRoomsController, 'Number of Rooms', Icons.meeting_room,
                  keyboardType: TextInputType.number),
              _buildTextInput(_contactNumberController, 'Contact Number', Icons.phone,
                  keyboardType: TextInputType.phone),
              _buildTextInput(_descriptionController, 'Description', Icons.description,
                  keyboardType: TextInputType.multiline),
              const SizedBox(height: 16.0),
              
              const SizedBox(height: 16.0),
 Container(
  child: Container(
    height: 300,
    color: Colors.grey[300],
    child: FlutterMap(
      options: MapOptions(
        initialCenter: _selectedLocation,
        initialZoom: 13.0,
        minZoom: 13.0,
         onTap: (tapPosition, point) {
          setState(() {
            _selectedLocation = point;
          });
        },
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c'],
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: _selectedLocation,
              child: const Icon(Icons.pin_drop) 
            ),
          ],
        ),
      ],
    ),
  ), 
),

              const Text(
                'Amenities',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
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
              const SizedBox(height: 16.0),
              ElevatedButton.icon(
                icon: const Icon(Icons.photo_library),
                label: const Text('Upload Images'),
                onPressed: _pickImages,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(70, 0, 119, 1),
                ),
              ),
              const SizedBox(height: 16.0),
              _images.isNotEmpty
                  ? Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: _images.map((image) {
                        return Stack(
                          children: [
                            Image.file(image, width: 100, height: 100, fit: BoxFit.cover),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                icon: const Icon(Icons.cancel, color: Colors.red),
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
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 16.0),
              ElevatedButton.icon(
                icon: const Icon(Icons.photo_library),
                label: const Text('Upload Profile Image'),
                onPressed: _pickProfileImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(70, 0, 119, 1),
                ),
              ),
              const SizedBox(height: 16.0),
              _profileImage != null
                  ? Stack(
                      children: [
                        Image.file(_profileImage!, width: 100, height: 100, fit: BoxFit.cover),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            icon: const Icon(Icons.cancel, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                _profileImage = null;
                              });
                            },
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 16.0),
              _buildTextInput(_managerNameController, 'Manager Name', Icons.person),
              _buildTextInput(_dobController, 'Date of Birth', Icons.cake),
              const SizedBox(height: 16.0),
              const Text(
                'Gender',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              ListTile(
                title: const Text('Male'),
                leading: Radio<String>(
                  value: 'Male',
                  groupValue: _selectedGender,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Female'),
                leading: Radio<String>(
                  value: 'Female',
                  groupValue: _selectedGender,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedGender = value;
                    });
                  },
                ),
              ),
              
              _buildTextInput(_ninController, 'NIN', Icons.credit_card),
              const SizedBox(height: 16.0),
              const Text(
                'Hostel Gender',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              ListTile(
                title: const Text('Male'),
                leading: Radio<String>(
                  value: 'Male',
                  groupValue: _selectedHostelGender,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedHostelGender = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Female'),
                leading: Radio<String>(
                  value: 'Female',
                  groupValue: _selectedHostelGender,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedHostelGender = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Mixed'),
                leading: Radio<String>(
                  value: 'Mixed',
                  groupValue: _selectedHostelGender,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedHostelGender = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Room Types and Prices',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              ..._roomTypes.map((roomType) {
                return Column(
                  children: [
                    CheckboxListTile(
                      title: Text(roomType),
                      value: _selectedRoomTypes[roomType],
                      onChanged: (bool? value) {
                        setState(() {
                          _selectedRoomTypes[roomType] = value ?? false;
                        });
                      },
                    ),
                    if (_selectedRoomTypes[roomType] == true)
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                        child: _buildTextInput(
                          _roomTypePrices[roomType]!,
                          'Price for $roomType',
                          Icons.attach_money,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                  ],
                );
              }).toList(),
              const SizedBox(height: 32.0),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(70, 0, 119, 1),
                      ),
                      child: const Text('Register Hostel'),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextInput(
    TextEditingController controller,
    String label,
    IconData icon, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
