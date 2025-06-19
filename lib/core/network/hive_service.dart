import 'package:hive/hive.dart';

class HiveService {
  

  Future<void> init() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}ghar_sewa.db';

    Hive.init(path);

    Hive.registerAdapter(RegisterHiveModelAdapter());

    //queries 
    Future<void> addRegister(RegisterEntity register) async {
      var box = await Hive.openBox(HiveTableConstant.registerBox);
      await box.add(register);

    }



  }
}


