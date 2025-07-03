import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:ghar_sewa/core/error/failure.dart';
import 'package:ghar_sewa/features/register/data/data_source/remote_datasource/register_remote_datasource.dart';
import 'package:ghar_sewa/features/register/domain/entity/register_entity.dart';
import 'package:ghar_sewa/features/register/domain/repository/register_repository.dart';

class RegisterRemoteRepository implements IRegisterRepository {
  final RegisterRemoteDataSource _registerRemoteDataSource;

  RegisterRemoteRepository({
    required RegisterRemoteDataSource registerRemoteDataSource,
  }) : _registerRemoteDataSource = registerRemoteDataSource;

  @override
  Future<Either<Failure, void>> registerUser(RegisterEntity user) async {
    try {
      await _registerRemoteDataSource.registerUser(user);
      return const Right(null);
    } catch (e) {
      return Left(
        RemoteDatabaseFailure(message: e.toString(), statusCode: 400),
      );
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    try {
      final url = await _registerRemoteDataSource.uploadProfilePicture(file);
      return Right(url);
    } catch (e) {
      return Left(
        RemoteDatabaseFailure(message: e.toString(), statusCode: 400),
      );
    }
  }
  
  @override
  Future<Either<Failure, void>> addRegister(RegisterEntity register) {
    // TODO: implement addRegister
    throw UnimplementedError();
  }
}
