// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'chat_service.dart';

// class ChatPage extends StatefulWidget {
//   final String currentUserId;
//   final String hostelId;

//   const ChatPage({
//     Key? key,
//     required this.currentUserId,
//     required this.hostelId,
//   }) : super(key: key);

//   @override
//   _ChatPageState createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   final TextEditingController _messageController = TextEditingController();
//   final ChatService _chatService = ChatService();
//   late String _chatId;

//   @override
//   void initState() {
//     super.initState();
//     _chatId = _chatService.getChatId(widget.currentUserId, widget.hostelId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat about Hostel'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: _chatService.getMessages(_chatId),
//               builder: (context, snapshot) {
//                 if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 }
//                 if (!snapshot.hasData) {
//                   return Center(child: CircularProgressIndicator());
//                 }
//                 final messages = snapshot.data!.docs;
//                 return ListView.builder(
//                   reverse: true,
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     final message = messages[index].data() as Map<String, dynamic>;
//                     final isCurrentUser = message['senderId'] == widget.currentUserId;
//                     return _buildMessageBubble(message, isCurrentUser);
//                   },
//                 );
//               },
//             ),
//           ),
//           _buildMessageInput(),
//         ],
//       ),
//     );
//   }

//   Widget _buildMessageBubble(Map<String, dynamic> message, bool isCurrentUser) {
//     return Align(
//       alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//         padding: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: isCurrentUser ? Colors.blue[100] : Colors.grey[300],
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: Text(message['content']),
//       ),
//     );
//   }

//   Widget _buildMessageInput() {
//     return Container(
//       padding: EdgeInsets.all(8),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: _messageController,
//               decoration: InputDecoration(
//                 hintText: 'Type a message...',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(width: 8),
//           IconButton(
//             icon: Icon(Icons.send),
//             onPressed: _sendMessage,
//           ),
//         ],
//       ),
//     );
//   }

//   void _sendMessage() {
//     if (_messageController.text.isNotEmpty) {
//       _chatService.sendMessage(
//         _chatId,
//         widget.currentUserId,
//         _messageController.text,
//       );
//       _messageController.clear();
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'chat_service.dart';

// class ChatPage extends StatefulWidget {
//   final String currentUserId;
//   final String hostelId;
//   final bool isOwner;

//   ChatPage({
//     required this.currentUserId,
//     required this.hostelId,
//     required this.isOwner,
//   });

//   @override
//   _ChatPageState createState() => _ChatPageState();
// }

// class _ChatPageState extends State<ChatPage> {
//   final ChatService _chatService = ChatService();
//   final TextEditingController _messageController = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   late String _chatId;
//   String? _hostelName;

//   @override
//   void initState() {
//     super.initState();
//     _chatId = _chatService.getChatId(widget.currentUserId, widget.hostelId);
//     _initializeChat();
//     _loadHostelName();
//   }

//   void _initializeChat() async {
//     await _chatService.createOrUpdateChat(_chatId, widget.currentUserId, widget.hostelId);
//   }

//   void _loadHostelName() async {
//     String? name = await _chatService.getHostelName(widget.hostelId);
//     setState(() {
//       _hostelName = name ?? 'Unknown Hostel';
//     });
//   }

//   void _sendMessage() async {
//     if (_messageController.text.isNotEmpty) {
//       await _chatService.sendMessage(
//         _chatId,
//         widget.currentUserId,
//         _messageController.text,
//       );
//       _messageController.clear();
//       _scrollController.animateTo(
//         0.0,
//         duration: Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(_hostelName ?? 'Loading...', style: TextStyle(color: Colors.white),),
//         backgroundColor: const Color.fromRGBO(70, 0, 119, 1),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: _chatService.getMessages(_chatId),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                   return Center(child: CircularProgressIndicator(
//                     valueColor: AlwaysStoppedAnimation<Color>(const Color.fromRGBO(70, 0, 119, 1)),
//                   ));
//                 }

//                 final messages = snapshot.data!.docs;

//                 return ListView.builder(
//                   controller: _scrollController,
//                   reverse: true,
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     final message = messages[index].data() as Map<String, dynamic>;
//                     final isCurrentUser = message['senderId'] == widget.currentUserId;

//                     return Align(
//                       alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
//                       child: Container(
//                         margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//                         padding: EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: isCurrentUser ? const Color.fromRGBO(70, 0, 119, 1) : Colors.grey[300],
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               message['content'],
//                               style: TextStyle(color: isCurrentUser ? Colors.white : Colors.black87),
//                             ),
//                             SizedBox(height: 4),
//                             Text(
//                               isCurrentUser ? 'You' : (widget.isOwner ? 'Booker' : 'Owner'),
//                               style: TextStyle(color: isCurrentUser ? Colors.white70 : Colors.black54, fontSize: 10),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Container(
//             color: Colors.grey[200],
//             padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _messageController,
//                     decoration: InputDecoration(
//                       hintText: 'Type a message...',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(24),
//                         borderSide: BorderSide(color: const Color.fromRGBO(70, 0, 119, 1)),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(24),
//                         borderSide: BorderSide(color: const Color.fromRGBO(70, 0, 119, 1), width: 2),
//                       ),
//                       filled: true,
//                       fillColor: Colors.white,
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 Container(
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: const Color.fromRGBO(70, 0, 119, 1),
//                   ),
//                   child: IconButton(
//                     icon: Icon(Icons.send, color: Colors.white),
//                     onPressed: _sendMessage,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  final String hostelId;
  final String ownerId;
  final String userId;

  ChatScreen({
    required this.hostelId,
    required this.ownerId,
    required this.userId,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> _messagesStream;
  late String currentUserId;
  late bool isOwner;

  @override
  void initState() {
    super.initState();
    currentUserId = _auth.currentUser!.uid;
    isOwner = currentUserId == 'userId${widget.hostelId}';
    _setupMessagesStream();
  }

  void _setupMessagesStream() {
    _messagesStream = _firestore
        .collection('messages')
        .where('hostelId', isEqualTo: widget.hostelId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  void _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      String compositeId = isOwner
          ? 'userId${widget.hostelId}_${widget.userId}'
          : '${widget.userId}_userId${widget.hostelId}';

      try {
        await _firestore.collection('messages').add({
          'senderId': currentUserId,
          'receiverId': isOwner ? widget.userId : 'userId${widget.hostelId}',
          'messageContent': _messageController.text,
          'timestamp': FieldValue.serverTimestamp(),
          'hostelId': widget.hostelId,
          'compositeId': compositeId,
        });
        _messageController.clear();
      } catch (e) {
        print('Error sending message: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${isOwner ? "User" : "Hostel Owner"}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _messagesStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No messages yet.'));
                }

                return ListView.builder(
                  reverse: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var doc = snapshot.data!.docs[index];
                    bool isMe = doc['senderId'] == currentUserId;
                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.blue : Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doc['messageContent'],
                              style: TextStyle(color: isMe ? Colors.white : Colors.black),
                            ),
                            SizedBox(height: 2),
                            Text(
                              isMe ? 'You' : (isOwner ? 'User' : 'Hostel Owner'),
                              style: TextStyle(
                                color: isMe ? Colors.white70 : Colors.black54,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Enter a message...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
