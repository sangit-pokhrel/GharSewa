import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    useMaterial3: false,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.blue[200],
    fontFamily: 'Urbanist Regular',
  );
}
