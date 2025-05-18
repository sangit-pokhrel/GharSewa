import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onTap;

  const BottomNavBar({super.key, required this.currentIndex, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: const Color(0xFF0052CC),
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.location_city), label: "City"),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: "Order"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
      onTap: onTap,
    );
  }
}
