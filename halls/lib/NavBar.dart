import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:halls/hall.dart';


class NavBar extends StatefulWidget {
  const NavBar({super.key});
 
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero, 
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Kasakya Denis Nicholas'), 
            accountEmail: Text('kdnicholas9@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'https://images.app.goo.gl/6vCExB2uFqkeFtc47',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image: AssetImage(
                 "                     ",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ListTile(
  leading: Icon(Icons.person),
  title: Text('Profile'),
  onTap: () => null,
),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () => null,
            trailing: Container(
              color: Colors.red,
              width: 20,
              height: 20,
              child: Center(
                child: Text(
                  '5',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share'),
            onTap: () => null,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Exit'),
            onTap: () {
              Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const Hall();
                }));
            },
          ),
        ],
      ),
    );
  }
}
