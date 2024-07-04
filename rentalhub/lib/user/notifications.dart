import 'package:flutter/material.dart';

class NotificationHistoryPage extends StatefulWidget {
  @override
  _NotificationHistoryPageState createState() =>
      _NotificationHistoryPageState();
}

class _NotificationHistoryPageState extends State<NotificationHistoryPage> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'title': 'New Message',
      'body': 'You have a new message.',
      'date': '2024-07-01',
      'read': false
    },
    {
      'title': 'Alert',
      'body': 'Your subscription is about to expire.',
      'date': '2024-06-30',
      'read': true
    },
    {
      'title': 'Alert',
      'body': 'Your subscription is about to expire.',
      'date': '2024-06-30',
      'read': true
    },
    {
      'title': 'Alert',
      'body': 'Your subscription is about to expire.',
      'date': '2024-06-30',
      'read': true
    },
    {
      'title': 'Alert',
      'body': 'Your subscription is about to expire.',
      'date': '2024-06-30',
      'read': true
    },
    {
      'title': 'Alert',
      'body': 'Your subscription is about to expire.',
      'date': '2024-06-30',
      'read': true
    },
    // Add more notifications here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body: Container(
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [
        //       Color.fromRGBO(70, 0, 119, 0),
        //       Color.fromRGBO(70, 0, 119, 1),
        //     ],
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //   ),
        // ),
        child: ListView.builder(
          itemCount: _notifications.length,
          itemBuilder: (context, index) {
            final notification = _notifications[index];
            return NotificationCard(
              title: notification['title'],
              body: notification['body'],
              date: notification['date'],
              read: notification['read'],
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

  NotificationCard({
    required this.title,
    required this.body,
    required this.date,
    required this.read,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: read ? Colors.white : Colors.blue.shade50,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
