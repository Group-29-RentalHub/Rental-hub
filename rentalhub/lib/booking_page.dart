import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class BookingPage extends StatelessWidget {
  final String hostelId; 

  const BookingPage({Key? key, required this.hostelId}) : super(key: key);

  Future<List<Map<String, dynamic>>> _fetchBookings() async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('bookings')
      .where('hostelId', isEqualTo: hostelId)
      .where('status', isEqualTo: 'Pending')
      .get();

  return querySnapshot.docs.map((doc) {
    // Extract the data from the document
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    
    // Add the document ID to the data map
    data['bookingId'] = doc.id;
    
    return data;
  }).toList();
}


  Future<List<Map<String, dynamic>?>> _fetchUserPreferences(List<String> userIds) async {
    List<Map<String, dynamic>?> prefsList = [];
    for (String userId in userIds) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('user_hostel_prefs')
          .where('user_id', isEqualTo: userId)
          .get();
      
      if (querySnapshot.docs.isNotEmpty) {
        prefsList.add(querySnapshot.docs.first.data() as Map<String, dynamic>);
      } else {
        prefsList.add(null);
      }
    }
    return prefsList;
  }

  Future<void> _updateNotification(String userId, String title, String message) async {
    await FirebaseFirestore.instance.collection('notifications').add({
      'user_id': userId,
      'title': title,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> _handleBookingAction(
      BuildContext context, String bookingId, String userId, bool isApproved , String hostelName) async {
    try {
      // Update the booking status
      await FirebaseFirestore.instance.collection('bookings').doc(bookingId).update({
        'status': isApproved ? 'Approved' : 'Rejected',
      });

      // Determine the notification message and title
      String title = isApproved ? 'Booking Approved' : 'Booking Rejected';
      String message = isApproved
          ? 'Your booking for  $hostelName hostel has been approved.'
          : 'Your booking for  $hostelName hostel has been rejected.';

      // Update the notification collection
      await _updateNotification(userId, title, message);
  
      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking ${isApproved ? 'approved' : 'rejected'} successfully')),
      );
    } catch (e) {
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromRGBO(70, 0, 119, 1),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchBookings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No bookings found.'));
          }

          List<Map<String, dynamic>> bookings = snapshot.data!;
          List<String> userIds = bookings.map((booking) => booking['userId'] as String).toList();

          return FutureBuilder<List<Map<String, dynamic>?>>(
            future: _fetchUserPreferences(userIds),
            builder: (context, prefsSnapshot) {
              if (prefsSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (prefsSnapshot.hasError) {
                return Center(child: Text('Error: ${prefsSnapshot.error}'));
              } else if (!prefsSnapshot.hasData || prefsSnapshot.data!.isEmpty) {
                return const Center(child: Text('No user preferences found.'));
              }

              List<Map<String, dynamic>?> prefsList = prefsSnapshot.data!;

              return ListView.builder(
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> booking = bookings[index];
                  Map<String, dynamic>? prefs = prefsList[index];

                  String userName = prefs?['name'] ?? 'No Name';
                  String hostelName = booking['hostelName'] ?? 'No hostel';
                  String details = booking['additionalDetails'] ?? 'No Details';
                  Timestamp bookingTimestamp = booking['bookingDate'] as Timestamp;
                  DateTime bookingDate = bookingTimestamp.toDate();
                  String formattedDate = DateFormat.yMMMd().format(bookingDate);

                  String bookingId = booking['bookingId'] as String;
                  String userId = booking['userId'] as String;

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Booking Date: $formattedDate',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (prefs != null) ...[
                            Text(
                              'Name: ${prefs['name'] ?? 'N/A'}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Nationality: ${prefs['nationality'] ?? 'N/A'}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Year of Study: ${prefs['year_of_study'] ?? 'N/A'}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Budget: ${prefs['budget'] ?? 'N/A'}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Details: ${details}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Preferences:',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Cafeteria: ${prefs['cafeteria'] == true ? 'Yes' : 'No'}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Laundry Services: ${prefs['laundry_services'] == true ? 'Yes' : 'No'}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Parking: ${prefs['parking'] == true ? 'Yes' : 'No'}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Security: ${prefs['security'] == true ? 'Yes' : 'No'}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              'WiFi: ${prefs['wifi'] == true ? 'Yes' : 'No'}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              'Hostel Type: ${prefs['hostel_type'] ?? 'N/A'}',
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              'House Type: ${prefs['house_type'] ?? 'N/A'}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () 
                                => _handleBookingAction(
                                  context,
                                  bookingId,
                                  userId,
                                  true, // Approved
                                  hostelName
                                ),
                                child: const Text('Approve',  style: TextStyle(color: Colors.white),),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                onPressed:  
                                () => _handleBookingAction(
                                  context,
                                  bookingId,
                                  userId,
                                  false, // Rejected
                                  hostelName
                                ),
                                child: const Text('Reject' , style: TextStyle(color: Colors.white),),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
