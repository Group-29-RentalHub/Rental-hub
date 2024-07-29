// import 'package:cloud_firestore/cloud_firestore.dart';

// class ChatService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   String getChatId(String userId, String hostelId) {
//     return '${userId}_$hostelId';
//   }

//   Future<void> sendMessage(
//       String chatId, String senderId, String content) async {
//     try {
//       await _firestore.collection('chats').doc(chatId).set({
//         'lastMessage': content,
//         'lastMessageTimestamp': FieldValue.serverTimestamp(),
//       }, SetOptions(merge: true));

//       await _firestore
//           .collection('chats')
//           .doc(chatId)
//           .collection('messages')
//           .add({
//         'senderId': senderId,
//         'content': content,
//         'timestamp': FieldValue.serverTimestamp(),
//       });
//     } catch (e) {
//       print('Error sending message: $e');
//     }
//   }

//   Stream<QuerySnapshot> getMessages(String chatId) {
//     return _firestore
//         .collection('chats')
//         .doc(chatId)
//         .collection('messages')
//         .orderBy('timestamp', descending: true)
//         .snapshots();
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';

// class ChatService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   String getChatId(String currentUserId, String hostelId) {
//     List<String> ids = [currentUserId, hostelId];
//     ids.sort();
//     return ids.join('_');
//   }

//   Future<void> sendMessage(String chatId, String senderId, String content) async {
//     try {
//       final messageRef = _firestore
//           .collection('chats')
//           .doc(chatId)
//           .collection('messages')
//           .doc();

//       await messageRef.set({
//         'senderId': senderId,
//         'content': content,
//         'timestamp': FieldValue.serverTimestamp(),
//         'id': messageRef.id,
//       });

//       await _firestore.collection('chats').doc(chatId).set({
//         'lastMessage': content,
//         'lastMessageTimestamp': FieldValue.serverTimestamp(),
//         'lastSenderId': senderId,
//       }, SetOptions(merge: true));
//     } catch (e) {
//       print('Error sending message: $e');
//     }
//   }

//   Stream<QuerySnapshot> getMessages(String chatId) {
//     return _firestore
//         .collection('chats')
//         .doc(chatId)
//         .collection('messages')
//         .orderBy('timestamp', descending: true)
//         .snapshots();
//   }

//   Future<void> createOrUpdateChat(String chatId, String currentUserId, String hostelId) async {
//     try {
//       await _firestore.collection('chats').doc(chatId).set({
//         'participants': [currentUserId, hostelId],
//         'lastMessageTimestamp': FieldValue.serverTimestamp(),
//       }, SetOptions(merge: true));
//     } catch (e) {
//       print('Error creating or updating chat: $e');
//     }
//   }

//   Future<String?> getHostelName(String hostelId) async {
//     try {
//       DocumentSnapshot hostelDoc = await _firestore.collection('hostels').doc(hostelId).get();
//       if (hostelDoc.exists) {
//         return (hostelDoc.data() as Map<String, dynamic>)['name'] as String?;
//       }
//     } catch (e) {
//       print('Error fetching hostel name: $e');
//     }
//     return null;
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String getChatId(String userId1, String userId2) {
    List<String> ids = [userId1, userId2];
    ids.sort();
    return ids.join('_');
  }

  Future<void> sendMessage(String chatId, String senderId, String content) async {
    try {
      final messageRef = _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .doc();

      await messageRef.set({
        'senderId': senderId,
        'content': content,
        'timestamp': FieldValue.serverTimestamp(),
        'id': messageRef.id,
      });

      await _firestore.collection('chats').doc(chatId).set({
        'lastMessage': content,
        'lastMessageTimestamp': FieldValue.serverTimestamp(),
        'lastSenderId': senderId,
      }, SetOptions(merge: true));
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  Stream<QuerySnapshot> getMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Future<void> createOrUpdateChat(String chatId, String userId1, String userId2) async {
    try {
      await _firestore.collection('chats').doc(chatId).set({
        'participants': [userId1, userId2],
        'lastMessageTimestamp': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      print('Error creating or updating chat: $e');
    }
  }

  Future<String?> getUserName(String userId) async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        return (userDoc.data() as Map<String, dynamic>)['name'] as String?;
      }
    } catch (e) {
      print('Error fetching user name: $e');
    }
    return null;
  }

  Future<bool> isUserIdOwner(String userId) async {
    try {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        return (userDoc.data() as Map<String, dynamic>)['isOwner'] ?? false;
      }
    } catch (e) {
      print('Error checking if user is owner: $e');
    }
    return false;
  }
}
