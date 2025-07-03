import 'package:dartz/dartz.dart';
import 'package:ghar_sewa/core/error/failure.dart';
import 'package:ghar_sewa/features/login/data/model/login_api_model.dart';
import 'package:ghar_sewa/features/login/domain/repository/login_repository.dart';

class LoginUseCase {
  final ILoginRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, String>> call(LoginApiModel loginData) {
    return repository.login(loginData);
  }
}
