import 'package:flutter/material.dart';
import 'package:halls/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Application_form.dart';
import "login.dart";
import 'profile.dart';
import 'NavBar.dart';

class Hall extends StatefulWidget {
  const Hall({super.key});

  @override
  State<Hall> createState() => _HallState();
}

class _HallState extends State<Hall> {
  int currentpage = 0;
  List<Widget> pages = const [
    ProfilePage(),
    LoginScreen(),
  ];
  final AuthMethod _authMethod = AuthMethod();
  late User? _user;

  final PageController _pageController = PageController(initialPage: 0);
  final List<String> _images = [
    'assets/images/library.jpg',
    'assets/images/maingate.jpg',
    'assets/images/ctf.jpg',
  ];
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _user = _authMethod.getCurrentUser();
    _startSlideshow();
  }

  void _startSlideshow() {
    Future.delayed(const Duration(seconds: 3), () {
      if (_pageController.hasClients) {
        setState(() {
          _currentPage = (_currentPage + 1) % _images.length;
        });
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
        _startSlideshow();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("MAKERERE HALL APP"),
          backgroundColor: Colors.green,
           actions: [
            DrawerButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return const NavBar();
                }));
              },
            )

          ],
        ),
        body: Center(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              SizedBox(
                  height: 300,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _images.length,
                    itemBuilder: (context, index) {
                      return Image.asset(_images[index]);
                    },
                  )),
              Container(
                color: Colors.lightGreenAccent[700],
                child: SizedBox(
                  height: 50,
                  child: Center(
                      child: _user != null
                          ? Text(
                              'Hi:  ${_user?.displayName ?? 'No name provided'}',
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            )
                          : const Text(" No user name specified")),
                ),
              ),
              Container(
                color: Colors.lightGreenAccent[700],
                child: const SizedBox(
                    height: 90,
                    child: Center(
                        child: Text(
                      "CHOOSE YOUR HALL",
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.black,
                      ),
                    ))),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const Student();
                  }));
                },
                child: const Text(
                  "Nkrumah",
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: SizedBox(
                    height: 150.0,
                    width: 50.0,
                    child: Image.asset(
                      "assets/images/nkruma.jpeg",
                      fit: BoxFit.fill,
                    )),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const Student();
                  }));
                },
                child: const Text(
                  "Livingstone",
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: SizedBox(
                  height: 150.0,
                  width: 50.0,
                  child: Image.asset(
                    "assets/images/livingston.jpg",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const Student();
                  }));
                },
                child: const Text(
                  "Mitchell",
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: SizedBox(
                  height: 150.0,
                  width: 50.0,
                  child: Image.asset(
                    "assets/images/mitchel.jpg",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const Student();
                  }));
                },
                child: const Text(
                  "Nsibirwa",
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: SizedBox(
                  height: 150.0,
                  width: 50.0,
                  child: Image.asset(
                    "assets/images/nsibirw.jpg",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const Student();
                  }));
                },
                child: const Text(
                  "University Hall",
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: SizedBox(
                  height: 150.0,
                  width: 50.0,
                  child: Image.asset(
                    "assets/images/university.jpg",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const Student();
                  }));
                },
                child: const Text(
                  "Lumumba",
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: SizedBox(
                  height: 150.0,
                  width: 50.0,
                  child: Image.asset(
                    "assets/images/lumumb.jpg",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const Student();
                  }));
                },
                child: const Text(
                  "Africa",
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: SizedBox(
                  height: 150.0,
                  width: 50.0,
                  child: Image.asset(
                    "assets/images/afric.jpg",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const Student();
                  }));
                },
                child: const Text(
                  "Complex",
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: SizedBox(
                  height: 150.0,
                  width: 50.0,
                  child: Image.asset(
                    "assets/images/comp.jpg",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const Student();
                  }));
                },
                child: const Text(
                  "Mary Stuart",
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: SizedBox(
                  height: 150.0,
                  width: 50.0,
                  child: Image.asset(
                    "assets/images/mary.jpg",
                    fit: BoxFit.fill,
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: NavigationBarTheme(
          data: const NavigationBarThemeData(
            indicatorColor: Colors.green,
          ),
          child: NavigationBar(
            destinations: const [
              NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
              NavigationDestination(
                  icon: Icon(Icons.perm_identity), label: 'Profile'),
              NavigationDestination(icon: Icon(Icons.logout), label: 'Logout'),
            ],
            onDestinationSelected: (int index) async {
              if (index == 2) {
                // Perform logout
                await AuthMethod().signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              } else if (index == 1) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              }
              setState(() {
                currentpage = index;
              });
            },
            selectedIndex: currentpage,
          ),
        ));
  }
}
