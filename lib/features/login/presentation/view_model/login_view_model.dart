import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghar_sewa/features/login/domain/use_case/login_usecase.dart';
import 'package:ghar_sewa/features/login/data/model/login_api_model.dart';
import 'package:ghar_sewa/features/login/presentation/view_model/login_event.dart';
import 'package:ghar_sewa/features/login/presentation/view_model/login_state.dart';

class LoginViewModel extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginViewModel({required this.loginUseCase, required Object checkLoginUsecase}) : super(LoginState.initial()) {
    on<CheckLoginEvent>(_onLogin);
  }

  Future<void> _onLogin(CheckLoginEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await loginUseCase(
      LoginApiModel(email: event.email, password: event.password),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          isLoading: false,
          isFailure: true,
          errorMessage: failure.message,
        ),
      ),
      (token) => emit(
        state.copyWith(
          isLoading: false,
          isSuccess: true,
          loginMatched: true,
          // token: token, // Optional: if you want to store token
        ),
      ),
    );
  }
}
