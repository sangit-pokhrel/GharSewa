import 'package:flutter/material.dart';
import 'package:ghar_sewa/app.dart';
import 'package:ghar_sewa/app/service_locator/service_locator.dart';
import 'package:ghar_sewa/core/network/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();

  await HiveService().init();

  runApp(const MyApp());
}
