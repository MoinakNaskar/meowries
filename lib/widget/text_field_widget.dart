// ignore_for_file: unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class TextFieldWidget extends StatefulWidget {
  final String title;
  final TextEditingController controller;
  final String hintsText;
  final bool obscureText;
  const TextFieldWidget(
      {super.key,
      required this.title,
      required this.controller,
      required this.obscureText,
      required this.hintsText});

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
          child: Text(widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )),
        ),
        Container(
          decoration: BoxDecoration(boxShadow: [
            isInFocus
                ? const BoxShadow(
                    color: Colors.purple, blurRadius: 8, spreadRadius: 4)
                : const BoxShadow(
                    color: Colors.transparent, blurRadius: 8, spreadRadius: 4)
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
                  color: Colors.pink,
                  width: 3,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.purple.shade400,
                width: 2,
              )),
            ),
          ),
        ),
      ],
    );
  }
}
