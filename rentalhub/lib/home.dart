import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:halls/chat_service.dart';
import 'package:halls/chatpage.dart';
import 'package:halls/explore.dart';
import 'package:halls/models/detailspage.dart';
import '/models/house_model.dart';

class ForYouPage extends StatelessWidget {
  Future<House> getHouse(String houseId) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('hostels')
        .doc(houseId)
        .get();
    if (doc.exists) {
      return House.fromFirestore(doc);
    } else {
      throw Exception('House not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              '',
              style: TextStyle(color: Color.fromARGB(255, 16, 0, 0)),
            ),
            Spacer(), // Pushes the button to the rightmost side
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const HomePage()), // Navigate to ExplorePage
                );
              },
              child: const Text(
                'Explore',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromRGBO(70, 0, 119, 1),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchHostels(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // ignore: avoid_print
            print('Error fetching data: ${snapshot.error}');
            return const Center(
                child: Text(
                    'Error fetching data. Check your internet connection.'));
          } else {
            List<Map<String, dynamic>> hostels = snapshot.data ?? [];
            if (hostels.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('No hostels currently available for you.'),
                    const SizedBox(height: 8.0),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color.fromRGBO(70, 0, 119, 1),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const HomePage()), // Navigate to ExplorePage
                        );
                      },
                      child: const Text('Maybe explore'),
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: hostels.length,
                itemBuilder: (context, index) {
                  final hostel = hostels[index];
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
                              hostel['images'].isNotEmpty
                                  ? hostel['images'][0]
                                  : 'https://via.placeholder.com/600x400',
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
                                hostel['name'],
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              const Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 20,
                                  ),
                                  SizedBox(width: 4.0),
                                  Text(
                                    'Location Unknown', // Adjust this based on actual data
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
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
                                'Matching percentage: ${hostel['match'].toStringAsFixed(0)}%',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  // ignore: avoid_print
                                  print(hostel['id']);
                                  final house = await getHouse(hostel['id']);

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailPage(house: house),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(70, 0, 119, 1),
                                  elevation: 3.0,
                                  textStyle:
                                      const TextStyle(color: Colors.white),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.phone,
                                        size: 20, color: Colors.white),
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
                                  final currentUser =
                                      FirebaseAuth.instance.currentUser;
                                  if (currentUser != null) {
                                    final chatService = ChatService();
                                    bool isCurrentUserOwner = await chatService
                                        .isUserIdOwner(currentUser.uid);
                                    String otherUserId = isCurrentUserOwner
                                        ? 'userId${hostel['id']}'
                                        : hostel['id'];

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatScreen(
                                          hostelId: hostel['id'],
                                          ownerId: 'userId${hostel['id']}',
                                          userId: currentUser.uid,
                                        ),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text('Please log in to chat')),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(70, 0, 119, 1),
                                  elevation: 3.0,
                                  textStyle:
                                      const TextStyle(color: Colors.white),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.chat,
                                        size: 20, color: Colors.white),
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
                },
              );
            }
          }
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _fetchHostels() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // ignore: avoid_print
      print('No user is signed in.');
      throw Exception('No user is signed in now.');
    }

    try {
      final userPrefsQuerySnapshot = await FirebaseFirestore.instance
          .collection('user_hostel_prefs')
          .where('user_id', isEqualTo: user.uid)
          .get();

      if (userPrefsQuerySnapshot.docs.isEmpty) {
        print('User preferences not found for user ID: ${user.uid}');
        return [];
      }

      final userPrefs = userPrefsQuerySnapshot.docs.first.data();
      if (userPrefs == null) {
        throw Exception('User preferences data is null.');
      }

      final hostelsSnapshot =
          await FirebaseFirestore.instance.collection('hostels').get();

      List<Map<String, dynamic>> matchedHostels = [];

      for (var hostelDoc in hostelsSnapshot.docs) {
        final hostel = hostelDoc.data();
        final matchPercentage = _calculateMatchPercentage(userPrefs, hostel);

        print('Hostel: ${hostel['name']}');
        print('Match Percentage: ${matchPercentage.toStringAsFixed(2)}%');

        if (matchPercentage >= 10) {
          matchedHostels.add({
            'id': hostelDoc.id,
            'name': hostel['name'],
            'match': matchPercentage,
            'images': hostel['images'] ?? [],
          });
        }
      }

      return matchedHostels;
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Failed to fetch hostels: $e');
    }
  }

  double _calculateMatchPercentage(
      Map<String, dynamic> userPrefs, Map<String, dynamic> hostel) {
    int matchCount = 0;
    int totalCount = 0;

    if (userPrefs['hostel_type'] == hostel['hostel_gender'] ||
        hostel['hostel_gender'] == 'Mixed') {
      matchCount++;
    }
    totalCount++;

    final userBudgetRange = userPrefs['budget']
            ?.split(' - ')
            .map((e) => num.tryParse(e.replaceAll(RegExp(r'[^\d]'), '')) ?? 0)
            .toList() ??
        [0, 0];
    final hostelPrices =
        hostel['room_types']?.values.map((e) => e as num).toList() ?? [];

    if (userBudgetRange.length == 2) {
      final minBudget = userBudgetRange[0];
      final maxBudget = userBudgetRange[1];
      if (hostelPrices
          .any((price) => price >= minBudget && price <= maxBudget)) {
        matchCount++;
      }
    }

    final userRoomType = userPrefs['house_type'];
    final hostelRoomTypes = hostel['room_types']?.keys.toList() ?? [];

    if (hostelRoomTypes.contains(userRoomType)) {
      matchCount++;
    }
    totalCount++;

    Map<String, dynamic> userAmenities = {
      'wifi': userPrefs['wifi'],
      'laundry_services': userPrefs['laundry_services'],
      'cafeteria': userPrefs['cafeteria'],
      'parking': userPrefs['parking'],
      'security': userPrefs['security'],
    };

    Map<String, dynamic> hostelAmenities = {
      'wifi': hostel['Wi-Fi'],
      'laundry_services': hostel['Laundry Service'],
      'cafeteria': hostel['Cafeteria'],
      'parking': hostel['Parking'],
      'security': hostel['Security'],
    };

    for (String amenity in userAmenities.keys) {
      var userValue = userAmenities[amenity];
      var hostelValue = hostelAmenities[amenity];

      if (userValue == null) {
        userValue = false;
      }
      if (hostelValue == null) {
        hostelValue = false;
      }

      if (userValue == hostelValue) {
        matchCount++;
      }
      totalCount++;
    }

    return (totalCount > 0) ? (matchCount / totalCount) * 100 : 0;
  }
}

// class DetailPage extends StatelessWidget {
//   final House house;

//   const DetailPage({Key? key, required this.house}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(house.name),
//       ),
//       body: Center(
//         child: Text('Details for ${house.name}'),
//       ),
//     );
//   }
// }

// class ChatPage extends StatelessWidget {
//   const ChatPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Chat'),
//       ),
//       body: Center(
//         child: const Text('Chat Page'),
//       ),
//     );
//   }
// }

