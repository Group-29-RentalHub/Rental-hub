import 'package:flutter/material.dart';
import 'package:rentalhub/layout/navigation.dart';

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
        children: [Container(), const Navigation()],
      ),
    );
  }
}
