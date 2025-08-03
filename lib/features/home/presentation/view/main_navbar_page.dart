import 'package:flutter/material.dart';
import 'package:ghar_sewa/core/common/bottom_navbar/bottom_navbar.dart';
import 'package:ghar_sewa/features/home/presentation/navbar_screens/city_screen.dart';
import 'package:ghar_sewa/features/home/presentation/navbar_screens/search_screen.dart';
import 'package:ghar_sewa/features/home/presentation/navbar_screens/order_screen.dart';
import 'package:ghar_sewa/features/home/presentation/navbar_screens/profile_screen.dart';
import 'package:ghar_sewa/features/home/presentation/view/home_screen.dart';

class MainNavbarPage extends StatefulWidget {
  const MainNavbarPage({super.key});

  @override
  State<MainNavbarPage> createState() => _MainNavbarPageState();
}

class _MainNavbarPageState extends State<MainNavbarPage> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    CityScreen(),
    SearchScreen(),
    OrderScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
