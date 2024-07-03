import 'package:flutter/material.dart';
import 'hall.dart';

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

  String? _selectedStudentType; // Initialize as null
  bool _hasDisability = false;
  bool _hasAppliedBefore = false;
  bool _isContinuingResident = false;

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
        title: const Text("Student Information"),
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
                  decoration: const InputDecoration(labelText: 'First Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(labelText: 'Last Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _sexController,
                  decoration: const InputDecoration(labelText: 'Sex'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your sex';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _registrationController,
                  decoration:
                      const InputDecoration(labelText: 'Registration Number'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your registration number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
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
                TextFormField(
                  controller: _yearOfStudyController,
                  decoration: const InputDecoration(labelText: 'Year of Study'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your year of study';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _collegeController,
                  decoration: const InputDecoration(labelText: 'College'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your college';
                    }
                    return null;
                  },
                ),
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
                  decoration: const InputDecoration(labelText: 'Student Type'),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a student type';
                    }
                    return null;
                  },
                ),
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
                SwitchListTile(
                  title: const Text('Applied Before'),
                  value: _hasAppliedBefore,
                  onChanged: (newValue) {
                    setState(() {
                      _hasAppliedBefore = newValue;
                    });
                  },
                ),
                ElevatedButton(
                  
                  onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const Hall();
                  }),
                );
              },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


