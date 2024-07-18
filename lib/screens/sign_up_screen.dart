import 'package:flutter/material.dart';
import 'package:memow/layout/screen_layout.dart';
import 'package:memow/utils/glassmorphism.dart';
import 'package:memow/utils/matte_glass.dart';
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
  bool _isBlur = false;

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
      scrollDirection: Axis.vertical,
      child: MatteGlass(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/logo.png',
                      height: screenSize.height * 0.3),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isBlur = !_isBlur;
                      });
                    },
                    child: GlassMorphism(
                      blur: _isBlur ? 100 : 0,
                      opacity: 0.2,
                      child: const SizedBox(
                        height: 210,
                        width: 320,
                      ),
                    ),
                  ),
                  Container(
                    height: screenSize.height * 0.55,
                    width: screenSize.width * 0.8,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color.fromARGB(255, 237, 237, 234),
                          Colors.grey
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(29),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 28,
                              color: Color.fromARGB(255, 4, 4, 3),
                            ),
                          ),
                          TextFieldWidget(
                            title: "Name",
                            controller: nameController,
                            obscureText: false,
                            hintsText: "Enter your Email",
                            titleColor: const Color.fromARGB(255, 16, 12, 0),
                          ),
                          TextFieldWidget(
                            title: "Address",
                            controller: addressController,
                            obscureText: true,
                            hintsText: "Enter your address",
                            titleColor: const Color.fromARGB(255, 37, 28, 1),
                          ),
                          TextFieldWidget(
                            title: "Email",
                            controller: passwordController,
                            obscureText: true,
                            hintsText: "Enter your Email",
                            titleColor: const Color.fromARGB(255, 37, 28, 1),
                          ),
                          TextFieldWidget(
                            title: "Password",
                            controller: passwordController,
                            obscureText: true,
                            hintsText: "Enter your Password",
                            titleColor: const Color.fromARGB(255, 37, 28, 1),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: CustomMainButton(
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 24, 24, 1),
                                  Colors.grey
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              isLoading: false,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen()));
                              },
                              color: Colors.amber,
                              child: const Text(
                                "Sign in",
                                style: TextStyle(
                                  letterSpacing: 0.9,
                                ),
                              ),
                            ),
                          ),
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
                        colors: [Colors.yellow, Colors.orange],
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
    ));
  }
}
