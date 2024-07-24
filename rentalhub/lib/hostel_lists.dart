import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:halls/hostel_edit.dart';
 import '/models/hostel.dart';

class HostelsListPage extends StatefulWidget {
  @override
  _HostelsListPageState createState() => _HostelsListPageState();
}

class _HostelsListPageState extends State<HostelsListPage> {
  User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Registered Hostels'),
        backgroundColor: const Color.fromRGBO(70, 0, 119, 1),
      ),
      body: currentUser == null
          ? Center(child: Text('You are not logged in.'))
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('hostels')
                  .where('user_id', isEqualTo: currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final hostels = snapshot.data!.docs
                    .map((doc) => Hostel.fromFirestore(doc as DocumentSnapshot<Map<String, dynamic>>))
                    .toList();

                if (hostels.isEmpty) {
                  return Center(child: Text('No hostels registered.'));
                }

                return ListView.builder(
                  itemCount: hostels.length,
                  itemBuilder: (context, index) {
                    final hostel = hostels[index];
                    return Card(
                      margin: EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(hostel.name),
                        subtitle: Text(
                          'Location: ${hostel.location}\n'
                          'Rooms: ${hostel.numberOfRooms}\n'
                          'Price per Room: ${hostel.pricePerRoom}\n'
                          'Contact: ${hostel.contactNumber}',
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditHostelPage(hostel: hostel),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
