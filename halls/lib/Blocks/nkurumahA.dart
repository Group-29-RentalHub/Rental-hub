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
              title: Text('A1'),
            ),
            ListTile(
              title: Text('A2'),
            ),
            ListTile(
              title: Text(' A3'),
            ),
            ListTile(
              title: Text(' A4'),
            ),
            ListTile(
              title: Text(' A5'),
            ),
            ListTile(
              title: Text(' A6'),
            ),
             ListTile(
              title: Text('A7'),
            ),
             ListTile(
              title: Text('A8'),
            ),
             ListTile(
              title: Text('A9'),
            ),
             ListTile(
              title: Text('A10'),
            ),
             ListTile(
              title: Text(' A11'),
            ),
             ListTile(
              title: Text(' A12'),
            ),
             ListTile(
              title: Text(' A13'),
            ),
             ListTile(
              title: Text('A14'),
            ),
             ListTile(
              title: Text('A15'),
            ),
             ListTile(
              title: Text('A16'),
            ),
             ListTile(
              title: Text('A17'),
            
            ),
             ListTile(
              title: Text('A18'),
            ),
             ListTile(
              title: Text('A19'),
            ),
             ListTile(
              title: Text('A20'),
            )    
          ],
        
        ),
      ),
    );
  }
}