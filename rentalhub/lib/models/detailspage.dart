import 'package:flutter/material.dart';
import '/models/house_model.dart';

class DetailPage extends StatelessWidget {
  final House house;

  const DetailPage({super.key, required this.house});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(house.name, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromRGBO(70, 0, 119, 1),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main Image
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.network(
                  house.images.isNotEmpty ? house.images[0] : 'https://via.placeholder.com/600x400',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 250,
                ),
              ),
              const SizedBox(height: 16.0),
              
              // Image Grid
              if (house.images.length > 1)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.network(
                          house.images.length > 1 ? house.images[1] : 'https://via.placeholder.com/300x200',
                          fit: BoxFit.cover,
                          height: 150,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.network(
                          house.images.length > 2 ? house.images[2] : 'https://via.placeholder.com/300x200',
                          fit: BoxFit.cover,
                          height: 150,
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 8.0),
              
              // Additional Images Row
              if (house.images.length > 3)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.network(
                          house.images.length > 3 ? house.images[3] : 'https://via.placeholder.com/300x200',
                          fit: BoxFit.cover,
                          height: 150,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.network(
                          house.images.length > 4 ? house.images[4] : 'https://via.placeholder.com/300x200',
                          fit: BoxFit.cover,
                          height: 150,
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 16.0),

              // Title and Location
              Text(
                house.name,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                house.location,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8.0),
              const Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star_border, color: Colors.yellow),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                house.price,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),

              // Description
              const Text(
                'Description:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'This is a wonderful hostel located in the heart of the city. It offers comfortable rooms and modern amenities to ensure a pleasant stay for all guests.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 16.0),

              // Minimum Requirements
              const Text(
                'Minimum Requirements:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('- Valid ID'),
                  Text('- Security Deposit'),
                  Text('- Minimum Stay of 2 nights'),
                  Text('- No Smoking in Rooms'),
                ],
              ),
              const SizedBox(height: 16.0),

              // Ratings
              const Text(
                'Ratings:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              const RatingBar(label: 'Cleanliness', rating: 4.5),
              const RatingBar(label: 'Hospitality', rating: 4.0),
              const RatingBar(label: 'Facilities', rating: 4.2),
              const SizedBox(height: 16.0),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Implement booking functionality
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(70, 0, 119, 1),
                      elevation: 3.0,
                      textStyle: const TextStyle(color: Colors.white),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.payment, size: 20, color: Colors.white),
                        SizedBox(width: 4.0),
                        Text('Book Now', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Implement chat functionality
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(70, 0, 119, 1),
                      elevation: 3.0,
                      textStyle: const TextStyle(color: Colors.white),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.chat, size: 20, color: Colors.white),
                        SizedBox(width: 4.0),
                        Text('Chat', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RatingBar extends StatelessWidget {
  final String label;
  final double rating;

  const RatingBar({super.key, required this.label, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 4.0),
        Stack(
          children: [
            Container(
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300],
              ),
            ),
            Container(
              height: 20,
              width: rating * 20, // Adjust width based on rating
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
      ],
    );
  }
}
