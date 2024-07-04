import 'package:flutter/material.dart';

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(  
            color:const Color.fromRGBO(70, 0, 119, 1),
            height: 100, 
            child: Row( 
            
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround, 
             children: [
            Container(
              height: 100,
              child: const Icon(
                Icons.list_alt_outlined,
                color: Colors.white,
                size: 30.0, 
              ),
            ),
            Container(
              height: 100,
              child: const Icon(
                Icons.account_circle,
                color: Colors.white,
                size: 30.0, 
              ),
            ),
            Container(
              height: 100,
              child: const Icon(
                Icons.home,
                color: Colors.white,
                size: 30.0, 
              ),
            ),
            Container(
              height: 100, 
              child: Container(
                child: const Icon(
                Icons.menu,
                color: Colors.white, 
                size: 30.0, 
              ),
              )
            ),
            Container(
              height: 100,
              child: const Icon(
                Icons.payment,
                color: Colors.white,
                size: 30.0, 
              ),
            ), 
          ],
          ),
          ) ;
  }
}