import 'package:cloud_firestore/cloud_firestore.dart';

class House {
  final String id;
  final String name;
  // final String location;
  final String contact;
  final String description;
  final String hostelGender; // Hostel gender field
  final List<String> images; // List of image URLs
  final Map<String, bool> amenities; // Map of amenities with boolean values
  final Map<String, int> roomTypes; // Map of room types and their prices


  House({
    required this.id,
    required this.name,
    // required this.location,
    required this.description,
    required this.contact,
    required this.images,
    required this.amenities,
    required this.hostelGender,
    required this.roomTypes,

  });

  factory House.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return House(
      id: doc.id,
      name: data['name'] ?? '',
      contact: data['contact_number'] ?? '',
      // location: data['location'] ?? '',
      description: data['description'] ?? '',
      images: List<String>.from(data['images'] ?? []),
      amenities: _mapFromFirestore(data['amenities']),
      roomTypes: _mapRoomTypesFromFirestore(data['room_types']),

      hostelGender: data['hostel_gender'] ?? '', // Adding the hostel_gender field
    );
  }

  // Helper method to handle the amenities map
  static Map<String, bool> _mapFromFirestore(dynamic data) {
    if (data == null) {
      return {};
    }
    // Cast the data to Map<String, dynamic> and convert to Map<String, bool>
    final Map<String, dynamic> mapData = data as Map<String, dynamic>;
    return mapData.map((key, value) => MapEntry(key, value as bool));
  }
 // Helper method to handle the room_types map, converting from double to int if needed
  static Map<String, int> _mapRoomTypesFromFirestore(dynamic data) {
    if (data == null) {
      return {};
    }
    final Map<String, dynamic> mapData = data as Map<String, dynamic>;
    return mapData.map((key, value) {
      final int price = (value is int) ? value : (value as double).toInt();
      return MapEntry(key, price);
    });
  }
}
