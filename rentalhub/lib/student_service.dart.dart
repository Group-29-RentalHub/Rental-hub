// student_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';

// Define a Student model class based on your Firestore structure
class Student {
  final String id;
  final String firstName;
  final String lastName;
  final num cgpa;
  final num points;
  final String studentType;
  final bool hasDisability;
  final bool isAttachedToHall;
  final bool isContinuingResident;

  Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.cgpa,
    required this.points,
    required this.studentType,
    required this.hasDisability,
    required this.isAttachedToHall,
    required this.isContinuingResident,
  });

  factory Student.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    return Student(
      id: doc.id,
      firstName: data?['firstName'] ?? '',
      lastName: data?['lastName'] ?? '',
      cgpa: (data?['cgpa'] ?? 0).toDouble(), // Convert to double
      points: (data?['points'] ?? 0).toDouble(), // Convert to double
      studentType: data?['studentType'] ?? '',
      hasDisability: data?['hasDisability'] ?? false,
      isAttachedToHall: data?['isAttachedToHall'] ?? false,
      isContinuingResident: data?['isContinuingResident'] ?? false,
    );
  }
}

// Function to fetch student data from Firestore
Future<List<Student>> fetchStudents() async {
  try {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('students').get();

    List<Student> students = querySnapshot.docs.map((doc) {
      return Student.fromFirestore(doc); // Use static method from Student class
    }).toList();

    print('Fetched ${students.length} students');
    return students;
  } catch (e) {
    print('Error fetching students: $e');
    return [];
  }
}
