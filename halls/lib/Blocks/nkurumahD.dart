import 'package:flutter/material.dart';
class BlockDRooms extends StatelessWidget {
  const BlockDRooms({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BLOCK D ROOMS'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: ListView(
          children: const [
            ListTile(
              title: Text(' D1'),
            ),
            ListTile(
              title: Text(' D2'),
            ),
            ListTile(
              title: Text('D3'),
            ),
            ListTile(
              title: Text(' D4'),
            ),
            ListTile(
              title: Text(' D5'),
            ),
            ListTile(
              title: Text(' D6'),
            ),
             ListTile(
              title: Text('D7'),
            ),
             ListTile(
              title: Text('D8'),
            ),
             ListTile(
              title: Text('D9'),
            ),
             ListTile(
              title: Text('D10'),
            ),
             ListTile(
              title: Text('D11'),
            ),
             ListTile(
              title: Text('D12'),
            ),
             ListTile(
              title: Text('D13'),
            ),
             ListTile(
              title: Text('D14'),
            ),
             ListTile(
              title: Text('D15'),
            ),
             ListTile(
              title: Text('D16'),
            ),
             ListTile(
              title: Text('D17'),
            
            ),
             ListTile(
              title: Text('D18'),
            ),
             ListTile(
              title: Text('D19'),
            ),
             ListTile(
              title: Text('D20'),
            )    
          ],
        
        ),
      ),
    );
  }
}