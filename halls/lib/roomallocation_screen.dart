import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'student_model.dart'; // Ensure Student model is imported and defined correctly
import 'room_allocation_service.dart'; // Import your room allocation service

class RoomAllocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room Allocation'),
      ),
      body: FutureBuilder<List<Student>>(
        future: fetchStudents(), // Fetch students from Firestore
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          
          // Print statements to monitor data fetching
          print('Fetching students...');
          List<Student> students = snapshot.data ?? [];
          print('Fetched ${students.length} students');
          
          // Allocate rooms based on criteria
          allocateRooms(students);

          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${students[index].firstName} ${students[index].lastName}'),
                subtitle: Text('Room: ${students[index].roomNumber ?? "Not allocated"}'),
              );
            },
          );
        },
      ),
    );
  }
}
