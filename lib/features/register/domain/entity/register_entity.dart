import 'package:equatable/equatable.dart';

class RegisterEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String password;
  final String phone;
  final String country;
  final String province;

  const RegisterEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.country,
    required this.province,
  });

  @override
  List<Object?> get props => [name, email, password, phone, country, province];
}
