// import 'package:proximity_sensor/proximity_sensor.dart';
// import 'package:screen_brightness/screen_brightness.dart';

// class ProximityService {
//   static final ProximityService _instance = ProximityService._internal();

//   factory ProximityService() => _instance;

//   ProximityService._internal();

//   void startListening() {
//     ProximitySensor.events.listen((isNear) async {
//       if (isNear == true) {
//         print("Proximity is near: $isNear");

//         await ScreenBrightness().setScreenBrightness(0.0); 
//       } else {
//         print("Proximity is not near: $isNear");
//         await ScreenBrightness().resetScreenBrightness(); 
//       }
//     });
//   }
// }

// lib/app/services/proximity_service.dart
import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:screen_brightness/screen_brightness.dart';

class ProximityService {
  static final ProximityService _instance = ProximityService._internal();

  factory ProximityService() => _instance;

  ProximityService._internal();

  void startListening() {
    ProximitySensor.events.listen((isNear) async {
      print("📡 Proximity sensor state: $isNear");

      try {
        if (isNear == true || isNear == 1) {
          print("🔒 Object is close. Dimming screen.");
          await ScreenBrightness().setScreenBrightness(0.0);
        } else {
          print("📱 Object is far. Restoring brightness.");
          await ScreenBrightness().resetScreenBrightness();
        }
      } catch (e) {
        print("❌ Brightness control failed: $e");
      }
    });
  }
}
