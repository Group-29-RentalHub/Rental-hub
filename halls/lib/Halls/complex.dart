import 'package:flutter/material.dart';
import 'package:halls/Blocks/complexA.dart';
import 'package:halls/Blocks/complexB.dart';
import 'package:halls/Blocks/complexC.dart';

class Complex extends StatefulWidget {
  const Complex({super.key});

  @override
  State<Complex> createState() => _ComplexState();
}

class _ComplexState extends State<Complex> {
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
        title: const Text("CHOOSE A BLOCK"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const BlockARooms();
                  }),
                );
              },
              child: const Text("BLOCK A"),
            ),
            const SizedBox(
              height: 60,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const BlockBRooms();
                  }),
                );
              },
              child: const Text("BLOCK B"),
            ),
            const SizedBox(
              height: 60,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const BlockCRooms();
                  }),
                );
              },
              child: const Text("BLOCK C"),
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
