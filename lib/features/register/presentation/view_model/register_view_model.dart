// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ghar_sewa/features/register/domain/use_case/register_usecase.dart';
// import 'package:ghar_sewa/features/register/domain/entity/register_entity.dart';
// import 'register_event.dart';
// import 'register_state.dart';

// class RegisterViewModel extends Bloc<RegisterEvent, RegisterState> {
//   final RegisterUseCase registerUseCase;

//   RegisterViewModel({required this.registerUseCase})
//     : super(const RegisterState.initial()) {
//     on<AddRegisterEvent>(_onAddRegister);
//   }

//   Future<void> _onAddRegister(
//     AddRegisterEvent event,
//     Emitter<RegisterState> emit,
//   ) async {
//     emit(state.copyWith(isLoading: true, isFailure: false, isSuccess: false));

//     final registerEntity = RegisterEntity(
//       name: event.name,
//       email: event.email,
//       password: event.password,
//       phone: event.phone,
//       country: event.country,
//       province: event.province,
//     );

//     final result = await registerUseCase(registerEntity);

//     result.fold(
//       (failure) {
//         emit(
//           state.copyWith(
//             isLoading: false,
//             isFailure: true,
//             errorMessage: failure.message,
//           ),
//         );
//       },
//       (_) {
//         emit(
//           state.copyWith(isLoading: false, isSuccess: true, isFailure: false),
//         );
//       },
//     );
//   }
// }
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterViewModel extends Bloc<RegisterEvent, RegisterState> {
  final Dio dio;

  RegisterViewModel({required this.dio}) : super(const RegisterState.initial()) {
    on<AddRegisterEvent>(_onAddRegister);
  }

  Future<void> _onAddRegister(
    AddRegisterEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, isFailure: false, isSuccess: false));

    final data = {
      'name': event.name,
      'email': event.email,
      'password': event.password,
      'phone': event.phone,
      'country': event.country,
      'province': event.province,
    };

    try {
      final response = await dio.post(
        'http://192.168.1.66:3000/api/auth/register',
        data: data,
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      final result = response.data;

      if (result['success'] == true) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          isFailure: false,
        ));
      } else {
        emit(state.copyWith(
          isLoading: false,
          isFailure: true,
          isSuccess: false,
          errorMessage: result['message'] ?? 'Registration failed.',
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isFailure: true,
        isSuccess: false,
        errorMessage: 'Something went wrong. Please try again.',
      ));
    }
  }
}
