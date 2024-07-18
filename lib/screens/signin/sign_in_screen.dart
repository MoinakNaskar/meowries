import 'package:flutter/material.dart';
import 'package:memow/layout/screen_layout.dart';
import 'package:memow/screens/earth_globe.dart';
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
  bool _isBlur = true;

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
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  Image.asset('assets/logo.png',
                      height: screenSize.height * 0.5),
                  GestureDetector(
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
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: screenSize.height * 0.55,
                    width: screenSize.width * 0.8,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.white, Colors.grey],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
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
                            color: Colors.black,
                          ),
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
                            gradient: const LinearGradient(
                              colors: [Colors.white, Colors.grey],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            isLoading: false,
                            onPressed: () {
                              Navigator.of(context).push(_createRoute());
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
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.yellow,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "New to Memow?",
                          style: TextStyle(
                              color: Color.fromARGB(255, 222, 216, 57)),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.yellow,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  CustomMainButton(
                    gradient: const LinearGradient(
                      colors: [Colors.white, Colors.grey],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    isLoading: false,
                    onPressed: () {
                      Navigator.of(context).push(_createRoute());
                    },
                    color: Colors.amber,
                    child: const Text(
                      "Create New Memow Account",
                      style: TextStyle(
                        letterSpacing: 0.9,
                      ),
                    ),
                  ),
                  const Spacer()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = 0.0;
      var end = 1.0;
      var tween = Tween(begin: begin, end: end);
      var opacityAnimation = animation.drive(tween);

      return Stack(
        children: <Widget>[
          const EarthGlobe(),
          FadeTransition(
            opacity: opacityAnimation,
            child: child,
          ),
        ],
      );
    },
  );
}
