import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:ghar_sewa/core/network/api_service.dart';
import 'package:ghar_sewa/core/network/hive_service.dart';
import 'package:ghar_sewa/features/login/data/data_source/remote_datasource/login_remote_datasource.dart';
import 'package:ghar_sewa/features/login/data/repository/remote_repository/login_remote_repository.dart';
import 'package:ghar_sewa/features/login/domain/repository/login_repository.dart';
import 'package:ghar_sewa/features/login/domain/use_case/login_usecase.dart';

// Register
import 'package:ghar_sewa/features/register/data/data_source/remote_datasource/register_remote_datasource.dart';
import 'package:ghar_sewa/features/register/data/repository/remote_repository/register_remote_repository.dart';
import 'package:ghar_sewa/features/register/domain/repository/register_repository.dart';
import 'package:ghar_sewa/features/register/domain/use_case/register_usecase.dart';
import 'package:ghar_sewa/features/register/presentation/view_model/register_view_model.dart';

// Login
import 'package:ghar_sewa/features/login/data/data_source/local_datasource/login_local_datasource.dart';
import 'package:ghar_sewa/features/login/data/repository/local_repository/login_local_repository.dart';
import 'package:ghar_sewa/features/login/domain/use_case/check_login_usecase.dart';
import 'package:ghar_sewa/features/login/presentation/view_model/login_view_model.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initApiService();
  await _initRegisterModule();
  await _initLoginModule();
}

Future<void> _initHiveService() async {
  serviceLocator.registerLazySingleton(() => HiveService());
}

Future<void> _initApiService() async {
  serviceLocator.registerLazySingleton(() => ApiService(Dio()));
}

Future<void> _initRegisterModule() async {
  // Register the remote data source
  serviceLocator.registerFactory(
    () => RegisterRemoteDataSource(
      apiService: serviceLocator<ApiService>(),
      hiveService: serviceLocator<HiveService>(),
    ),
  );

  // Register the repository
  serviceLocator.registerFactory<IRegisterRepository>(
    () => RegisterRemoteRepository(
      registerRemoteDataSource: serviceLocator<RegisterRemoteDataSource>(),
    ),
  );

  // ✅ Register the usecase
  serviceLocator.registerFactory<RegisterUseCase>(
    () => RegisterUseCase(serviceLocator<IRegisterRepository>()),
  );

  // ✅ Register the ViewModel
  serviceLocator.registerLazySingleton(
    () => RegisterViewModel(registerUseCase: serviceLocator<RegisterUseCase>()),
  );
}

Future<void> _initLoginModule() async {
  // Local Login (for checkLogin)
  serviceLocator.registerFactory(
    () => LoginLocalDataSource(hiveService: serviceLocator<HiveService>()),
  );
  serviceLocator.registerFactory(
    () => LoginLocalRepository(
      loginLocalDataSource: serviceLocator<LoginLocalDataSource>(),
    ),
  );
  serviceLocator.registerFactory(
    () => CheckLoginUsecase(
      loginRepository: serviceLocator<LoginLocalRepository>(),
    ),
  );

  // ✅ Remote Login (for real API login)
  serviceLocator.registerFactory(
    () => LoginRemoteDataSource(apiService: serviceLocator<ApiService>()),
  );
  serviceLocator.registerFactory<ILoginRepository>(
    () => LoginRemoteRepository(
      loginRemoteDataSource: serviceLocator<LoginRemoteDataSource>(),
    ),
  );
  serviceLocator.registerFactory<LoginUseCase>(
    () => LoginUseCase(serviceLocator<ILoginRepository>()),
  );

  // ✅ ViewModel
  serviceLocator.registerLazySingleton(
    () => LoginViewModel(
      checkLoginUsecase: serviceLocator<CheckLoginUsecase>(),
      loginUseCase: serviceLocator<LoginUseCase>(),
    ),
  );
}
