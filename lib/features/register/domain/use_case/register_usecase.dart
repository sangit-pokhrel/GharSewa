import 'package:dartz/dartz.dart';
import 'package:ghar_sewa/core/error/failure.dart';
import 'package:ghar_sewa/features/register/domain/entity/register_entity.dart';
import 'package:ghar_sewa/features/register/domain/repository/register_repository.dart';

class RegisterUseCase {
  final IRegisterRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, void>> call(RegisterEntity registerEntity) {
    return repository.registerUser(registerEntity);
  }
}
