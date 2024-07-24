import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'chatpage.dart';
import '/models/detailspage.dart';
import '/models/house_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference housesCollection = FirebaseFirestore.instance
      .collection('hostels'); // Updated collection name

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     'Explore Houses',
      //     style: TextStyle(fontWeight: FontWeight.bold),
      //   ),
      // ),
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

  const HouseCard({super.key, required this.house});

  @override
  Widget build(BuildContext context) {
    String imageUrl = house.images.isNotEmpty ? house.images[0] : 'https://via.placeholder.com/600x400';

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                    'https://via.placeholder.com/600x400',
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title of the hostel
                Text(
                  house.name,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                // Location of the hostel
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 20,
                    ),
                    const SizedBox(width: 4.0),
                    Text(house.location,
                        style: const TextStyle(
                          color: Colors.grey,
                        )),
                  ],
                ),
                const SizedBox(height: 4.0),
                // Rating
                const Row(
                  children: [
                    Icon(Icons.star, size: 20),
                    Icon(Icons.star, size: 20),
                    Icon(Icons.star, size: 20),
                    Icon(Icons.star, size: 20),
                  ],
                ),
                const SizedBox(height: 4.0),
                // Price
                Text(
                  house.price,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(house: house),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(70, 0, 119, 1),
                    elevation: 3.0,
                    textStyle: const TextStyle(color: Colors.white),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.phone, size: 20, color: Colors.white),
                      SizedBox(width: 4.0),
                      Text(
                        'Details',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChatPage(),
                      ),
                    );
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
                      Text(
                        'Chat',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
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
