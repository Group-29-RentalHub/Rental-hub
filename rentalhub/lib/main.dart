import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rentalhub/user/notifications.dart'; // Import your NotificationHistoryPage
import 'package:rentalhub/user/profile.dart'; // Import your Profile page
import 'package:rentalhub/layout/home.dart'; // Import your Home page
import 'package:rentalhub/about/about.dart'; // Import your About page
import 'package:rentalhub/settings/settings.dart'; // Import your Settings page
import 'package:rentalhub/user/login.dart';
import 'package:rentalhub/user/ForgotPassword.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCv3L7b04n5_86waJE0sDSN-53TQOHHWTk",
      appId: "1:52847626874:android:b190a976c9db8ff51849c3",
      messagingSenderId: "52847626874",
      projectId: "rentalhub-fd89e",
      // Other optional parameters such as storageBucket
    ),
  );
  runApp(RentalHub()); // Replace with MyApp() or your custom class
}

class RentalHub extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rental Hub',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(),
        '/notifications': (context) => NotificationHistoryPage(),
        '/profile': (context) => Profile(),
        '/about': (context) => AboutPage(),
        '/settings': (context) => SettingsPage(),
        '/login': (context) => LoginPage(),
        '/forgot_password': (context) =>
            ForgotPasswordPage(), // Ensure the route name matches the one used in the LoginPage
      },
    );
  }
}

class MainPage extends StatefulWidget {
  
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
    SettingsPage(),
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
        backgroundColor: Color.fromRGBO(70, 0, 119, 1),
        title: !_isSearching
            ? Text(
                _title,
                style: TextStyle(color: Colors.white),
              )
            : TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.white),
                onSubmitted: (query) {
                  // Perform search operation
                  print('Search query: $query');
                  setState(() {
                    _isSearching = false;
                  });
                },
              ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                _isSearching ? Icons.close : Icons.search_outlined,
                color: Colors.white,
              ),
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
                  Navigator.pop(context);
                  setState(() {
                    _currentIndex = 2;
                    _title = 'Profile';
                  });
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/settings');
                },
              ),
              ListTile(
                leading: const Icon(Icons.info),
                title: const Text('About'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/about');
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Log Out'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/login');
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
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
