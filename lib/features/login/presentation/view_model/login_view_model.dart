import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginViewModel extends Bloc<LoginEvent, LoginState> {
  final Dio dio;
  final FlutterSecureStorage secureStorage;

  LoginViewModel({
    required this.dio,
    required this.secureStorage,
  }) : super(const LoginState.initial()) {
    on<CheckLoginEvent>(_onLogin);
  }

  Future<void> _onLogin(CheckLoginEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true, isFailure: false, isSuccess: false));
    print('🔐 Sending login credentials: ${event.email}, ${event.password}');

    try {
      final response = await dio.post(
        'http://192.168.1.66:3000/api/auth/login',
        data: {
          'email': event.email,
          'password': event.password,
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      final result = response.data;
      print('📥 Response from server: $result');

      if (result['success'] == true &&
          result['token'] != null &&
          result['user'] != null) {
        final token = result['token'];
        final user = result['user'];

        // ✅ Save all fields to secure storage
        await secureStorage.write(key: 'token', value: token);
        await secureStorage.write(key: 'email', value: user['email']);
        await secureStorage.write(key: 'userId', value: user['id']);
        await secureStorage.write(key: 'role', value: user['role']);

        // 🔍 Log secure storage contents
        final allStored = await secureStorage.readAll();
        print("🧾 Secure Storage Contents After Login:");
        allStored.forEach((key, value) => print("  $key: $value"));

        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          isFailure: false,
          loginMatched: true,
        ));
      } else {
        print('❌ Login failed: success=false or missing token/user');
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          isFailure: false,
          loginMatched: false,
        ));
      }
    } catch (e) {
      print('❗ Login error: $e');
      emit(state.copyWith(
        isLoading: false,
        isFailure: true,
        isSuccess: false,
        errorMessage: 'Login failed. Please check your credentials.',
      ));
    }
  }
}
