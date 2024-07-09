import 'package:flutter/material.dart';
import 'package:halls/Blocks/livingstoneA.dart';
import 'package:halls/Blocks/livingstoneB.dart';
import 'package:halls/Blocks/livingstoneC.dart';

class Livingstone extends StatefulWidget {
  const Livingstone({super.key});

  @override
  State<Livingstone> createState() => _LivingstoneState();
}

class _LivingstoneState extends State<Livingstone> {
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
              height: 70,
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
              height: 70,
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
              height: 70,
            ),
          ],
        ),
      ),
    );
  }
}
