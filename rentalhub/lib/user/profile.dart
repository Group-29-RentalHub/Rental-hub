import 'package:flutter/material.dart';
import 'package:rentalhub/layout/navigation.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Container(), const Navigation()],
          ),
        ));
  }
}
