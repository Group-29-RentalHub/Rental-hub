// import 'package:cloud_firestore/cloud_firestore.dart';

// class Hostel {
//   final String id;
//   final String name;
//   final String location;
//   final int numberOfRooms;
//   final double pricePerRoom;
//   final String contactNumber;
//   final String description;
//   final List<String> amenities;
//   final List<String> imageUrls;

//   Hostel({
//     required this.id,
//     required this.name,
//     required this.location,
//     required this.numberOfRooms,
//     required this.pricePerRoom,
//     required this.contactNumber,
//     required this.description,
//     required this.amenities,
//     required this.imageUrls,
//   });

//   factory Hostel.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
//     final data = doc.data()!;
//     return Hostel(
//       id: doc.id,
//       name: data['name'] ?? '',
//       location: data['location'] ?? '',
//       numberOfRooms: data['number_of_rooms'] ?? 0,
//       pricePerRoom: (data['price_per_room'] ?? 0).toDouble(),
//       contactNumber: data['contact_number'] ?? '',
//       description: data['description'] ?? '',
//       amenities: List<String>.from(data['amenities'] ?? []),
//       imageUrls: List<String>.from(data['images'] ?? []),
//     );
//   }
// }
