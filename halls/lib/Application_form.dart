import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'hall.dart';
import 'roomallocation_screen.dart';



class Student extends StatefulWidget {
  const Student({super.key});

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _sexController = TextEditingController();
  final TextEditingController _registrationController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _yearOfStudyController = TextEditingController();
  final TextEditingController _collegeController = TextEditingController();
  final TextEditingController _hallOfAttachmentController = TextEditingController();
  String _studentType = 'Fresher';  // Default value
  String? _points;
  String? _cgpa;

  String? _selectedStudentType; // Initialize as null
  bool _hasDisability = false;
  bool _isContinuingResident = false;

  void _submitForm() async {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();
    
    // Ensure _points and _cgpa are correctly populated
    print('_points: $_points');
    print('_cgpa: $_cgpa');
    
    try {
      await FirebaseFirestore.instance.collection('students').add({
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'sex': _sexController.text,
        'registrationNumber': _registrationController.text,
        'email': _emailController.text,
        'yearOfStudy': _yearOfStudyController.text,
        'college': _collegeController.text,
        'hallOfAttachment': _hallOfAttachmentController.text,
        'studentType': _selectedStudentType,
        'points': _points ?? '',
        'cgpa': _cgpa ?? '',
        'hasDisability': _hasDisability,
        'isContinuingResident': _isContinuingResident,
        'timestamp': FieldValue.serverTimestamp(),
      });
      
      // Navigate to the next screen after successful submission
      Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) {
          return  RoomAllocationScreen();
        }),
      );
      
    } catch (e) {
      print('Error saving to Firestore: $e');
      // Handle error as needed
    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("Hall Application Form"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    hintText: 'Enter your given name',
                    labelStyle: TextStyle(fontSize: 16, color: Colors.black),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    hintText: "Your Surname name",
                    labelStyle: TextStyle(fontSize: 16, color: Colors.black),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _sexController,
                  decoration: const InputDecoration(
                    labelText: 'Sex',
                    hintText: "Your sex",
                    labelStyle: TextStyle(fontSize: 16, color: Colors.black),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your sex';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _registrationController,
                  decoration: const InputDecoration(
                    labelText: 'Registration Number',
                    hintText: "Your University Reg no.",
                    labelStyle: TextStyle(fontSize: 16, color: Colors.black),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your registration number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: "Your personal email",
                    labelStyle: TextStyle(fontSize: 16, color: Colors.black),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _yearOfStudyController,
                  decoration: const InputDecoration(
                    labelText: 'Year of Study',
                    hintText: "Your year of study e.g Year 1",
                    labelStyle: TextStyle(fontSize: 16, color: Colors.black),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your year of study';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _collegeController,
                  decoration: const InputDecoration(
                    labelText: 'College',
                    hintText: "Name of your college",
                    labelStyle: TextStyle(fontSize: 16, color: Colors.black),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your College name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _hallOfAttachmentController,
                  decoration: const InputDecoration(
                    labelText: 'Hall Of Attachment',
                    hintText: "Name of the hall you are attached to",
                    labelStyle: TextStyle(fontSize: 16, color: Colors.black),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Hall of attachment';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _studentType,
                  decoration: const InputDecoration(
                    labelText: 'Are you a fresher or a continuing student?',
                    border: OutlineInputBorder(),
                  ),
                  items: ['Fresher', 'Continuing Student']
                      .map((label) => DropdownMenuItem(
                            child: Text(label),
                            value: label,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _studentType = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                if (_studentType == 'Fresher')
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Enter your points',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      _points = value;
                    },
                  ),
                if (_studentType == 'Continuing Student')
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Enter your CGPA',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      _cgpa = value;
                    },
                  ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedStudentType,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedStudentType = newValue;
                    });
                  },
                  items: const [
                    DropdownMenuItem(
                        value: 'Government', child: Text('Government')),
                    DropdownMenuItem(value: 'Private', child: Text('Private')),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Student Type',
                    labelStyle: TextStyle(fontSize: 16, color: Colors.black),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a student type';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Has Disability'),
                  value: _hasDisability,
                  onChanged: (newValue) {
                    setState(() {
                      _hasDisability = newValue;
                    });
                  },
                ),
                SwitchListTile(
                  title: const Text('Continuing Resident'),
                  value: _isContinuingResident,
                  onChanged: (newValue) {
                    setState(() {
                      _isContinuingResident = newValue;
                    });
                  },
                ),
                const SizedBox(height: 16),
               
                
                  ElevatedButton(
                  onPressed: () {
                    _submitForm();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                  ),
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: Center(
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
