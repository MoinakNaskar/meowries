import 'package:flutter/material.dart';
import 'package:memow/features/auth/screens/sign_up_screen.dart';
import 'package:memow/features/home_memoworld/screens/home_screen.dart';
import 'package:memow/utils/frossted_glass.dart';
import 'package:memow/utils/utils.dart';
import 'package:memow/widget/custom_main_button.dart';
import 'package:memow/widget/text_field_widget.dart';

class SignInScreen extends StatefulWidget {
  static const String routeName = '/signIn-screen';
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  // ignore: unused_field
  final bool _isBlur = false;

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
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    height: screenSize.height * 0.12,
                    width: screenSize.width * 0.5,
                  ),
                  const Spacer(),
                  FrostedGlassBox(
                    key: null,
                    width: screenSize.height * 0.6,
                    height: screenSize.width * 0.85,
                    child: Container(
                      height: screenSize.height * 0.6,
                      width: screenSize.width * 0.85,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                              color: const Color.fromARGB(167, 226, 224, 79))),
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
                                    Color.fromARGB(255, 235, 235, 54),
                                    Color.fromARGB(255, 255, 254, 254)
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
                                    color: Colors.black,
                                    letterSpacing: 0.9,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Color.fromARGB(255, 241, 235, 235),
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Text(
                          "New to Memow?",
                          style: TextStyle(
                              color: Color.fromARGB(255, 244, 241, 241)),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Color.fromARGB(255, 239, 233, 233),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  CustomMainButton(
                    gradient: const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 240, 240, 237),
                        Color.fromARGB(255, 221, 239, 19)
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
                    color: const Color.fromARGB(217, 241, 233, 91),
                    child: const Text(
                      "Create a Memow account",
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
