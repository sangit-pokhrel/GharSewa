import 'dart:io';

import 'package:ghar_sewa/features/register/domain/entity/register_entity.dart';

abstract interface class IRegisterLocalDataSource {
  Future<void> addRegister(RegisterEntity register);
}

//remote data source
abstract interface class IRegisterRemoteDataSource {
  Future<void> registerUser(RegisterEntity user);
  Future<String> uploadProfilePicture(File file);
}
