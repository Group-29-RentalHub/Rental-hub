import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About Our App',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Welcome to [App Name], your ultimate solution for booking hostel rooms with ease and convenience. Whether you\'re a student searching for the perfect place to stay during your academic journey or a hostel owner looking to reach more potential residents, our app is designed to meet your needs seamlessly.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'For Students',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Finding a suitable hostel room can be challenging, especially when you have to balance academic responsibilities. Our app simplifies this process by providing a comprehensive platform where you can explore various hostel options, compare amenities, check availability, and make bookings—all from the comfort of your device. Say goodbye to the hassle of endless phone calls and in-person visits. With [App Name], securing your next home-away-from-home has never been easier.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'For Hostel Owners',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'Managing a hostel and filling vacancies can be a time-consuming task. [App Name] helps you streamline this process by connecting you directly with potential residents. List your available rooms, highlight key features, and manage bookings efficiently. Our user-friendly interface ensures you can focus on providing a great living experience while we handle the rest.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'Why Choose [App Name]?',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '• Convenience: Book or list a room anytime, anywhere.\n'
                '• Variety: Explore numerous hostel options with detailed information.\n'
                '• User-Friendly: Intuitive design for easy navigation and use.\n'
                '• Secure: Safe and reliable booking process for peace of mind.\n'
                '• Support: Dedicated customer service to assist with any queries.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'Join our growing community of satisfied students and hostel owners today. Experience the convenience of modern room booking with [App Name]. Your perfect hostel room is just a few taps away!',
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


