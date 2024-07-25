import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'explore.dart';

class ForYouPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchHostels(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Error fetching data: ${snapshot.error}');
            return const Center(child: Text('Error fetching data. Check your internet connection.'));
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
                        backgroundColor: const Color.fromRGBO(70, 0, 119, 1), // White text
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage()), // Navigate to ExplorePage
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
      final userPrefsQuerySnapshot = await FirebaseFirestore.instance
          .collection('user_hostel_prefs')
          .where('user_id', isEqualTo: user.uid)
          .get();

      if (userPrefsQuerySnapshot.docs.isEmpty) {
        print('User preferences not found for user ID: ${user.uid}');
        return []; // Return an empty list if preferences are not found
      }

      final userPrefs = userPrefsQuerySnapshot.docs.first.data();
      if (userPrefs == null) {
        throw Exception('User preferences data is null.');
      }

      final hostelsSnapshot = await FirebaseFirestore.instance.collection('hostels').get();

      List<Map<String, dynamic>> matchedHostels = [];

      for (var hostelDoc in hostelsSnapshot.docs) {
        final hostel = hostelDoc.data();
        final matchPercentage = _calculateMatchPercentage(userPrefs, hostel);

        print('Hostel: ${hostel['name']}');
        print('Match Percentage: $matchPercentage');

        if (matchPercentage >= 10) { // Change the match threshold to 50%
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

    // Check hostel type
    if (userPrefs['hostel_type'] == hostel['hostel_type']) {
      matchCount++;
    }
    totalCount++;

    // Check amenities
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
      if (userAmenities[amenity] == true && hostelAmenities[amenity] == true) {
        matchCount++;
      }
      totalCount++;
    }

    // Log match details
    print('User Preferences: $userPrefs');
    print('Hostel Amenities: $hostelAmenities');
    print('Match Count: $matchCount');
    print('Total Count: $totalCount');

    return (totalCount > 0) ? (matchCount / totalCount) * 100 : 0;
  }
}
