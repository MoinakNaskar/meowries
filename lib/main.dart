// ignore_for_file: unused_import

import 'package:flutter/material.dart';

import 'package:memow/layout/wedding_booking.dart';

import 'package:memow/screens/premium_booking.dart';

import 'package:memow/screens/sign_in_screen.dart';
import 'package:memow/screens/signup/sign_up_screen.dart';
import 'package:memow/screens/spinningwheel.dart';
import 'package:memow/utils/customtheme.dart';

void main() {
  runApp(const Memow());
}

class Memow extends StatelessWidget {
  const Memow({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MEMOWRIES',
        debugShowCheckedModeBanner: false,
        theme: matteGlassTheme(),
        home: const SignInScreen());
  }
}
