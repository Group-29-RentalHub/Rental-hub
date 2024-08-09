
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart'; // Make sure to add this package to your pubspec.yaml

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
  String hostelName = "Chat"; // Default value

  @override
  void initState() {
    super.initState();
    currentUserId = _auth.currentUser!.uid;
    isOwner = currentUserId == 'userId${widget.hostelId}';
    _setupMessagesStream();
    _fetchHostelName();
  }

  void _setupMessagesStream() {
    _messagesStream = _firestore
        .collection('messages')
        .where('hostelId', isEqualTo: widget.hostelId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  void _fetchHostelName() async {
    DocumentSnapshot hostelDoc = await _firestore.collection('hostels').doc(widget.hostelId).get();
    if (hostelDoc.exists) {
      setState(() {
        hostelName = hostelDoc['name'] ?? "Chat";
      });
    }
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
        title: Text(hostelName, style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromRGBO(70, 0, 119, 1),
        iconTheme: IconThemeData(color: Colors.white),
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
                    Timestamp? timestamp = doc['timestamp'] as Timestamp?;
                    String time = timestamp != null
                        ? DateFormat('HH:mm').format(timestamp.toDate())
                        : '';

                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.purple: Colors.grey[300],
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
                              time,
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


