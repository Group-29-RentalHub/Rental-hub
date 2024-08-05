import 'package:cloud_firestore/cloud_firestore.dart';

class BookingService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> bookHostel({
    required String hostelId,
    required DateTime bookingDate,
    required String additionalDetails,
  }) async {
    final String userId = 'currentUserId'; // Replace with the actual user ID

    await _db.collection('bookings').add({
      'hostelId': hostelId,
      'userId': userId,
      'bookingDate': bookingDate,
      'additionalDetails': additionalDetails,
      'status': 'Pending', // Example field
    });
  }
}
