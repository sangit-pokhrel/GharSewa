import 'package:hive/hive.dart';

class HiveService {
  

  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}ghar_sewa.db';

    Hive.init(path);

    Hive.registerAdapter(RegisterHiveModelAdapter());

    await Hive.openBox(HiveTableConstant.registerBox);
  }
}


