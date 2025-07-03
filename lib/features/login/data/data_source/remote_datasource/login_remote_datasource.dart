import 'package:dio/dio.dart';
import 'package:ghar_sewa/app/constant/api_endpoint.dart';
import 'package:ghar_sewa/core/network/api_service.dart';
import 'package:ghar_sewa/features/login/data/model/login_api_model.dart';

abstract class ILoginDataSource {
  Future<String> login(LoginApiModel loginData);
}

class LoginRemoteDataSource implements ILoginDataSource {
  final ApiService _apiService;
  LoginRemoteDataSource({required ApiService apiService})
    : _apiService = apiService;

  @override
  Future<String> login(LoginApiModel loginData) async {
    try {
      final response = await _apiService.dio.post(
        ApiEndpoints.login,
        data: loginData.toJson(),
      );

      if (response.statusCode == 200) {
        final token = response.data['token'];
        return token;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception('Failed to login: ${e.message}');
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }
}
