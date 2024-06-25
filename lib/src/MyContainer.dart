import 'package:flutter/material.dart';
import 'dart:math';
class Mycontainer extends StatelessWidget {
  const Mycontainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / 3.5, 
      child: ClipPath(
      child: Container(
        height: MediaQuery.of(context).size.height *.5,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xfffbb448),Color(0xffe46b10)]
            )
          ),
      ),
    ),
    );
  }
}