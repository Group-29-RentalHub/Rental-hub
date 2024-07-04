import 'package:flutter/material.dart';
import 'package:rentalhub/models/house_model.dart';
class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final House? house = ModalRoute.of(context)?.settings.arguments as House?;

    if (house == null) {
      // Handle the case where house is null
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('House details not found.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('House Details'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  house.title,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.0),
                Image.asset(
                  house.imageUrl,
                  width: 300,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 16.0),
                Text(
                  'Location: ${house.location}',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Price: ${house.price}',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Add functionality to navigate to more details page
                  },
                  child: Text('View More Details'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
