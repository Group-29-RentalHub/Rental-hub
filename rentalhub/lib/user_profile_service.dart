import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/userprofile.dart';

class UserProfileService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserProfile> getUserProfile(String userId) async {
    try {
      final doc = await _firestore.collection('user_profiles').doc(userId).get();
      if (doc.exists) {
        return UserProfile.fromFirestore(doc);
      } else {
        throw Exception('User profile not found');
      }
    } catch (e) {
      throw Exception('Failed to load user profile: $e');
    }
  }

  Future<void> updateUserProfile(UserProfile userProfile) async {
    try {
      await _firestore.collection('user_profiles').doc(userProfile.id).set(userProfile.toMap());
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }
}
