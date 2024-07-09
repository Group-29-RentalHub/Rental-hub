import 'package:flutter/material.dart';

class BlockERooms extends StatefulWidget {
  const BlockERooms({super.key});

  @override
  State<BlockERooms> createState() => _BlockERoomsState();
}

class _BlockERoomsState extends State<BlockERooms> {
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
              child: const Text("ROOM ED1"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
          
              },
              child: const Text("ROOM ED2"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
              },
              child: const Text("ROOM ED3"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
        
              },
              child: const Text("ROOM ED4"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                
              },
              child: const Text("ROOM ED5"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                
              },
              child: const Text("ROOM ED6"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                
              },
              child: const Text("ROOM ED7"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
              },
              child: const Text("ROOM ED8"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
              
              },
              child: const Text("ROOM ED9"),
            ),
             const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
              
              },
              child: const Text("ROOM E10"),
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