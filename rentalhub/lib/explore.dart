
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chat_service.dart';
import 'chatpage.dart';
import '../models/house_model.dart';
// import 'detailspage.dart';
import 'package:halls/models/detailspage.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference housesCollection = FirebaseFirestore.instance.collection('hostels');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Explore Hostels',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder(
        stream: housesCollection.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<House> houses = snapshot.data!.docs
              .map((doc) => House.fromFirestore(doc))
              .toList();

          return ListView.builder(
            itemCount: houses.length,
            itemBuilder: (context, index) {
              return HouseCard(house: houses[index]);
            },
          );
        },
      ),
    );
  }
}

class HouseCard extends StatelessWidget {
  final House house;

  const HouseCard({Key? key, required this.house}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageUrl = house.images.isNotEmpty
        ? house.images[0]
        : 'https://via.placeholder.com/600x400';

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
                Text(
                  house.name,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
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
                const Row(
                  children: [
                    Icon(Icons.star, size: 20),
                    Icon(Icons.star, size: 20),
                    Icon(Icons.star, size: 20),
                    Icon(Icons.star, size: 20),
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(
                  house.name,
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
                  onPressed: () async {
                    final currentUser = FirebaseAuth.instance.currentUser;
                    if (currentUser != null) {
                      final chatService = ChatService();
                      bool isCurrentUserOwner = await chatService.isUserIdOwner(currentUser.uid);
                      String otherUserId = isCurrentUserOwner ? 'userId${house.id}' : house.id;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            // currentUserId: currentUser.uid,
                            // otherUserId: otherUserId,
                            hostelId: house.id,
                            ownerId: 'userId${house.id}',
                            userId: FirebaseAuth.instance.currentUser!.uid,
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Please log in to chat')),
                      );
                    }
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
