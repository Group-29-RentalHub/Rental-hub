import 'package:flutter/material.dart';
import 'package:halls/Blocks/nkurumahA.dart';
import 'package:halls/Blocks/nkurumahB.dart';
import 'package:halls/Blocks/nkurumahC.dart';
import 'package:halls/Blocks/nkurumahD.dart';
class Nkrumah extends StatefulWidget {
  const Nkrumah({super.key});

  @override
  State<Nkrumah> createState() => _NkrumahState();
}

class _NkrumahState extends State<Nkrumah> {
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
              height: 70,
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