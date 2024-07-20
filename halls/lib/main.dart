import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'login.dart'; // Import your login screen
import 'room_allocation_service.dart'; // Import your hall allocation service
import 'student_model.dart'; // Import your Student model
import 'roomallocation_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Future.delayed(const Duration(seconds: 1));
  
  FlutterNativeSplash.remove();
  
  // Example data for students
  List<Student> studentsData = [
    Student(
      id: '1', // Replace with actual Firestore document ID or unique identifier
      isAttachedToHall: true,
      isGovernmentStudent: true,
      isDisabled: true,
      cgpa: 3,
      uacePoints: null,
      isContinuingResident: true,
      isPrivateStudent: true,
      isFresher: false, 
      firstName: '', 
      lastName: '',
      roomNumber: null, // Make sure to include roomNumber if it's part of the constructor
    ),
    // Add more students as needed
  ];
  
  runApp(MyApp(studentsData: studentsData));
}

class MyApp extends StatelessWidget {
  final List<Student> studentsData;

  const MyApp({Key? key, required this.studentsData}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "HALL BOOKING",
      theme: ThemeData(primarySwatch: Colors.green),
      // Assuming LoginScreen is where authentication happens
      home: const LoginScreen(),
      // Example of how you might add routes for navigation
      routes: {
        '/login': (context) => const LoginScreen(),
        '/roomAllocation': (context) => RoomAllocationScreen(),
        // Add more routes as needed
      },
    );
  }
}
