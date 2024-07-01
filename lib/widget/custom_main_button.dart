import 'package:flutter/material.dart';

class CustomMainButton extends StatelessWidget {
  final Gradient gradient;
  final bool isLoading;
  final VoidCallback onPressed;
  final Widget child;

  const CustomMainButton({
    super.key,
    required this.gradient,
    required this.isLoading,
    required this.onPressed,
    required this.child,
    required Color color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(25),
      ),
      child: MaterialButton(
        onPressed: isLoading ? null : onPressed,
        textColor: Colors.white,
        child: isLoading ? const CircularProgressIndicator() : child,
      ),
    );
  }
}
