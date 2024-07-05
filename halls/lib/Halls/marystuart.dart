import 'package:flutter/material.dart';
import 'marystuartA.dart';
import 'marystuartB.dart';
import 'marystuartC.dart';
import 'marystuartD.dart';
import 'marystuartE.dart';
import 'marystuartF.dart';
import 'marystuartG.dart';
import 'marystuartH.dart';
import 'marystuartJ.dart';
import 'marystuartK.dart';
import 'marystuartL.dart';
import 'marystuartM.dart';
import 'marystuartN.dart';
import 'marystuartP.dart';

class Marystuart extends StatefulWidget {
  const Marystuart({super.key});

  @override
  State<Marystuart> createState() => _MarystuartState();
}

class _MarystuartState extends State<Marystuart> {
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
              height: 40,
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
              height: 40,
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
              height: 40,
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
              height: 40,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const BlockERooms();
                  }),
                );
              },
              child: const Text("BLOCK E"),
            ),
            const SizedBox(
              height: 40,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const BlockFRooms();
                  }),
                );
              },
              child: const Text("BLOCK F"),
            ),
            const SizedBox(
              height: 40,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const BlockGRooms();
                  }),
                );
              },
              child: const Text("BLOCK G"),
            ),
            const SizedBox(
              height: 40,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const BlockHRooms();
                  }),
                );
              },
              child: const Text("BLOCK H"),
            ),
            const SizedBox(
              height: 40,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const BlockJRooms();
                  }),
                );
              },
              child: const Text("BLOCK J"),
            ),
            const SizedBox(
              height: 40,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const BlockKRooms();
                  }),
                );
              },
              child: const Text("BLOCK K"),
            ),
            const SizedBox(
              height: 40,
            ),
           TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const BlockLRooms();
                  }),
                );
              },
              child: const Text("BLOCK L"),
            ),
            const SizedBox(
              height: 40,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const BlockMRooms();
                  }),
                );
              },
              child: const Text("BLOCK M"),
            ),
            const SizedBox(
              height: 40,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const BlockNRooms();
                  }),
                );
              },
              child: const Text("BLOCK N"),
            ),
            const SizedBox(
              height: 40,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const BlockPRooms();
                  }),
                );
              },
              child: const Text("BLOCK P"),
            ),
            const SizedBox(
              height: 40,
            ),
            
            
          ],
        ),
      ),
    );
  }
}