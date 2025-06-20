import 'dart:async';
import 'package:ghar_sewa/app/service_locator/service_locator.dart';
import 'package:ghar_sewa/core/network/hive_service.dart';

class NextPageNavigateUseCase {
  Future<void> waitAndNavigate(Function(String route) navigateCallback) async {
    await Future.delayed(const Duration(seconds: 2));

    final hiveService = serviceLocator<HiveService>();
    final loggedInEmail = await hiveService.getLoggedInUserEmail();

    if (loggedInEmail != null && loggedInEmail.isNotEmpty) {
      navigateCallback('/home');
    } else {
      navigateCallback('/login');
    }
  }
}
