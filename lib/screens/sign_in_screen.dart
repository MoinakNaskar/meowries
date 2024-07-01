import 'package:flutter/material.dart';
import 'package:memow/layout/screen_layout.dart';
// ignore: unused_import
import 'package:memow/screens/earth_globe.dart';
import 'package:memow/screens/signup/sign_up_screen.dart';
import 'package:memow/utils/glassmorphism.dart';
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
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      body: SingleChildScrollView(
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
                            "Sign In",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 28,
                              color: Color.fromARGB(255, 4, 4, 3),
                            ),
                          ),
                          TextFieldWidget(
                            title: "Email",
                            controller: emailcontroller,
                            obscureText: false,
                            hintsText: "Enter your Email",
                            titleColor: const Color.fromARGB(255, 16, 12, 0),
                          ),
                          TextFieldWidget(
                            title: "Password",
                            controller: passwordcontroller,
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
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: const Color.fromARGB(255, 247, 247, 244),
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Text(
                          "New to Memow?",
                          style: TextStyle(
                              color: Color.fromARGB(255, 235, 235, 232)),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: const Color.fromARGB(255, 231, 230, 228),
                        ),
                      ),
                    ],
                  ),
                  CustomMainButton(
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 21, 1, 1),
                        Color.fromARGB(255, 24, 1, 1)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    isLoading: false,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()));
                    },
                    color: const Color.fromARGB(99, 11, 1, 1),
                    child: const Text(
                      "Create a Memow account",
                      style: TextStyle(
                          letterSpacing: 0.1, backgroundColor: Color(100)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
