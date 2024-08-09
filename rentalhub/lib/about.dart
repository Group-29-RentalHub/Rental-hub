import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromRGBO(70, 0, 119, 1),
      ),
      body: Container(
        color: Colors.white, // Set the background color to white
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'About RentalHub',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(70, 0, 119, 1),
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Welcome to RentalHub, your ultimate solution for booking hostel rooms with ease and convenience. Whether you\'re a student looking for a place to stay during your academic journey or a hostel owner wanting to reach more potential residents, our app is designed to meet your needs seamlessly.',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 16.0),
                const Divider(color: Colors.grey),
                const SizedBox(height: 16.0),
                const Text(
                  'Why Choose RentalHub?',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(70, 0, 119, 1),
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  '• Convenience: Book or list a room anytime, anywhere.\n'
                  '• Variety: Explore numerous hostel options with detailed information.\n'
                  '• User-Friendly: Intuitive design for easy navigation and use.\n'
                  '• Secure: Safe and reliable booking process for peace of mind.',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 16.0),
                const Divider(color: Colors.grey),
                const SizedBox(height: 16.0),
                Text(
                  'Join our community of satisfied students and hostel owners today. Experience the convenience of modern room booking with RentalHub. Your perfect hostel room is just a few taps away!',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey[700],
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
