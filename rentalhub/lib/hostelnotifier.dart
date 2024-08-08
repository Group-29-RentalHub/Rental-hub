import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:halls/calculate_prefs.dart';

Future<void> notifyUsersOnNewHostel(Map<String, dynamic> hostel) async {
  final userPrefsSnapshot = await FirebaseFirestore.instance.collection('user_hostel_prefs').get();

  for (var userPrefDoc in userPrefsSnapshot.docs) {
    final userPrefs = userPrefDoc.data();
    final matchPercentage = calculateMatchPercentage(userPrefs, hostel);

    if (matchPercentage >= 50) {
      await FirebaseFirestore.instance.collection('notifications').add({
        'user_id': userPrefs['user_id'],
        'title': 'New Hostel Available!',
        'message': 'A new hostel matching your preferences has been added: ${hostel['name']}',
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }
}
