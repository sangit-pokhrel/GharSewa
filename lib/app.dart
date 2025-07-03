import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghar_sewa/features/login/presentation/view/login_view.dart';
import 'package:ghar_sewa/features/login/presentation/view_model/login_view_model.dart';
import 'package:ghar_sewa/features/register/presentation/view_model/register_view_model.dart';
import 'package:ghar_sewa/features/splash/presentation/view/splash_screen.dart';
import 'package:ghar_sewa/screens/about_us.dart';
import 'package:ghar_sewa/screens/acheivements_screen.dart';
import 'package:ghar_sewa/screens/popular_service_screen.dart';
import 'package:ghar_sewa/screens/service_provider_detail.dart';
import 'package:ghar_sewa/screens/top_rated.dart';
import 'package:ghar_sewa/screens/trending_service_screen.dart';
import 'package:ghar_sewa/theme/app_theme_font.dart';
import 'package:ghar_sewa/view/main_navbar_page.dart';
import 'package:ghar_sewa/features/register/presentation/view/register_view.dart';
import 'package:ghar_sewa/app/service_locator/service_locator.dart'; // 👈 to access serviceLocator

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
        '/': (context) => const SplashScreenView(),
        '/home': (context) => const MainNavbarPage(),
        '/popularservices': (context) => const PopularServicesScreen(),
        '/serviceproviders': (context) => const ServiceProviderDetail(),
        '/toprated': (context) => const TopRatedServiceScreen(),
        '/trendingservice': (context) => const TrendingServiceScreen(),
        '/acheivements': (context) => const AcheivementsScreen(),
        '/about': (context) => const AboutUs(),

        '/register':
            (context) => BlocProvider.value(
              value: serviceLocator<RegisterViewModel>(),
              child: const RegisterView(),
            ),
        '/login':
            (context) => BlocProvider.value(
              value: serviceLocator<LoginViewModel>(),
              child: const LoginView(),
            ),
      },
    );
  }
}
