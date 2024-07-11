import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:io';
import 'package:image_picker/image_picker.dart'; // for image selection

class HostelRegistrationPage extends StatefulWidget {
  @override
  _HostelRegistrationPageState createState() => _HostelRegistrationPageState();
}

class _HostelRegistrationPageState extends State<HostelRegistrationPage> {
  final _formKey = GlobalKey<FormState>(); // Key for form state management
  String _name = "";
  String _description = "";
  String _location = "";
  String _telephone = "";
  XFile? _imageFile; // Stores the selected image file

  // Function to pick an image from the device
  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = pickedFile;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hostel Registration'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: "Hostel Name"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a hostel name';
                    }
                    return null;
                  },
                  onSaved: (value) => setState(() => _name = value!),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Description"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  onSaved: (value) => setState(() => _description = value!),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Location"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the location';
                    }
                    return null;
                  },
                  onSaved: (value) => setState(() => _location = value!),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Telephone"),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the telephone number';
                    }
                    return null;
                  },
                  onSaved: (value) => setState(() => _telephone = value!),
                ),
                TextButton.icon(
                  onPressed: _pickImage,
                  icon: Icon(Icons.image),
                  label: Text('Select Image'),
                ),
                if (_imageFile != null)
                  Image.file(File(_imageFile!.path)), // Display selected image
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      registerHostel(Hostel(
                          _name, _description, _location, _telephone, []));
                    }
                  },
                  child: Text('Register Hostel'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const String registerHostelUrl = "https://your-api.com/hostels";

class Hostel {
  final String name;
  final String description;
  final String location;
  final String telephone;
  final List<String> imageUrls; // Placeholder for future image upload handling

  Hostel(this.name, this.description, this.location, this.telephone,
      this.imageUrls);
}

Future<http.Response> registerHostel(Hostel hostel) async {
  try {
    var multipartRequest =
        http.MultipartRequest('POST', Uri.parse(registerHostelUrl));
    multipartRequest.fields['name'] = hostel.name;
    multipartRequest.fields['description'] = hostel.description;
    multipartRequest.fields['location'] = hostel.location;
    multipartRequest.fields['telephone'] = hostel.telephone;

    // Loop through images and add them to the request
    for (var imageUrl in hostel.imageUrls) {
      var multipartFile = await http.MultipartFile.fromPath('images', imageUrl);
      multipartRequest.files.add(multipartFile);
    }

    var response = await multipartRequest.send();
    var responseBytes = await response.stream.toBytes();
    var responseString = convert.utf8.decode(responseBytes);
    return http.Response(responseString, response.statusCode);
  } catch (error) {
    print("Error sending hostel registration request: $error");
    // Handle the error appropriately (e.g., retry, show error message)
    throw error; // Re-throw for further handling if needed
  }
}

void host() async {
  // Sample hostel data
  String hostelName = "Dream Hostel";
  String description = "A cozy hostel in the city center";
  String location = "Kampala, Uganda";
  String telephone = "+256 414 567890";
  List<String> imageUrls = ["path/to/image1.jpg", "path/to/image2.png"];

  Hostel hostel =
      Hostel(hostelName, description, location, telephone, imageUrls);

  // Send registration request with images
  try {
    var response = await registerHostel(hostel);

    if (response.statusCode == 200) {
      print("Hostel registered successfully!");
    } else {
      print("Error registering hostel: ${response.reasonPhrase}");
    }
  } catch (error) {
    print("Error during hostel registration process: $error");
  }
}
