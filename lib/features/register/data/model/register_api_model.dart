import 'package:ghar_sewa/features/register/domain/entity/register_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';

part 'register_api_model.g.dart';

@JsonSerializable()
class RegisterApiModel extends Equatable {
  final String name;
  final String email;
  final String password;
  final String phone;
  final String country;
  final String province;

  const RegisterApiModel({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.country,
    required this.province,
  });

  factory RegisterApiModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterApiModelToJson(this);

  factory RegisterApiModel.fromEntity(RegisterEntity entity) {
    return RegisterApiModel(
      name: entity.name,
      email: entity.email,
      password: entity.password,
      phone: entity.phone,
      country: entity.country,
      province: entity.province,
    );
  }

  RegisterEntity toEntity() {
    return RegisterEntity(
      name: name,
      email: email,
      password: password,
      phone: phone,
      country: country,
      province: province,
    );
  }

  @override
  List<Object?> get props => [name, email, password, phone, country, province];
}
