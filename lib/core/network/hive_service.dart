import 'package:ghar_sewa/app/constant/hive/hive_table_constant.dart';
import 'package:ghar_sewa/features/register/data/model/register_hive_model.dart';
import 'package:ghar_sewa/features/register/domain/entity/register_entity.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}ghar_sewa.db';

    Hive.init(path);

    Hive.registerAdapter(RegisterHiveModelAdapter());

    //queries
    // Future<void> addRegister(RegisterEntity register) async {
    //   var box = await Hive.openBox(HiveTableConstant.registerBox);
    //   await box.add(register);

    // }
  }

  Future<void> addRegister(RegisterHiveModel register) async {
    // Implement logic to add the register to Hive box
    final box = await Hive.openBox<RegisterHiveModel>(
      HiveTableConstant.registerBox,
    );
    await box.add(register);
  }
}
