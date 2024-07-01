// ignore_for_file: library_private_types_in_public_api

import 'dart:math';
import 'package:flutter/material.dart';

class MemoBookingWidget extends StatefulWidget {
  const MemoBookingWidget({super.key});

  @override
  _MemoBookingWidgetState createState() => _MemoBookingWidgetState();
}

class _MemoBookingWidgetState extends State<MemoBookingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _outerController;
  late Animation<double> _outerAnimation;
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
  double _rotationAngle = 0.0;

  @override
  void initState() {
    super.initState();
    _outerController = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    );

    _outerAnimation =
        Tween<double>(begin: 0, end: 2 * pi).animate(_outerController);

    _outerController.addListener(_onAnimationTick);
    _outerController.repeat();
  }

  void _onAnimationTick() {
    final sectionAngle = 2 * pi / _sectionImages.length;
    final currentAngle = _outerAnimation.value % (2 * pi);

    if (!_isPaused && (currentAngle / sectionAngle).round() != _currentIndex) {
      _currentIndex =
          (currentAngle / sectionAngle).round() % _sectionImages.length;
      _isPaused = true;

      _outerController.stop();
      Future.delayed(const Duration(seconds: 2), () {
        _outerController.forward();
        _isPaused = false;
      });
    }
  }

  @override
  void dispose() {
    _outerController.dispose();
    super.dispose();
  }

  void _handleSectionTap(int index) {
    setState(() {
      _selectedIndex = index;
      _outerController.stop(); // Stop the rotation when a section is tapped

      // Pause for 2 seconds before navigating to the new page
      Future.delayed(const Duration(seconds: 2), () {
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
      _outerController.stop();
      _rotationAngle += details.delta.dx / 200;
    });
  }

  void _handlePanEnd(DragEndDetails details) {
    final sectionAngle = 2 * pi / _sectionImages.length;
    final currentAngle = _rotationAngle % (2 * pi);

    setState(() {
      _currentIndex =
          (currentAngle / sectionAngle).round() % _sectionImages.length;
      _selectedIndex = _currentIndex;
      _rotationAngle = sectionAngle * _currentIndex;

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
      body: Center(
        child: GestureDetector(
          onPanUpdate: _handlePanUpdate,
          onPanEnd: _handlePanEnd,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer rotating circle
              Transform.rotate(
                angle: _rotationAngle,
                child: Container(
                  width: 450,
                  height: 450,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color.fromARGB(255, 220, 209, 61),
                      width: 4,
                    ),
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
              // Inner circle outline
              Container(
                width: 290,
                height: 290,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color.fromARGB(255, 233, 226, 78),
                    width: 4,
                  ),
                ),
              ),
              // Triangular label on the right side
              Positioned(
                right: 0,
                child: Container(
                  width: 20,
                  height: 20,
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
              // Center image showing selected section
              if (_selectedIndex != -1)
                Positioned(
                  child: Image.asset(
                    _sectionImages[_selectedIndex],
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(int index) {
    final double sectionAngle = 2 * pi / _sectionImages.length;
    // ignore: unused_local_variable
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
                  color: const Color.fromARGB(255, 246, 219, 71),
                  width: 2,
                ),
              ),
              child: Image.asset(
                _sectionImages[index],
                width: 60,
                height: 60,
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
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
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
        title: Text('Section $sectionIndex Details'),
      ),
      body: Center(
        child: Text('Details for section $sectionIndex'),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: MemoBookingWidget(),
  ));
}
