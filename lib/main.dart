import 'package:flutter/material.dart';
import 'package:memow/features/auth/screens/sign_in_screen.dart';

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
        theme: ThemeData.dark(),
        home: const SignInScreen());
  }
}
