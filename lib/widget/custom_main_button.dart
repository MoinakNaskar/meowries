import 'package:flutter/material.dart';
import 'package:memow/utils/utils.dart';

class CustomMainButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final bool isLoading;
  final VoidCallback onPressed;
  const CustomMainButton(
      {super.key,
      required this.child,
      required this.color,
      required this.isLoading,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            fixedSize: Size(screenSize.width * 0.5, 40),
            shadowColor: Colors.purple[400]),
        onPressed: onPressed,
        child: !isLoading
            ? child
            : const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: CircularProgressIndicator(),
                )));
  }
}
