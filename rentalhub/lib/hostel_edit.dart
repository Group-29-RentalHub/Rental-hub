import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:halls/models/hostel.dart';

class EditHostelPage extends StatefulWidget {
  final Hostel hostel;

  const EditHostelPage({required this.hostel});

  @override
  _EditHostelPageState createState() => _EditHostelPageState();
}

class _EditHostelPageState extends State<EditHostelPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _locationController;
  late TextEditingController _numberOfRoomsController;
  late TextEditingController _pricePerRoomController;
  late TextEditingController _contactNumberController;
  late TextEditingController _descriptionController;
  late TextEditingController _amenitiesController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.hostel.name);
    _locationController = TextEditingController(text: widget.hostel.location);
    _numberOfRoomsController = TextEditingController(text: widget.hostel.numberOfRooms.toString());
    _pricePerRoomController = TextEditingController(text: widget.hostel.pricePerRoom.toString());
    _contactNumberController = TextEditingController(text: widget.hostel.contactNumber);
    _descriptionController = TextEditingController(text: widget.hostel.description);
    _amenitiesController = TextEditingController(text: widget.hostel.amenities.join(', '));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _numberOfRoomsController.dispose();
    _pricePerRoomController.dispose();
    _contactNumberController.dispose();
    _descriptionController.dispose();
    _amenitiesController.dispose();
    super.dispose();
  }

  Future<void> _updateHostel() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('hostels').doc(widget.hostel.id).update({
          'name': _nameController.text,
          'location': _locationController.text,
          'number_of_rooms': int.parse(_numberOfRoomsController.text),
          'price_per_room': double.parse(_pricePerRoomController.text),
          'contact_number': _contactNumberController.text,
          'description': _descriptionController.text,
          'amenities': _amenitiesController.text.split(',').map((s) => s.trim()).toList(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hostel updated successfully!')),
        );

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating hostel: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Hostel'),
        backgroundColor: const Color.fromRGBO(70, 0, 119, 1),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a location';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _numberOfRoomsController,
                decoration: InputDecoration(labelText: 'Number of Rooms'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the number of rooms';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _pricePerRoomController,
                decoration: InputDecoration(labelText: 'Price per Room'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the price per room';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _contactNumberController,
                decoration: InputDecoration(labelText: 'Contact Number'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a contact number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _amenitiesController,
                decoration: InputDecoration(labelText: 'Amenities (comma-separated)'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter amenities';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateHostel,
                style: ElevatedButton.styleFrom(
                  // primary: const Color.fromRGBO(70, 0, 119, 1),
                ),
                child: Text('Update Hostel'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
