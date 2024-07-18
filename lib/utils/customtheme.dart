import 'package:flutter/material.dart';
import 'matte_glass.dart';

ThemeData matteGlassTheme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.transparent,
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // Add other theme settings here
  );
}
