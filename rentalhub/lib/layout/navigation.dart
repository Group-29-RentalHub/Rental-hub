import 'package:flutter/material.dart';
import 'package:rentalhub/user/notifications.dart';
import 'package:rentalhub/user/profile.dart';

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
           
              FilledButton( 
               onPressed: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              }, 
                child: const Icon(
                Icons.flash_on_sharp,
                color: Colors.white,
                size: 30.0, 
                
              ) 
              
            ), 
            FilledButton( 
              child: const Icon(
                Icons.home,
                color: Colors.white,
                size: 30.0, 
                
              ),
              onPressed: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              },
            ), 
            FilledButton( 
              child: const Icon(
                Icons.notifications,
                color: Colors.white,
                size: 30.0, 
                
              ),
              onPressed: () {
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              },
            ), 
          ],
          ),
          ) ;
  }
}