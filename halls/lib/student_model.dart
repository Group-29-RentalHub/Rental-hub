import 'package:flutter/foundation.dart'; // Import this for required annotation
import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  final String id; // Add id field to store Firestore document ID
  final bool isAttachedToHall;
  final bool isGovernmentStudent;
  final bool isDisabled;
  final num? cgpa;
  final num? uacePoints;
  final bool isContinuingResident;
  final bool isPrivateStudent;
  final bool isFresher;
  String firstName;
  String lastName;
  int? roomNumber; // Add roomNumber property

  Student({
    required this.id, // Require id in the constructor
    required this.isAttachedToHall,
    required this.isGovernmentStudent,
    required this.isDisabled,
    this.cgpa,
    this.uacePoints,
    required this.isContinuingResident,
    required this.isPrivateStudent,
    required this.isFresher,
    required this.firstName,
    required this.lastName,
    this.roomNumber, // Include roomNumber in the constructor
  });
  
  double get totalPoints {
    // Calculation logic for total points
    double attachmentPoints = isAttachedToHall ? 100 : 0;
    double governmentPoints = isGovernmentStudent ? 100 : 0;
    double disabledPoints = isDisabled ? 100 : 0;
    double academicPoints;
    if (isFresher) {
      academicPoints = (uacePoints != null && uacePoints! <= 20) ? uacePoints! * 5 : 0;
    } else {
      academicPoints = (cgpa != null && cgpa! >= 4.4) ? 100 :
                       (cgpa != null && cgpa! >= 3.6) ? 75 :
                       (cgpa != null && cgpa! >= 2.8) ? 50 :
                       (cgpa != null && cgpa! >= 2.0) ? 25 : 0;
    }
    double continuingResidentPoints = isContinuingResident ? 100 : 0;
    double privateStudentPoints = isPrivateStudent ? 100 : 0;

    return (attachmentPoints * 0.2) + (governmentPoints * 0.15) +
           (disabledPoints * 0.25) + (academicPoints * 0.2) +
           (continuingResidentPoints * 0.1) + (privateStudentPoints * 0.1);
  }

  // Static method to create Student object from Firestore document
  static Student fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Student(
      id: doc.id, // Assign document ID to id field
    isAttachedToHall: data['isAttachedToHall'] ?? false, // Default to false if null
    isGovernmentStudent: data['isGovernmentStudent'] ?? false, // Default to false if null
    isDisabled: data['isDisabled'] ?? false, // Default to false if null
    cgpa: data['cgpa'] != null ? (data['cgpa'] as num).toDouble() : null, // Convert to double if not null
    uacePoints: data['uacePoints'] != null ? data['uacePoints'] as num : null, // Convert to int if not null
    isContinuingResident: data['isContinuingResident'] ?? false, // Default to false if null
    isPrivateStudent: data['isPrivateStudent'] ?? false, // Default to false if null
    isFresher: data['isFresher'] ?? false, // Default to false if null
    firstName: data['firstName'] ?? '',
    lastName: data['lastName'] ?? '',
    roomNumber: data['roomNumber'] ?? null, // Assign roomNumber from Firestore data
    );
  }
}
