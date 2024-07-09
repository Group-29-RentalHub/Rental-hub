import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  // Moved SignUpPage to a top-level class
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _selectedGender = "";

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hostel Sign Up'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your email';
                  } else if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]+")
                      .hasMatch(value ?? '')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (String? value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  const Text('Gender:'),
                  Radio(
                    value: 'Male',
                    groupValue: _selectedGender,
                    onChanged: (value) =>
                        setState(() => _selectedGender = value as String),
                  ),
                  Text('Male'),
                  Radio(
                    value: 'Female',
                    groupValue: _selectedGender,
                    onChanged: (value) =>
                        setState(() => _selectedGender = value as String),
                  ),
                  Text('Female'),
                ],
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter a password';
                  } else if (value?.length is int && (value?.length ?? 0) < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Implement sign up logic here with a backend service
                    // (e.g., Firebase Authentication)

                    // Show a progress indicator while signing up
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Center(child: CircularProgressIndicator());
                      },
                    );

                    // Replace with your actual sign up logic
                    // (This is just an example)
                    await Future.delayed(const Duration(seconds: 2));
                    Navigator.pop(context); // Hide progress indicator

                    print('Sign Up successful!');

                    // Handle potential errors during sign up
                  }
                },
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
