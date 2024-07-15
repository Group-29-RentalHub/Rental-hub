import 'package:flutter/material.dart';
import 'package:halls/services/authentication.dart';
import 'Application_form.dart';
import "login.dart";
import 'profile.dart';
class Hall extends StatefulWidget {
  const Hall({super.key});

  @override
  State<Hall> createState() => _HallState();
}

class _HallState extends State<Hall> {
  int currentpage = 0;
  List<Widget> pages = const [
    Hall(),
    ProfilePage(),
    LoginScreen(),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("CHOOSE YOUR HALL"),
        backgroundColor: Colors.green,
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
      bottomNavigationBar:NavigationBarTheme(
        data: const NavigationBarThemeData(
          indicatorColor: Colors.green,),
       child: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(
              icon: Icon(Icons.perm_identity), label: 'Profile'),
          NavigationDestination(icon: Icon(Icons.logout), label: 'Logout'),
        ],
        onDestinationSelected: (int index) async {
           if (index == 2) {
      // Perform logout
      await AuthMethod().signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );}
          setState(() {
            currentpage = index;
          });
        },
        selectedIndex: currentpage,
      
      ),
    ));
  }
}
