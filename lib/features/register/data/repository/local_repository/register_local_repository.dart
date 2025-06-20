import 'package:dartz/dartz.dart';
import 'package:ghar_sewa/core/error/failure.dart';
import 'package:ghar_sewa/features/register/data/data_source/local_datasource/register_local_datasource.dart';
import 'package:ghar_sewa/features/register/data/data_source/register_datasource.dart';
import 'package:ghar_sewa/features/register/domain/entity/register_entity.dart';
import 'package:ghar_sewa/features/register/domain/repository/register_repository.dart';

class RegisterLocalRepository implements IRegisterRepository {
  final RegisterLocalDataSource _registerLocalDataSource;

  RegisterLocalRepository({
    required RegisterLocalDataSource registerLocalDataSource,
  }) : _registerLocalDataSource = registerLocalDataSource;

  @override
  Future<Either<Failure, void>> addRegister(RegisterEntity register) async {
    try {
      await _registerLocalDataSource.addRegister(register);
      return Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }
}
