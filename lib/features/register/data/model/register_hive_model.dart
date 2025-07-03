import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:ghar_sewa/app/constant/hive/hive_table_constant.dart';
import 'package:ghar_sewa/features/register/domain/entity/register_entity.dart';

//adapter code for converting hive binary code to dart code
part 'register_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.registerTableId)
class RegisterHiveModel extends Equatable {
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String password;
  @HiveField(4)
  final String phone;
  @HiveField(5)
  final String country;
  @HiveField(6)
  final String province;

  const RegisterHiveModel({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
    required this.country,
    required this.province,
  });

  //initial data
  const RegisterHiveModel.initial()
    : name = '',
      email = '',
      password = '',
      phone = '',
      country = '',
      province = '';

  //conversion code like to entity and from entity
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

  factory RegisterHiveModel.fromEntity(RegisterEntity register) {
    return RegisterHiveModel(
      name: register.name,
      email: register.email,
      password: register.password,
      phone: register.phone,
      country: register.country,
      province: register.province,
    );
  }

  // to entity list
  static List<RegisterEntity> toEntityList(List<RegisterHiveModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }

  // from entity list
  static List<RegisterHiveModel> fromEntityList(List<RegisterEntity> entities) {
    return entities
        .map((entity) => RegisterHiveModel.fromEntity(entity))
        .toList();
  }

  @override
  List<Object?> get props => [name, email, password, phone, country, province];
}
