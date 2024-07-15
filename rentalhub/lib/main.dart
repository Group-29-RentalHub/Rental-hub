import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rentalhub/layout/landingpage.dart'; // Ensure this is your booking/registration page
import 'package:rentalhub/user/notifications.dart';
import 'package:rentalhub/user/profile.dart';
import 'package:rentalhub/layout/home.dart';
import 'package:rentalhub/user/profile_form.dart';
import 'package:rentalhub/about/about.dart';
import 'package:rentalhub/settings/settings.dart';
import 'package:rentalhub/user/login.dart';
import 'package:rentalhub/user/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyA0tbKIpSXXGhUpj5qTafSFh4qOdhTvfBM",
    appId: "1:52847626874:android:b190a976c9db8ff51849c3",
    messagingSenderId: "52847626874",
    projectId: "rentalhub-96a37",
  ));
  runApp(RentalHub());
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
      initialRoute: '/', // Ensure this is set to '/'
      routes: {
        '/': (context) =>
            LandingPage(), // This should be your booking/registration page
        '/notifications': (context) => NotificationHistoryPage(),
        '/profile': (context) => Profile(),
        '/profileForm': (context) => ProfileFormPage(
              onSubmit: () {
                navigateToHomePage(context); // Pass callback to ProfileFormPage
              },
            ),
        '/about': (context) => AboutPage(),
        '/settings': (context) => SettingsPage(),
        '/home': (context) => MainPage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
      },
    );
  }

  void navigateToHomePage(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/home');
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Display a loading indicator while waiting for authentication state
        } else if (snapshot.hasData) {
          return MainPage(); // If the user is authenticated, show the main page
        } else {
          return LoginPage(); // If the user is not authenticated, show the login page
        }
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
    LandingPage(), // Ensure this page is also part of the bottom navigation
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

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
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
                  Navigator.pop(context); // Close the drawer
                  _logout(); // Call the logout function
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
