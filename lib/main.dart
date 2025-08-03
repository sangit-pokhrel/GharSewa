// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ghar_sewa/app.dart'; // Your main app file with routes
import 'package:ghar_sewa/app/service_locator/service_locator.dart';
import 'package:ghar_sewa/app/services/proximity_service.dart';
import 'package:ghar_sewa/core/network/hive_service.dart';
import 'package:shake/shake.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  await HiveService().init();
  runApp(const MyAppWithShake());
}

class MyAppWithShake extends StatefulWidget {
  const MyAppWithShake({super.key});

  @override
  State<MyAppWithShake> createState() => _MyAppWithShakeState();
}

class _MyAppWithShakeState extends State<MyAppWithShake> {
  late ShakeDetector detector;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();

    detector = ShakeDetector.autoStart(
      minimumShakeCount: 2, // Require at least 2 shakes
      shakeSlopTimeMS: 800, // Time gap between shakes
      shakeThresholdGravity: 5.0, // Lower = more sensitive
      onPhoneShake: (_) async {
        final context = navigatorKey.currentContext;
        if (context != null) {
          await _handleLogout(context);
        }
      },
    );

    ProximityService().startListening();
  }

  Future<void> _handleLogout(BuildContext context) async {
    final fpEmail = await secureStorage.read(key: 'fp_email');
    final fpPassword = await secureStorage.read(key: 'fp_password');

    await secureStorage.deleteAll();

    if (fpEmail != null) {
      await secureStorage.write(key: 'fp_email', value: fpEmail);
    }
    if (fpPassword != null) {
      await secureStorage.write(key: 'fp_password', value: fpPassword);
    }

    if (context.mounted) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        '/login',
        (route) => false,
      );
    }
  }

  @override
  void dispose() {
    detector.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const MyApp();
  }
}
