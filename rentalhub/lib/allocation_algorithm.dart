import 'student_model.dart';
import 'package:flutter/material.dart';

List<Student> allocateRooms(List<Student> students) {
  // Sort students by their total points in descending order
  students.sort((a, b) => b.totalPoints.compareTo(a.totalPoints));

  // Allocate rooms
  for (int i = 0; i < students.length; i++) {
    students[i].roomNumber = i + 1; // Simple allocation logic
  }

  return students;
}
