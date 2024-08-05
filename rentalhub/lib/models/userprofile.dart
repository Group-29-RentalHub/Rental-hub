import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  final String id;
  final String name;
  final String email;
  final String address;
  final String phone;
  final String dateOfBirth;
  final String imageUrl;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.address,
    required this.phone,
    required this.dateOfBirth,
    required this.imageUrl,
  });

  factory UserProfile.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserProfile(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      address: data['address'] ?? '',
      phone: data['phone'] ?? '',
      dateOfBirth: data['dateOfBirth'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'address': address,
      'phone': phone,
      'dateOfBirth': dateOfBirth,
      'imageUrl': imageUrl,
    };
  }
}
