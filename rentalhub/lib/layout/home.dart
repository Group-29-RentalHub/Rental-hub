import 'package:flutter/material.dart';
import 'package:rentalhub/models/house_model.dart';

// Assuming you have a House model defined (house_model.dart)

// Sample data (replace with your actual data or fetch from API)
List<House> houses = [
  House(
    id: '1',
    title: 'Modern Apartment in City Center',
    location: 'New York, USA',
    imageUrl: 'assets/user_image.png', // Replace with actual image URL or path
    price: '\$150 per night',

  ),
  House(
    id: '2',
    title: 'Cozy Cottage by the Lake',
    location: 'Geneva, Switzerland',
        price: '\$150 per night',

    imageUrl: 'assets/user_image.png', // Replace with actual image URL or path
  ),
  // Add more listings as needed
];

void main() {
  runApp(RentalHub());
}

class RentalHub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rental Hub',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Explore Houses'),
      ),
      body: ListView.builder(
        itemCount: houses.length,
        itemBuilder: (context, index) {
          return HouseCard(house: houses[index]);
        },
      ),
    );
  }
}

class HouseCard extends StatelessWidget {
  final House house;

  HouseCard({required this.house});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9, // Adjust aspect ratio as needed
            child: Image.asset(
              house.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  house.title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  house.location,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
