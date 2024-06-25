import 'package:flutter/material.dart';
import 'home_page.dart';
import 'profile_page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentpage = 0;
  List<Widget> pages = const [
    WelcomePage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LIVESTOCK"),
      ),
       body: pages[currentpage],
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'home'),
          NavigationDestination(icon: Icon(Icons.person), label: 'profile'),
          NavigationDestination(icon: Icon(Icons.search), label: 'search'),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentpage = index;
          });
        },
        selectedIndex: currentpage,
      ),
    );
  }
}
