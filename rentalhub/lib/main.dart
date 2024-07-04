import 'package:flutter/material.dart';
import 'package:rentalhub/layout/navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp( 
      theme: ThemeData( 
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(70, 0, 119, 1)),
         useMaterial3: true,
      ),
      
      home: Scaffold(
        appBar: AppBar( 
        ),
        body: const Home(),
        )
        
    );
    
  }
}



class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
       
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(70, 0, 119, 0),
                Color.fromRGBO(70, 0, 119, 1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),

          body: const Home(),
          drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [ const
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 215, 17, 250),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                // Handle home navigation
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                // Handle about navigation
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Handle about navigation
              },
            ),
            ListTile(
              leading: const  Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                // Handle about navigation
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () {
                // Handle about navigation
              },
            ),


          ],
        ),
      ),
        ));

  }
}
