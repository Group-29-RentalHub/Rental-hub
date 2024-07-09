import 'package:flutter/material.dart';

class BlockARooms extends StatefulWidget {
  const BlockARooms({super.key});

  @override
  State<BlockARooms> createState() => _BlockARoomsState();
}

class _BlockARoomsState extends State<BlockARooms> {
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
              child: const Text("ROOM A1"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
          
              },
              child: const Text("ROOM A2"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
              },
              child: const Text("ROOM A3"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
        
              },
              child: const Text("ROOM A4"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                
              },
              child: const Text("ROOM A5"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                
              },
              child: const Text("ROOM A6"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                
              },
              child: const Text("ROOM A7"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
              },
              child: const Text("ROOM A8"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
              
              },
              child: const Text("ROOM A9"),
            ),
             const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
              
              },
              child: const Text("ROOM A10"),
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