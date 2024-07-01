import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class TextFieldWidget extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final String hintsText;
  final bool obscureText;
  final Color? titleColor;

  const TextFieldWidget({
    Key? key,
    required this.title,
    required this.controller,
    required this.obscureText,
    required this.hintsText,
    this.titleColor,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late FocusNode focusNode;
  bool isInFocus = false;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          isInFocus = true;
        });
      } else {
        setState(() {
          isInFocus = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: widget.titleColor ??
                  Colors.black, // Use custom color or default to black
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(boxShadow: [
            isInFocus
                ? const BoxShadow(
                    color: Color.fromARGB(255, 233, 233, 75),
                    blurRadius: 8,
                    spreadRadius: 4)
                : const BoxShadow(
                    color: Color.fromARGB(0, 241, 238, 62),
                    blurRadius: 8,
                    spreadRadius: 4)
          ]),
          child: TextField(
            obscureText: widget.obscureText,
            maxLines: 1,
            decoration: InputDecoration(
              fillColor: Colors.purple[30],
              filled: true,
              hintText: widget.hintsText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(
                  color: Color.fromARGB(255, 223, 225, 73),
                  width: 3,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                color: Color.fromARGB(255, 237, 234, 61),
                width: 2,
              )),
            ),
          ),
        ),
      ],
    );
  }
}
