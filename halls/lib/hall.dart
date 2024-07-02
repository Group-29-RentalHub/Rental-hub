import 'package:flutter/material.dart';

class Hall extends StatefulWidget {
  const Hall({Key? key}) : super(key: key);


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
        title: const Text("University Halls"),
      ),
    );
  }
}
