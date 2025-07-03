// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterApiModel _$RegisterApiModelFromJson(Map<String, dynamic> json) =>
    RegisterApiModel(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      phone: json['phone'] as String,
      country: json['country'] as String,
      province: json['province'] as String,
    );

Map<String, dynamic> _$RegisterApiModelToJson(RegisterApiModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'phone': instance.phone,
      'country': instance.country,
      'province': instance.province,
    };
