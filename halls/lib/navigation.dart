import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'hall.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      home: Navigation(),
    );
  }
}

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
  
    return Scaffold(
      body: Obx(
        () => controller.screens[controller.selectedIndex.value],
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: "Home"),
            NavigationDestination(icon: Icon(Icons.perm_identity), label: "Profile"),
            NavigationDestination(icon: Icon(Icons.logout), label: "Logout"),
          ],
        ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final List<Widget> screens = [
    const  Hall(),
    Container(color: Colors.purple),
    Container(color: Colors.yellow),
  ];
}
