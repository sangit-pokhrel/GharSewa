import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghar_sewa/features/register/domain/use_case/add_register_usecase.dart';
import 'package:ghar_sewa/features/register/presentation/view_model/register_event.dart';
import 'package:ghar_sewa/features/register/presentation/view_model/register_state.dart';

class RegisterViewModel extends Bloc<RegisterEvent, RegisterState> {
  final AddRegisterUsecase addRegisterUsecase;

  //   RegisterViewModel(this._addRegisterUsecase, {
  //     required this.addRegisterUsecase,
  // }) : super(RegisterState.initial()){
  //     on<AddRegisterEvent>(_onAddRegister);
  // };

  RegisterViewModel({required this.addRegisterUsecase})
    : super(RegisterState.initial()) {
    on<AddRegisterEvent>(_onAddRegister);
  }

  Future<void> _onAddRegister(
    AddRegisterEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await addRegisterUsecase(
      AddRegisterParams(
        name: event.name,
        email: event.email,
        password: event.password,
        phone: event.phone,
        country: event.country,
        province: event.province,
      ),
    );
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
      (success) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
      },
    );
  }
}
