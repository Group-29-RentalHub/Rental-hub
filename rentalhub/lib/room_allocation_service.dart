import 'package:cloud_firestore/cloud_firestore.dart';
import 'student_model.dart'; // Ensure Student model is imported and defined correctly

// Function to fetch students from Firestore
Future<List<Student>> fetchStudents() async {
  try {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('students').get();

    List<Student> students = querySnapshot.docs.map((doc) {
      return Student.fromFirestore(doc); // Use static method from Student class
    }).toList();

    return students;
  } catch (e) {
    print('Error fetching students: $e');
    return [];
  }
}

// Function to allocate rooms based on criteria
void allocateRooms(List<Student> students) {
  List<Student> eligibleStudents = students.where((student) {
    return student.totalPoints >= 70 &&
        student.isAttachedToHall &&
        student.isContinuingResident &&
        !student.isDisabled &&
        (student.isGovernmentStudent || student.isPrivateStudent);
  }).toList();

  for (var student in eligibleStudents) {
    String allocatedRoom = allocateRoomBasedOnCriteria(student);
    print('${student.firstName} ${student.lastName} allocated to $allocatedRoom');
    
    updateStudentRoom(student.id, allocatedRoom);
  }
}

// Example function to allocate room based on criteria
String allocateRoomBasedOnCriteria(Student student) {
  return 'Room 101'; // Replace with actual room allocation logic
}

// Function to update student's allocated room in Firestore
void updateStudentRoom(String studentId, String allocatedRoom) {
  try {
    FirebaseFirestore.instance.collection('students').doc(studentId).update({
      'roomNumber': allocatedRoom,
    });
  } catch (e) {
    print('Error updating room for student: $e');
  }
}
