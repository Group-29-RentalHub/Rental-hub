import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/userprofile.dart'; // Ensure this path is correct
import 'edit_profile.dart'; // Import the EditProfile page

class Profile extends StatelessWidget {
  final String userId;

  const Profile({Key? key, required this.userId}) : super(key: key);

  Future<UserProfile> _fetchUserProfile() async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return UserProfile.fromFirestore(doc);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserProfile>(
      future: _fetchUserProfile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          return const Center(child: Text('User profile not found'));
        } else {
          final userProfile = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, // Center the content
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: userProfile.imageUrl != null
                          ? NetworkImage(userProfile.imageUrl!)
                          : const AssetImage('assets/default_profile.png') as ImageProvider,
                      backgroundColor: Colors.grey[200], // Default background color
                      child: userProfile.imageUrl == null
                          ? const Icon(Icons.person, size: 50, color: Colors.grey) // Default icon if no image
                          : null,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      userProfile.name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(118, 36, 177, 1), // Purple color
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildProfileFields(
                    [
                      _buildProfileField('Email', userProfile.email),
                      _buildProfileField('Address', userProfile.address),
                      _buildProfileField('Phone', userProfile.phone),
                      _buildProfileField('Date of Birth', userProfile.dateOfBirth),
                    ],
                  ),
                  const SizedBox(height: 24), // Increased spacing below the profile fields
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfile(userId: userId),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(118, 36, 177, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildProfileField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0), // Spacing between fields
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$label: ',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: const Color.fromRGBO(118, 36, 177, 1), // Purple color
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                color: const Color.fromRGBO(118, 36, 177, 1), // Purple color
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileFields(List<Widget> fields) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: fields,
    );
  }
}
