import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:halls/chat_service.dart';
import 'package:halls/chatpage.dart';
import 'package:halls/models/booking.dart';
import 'package:halls/models/house_model.dart';
import 'package:halls/models/reviewform.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatelessWidget {
  final House house;

  const DetailPage({Key? key, required this.house}) : super(key: key);

  Future<List<Map<String, dynamic>>> _fetchReviews() async {
    final reviewsRef = FirebaseFirestore.instance.collection('reviews');
    final querySnapshot =
        await reviewsRef.where('hostel_id', isEqualTo: house.id).get();
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final BookingService bookingService = BookingService();

    Future<void> _bookNow() async {
      final TextEditingController detailsController = TextEditingController();
      DateTime selectedDate = DateTime.now();

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Book Now'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: detailsController,
                decoration: const InputDecoration(
                  labelText: 'Additional Details',
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null && pickedDate != selectedDate) {
                    selectedDate = pickedDate;
                    // Refresh the UI to show the selected date
                    if (context.mounted) {
                      Navigator.of(context).setState(() {});
                    }
                  }
                },
                child: Text(
                  selectedDate == DateTime.now()
                      ? 'Pick Date'
                      : 'Selected Date: ${DateFormat.yMMMd().format(selectedDate)}',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Close the dialog
                try {
                  await bookingService.bookHostel(
                    hostelId: house.id,
                    hostelName: house.name,
                    bookingDate: selectedDate,
                    additionalDetails: detailsController.text,
                  );
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Booking successful!')),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to book the hostel: $e')),
                    );
                  }
                }
              },
              child: const Text('Book Now'),
            ),
          ],
        ),
      );
    }

    Future<void> _showReviewDialog() async {
      showDialog(
          context: context,
          builder: (context) => ReviewForm(
                hostelImage: house.images.isNotEmpty
                    ? house.images[0]
                    : 'https://via.placeholder.com/600x400',
                hostelId: house.id,
              ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(house.name, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromRGBO(70, 0, 119, 1),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main Image
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Image.network(
                  house.images.isNotEmpty
                      ? house.images[0]
                      : 'https://via.placeholder.com/600x400',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 250,
                ),
              ),
              const SizedBox(height: 16.0),

              // Image Grid
              if (house.images.length > 1)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.network(
                          house.images.length > 1
                              ? house.images[1]
                              : 'https://via.placeholder.com/300x200',
                          fit: BoxFit.cover,
                          height: 150,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.network(
                          house.images.length > 2
                              ? house.images[2]
                              : 'https://via.placeholder.com/300x200',
                          fit: BoxFit.cover,
                          height: 150,
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 8.0),

              // Additional Images Row
              if (house.images.length > 3)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.network(
                          house.images.length > 3
                              ? house.images[3]
                              : 'https://via.placeholder.com/300x200',
                          fit: BoxFit.cover,
                          height: 150,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: Image.network(
                          house.images.length > 4
                              ? house.images[4]
                              : 'https://via.placeholder.com/300x200',
                          fit: BoxFit.cover,
                          height: 150,
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 16.0),

              // Title and Location
              Text(
                house.name,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              // Text(
              //   house.location,
              //   style: const TextStyle(
              //     fontSize: 16.0,
              //     color: Colors.grey,
              //   ),
              // ),
              const SizedBox(height: 8.0),

              // Description
              const Text(
                'Description:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                house.description,
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 16.0),

              // Amenities
              const Text(
                'Amenities:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: house.amenities.entries
                    .where((entry) =>
                        entry.value) // Only display amenities that are true
                    .map((entry) => Text('- ${entry.key}'))
                    .toList(),
              ),
              const SizedBox(height: 16.0),

              // Contact Information
              Text(
                'Contact: ${house.contact}',
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),

              Text(
                'Hostel Gender: ${house.hostelGender}',
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // Minimum Requirements
              const Text(
                'Minimum Requirements:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('- Valid ID'),
                  Text('- Security Deposit'),
                  Text('- Minimum Stay of 2 nights'),
                  Text('- Proof of Income'),
                ],
              ),
              const SizedBox(height: 16.0),
              const SizedBox(height: 8.0),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: _fetchReviews(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No reviews available.');
                  } else {
                    final reviews = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: reviews.map((review) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review['user_name'] ?? 'Anonymous',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Row(
                                children: List.generate(5, (index) {
                                  return Icon(
                                    index < (review['rating'] ?? 0)
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: Colors.amber,
                                    size: 20,
                                  );
                                }),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                review['comment'] ?? 'No comment',
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
              const SizedBox(height: 16.0),
              // Book Now Button
              Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: _bookNow,
                    child: const Text('Book Now',
                        style: const TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(70, 0, 119, 1),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _showReviewDialog,
                    child: const Text('Leave a Review'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final currentUser = FirebaseAuth.instance.currentUser;
                      if (currentUser != null) {
                        final chatService = ChatService();
                        bool isCurrentUserOwner =
                            await chatService.isUserIdOwner(currentUser.uid);
                        String otherUserId =
                            isCurrentUserOwner ? 'userId${house.id}' : house.id;

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              // currentUserId: currentUser.uid,
                              // otherUserId: otherUserId,
                              hostelId: house.id,
                              ownerId: 'userId${house.id}',
                              userId: FirebaseAuth.instance.currentUser!.uid,
                            ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please log in to chat')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(70, 0, 119, 1),
                      elevation: 3.0,
                      textStyle: const TextStyle(color: Colors.white),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.chat, size: 20, color: Colors.white),
                        SizedBox(width: 4.0),
                        Text(
                          'Chat',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
