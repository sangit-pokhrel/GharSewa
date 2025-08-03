// lib/app.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghar_sewa/features/home/presentation/screens/profile/about_screen.dart';
import 'package:ghar_sewa/features/home/presentation/screens/profile/account_info.dart';
import 'package:ghar_sewa/features/home/presentation/screens/profile/complaint.dart';
import 'package:ghar_sewa/features/home/presentation/screens/profile/fav.dart';
import 'package:ghar_sewa/features/home/presentation/screens/profile/privacy.dart';
import 'package:ghar_sewa/features/home/presentation/screens/profile/terms.dart';
import 'package:ghar_sewa/features/login/presentation/view/login_view.dart';
import 'package:ghar_sewa/features/login/presentation/view_model/login_view_model.dart';
import 'package:ghar_sewa/features/register/presentation/view_model/register_view_model.dart';
import 'package:ghar_sewa/features/home/presentation/screens/acheivements_screen.dart';
import 'package:ghar_sewa/features/home/presentation/screens/popular_service_screen.dart';
import 'package:ghar_sewa/features/home/presentation/screens/service_provider_detail.dart';
import 'package:ghar_sewa/features/home/presentation/screens/top_rated.dart';
import 'package:ghar_sewa/features/home/presentation/screens/trending_service_screen.dart';
import 'package:ghar_sewa/main.dart';
import 'package:ghar_sewa/theme/app_theme_font.dart';
import 'package:ghar_sewa/features/home/presentation/view/main_navbar_page.dart';
import 'package:ghar_sewa/features/register/presentation/view/register_view.dart';
import 'package:ghar_sewa/app/service_locator/service_locator.dart';
import 'package:ghar_sewa/view/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Ghar Sewa',
      theme: getApplicationTheme(),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const SplashScreen());
          case '/home':
            return MaterialPageRoute(builder: (_) => const MainNavbarPage());
          case '/popularservices':
            return MaterialPageRoute(
              builder: (_) => const PopularServicesScreen(),
            );
          case '/toprated':
            return MaterialPageRoute(
              builder: (_) => const TopRatedServiceScreen(),
            );
          case '/trendingservice':
            return MaterialPageRoute(
              builder: (_) => const TrendingServiceScreen(),
            );
          case '/acheivements':
            return MaterialPageRoute(
              builder: (_) => const AcheivementsScreen(),
            );
          case '/about':
            return MaterialPageRoute(builder: (_) => const AboutUsScreen());
          // case '/register':
          //   return MaterialPageRoute(
          //     builder: (_) => BlocProvider.value(
          //       value: serviceLocator<RegisterViewModel>(),
          //       child: const RegisterView(),
          //     ),
          //   );
          case '/register':
            return MaterialPageRoute(
              builder:
                  (_) => BlocProvider.value(
                    value: serviceLocator<RegisterViewModel>(),
                    child: const RegisterView(),
                  ),
            );

          case '/login':
            return MaterialPageRoute(
              builder:
                  (_) => BlocProvider(
                    create: (context) => serviceLocator<LoginViewModel>(),
                    child: LoginView(),
                  ),
            );
          case '/serviceproviders':
            final args = settings.arguments;
            if (args is Map<String, dynamic>) {
              return MaterialPageRoute(
                builder:
                    (_) => ProviderDetailScreen(provider: args, serviceId: ' '),
              );
            } else {
              return _errorRoute("Invalid provider arguments");
            }
          case '/favorites':
            return MaterialPageRoute(
              builder: (_) => const MyFavouritesScreen(),
            );
          case '/account-info':
            return MaterialPageRoute(builder: (_) => const AccountInfoScreen());
          case '/privacy':
            return MaterialPageRoute(
              builder: (_) => const PrivacyPolicyScreen(),
            );
          case '/terms':
            return MaterialPageRoute(
              builder: (_) => const TermsConditionsScreen(),
            );

          case '/complaints':
            return MaterialPageRoute(builder: (_) => const ComplaintsScreen());
          default:
            return _errorRoute("Route not found");
        }
      },
    );
  }

  Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder:
          (_) => Scaffold(
            appBar: AppBar(title: const Text("Error")),
            body: Center(child: Text("❌ $message")),
          ),
    );
  }
}
