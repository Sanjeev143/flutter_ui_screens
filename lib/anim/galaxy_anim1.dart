import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const GalaxyApp());

class GalaxyApp extends StatelessWidget {
  const GalaxyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GalaxyScreen(),
    );
  }
}

class GalaxyScreen extends StatefulWidget {
  const GalaxyScreen({super.key});
  @override
  State<GalaxyScreen> createState() => _GalaxyScreenState();
}

class _GalaxyScreenState extends State<GalaxyScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _showText = true; // toggle this to hide/show

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    )..repeat();

    // Example: auto hide/show text every 4 seconds
    Future.delayed(const Duration(seconds: 3), () {
      setState(() => _showText = !_showText);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack( // 1. Use Stack to layer text on top of animation
        fit: StackFit.expand,
        children: [
          // LAYER 1: THE ANIMATION
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: GalaxyPainter(_controller.value),
                child: Container(),
              );
            },
          ),

          // LAYER 2: THE TEXT WITH FADE
          Center(
            child: AnimatedOpacity(
              opacity: _showText ? 1.0 : 0.0, // 1 = visible, 0 = hidden
              duration: const Duration(seconds: 1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "GALAXY EXPLORER",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 3,
                      shadows: [
                        Shadow(blurRadius: 20, color: Colors.blueAccent),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// PASTE YOUR GALAXYPAINTER CLASS HERE FROM PREVIOUS MESSAGE
class GalaxyPainter extends CustomPainter {
  final double t;
  final Random _rand = Random(123);
  final List<Offset> stars = [];
  final List<Particle> particles = [];

  GalaxyPainter(this.t) {
    if (stars.isEmpty) {
      for (int i = 0; i < 5000; i++) {
        stars.add(Offset(
          _rand.nextDouble() * 2 - 1,
          _rand.nextDouble() * 2 - 1,
        ));
      }
    }
    if (particles.isEmpty) {
      for (int i = 0; i < 300; i++) {
        particles.add(Particle(
          _rand.nextDouble() * 2 - 1,
          _rand.nextDouble() * 2 - 1,
          1 + _rand.nextDouble() * 3,
          _rand.nextDouble(),
        ));
      }
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final zoom = 1.0 + sin(t * pi * 2) * 0.3;

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2D0036), Color(0xFF1A0033), Color(0xFF000022)],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)),
    );

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.scale(zoom);
    canvas.rotate(t * 0.1);
    canvas.translate(-center.dx, -center.dy);

    _drawNebula(canvas, center, size.width * 0.6, const Color(0xFF6A0DAD));
    _drawNebula(canvas, center + const Offset(100, 50), size.width * 0.4, const Color(0xFF8B0000));

    for (var star in stars) {
      double x = center.dx + star.dx * size.width * 0.7;
      double y = center.dy + star.dy * size.height * 0.7;
      double twinkle = 0.6 + 0.4 * sin(t * 10 + star.dx * 100);
      double starSize = 0.5 + _rand.nextDouble() * 1.5;
      Offset pos = Offset(x, y);
      canvas.drawCircle(pos, starSize, Paint()..color = Colors.white.withOpacity(twinkle));
    }

    for (var p in particles) {
      double px = center.dx + p.x * size.width * 0.8 + sin(t * 2 + p.seed * 10) * 20;
      double py = center.dy + p.y * size.height * 0.8 + cos(t * 2 + p.seed * 10) * 20;
      double opacity = 0.3 + 0.7 * sin(t * 6 + p.seed * 50);
      Offset ppos = Offset(px, py);
      canvas.drawCircle(ppos, p.size, Paint()..color = Colors.white.withOpacity(opacity));
    }
    canvas.restore();
  }

  void _drawNebula(Canvas canvas, Offset pos, double radius, Color color) {
    canvas.drawCircle(pos, radius,
        Paint()..color = color.withOpacity(0.15)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 80));
  }

  @override
  bool shouldRepaint(covariant GalaxyPainter oldDelegate) => true;
}

class Particle {
  double x, y, size, seed;
  Particle(this.x, this.y, this.size, this.seed);
}