import 'package:flutter/material.dart';
import 'package:ghar_sewa/view/login_screen.dart';
import 'package:ghar_sewa/view/main_navbar_page.dart';
import 'package:ghar_sewa/view/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ghar Sewa',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const MainNavbarPage(),
      },
    );
  }
}
