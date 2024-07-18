import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memow/layout/screen_layout.dart';

import 'package:memow/utils/utils.dart';
import 'package:memow/widget/custom_main_button.dart';
import 'package:memow/widget/text_field_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    addressController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          child: SizedBox(
            height: screenSize.height,
            width: screenSize.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/logo.png',
                        height: screenSize.height * 0.2),
                    SingleChildScrollView(
                      child: Container(
                        height: screenSize.height * 0.8,
                        width: screenSize.width * 0.8,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 188, 187, 180),
                              Color.fromARGB(255, 219, 214, 207),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          border: Border.all(
                              color: Color.fromARGB(212, 208, 214, 87),
                              width: 2),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 32,
                                  color: Color.fromARGB(255, 22, 21, 21)),
                            ),
                            TextFieldWidget(
                              title: "Name",
                              controller: nameController,
                              obscureText: false,
                              hintsText: "Enter your Name",
                              titleColor: const Color.fromARGB(255, 21, 2, 2),
                            ),
                            TextFieldWidget(
                              title: "Address",
                              controller: addressController,
                              obscureText: false,
                              hintsText: "Enter your Address",
                              titleColor: const Color.fromARGB(255, 18, 1, 1),
                            ),
                            TextFieldWidget(
                              title: "Email",
                              controller: emailController,
                              obscureText: false,
                              hintsText: "Enter your Email",
                              titleColor: const Color.fromARGB(255, 16, 1, 1),
                            ),
                            TextFieldWidget(
                              title: "Password",
                              controller: passwordController,
                              obscureText: true,
                              hintsText: "Enter your Password",
                              titleColor: const Color.fromARGB(255, 12, 1, 1),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: CustomMainButton(
                                  color: Colors.transparent,
                                  isLoading: false,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeScreen()));
                                  },
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 18, 18, 17),
                                      Color.fromARGB(255, 252, 250, 247)
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  child: const Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      letterSpacing: 0.9,
                                      color: Colors.white,
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                    CustomMainButton(
                        color: Colors.transparent,
                        isLoading: false,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 18, 18, 17),
                            Color.fromARGB(255, 240, 236, 230)
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        child: const Text(
                          "Back",
                          style: TextStyle(
                            letterSpacing: 0.1,
                            color: Colors.white,
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
