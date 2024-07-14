import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class HostelRegistrationPage extends StatefulWidget {
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

  List<File> _images = [];

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? pickedFiles = await picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _images.addAll(pickedFiles.map((file) => File(file.path)).toList());
      });
    }
  }

  Widget _buildTextInput(TextEditingController controller, String labelText, IconData icon,
      {TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
          prefixIcon: Icon(icon),
        ),
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $labelText';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hostel Registration', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromRGBO(70, 0, 119, 1), // Theme color
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
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
              SizedBox(height: 16.0),
              Text(
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
              }).toList(),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _pickImages,
                child: Text('Pick Images', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(70, 0, 119, 1), // Theme color
                ),
              ),
              SizedBox(height: 16.0),
              _images.isEmpty
                  ? Text('No images selected')
                  : Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: _images.map((image) {
                        return Stack(
                          children: [
                            Image.file(image, width: 100, height: 100, fit: BoxFit.cover),
                            Positioned(
                              right: 0,
                              child: IconButton(
                                icon: Icon(Icons.remove_circle, color: Colors.red),
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
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Handle form submission
                },
                child: Text('Submit', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(70, 0, 119, 1), // Theme color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}