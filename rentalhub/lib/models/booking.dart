import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookingService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> bookHostel({
    required String hostelId,
    required DateTime bookingDate,
    required String additionalDetails,
    required String hostelName,
  }) async {
    try {
      // Get the current user ID from FirebaseAuth
      final String userId = _auth.currentUser?.uid ?? '';

      if (userId.isEmpty) {
        throw Exception('User is not authenticated');
      }

      await _db.collection('bookings').add({
        'hostelId': hostelId,
        'userId': userId,
        'bookingDate': bookingDate,
        'additionalDetails': additionalDetails,
        'hostelName': hostelName,
        'status': 'Pending', // Example field
        'timestamp': FieldValue.serverTimestamp(), // Add a timestamp
      });
    } catch (e) {
      throw Exception('Failed to book the hostel: $e');
    }
  }
}
