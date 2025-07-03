import 'package:dartz/dartz.dart';
import 'package:ghar_sewa/core/error/failure.dart';
import 'package:ghar_sewa/features/login/data/data_source/remote_datasource/login_remote_datasource.dart';
import 'package:ghar_sewa/features/login/data/model/login_api_model.dart';
import 'package:ghar_sewa/features/login/domain/entity/login_entity.dart';
import 'package:ghar_sewa/features/login/domain/repository/login_repository.dart';

class LoginRemoteRepository implements ILoginRepository {
  final LoginRemoteDataSource _loginRemoteDataSource;

  LoginRemoteRepository({required LoginRemoteDataSource loginRemoteDataSource})
    : _loginRemoteDataSource = loginRemoteDataSource;

  @override
  Future<Either<Failure, String>> login(LoginApiModel loginData) async {
    try {
      final token = await _loginRemoteDataSource.login(loginData);
      return Right(token);
    } catch (e) {
      return Left(RemoteDatabaseFailure(message: e.toString(), statusCode: 400));
    }
  }

  @override
  Future<Either<Failure, bool>> checkLogin(LoginEntity login) {
    // TODO: implement checkLogin
    throw UnimplementedError();
  }
}
