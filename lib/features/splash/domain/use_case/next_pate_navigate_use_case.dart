import 'dart:async';

class NextPageNavigateUseCase {
  Future<void> waitAndNavigate(Function(String route) navigateCallback) async {
    await Future.delayed(const Duration(seconds: 2));
    navigateCallback('/login'); // this could be dynamic in the future
  }
}
