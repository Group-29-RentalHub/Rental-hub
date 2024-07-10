import 'package:flutter/material.dart';
import 'package:rentalhub/user/notifications.dart'; // Import your NotificationHistoryPage
import 'package:rentalhub/user/profile.dart'; // Import your Profile page
import 'package:rentalhub/layout/home.dart'; // Import your Home page
import 'package:rentalhub/about/about.dart'; // Import your About page
import 'package:rentalhub/settings/settings.dart'; // Import your Settings page
import 'package:rentalhub/user/login.dart';
import 'package:rentalhub/user/signup.dart';

void main() {
  runApp(const RentalHub());
}

class RentalHub extends StatelessWidget {
  const RentalHub({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,


class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: Center(
        child: Text('Signup Page'),
      ),
    );
  }
},
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainPage(),
        '/notifications': (context) => NotificationHistoryPage(),
        '/profile': (context) => Profile(),
        '/about': (context) => AboutPage(), // Add the AboutPage route
        '/settings': (context) => SettingsPage(), // Add the SettingsPage route
        '/login': (context) => LoginPage(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  int _currentIndex = 0;
  String _title = 'Home'; // Default title

  final List<Widget> _pages = [
    HomePage(),
    NotificationHistoryPage(),
    Profile(),
    SettingsPage(), // Add the SettingsPage to the list
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      _updateTitle(index);
    });
  }

  void _updateTitle(int index) {
    switch (index) {
      case 0:
        setState(() {
          _title = 'Home';
        });
        break;
      case 1:
        setState(() {
          _title = 'Notifications';
        });
        break;
      case 2:
        setState(() {
          _title = 'Profile';
        });
        break;
      case 3:
        setState(() {
          _title = 'Settings';
        });
        break;
      default:
        setState(() {
          _title = 'Home';
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(70, 0, 119, 1),
        title: !_isSearching
        ?Text(
          _title,
          style: const TextStyle(color: Colors.white),
        ):
        TextField(
          controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.black),
                onSubmitted: (query) {  
                  // Perform search operation
                  ('Search query: $query');
                  setState(() {
                    _isSearching = false;
                  });
                },
        ),
        
        // 
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(_isSearching ? Icons.close : Icons.search_outlined, color: Colors.white,),
              onPressed: () {
                setState(() {
                  _isSearching = !_isSearching;
                  if (!_isSearching) {
                    _searchController.clear();
                  }
                });
              },
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(70, 0, 119, 1),
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
                  Navigator.pop(context);
                  setState(() {
                    _currentIndex = 0;
                    _title = 'Home';
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer before navigating
                  setState(() {
                    _currentIndex = 2;
                    _title =
                        'Profile'; // Update title when navigating from drawer
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer before navigating
                  Navigator.pushNamed(
                      context, '/settings'); // Navigate to SettingsPage
                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('About'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer before navigating
                  Navigator.pushNamed(
                      context, '/about'); // Navigate to AboutPage
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Log Out'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
