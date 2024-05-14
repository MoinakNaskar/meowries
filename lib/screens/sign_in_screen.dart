// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:memow/glassmorphism.dart';

import 'package:memow/utils/utils.dart';
import 'package:memow/widget/custom_main_button.dart';
import 'package:memow/widget/text_field_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool _isBlur = false;

  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size ScreenSize = Utils().getScreenSize();
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: ScreenSize.height,
          width: ScreenSize.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/grad2.png',
                      height: ScreenSize.height * 0.2),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isBlur = !_isBlur;
                        });
                      },
                      child: GlassMorphism(
                          blur: _isBlur ? 20 : 0,
                          opacity: 0.2,
                          child: const SizedBox(
                            height: 210,
                            width: 320,
                          )),
                    ),
                  ),
                  Container(
                    height: ScreenSize.height * 0.5,
                    width: ScreenSize.width * 0.8,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.purple.shade900, width: 2),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Sign In",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 28),
                        ),
                        TextFieldWidget(
                          title: "Email",
                          controller: emailcontroller,
                          obscureText: false,
                          hintsText: "Enter your Email",
                        ),
                        TextFieldWidget(
                          title: "Password",
                          controller: passwordcontroller,
                          obscureText: true,
                          hintsText: "Enter your Password",
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: CustomMainButton(
                              color: const Color.fromARGB(255, 223, 177, 231),
                              isLoading: false,
                              onPressed: () {},
                              child: const Text(
                                "Sign in",
                                style: TextStyle(
                                  letterSpacing: 0.9,
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: const Color.fromARGB(255, 223, 177, 231),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "New to Memow ?",
                          style: TextStyle(
                              color: Color.fromARGB(255, 223, 177, 231)),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: const Color.fromARGB(255, 223, 177, 231),
                        ),
                      ),
                    ],
                  ),
                  CustomMainButton(
                      color: const Color.fromARGB(255, 223, 177, 231),
                      isLoading: false,
                      onPressed: () {},
                      child: const Text(
                        "Create a Memow account",
                        style: TextStyle(
                          letterSpacing: 0.1,
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
