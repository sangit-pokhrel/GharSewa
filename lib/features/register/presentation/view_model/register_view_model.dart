import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghar_sewa/features/register/presentation/view_model/register_event.dart';
import 'package:ghar_sewa/features/register/presentation/view_model/register_state.dart';



class RegisterViewModel extends Bloc<RegisterEvent, RegisterState> {
    final AddRegisterUsecase _addRegisterUsecase;


    RegisterViewModel({
        required this.addRegisterUsecase,
    }) : super(RegisterState.initial()){
        on<AddRegisterEvent>(_onAddRegister);
    };

    Future<void> _onAddRegister(AddRegisterEvent event, Emitter<RegisterState> emit) async {
        emit(state.copyWith(isLoading: true));
        final result = await _addRegisterUsecase.call(event.params);
        result.fold((failure) {
            emit(state.copyWith(isLoading: false, isFailure: true, errorMessage: failure.message));
        }, (success) {
            emit(state.copyWith(isLoading: false, isSuccess: true));
        });
    }
}