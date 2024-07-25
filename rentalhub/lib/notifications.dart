import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationHistoryPage extends StatefulWidget {
  const NotificationHistoryPage({super.key});

  @override
  _NotificationHistoryPageState createState() =>
      _NotificationHistoryPageState();
}

class _NotificationHistoryPageState extends State<NotificationHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('hostels')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            var notifications = snapshot.data!.docs.map((doc) {
              return {
                'title': 'New Hostel Added',
                'body': doc['name'],
                'date': (doc['createdAt'] as Timestamp).toDate().toString(),
                'read': false, // default to false, update as necessary
              };
            }).toList();

            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return NotificationCard(
                  title: notification['title'],
                  body: notification['body'],
                  date: notification['date'],
                  read: notification['read'],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String body;
  final String date;
  final bool read;

  const NotificationCard({
    super.key,
    required this.title,
    required this.body,
    required this.date,
    required this.read,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: read ? Colors.white : Colors.blue.shade50,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Icon(
          read ? Icons.mark_email_read : Icons.mark_email_unread,
          color: read ? Colors.green : Colors.blue,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: read ? FontWeight.normal : FontWeight.bold,
          ),
        ),
        subtitle: Text(body),
        trailing: Text(date),
        onTap: () {
          // Mark as read or perform other actions
        },
      ),
    );
  }
}
