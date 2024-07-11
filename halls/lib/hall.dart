import 'package:flutter/material.dart';
import 'Application_form.dart';
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
                  return const Student();
                }));
              },
              child: const Text("Nkrumah"),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: SizedBox(
                  height: 150.0,
                  width: 50.0,
                  child: Image.asset(
                    "assets/images/nkruma.jpeg",
                    fit: BoxFit.fill,
                  )),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const Student();
                }));
              },
              child: const Text("Livingstone"),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: SizedBox(
                height: 150.0,
                width: 50.0,
                child: Image.asset(
                  "assets/images/livingston.jpg",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const Student();
                }));
              },
              child: const Text("Mitchell"),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: SizedBox(
                height: 150.0,
                width: 50.0,
                child: Image.asset(
                  "assets/images/mitchel.jpg",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const Student();
                }));
              },
              child: const Text("Nsibirwa"),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: SizedBox(
                height: 150.0,
                width: 50.0,
                child: Image.asset(
                  "assets/images/nsibirw.jpg",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const Student();
                }));
              },
              child: const Text("University Hall"),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: SizedBox(
                height: 150.0,
                width: 50.0,
                child: Image.asset(
                  "assets/images/university.jpg",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const Student();
                }));
              },
              child: const Text("Lumumba"),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: SizedBox(
                height: 150.0,
                width: 50.0,
                child: Image.asset(
                  "assets/images/lumumb.jpg",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const Student();
                }));
              },
              child: const Text("Africa"),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: SizedBox(
                height: 150.0,
                width: 50.0,
                child: Image.asset(
                  "assets/images/afric.jpg",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const Student();
                }));
              },
              child: const Text("Complex"),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: SizedBox(
                height: 150.0,
                width: 50.0,
                child: Image.asset(
                  "assets/images/comp.jpg",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const Student();
                }));
              },
              child: const Text("Mary Stuart"),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: SizedBox(
                height: 150.0,
                width: 50.0,
                child: Image.asset(
                  "assets/images/mary.jpg",
                  fit: BoxFit.fill,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
