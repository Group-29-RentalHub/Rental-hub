import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExplorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore Hostels', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromRGBO(70, 0, 119, 1), // Theme color
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection('hostels').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching data.'));
          } else if (!snapshot.hasData || (snapshot.data as QuerySnapshot).docs.isEmpty) {
            return const Center(child: Text('No hostels found.'));
          } else {
            final hostels = (snapshot.data as QuerySnapshot).docs;
            return ListView.builder(
              itemCount: hostels.length,
              itemBuilder: (context, index) {
                final hostel = hostels[index].data() as Map<String, dynamic>;
                return ListTile(
                  title: Text(hostel['name']),
                  subtitle: Text('Location: ${hostel['location']}'),
                  onTap: () {
                    // Navigate to hostel details page
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
