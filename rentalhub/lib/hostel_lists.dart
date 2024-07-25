import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import 'hostel_edit.dart';
  
class HostelListingsPage extends StatefulWidget {
  const HostelListingsPage({super.key});

  @override
  _HostelListingsPageState createState() => _HostelListingsPageState();
}

class _HostelListingsPageState extends State<HostelListingsPage> {
  late Future<List<Map<String, dynamic>>> _hostelsFuture;

  @override
  void initState() {
    super.initState();
    _hostelsFuture = _fetchHostels();
  }

  Future<List<Map<String, dynamic>>> _fetchHostels() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('No user is signed in.');
    }

    String userId = user.uid;

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('hostels')
        .where('userId', isEqualTo: userId)
        .get();

    if (querySnapshot.docs.isEmpty) {
      return [];
    }

    List<Map<String, dynamic>> hostels = querySnapshot.docs
        .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
        .toList();

    return hostels;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Hostels', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromRGBO(70, 0, 119, 1),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _hostelsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hostels found.'));
          }

          List<Map<String, dynamic>> hostels = snapshot.data!;
          return ListView.builder(
            itemCount: hostels.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> hostel = hostels[index];
              String hostelName = hostel['name'] ?? 'No Name';
              String hostelLocation = hostel['location'] ?? 'No Location';
              String? photoUrl = hostel['images'][0];

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(8.0),
                  leading: photoUrl != null
                      ? Image.network(photoUrl, width: 100, height: 100, fit: BoxFit.cover)
                      : Container(width: 100, height: 100, color: Colors.grey),
                  title: Text(
                    hostelName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(hostelLocation),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Navigator.push(
                      //  context,
                      //   MaterialPageRoute(
                      //     builder: (context) => EditHostelPage(hostelId: hostel['id']),
                      //   ),
                      // );
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
