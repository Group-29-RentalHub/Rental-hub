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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            const Navigation()
          ],),
    );
  }
}
