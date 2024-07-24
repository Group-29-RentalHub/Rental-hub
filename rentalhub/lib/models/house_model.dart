import 'package:cloud_firestore/cloud_firestore.dart';


class House {
  final String id;
  final String name;
  final String location;
  final String price;
  final List<String> images; // Add this field

  House({
    required this.id,
    required this.name,
    required this.location,
    required this.price,
    required this.images,
  });

  factory House.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return House(
      id: doc.id,
      name: data['name'] ?? '',
      location: data['location'] ?? '',
      price: data['price'] ?? '',
      images: List<String>.from(data['images'] ?? []), // Handle images array
    );
  }
}
