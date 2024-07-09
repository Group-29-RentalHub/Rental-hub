import 'package:flutter/material.dart';
import '../Blocks/lumumbaA.dart';
import '../Blocks/lumumbaB.dart';
import '../Blocks/lumumbaC.dart';
import '../Blocks/lumumbaD.dart';

class Lumumba extends StatefulWidget {
  const Lumumba({super.key});

  @override
  State<Lumumba> createState() => _LumumbaState();
}

class _LumumbaState extends State<Lumumba> {
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
        title: const Text("CHOOSE A BLOCK "),
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
              height: 50,
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
              height: 50,
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
              height: 50,
            ),
            TextButton(
              onPressed: () {
                 Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const BlockDRooms();
                  }),
                );
              },
              child: const Text("BLOCK D"),
            ),
            const SizedBox(
              height: 50,
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