import 'package:flutter/material.dart';

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(  
            color:const Color.fromRGBO(70, 0, 119, 1),
            height: 50, 
            child: Row( 
            
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround, 
             children: [
            Container(
              height: 100,
              child: const Icon(
                Icons.flash_on_sharp,
                color: Colors.white,
                size: 30.0, 
              ),
            ),
            
            Container(
              height: 100,
              child: Container(  
                 decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  color: Color.fromARGB(255, 82, 7, 136),
                ),
                // color: const Color.fromARGB(255, 82, 7, 136),
                child:  const Icon(
                Icons.home,
                color: Colors.white,
                size: 40.0, 
                )
              ),
            ),
           
            Container(
              height: 100,
              child: const Icon(
                Icons.notifications,
                color: Colors.white,
                size: 30.0, 
              ),
            ), 
          ],
          ),
          ) ;
  }
}