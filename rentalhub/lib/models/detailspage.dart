import 'package:flutter/material.dart';
import 'package:rentalhub/models/house_model.dart';

class DetailPage extends StatelessWidget {
  final House house;

  DetailPage({required this.house});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(house.title, style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromRGBO(70, 0, 119, 1),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.asset(
                  house.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 250,
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset(
                      house.imageUrl,
                      fit: BoxFit.cover,
                      width: (MediaQuery.of(context).size.width - 48) / 2,
                      height: 150,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset(
                      house.imageUrl,
                      fit: BoxFit.cover,
                      width: (MediaQuery.of(context).size.width - 48) / 2,
                      height: 150,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset(
                      house.imageUrl,
                      fit: BoxFit.cover,
                      width: (MediaQuery.of(context).size.width - 48) / 2,
                      height: 150,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.asset(
                      house.imageUrl,
                      fit: BoxFit.cover,
                      width: (MediaQuery.of(context).size.width - 48) / 2,
                      height: 150,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                house.title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                house.location,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star_border, color: Colors.yellow),
                ],
              ),
              SizedBox(height: 8.0),
              Text(
                house.price,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Description:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                'This is a wonderful hostel located in the heart of the city. It offers comfortable rooms and modern amenities to ensure a pleasant stay for all guests.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Minimum Requirements:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('- Valid ID'),
                  Text('- Security Deposit'),
                  Text('- Minimum Stay of 2 nights'),
                  Text('- No Smoking in Rooms'),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                'Ratings:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              RatingBar(label: 'Cleanliness', rating: 4.5),
              RatingBar(label: 'Hospitality', rating: 4.0),
              RatingBar(label: 'Facilities', rating: 4.2),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [ 
                  ElevatedButton(
                    onPressed: () {
                      // Implement chat functionality
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Color.fromRGBO(70, 0, 119, 1),
                      elevation: 3.0,
                      textStyle: const TextStyle(color: Colors.white),
                    ),
                    child: Row(
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
                    style: FilledButton.styleFrom(
                      backgroundColor: Color.fromRGBO(70, 0, 119, 1),
                      elevation: 3.0,
                      textStyle: const TextStyle(color: Colors.white),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.chat, size: 20, color: Colors.white),
                        SizedBox(width: 4.0),
                        Text('Chat', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              )
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

  RatingBar({required this.label, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 4.0),
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
        SizedBox(height: 8.0),
      ],
    );
  }
}
