import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghar_sewa/features/register/domain/use_case/register_usecase.dart';
import 'package:ghar_sewa/features/register/domain/entity/register_entity.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterViewModel extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterViewModel({required this.registerUseCase})
    : super(const RegisterState.initial()) {
    on<AddRegisterEvent>(_onAddRegister);
  }

  Future<void> _onAddRegister(
    AddRegisterEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, isFailure: false, isSuccess: false));

    final registerEntity = RegisterEntity(
      name: event.name,
      email: event.email,
      password: event.password,
      phone: event.phone,
      country: event.country,
      province: event.province,
    );

    final result = await registerUseCase(registerEntity);

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isLoading: false,
            isFailure: true,
            errorMessage: failure.message,
          ),
        );
      },
      (_) {
        emit(
          state.copyWith(isLoading: false, isSuccess: true, isFailure: false),
        );
      },
    );
  }
}
