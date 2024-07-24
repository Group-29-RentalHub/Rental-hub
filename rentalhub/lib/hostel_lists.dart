import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:halls/hostel_edit.dart';
import 'package:halls/models/hostel.dart';

class HostelsListPage extends StatefulWidget {
  @override
  _HostelsListPageState createState() => _HostelsListPageState();
}

class _HostelsListPageState extends State<HostelsListPage> {
  User? currentUser;
  List<Hostel> hostels = []; // Initialize empty list

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    _fetchHostels(); // Call data fetching function
  }

  Future<void> _fetchHostels() async {
    if (currentUser == null) return;

    final snapshot = await FirebaseFirestore.instance
        .collection('hostels')
        .where('userId', isEqualTo: currentUser!.uid)
        .get();

    hostels = snapshot.docs
        .map((doc) => Hostel.fromFirestore(doc as DocumentSnapshot<Map<String, dynamic>>))
        .toList();

    setState(() {}); // Update UI after data is fetched
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
          : hostels.isEmpty
              ? Center(child: Text('No hostels registered.'))
              : ListView.builder(
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
                ),
    );
  }
}
