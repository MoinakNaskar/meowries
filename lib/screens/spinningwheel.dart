import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

class SpinningWheelPage extends StatefulWidget {
  const SpinningWheelPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SpinningWheelPageState createState() => _SpinningWheelPageState();
}

class _SpinningWheelPageState extends State<SpinningWheelPage>
    with TickerProviderStateMixin {
  late AnimationController _outerController;
  late AnimationController _innerController;
  late Animation<double> _outerAnimation;
  late Animation<double> _innerAnimation;
  late int _selectedIndex;
  final List<String> _sections = [
    "Section 1",
    "Section 2",
    "Section 3",
    "Section 4",
    "Section 5",
    "Section 6",
    "Section 7",
    "Section 8",
    "Section 9"
  ];

  @override
  void initState() {
    super.initState();
    _outerController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _innerController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _outerAnimation =
        CurvedAnimation(parent: _outerController, curve: Curves.easeInOut);
    _innerAnimation =
        CurvedAnimation(parent: _innerController, curve: Curves.easeInOut);
    _selectedIndex = 0;

    _outerController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _selectedIndex = _calculateSelectedIndex();
        });
      }
    });
  }

  int _calculateSelectedIndex() {
    final double angle = (_outerAnimation.value * 2 * pi) % (2 * pi);
    final double sectionAngle = 2 * pi / _sections.length;
    return (_sections.length - (angle / sectionAngle).round()) %
        _sections.length;
  }

  void _spinWheel(int index) {
    final double sectionAngle = 2 * pi / _sections.length;
    final double targetAngle = sectionAngle * index;

    _outerController.reset();
    _innerController.reset();
    _outerAnimation = Tween<double>(
      begin: 0,
      end: 10 * 2 * pi - targetAngle,
    ).animate(
        CurvedAnimation(parent: _outerController, curve: Curves.easeInOut));
    _innerAnimation = Tween<double>(
      begin: 0,
      end: -10 * 2 * pi + targetAngle,
    ).animate(
        CurvedAnimation(parent: _innerController, curve: Curves.easeInOut));
    _outerController.forward();
    _innerController.forward();
  }

  @override
  void dispose() {
    _outerController.dispose();
    _innerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spinning Wheel'),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
              onTap: () => _spinWheel(_selectedIndex),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer ring with clockwise rotation
                  AnimatedBuilder(
                    animation: _outerAnimation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _outerAnimation.value,
                        child: child,
                      );
                    },
                    child: GlassmorphicContainer(
                      width: 400,
                      height: 400,
                      borderRadius: 200,
                      blur: 20,
                      alignment: Alignment.center,
                      border: 2,
                      linearGradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.1),
                          Colors.white.withOpacity(0.1),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderGradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.5),
                          Colors.white.withOpacity(0.5),
                        ],
                      ),
                      child: CustomPaint(
                        size: const Size(400, 400),
                        painter: WheelPainter(_sections),
                      ),
                    ),
                  ),
                  // Inner ring with anticlockwise rotation
                  AnimatedBuilder(
                    animation: _innerAnimation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: _innerAnimation.value,
                        child: child,
                      );
                    },
                    child: CustomPaint(
                      size: const Size(200, 200),
                      painter: InnerRingPainter(),
                    ),
                  ),
                ],
              ),
            ),
            // Center text showing selected section
            Positioned(
              child: Text(
                _sections[_selectedIndex],
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WheelPainter extends CustomPainter {
  final List<String> sections;
  WheelPainter(this.sections);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..style = PaintingStyle.fill;
    final double outerRadius = min(size.width / 2, size.height / 2);
    final double innerRadius = outerRadius / 2;
    final double sectionAngle = 2 * pi / sections.length;

    for (int i = 0; i < sections.length; i++) {
      final double startAngle = i * sectionAngle;
      final double sweepAngle = sectionAngle;
      paint.color = i.isEven
          ? Colors.blue.withOpacity(0.5)
          : Colors.purple.withOpacity(0.5);

      // Draw outer arc
      canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2),
            radius: outerRadius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      // Draw inner arc
      paint.color = Colors.white.withOpacity(0.2);
      canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width / 2, size.height / 2),
            radius: innerRadius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );

      // Draw text
      final textPainter = TextPainter(
        text: TextSpan(
            text: sections[i],
            style: const TextStyle(color: Colors.black, fontSize: 14)),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      final double textAngle = startAngle + sweepAngle / 2;
      final Offset textOffset = Offset(
        size.width / 2 +
            (innerRadius + outerRadius) / 2 * cos(textAngle) -
            textPainter.width / 2,
        size.height / 2 +
            (innerRadius + outerRadius) / 2 * sin(textAngle) -
            textPainter.height / 2,
      );

      canvas.save();
      canvas.translate(textOffset.dx + textPainter.width / 2,
          textOffset.dy + textPainter.height / 2);
      canvas.rotate(textAngle - pi / 2);
      canvas.translate(-textOffset.dx - textPainter.width / 2,
          -textOffset.dy - textPainter.height / 2);
      textPainter.paint(canvas, textOffset);
      canvas.restore();
    }

    // Draw double-lined outer ring
    paint.color = Colors.purple;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 4;
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), outerRadius, paint);
    paint.strokeWidth = 2;
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), outerRadius - 4, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class InnerRingPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final double innerRadius = min(size.width / 2, size.height / 2);

    // Draw double-lined inner ring
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), innerRadius, paint);
    paint.strokeWidth = 2;
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), innerRadius - 4, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class GlassmorphicContainer extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final double blur;
  final Alignment alignment;
  final double border;
  final LinearGradient linearGradient;
  final LinearGradient borderGradient;
  final Widget? child;

  const GlassmorphicContainer({
    super.key,
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.blur,
    required this.alignment,
    required this.border,
    required this.linearGradient,
    required this.borderGradient,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: width,
          height: height,
          alignment: alignment,
          decoration: BoxDecoration(
            gradient: linearGradient,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              width: border,
              color: Colors.transparent,
            ),
          ),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  border: Border.all(
                    width: border,
                    style: BorderStyle.solid,
                    color: borderGradient.colors.first,
                  ),
                ),
              ),
              if (child != null) child!,
            ],
          ),
        ),
      ),
    );
  }
}
