import 'package:flutter/material.dart';

class BlockDRooms extends StatefulWidget {
  const BlockDRooms({super.key});

  @override
  State<BlockDRooms> createState() => _BlockDRoomsState();
}

class _BlockDRoomsState extends State<BlockDRooms> {
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
      ),
      body: Center(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            TextButton(
              onPressed: () {
                
              },
              child: const Text("ROOM D1"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
          
              },
              child: const Text("ROOM D2"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
              },
              child: const Text("ROOM D3"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
        
              },
              child: const Text("ROOM D4"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                
              },
              child: const Text("ROOM D5"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                
              },
              child: const Text("ROOM D6"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                
              },
              child: const Text("ROOM D7"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
              },
              child: const Text("ROOM D8"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
              
              },
              child: const Text("ROOM D9"),
            ),
             const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
              
              },
              child: const Text("ROOM D10"),
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