import 'package:flutter/material.dart';
import 'dart:ui';

class MatteGlass extends StatelessWidget {
  final Widget child;

  const MatteGlass({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Add your background image or color here
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/logo.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
          child: Container(
            color: Colors.white
                .withOpacity(1), // Adjust the opacity to give a matte effect
            child: child,
          ),
        ),
      ],
    );
  }
}
