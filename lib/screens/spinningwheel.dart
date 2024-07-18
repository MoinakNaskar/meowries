import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:memow/features/home_memoworld/screens/post_card.dart';

class MemoBookingWidget extends StatefulWidget {
  const MemoBookingWidget({super.key});

  @override
  _MemoBookingWidgetState createState() => _MemoBookingWidgetState();
}

class _MemoBookingWidgetState extends State<MemoBookingWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _glowController;
  late Animation<double> _wheelAnimation;
  late Animation<double> _glowAnimation;
  int _selectedIndex = -1;
  final List<String> _sectionImages = [
    'assets/grad2.png',
    'assets/grad2.png',
    'assets/grad2.png',
    'assets/grad2.png',
    'assets/grad2.png',
    'assets/grad2.png',
    'assets/grad2.png',
    'assets/grad2.png',
    'assets/grad2.png',
  ];
  int _currentIndex = 0;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    );

    _wheelAnimation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);

    _controller.addListener(_onAnimationTick);
    _controller.repeat();

    _glowController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _glowAnimation = Tween<double>(begin: 0.8, end: 0.6).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.bounceIn),
    );

    _glowController.repeat(reverse: true);
  }

  void _onAnimationTick() {
    final sectionAngle = 2 * pi / _sectionImages.length;
    final currentAngle = _wheelAnimation.value % (2 * pi);

    if (!_isPaused && (currentAngle / sectionAngle).round() != _currentIndex) {
      _currentIndex =
          (currentAngle / sectionAngle).round() % _sectionImages.length;
      _isPaused = true;

      _controller.stop();
      Future.delayed(const Duration(seconds: 2), () {
        _controller.forward();
        _isPaused = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _glowController.dispose();
    super.dispose();
  }

  void _handleSectionTap(int index) {
    setState(() {
      _selectedIndex = index;
      _controller.stop(); // Stop the rotation when a section is tapped

      // Pause for 2 seconds before navigating to the new page
      Future.delayed(const Duration(seconds: 4), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SectionDetailPage(
              sectionIndex: index,
            ),
          ),
        );
      });
    });
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    setState(() {
      _controller.stop();
      _controller.value += details.delta.dx / 200;
    });
  }

  void _handlePanEnd(DragEndDetails details) {
    final sectionAngle = 2 * pi / _sectionImages.length;
    final currentAngle = _wheelAnimation.value % (2 * pi);

    setState(() {
      _currentIndex =
          (currentAngle / sectionAngle).round() % _sectionImages.length;
      _selectedIndex = _currentIndex;
      _controller.forward();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SectionDetailPage(
            sectionIndex: _selectedIndex,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memo Booking Widget'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          FrostedGlassBackground(
            child: Center(
              child: GestureDetector(
                onPanUpdate: _handlePanUpdate,
                onPanEnd: _handlePanEnd,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer rotating circle with shadow and gradient
                    AnimatedBuilder(
                      animation: _wheelAnimation,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _wheelAnimation.value,
                          child: child,
                        );
                      },
                      child: Container(
                        width: 450,
                        height: 450,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const RadialGradient(
                            colors: [Color(0xFFEFEFEF), Color(0xFFCCCCCC)],
                            center: Alignment(-0.3, -0.3),
                            radius: 0.8,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 15,
                              spreadRadius: 5,
                              offset: const Offset(5, 5),
                            ),
                            BoxShadow(
                              color: Colors.white.withOpacity(0.7),
                              blurRadius: 15,
                              spreadRadius: 5,
                              offset: const Offset(-5, -5),
                            ),
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: List.generate(
                            _sectionImages.length,
                            (index) => _buildSection(index),
                          ),
                        ),
                      ),
                    ),
                    // Glow effect around the wheel
                    AnimatedBuilder(
                      animation: _glowAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _glowAnimation.value,
                          child: Container(
                            width: 500,
                            height: 500,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 255, 0, 0)
                                      .withOpacity(0.5),
                                  blurRadius: 40,
                                  spreadRadius: 20,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    // Inner circle with bulged out effect and glass effect
                    ClipOval(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                        child: Container(
                          width: 290,
                          height: 290,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                Colors.white.withOpacity(0.6),
                                Colors.grey.withOpacity(0.2),
                              ],
                              center: const Alignment(0.1, 0.1),
                              radius: 0.6,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.8),
                                blurRadius: 15,
                                spreadRadius: 10,
                                offset: const Offset(-5, -5),
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 15,
                                spreadRadius: 10,
                                offset: const Offset(5, 5),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Image.asset(
                              _sectionImages[_currentIndex],
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Triangular label on the right side
                    Positioned(
                      right: 0,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Transform.rotate(
                          angle: -(pi / 2),
                          child: ClipPath(
                            clipper: TriangleClipper(),
                            child: Container(
                              color: const Color.fromARGB(255, 247, 245, 247),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(int index) {
    final double sectionAngle = 2 * pi / _sectionImages.length;
    const double radius = 160; // Adjusted radius to decrease the gap

    return Center(
      child: Transform.rotate(
        angle: sectionAngle * index,
        child: Align(
          alignment: Alignment.topCenter,
          child: GestureDetector(
            onTap: () => _handleSectionTap(index),
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color.fromARGB(255, 250, 250, 250),
                  width: 3,
                ),
                color: _selectedIndex == index
                    ? Colors.lightBlue.withOpacity(0.5)
                    : Colors.transparent,
              ),
              child: Image.asset(
                _sectionImages[index],
                width: 35,
                height: 35,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width / 2, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class SectionDetailPage extends StatelessWidget {
  final int sectionIndex;

  const SectionDetailPage({super.key, required this.sectionIndex});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Section Detail $sectionIndex'),
      ),
      body: Center(
        child: Text('Details of section $sectionIndex'),
      ),
    );
  }
}

class FrostedGlassBackground extends StatelessWidget {
  final Widget child;

  const FrostedGlassBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 17, 17, 17),
            Color.fromARGB(255, 249, 247, 247)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          color: Colors.transparent,
          child: child,
        ),
      ),
    );
  }
}
