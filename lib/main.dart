import 'package:flutter/material.dart';
import 'package:ghar_sewa/app.dart';
import 'package:ghar_sewa/core/network/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService().init();

  runApp(const MyApp());
}
