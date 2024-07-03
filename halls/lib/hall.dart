import 'package:flutter/material.dart';
import 'Halls/africa.dart';
import 'Halls/complex.dart';
import 'Halls/Livingstone.dart';
import 'Halls/lumumba.dart';
import 'Halls/marystuart.dart';
import 'Halls/mitchell.dart';
import 'Halls/nkrumah.dart';
import 'Halls/nsibirwa.dart';
import 'Halls/universityHall.dart';

class Hall extends StatefulWidget {
  const Hall({super.key});

  @override
  State<Hall> createState() => _HallState();
}

class _HallState extends State<Hall> {
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
        title: const Text("CHOOSE YOUR HALL"),
      ),
      body: Center(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const Nkrumah();
                }));
              },
              child: const Text("Nkrumah"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const Livingstone();
                }));
              },
              child: const Text("Livingstone"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const Mitchell();
                }));
              },
              child: const Text("Mitchell"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const Nsibirwa();
                }));
              },
              child: const Text("Nsibirwa"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const Universityhall();
                }));
              },
              child: const Text("University Hall"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const Lumumba();
                }));
              },
              child: const Text("Lumumba"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const Africa();
                }));
              },
              child: const Text("Africa"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const Complex();
                }));
              },
              child: const Text("Complex"),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const Marystuart();
                }));
              },
              child: const Text("Mary Stuart"),
            ),
          ],
        ),
      ),
    );
  }
}
