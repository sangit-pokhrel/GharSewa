import 'package:flutter/material.dart';
import 'package:ghar_sewa/screens/about_us.dart';
import 'package:ghar_sewa/screens/acheivements_screen.dart';
import 'package:ghar_sewa/screens/popular_service_screen.dart';
import 'package:ghar_sewa/screens/service_provider_detail.dart';
import 'package:ghar_sewa/screens/top_rated.dart';
import 'package:ghar_sewa/screens/trending_service_screen.dart';
import 'package:ghar_sewa/theme/app_theme_font.dart';
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
      theme: getApplicationTheme(),
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const MainNavbarPage(),
        '/popularservices': (context) => const PopularServicesScreen(),
        '/serviceproviders': (context) => const ServiceProviderDetail(),
        '/toprated': (context) => const TopRatedServiceScreen(),
        '/trendingservice': (context) => const TrendingServiceScreen(),
        '/acheivements': (context) => const AcheivementsScreen(),
        '/about': (context) => const AboutUs(),
      },
    );
  }
}
