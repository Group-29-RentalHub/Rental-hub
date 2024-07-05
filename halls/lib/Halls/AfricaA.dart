import 'package:flutter/material.dart';
class BlockARooms extends StatelessWidget {
  const BlockARooms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLOCK A ROOMS'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: ListView(
          children: const [
            ListTile(
              title: Text('Room 1'),
            ),
            ListTile(
              title: Text('Room 2'),
            ),
            ListTile(
              title: Text('Room 3'),
            ),
            ListTile(
              title: Text('Room 4'),
            ),
            ListTile(
              title: Text('Room 5'),
            ),
            ListTile(
              title: Text('Room 6'),
            ),
             ListTile(
              title: Text('Room 7'),
            ),
             ListTile(
              title: Text('Room 8'),
            ),
             ListTile(
              title: Text('Room 9'),
            ),
             ListTile(
              title: Text('Room 10'),
            ),
             ListTile(
              title: Text('Room 11'),
            ),
             ListTile(
              title: Text('Room 12'),
            ),
             ListTile(
              title: Text('Room 13'),
            ),
             ListTile(
              title: Text('Room 14'),
            ),
             ListTile(
              title: Text('Room 15'),
            ),
             ListTile(
              title: Text('Room 16'),
            ),
             ListTile(
              title: Text('Room 17'),
            
            ),
             ListTile(
              title: Text('Room 18'),
            ),
             ListTile(
              title: Text('Room 19'),
            ),
             ListTile(
              title: Text('Room 20'),
            )    
          ],
        
        ),
      ),
    );
  }
}