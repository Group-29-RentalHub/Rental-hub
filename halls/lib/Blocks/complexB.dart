import 'package:flutter/material.dart';

class BlockBRooms extends StatefulWidget {
  const BlockBRooms({super.key});

  @override
  State<BlockBRooms> createState() => _BlockBRoomsState();
}

class _BlockBRoomsState extends State<BlockBRooms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text("CHOOSE A ROOM"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            TextButton(
              onPressed: () {
                
              },
              child: const Text("ROOM B1"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
          
              },
              child: const Text("ROOM B2"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
              },
              child: const Text("ROOM B3"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
        
              },
              child: const Text("ROOM B4"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                
              },
              child: const Text("ROOM B5"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                
              },
              child: const Text("ROOM B6"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                
              },
              child: const Text("ROOM B7"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
              },
              child: const Text("ROOM B8"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
              
              },
              child: const Text("ROOM B9"),
            ),
             const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
              
              },
              child: const Text("ROOM B10"),
            ),
            const SizedBox(
              height: 10,
            ),
            
          ],
        ),
      ),
    );
  }
}