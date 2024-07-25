import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'explore.dart';

class ForYouPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('For You', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromRGBO(70, 0, 119, 1), // Theme color
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchHostels(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Error fetching data: ${snapshot.error}');
            return const Center(child: Text('Error fetching data.'));
          } else if (!snapshot.hasData || (snapshot.data?.isEmpty ?? true)) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No hostels currently available for you.'),
                  const SizedBox(height: 8.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ExplorePage()),
                      );
                    },
                    child: const Text(
                      'Maybe explore',
                      style: TextStyle(color: Color.fromRGBO(70, 0, 119, 1), decoration: TextDecoration.underline),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final hostel = snapshot.data![index];
                return ListTile(
                  title: Text(hostel['name']),
                  subtitle: Text('Matching percentage: ${hostel['match']}%'),
                  onTap: () {
                    // Navigate to hostel details page
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _fetchHostels() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print('No user is signed in.');
      throw Exception('No user is signed in.');
    }

    try {
      final userPrefsSnapshot = await FirebaseFirestore.instance
          .collection('user_hostel_prefs')
          .doc(user.uid)
          .get();

      if (!userPrefsSnapshot.exists) {
        print('User preferences not found for user ID: ${user.uid}');
        return []; // Return an empty list if preferences are not found
      }

      final userPrefs = userPrefsSnapshot.data();
      if (userPrefs == null) {
        throw Exception('User preferences data is null.');
      }

      final hostelsSnapshot = await FirebaseFirestore.instance.collection('hostels').get();

      List<Map<String, dynamic>> matchedHostels = [];

      for (var hostelDoc in hostelsSnapshot.docs) {
        final hostel = hostelDoc.data();
        final matchPercentage = _calculateMatchPercentage(userPrefs, hostel);

        if (matchPercentage >= 75) {
          matchedHostels.add({
            'id': hostelDoc.id,
            'name': hostel['name'],
            'match': matchPercentage,
          });
        }
      }

      return matchedHostels;
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Failed to fetch hostels: $e');
    }
  }

  double _calculateMatchPercentage(Map<String, dynamic> userPrefs, Map<String, dynamic> hostel) {
    int matchCount = 0;
    int totalCount = 0;

    // Check hostel gender
    if (userPrefs['hostel_gender'] == hostel['hostel_gender']) {
      matchCount++;
    }
    totalCount++;

    // Check amenities
    Map<String, dynamic> userAmenities = userPrefs['amenities'];
    Map<String, dynamic> hostelAmenities = hostel['amenities'];
    for (String amenity in userAmenities.keys) {
      if (userAmenities[amenity] == true && hostelAmenities[amenity] == true) {
        matchCount++;
      }
      totalCount++;
    }

    return (totalCount > 0) ? (matchCount / totalCount) * 100 : 0;
  }
}
