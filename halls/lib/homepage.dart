import 'package:flutter/material.dart';
import 'Application_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Welcome to Makerere",
          style: TextStyle(
            color: Colors.red[500],
            fontStyle: FontStyle.italic,
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            height: 300,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/images/makerere.png"),
              fit: BoxFit.fitHeight,
            )),
          ),
          Container(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const Student();
                  }),
                );
              },
              child: const Text(
                'CONTINUE',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
