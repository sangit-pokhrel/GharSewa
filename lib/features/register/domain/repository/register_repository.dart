import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ghar_sewa/core/error/failure.dart';
import 'package:ghar_sewa/features/register/domain/entity/register_entity.dart';

abstract interface class IRegisterRepository {
  Future<Either<Failure, void>> addRegister(RegisterEntity register);
  Future<Either<Failure, void>> registerUser(RegisterEntity user);
  Future<Either<Failure, String>> uploadProfilePicture(File file);
}
