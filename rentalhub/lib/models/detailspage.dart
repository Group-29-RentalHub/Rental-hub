import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:halls/chat_service.dart';
import 'package:halls/chatpage.dart';
import 'package:halls/models/booking.dart';
import 'package:halls/models/house_model.dart';
import 'package:intl/intl.dart'; // Import intl for date formatting

class DetailPage extends StatelessWidget {
  final House house;

  const DetailPage({super.key, required this.house})
      : assert(house != null, 'House cannot be null');

  @override
  Widget build(BuildContext context) {
    final BookingService bookingService = BookingService(); // Initialize the BookingService

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
                    // Update the state to refresh the UI
                    Navigator.of(context).setState(() {});
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
                    hostelId: house.id, // Assuming house.id is the hostel ID
                    bookingDate: selectedDate,
                    additionalDetails: detailsController.text,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Booking successful!')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Failed to book the hostel. Please try again.')),
                  );
                }
              },
              child: const Text('Book Now'),
            ),
          ],
        ),
      );
    }

    // Debug: Print the received house object
    print('Received House: $house');

    return Scaffold(
      appBar: AppBar(
        title: Text(house.name, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromRGBO(70, 0, 119, 1),
        iconTheme: IconThemeData(color: Colors.white),
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
                  house.images.isNotEmpty ? house.images[0] : 'https://via.placeholder.com/600x400',
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
                          house.images.length > 1 ? house.images[1] : 'https://via.placeholder.com/300x200',
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
                          house.images.length > 2 ? house.images[2] : 'https://via.placeholder.com/300x200',
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
                          house.images.length > 3 ? house.images[3] : 'https://via.placeholder.com/300x200',
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
                          house.images.length > 4 ? house.images[4] : 'https://via.placeholder.com/300x200',
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
              Text(
                house.location,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8.0),
              const Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star_border, color: Colors.yellow),
                ],
              ),
              const SizedBox(height: 16.0),

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
                  .where((entry) => entry.value) // Only display amenities that are true
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
                  Text('- No Smoking in Rooms'),
                ],
              ),
              const SizedBox(height: 16.0),

              // Ratings
              const Text(
                'Ratings:',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              const RatingBar(label: 'Cleanliness', rating: 4.5),
              const RatingBar(label: 'Hospitality', rating: 4.0),
              const RatingBar(label: 'Facilities', rating: 4.2),
              const SizedBox(height: 16.0),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: _bookNow, // Call the booking function
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(70, 0, 119, 1),
                    ),
                    child: const Text('Book Now'),
                  ),

                  //chat
                  ElevatedButton(
                  onPressed: () async {
                    final currentUser = FirebaseAuth.instance.currentUser;
                    if (currentUser != null) {
                      final chatService = ChatService();
                      bool isCurrentUserOwner = await chatService.isUserIdOwner(currentUser.uid);
                      String otherUserId = isCurrentUserOwner ? 'userId${house.id}' : house.id;

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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Dummy BookingService class
class BookingService {
  Future<void> bookHostel({
    required String hostelId,
    required DateTime bookingDate,
    required String additionalDetails,
  }) async {
    // Implement booking logic here
  }
}

// Dummy RatingBar widget
class RatingBar extends StatelessWidget {
  final String label;
  final double rating;

  const RatingBar({
    Key? key,
    required this.label,
    required this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(rating.toStringAsFixed(1)), // Show rating with 1 decimal place
      ],
    );
  }
}
