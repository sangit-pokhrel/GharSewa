import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ghar_sewa/app/constant/api_endpoint.dart';
import 'package:ghar_sewa/core/network/api_service.dart';
import 'package:ghar_sewa/core/network/hive_service.dart';
import 'package:ghar_sewa/features/register/data/model/register_api_model.dart';
import 'package:ghar_sewa/features/register/domain/entity/register_entity.dart';

abstract class IRegisterDataSource {
  Future<void> registerUser(RegisterEntity registerData);
  Future<String> uploadProfilePicture(File file);
}

class RegisterRemoteDataSource implements IRegisterDataSource {
  final ApiService _apiService;
  RegisterRemoteDataSource({required ApiService apiService, required HiveService hiveService})
    : _apiService = apiService;

  @override
  Future<void> registerUser(RegisterEntity registerData) async {
    try {
      final model = RegisterApiModel.fromEntity(registerData);
      final response = await _apiService.dio.post(
        ApiEndpoints.register,
        data: model.toJson(),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to register: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to register: ${e.message}');
    } catch (e) {
      throw Exception('Failed to register: $e');
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        'profilePicture': await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      });

      final response = await _apiService.dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );

      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception('Failed to upload image: ${e.message}');
    } catch (e) {
      throw Exception('Failed to upload image: $e');
    }
  }
}
