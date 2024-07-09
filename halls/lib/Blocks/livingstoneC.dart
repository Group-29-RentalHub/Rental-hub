import 'package:flutter/material.dart';

class BlockCRooms extends StatefulWidget {
  const BlockCRooms({super.key});

  @override
  State<BlockCRooms> createState() => _BlockBRoomsState();
}

class _BlockBRoomsState extends State<BlockCRooms> {
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
              child: const Text("ROOM C1"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
          
              },
              child: const Text("ROOM C2"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
              },
              child: const Text("ROOM C3"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
        
              },
              child: const Text("ROOM C4"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                
              },
              child: const Text("ROOM C5"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                
              },
              child: const Text("ROOM C6"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                
              },
              child: const Text("ROOM C7"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
              },
              child: const Text("ROOM C8"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
              
              },
              child: const Text("ROOM C9"),
            ),
             const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
              
              },
              child: const Text("ROOM C10"),
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