import 'dart:math';
import 'package:flutter/material.dart';
/// Amazevalley
void main() => runApp(const UniverseApp());

class UniverseApp extends StatelessWidget {
  const UniverseApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(debugShowCheckedModeBanner: false, home: UniverseScreen());
  }
}

class UniverseScreen extends StatefulWidget {
  const UniverseScreen({super.key});
  @override
  State<UniverseScreen> createState() => _UniverseScreenState();
}

class _UniverseScreenState extends State<UniverseScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 20))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) => CustomPaint(
          painter: UniversePainter(_controller.value),
          child: Container(),
        ),
      ),
    );
  }
}

class UniversePainter extends CustomPainter {
  final double t;
  final Random _rand = Random(777);
  UniversePainter(this.t);
  double _clamp01(double v) => v.clamp(0.0, 1.0);

  Path _irregularBlob(Offset center, double baseRadius, int points, double phase) {
    final path = Path();
    for (int i = 0; i <= points; i++) {
      double angle = (i / points) * 2 * pi;
      double noise = 0.6 + 0.4 * sin(angle * 3 + t * 1.5 + phase + i);
      double r = baseRadius * noise;
      double x = center.dx + cos(angle) * r + sin(t + phase + i) * 20;
      double y = center.dy + sin(angle) * r + cos(t + phase + i) * 20;
      if (i == 0) path.moveTo(x, y);
      else {
        double prevAngle = ((i - 1) / points) * 2 * pi;
        double cpx = center.dx + cos((angle + prevAngle) / 2) * r * 0.8;
        double cpy = center.dy + sin((angle + prevAngle) / 2) * r * 0.8;
        path.quadraticBezierTo(cpx, cpy, x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    double zoom = 1.0 + 4.0 * t; // 1x -> 5x infinite zoom

    // 1. Background
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), Paint()..color = const Color(0xFF000000));

    // 2. Nebula clouds - zoom with us
    _paintCloud(canvas, size, center, const Color(0xFF8B00FF), size.width * 0.8, 0, zoom);
    _paintCloud(canvas, size, center, const Color(0xFFD100FF), size.width * 0.7, pi / 2, zoom);
    _paintCloud(canvas, size, center, const Color(0xFF00BFFF), size.width * 0.9, pi, zoom);
    _paintCloud(canvas, size, center, const Color(0xFFFF4500), size.width * 0.6, pi * 1.5, zoom);

    // 3. 5000 STARS
    for (int i = 0; i < 5000; i++) {
      double depth = (_rand.nextDouble() * 0.9 + 0.1);
      double angle = _rand.nextDouble() * 2 * pi;
      double baseRadius = _rand.nextDouble() * size.width * 3.0;
      double radius = baseRadius * zoom / depth;
      double x = center.dx + cos(angle + t * 0.2) * radius;
      double y = center.dy + sin(angle + t * 0.2) * radius;

      double brightness = 0.1 + 0.9 * sin(t * 10 * pi + i * 0.4);
      brightness = _clamp01(brightness * (1.0 / depth));

      bool isBigStar = i % 80 == 0;
      double baseSize = isBigStar? 2.5 : 0.2;
      double starSize = (baseSize + _rand.nextDouble() * (isBigStar? 3.5 : 1.0)) * (zoom * depth);

      if (x > -200 && x < size.width + 200 && y > -200 && y < size.height + 200) {
        canvas.drawCircle(Offset(x, y), starSize, Paint()..color = Colors.white.withOpacity(brightness));
        if (isBigStar) {
          Color starColor = [Colors.white, Colors.cyan.shade200, Colors.yellow.shade200, Colors.pink.shade200][i % 4];
          canvas.drawCircle(
            Offset(x, y), starSize * 5,
            Paint()..color = starColor.withOpacity(_clamp01(brightness * 0.25))..maskFilter = MaskFilter.blur(BlurStyle.normal, starSize * 4),
          );
        }
      }
    }

    // 4. ONLY 2 PLANETS - LOCKED TO CENTER AND ROTATING
    // Draw back planet first
    _paintCenterPlanet(canvas, center, size, const Color(0xFFE94B3C), size.width * 0.08, zoom, angleOffset: pi, hasRing: false); // Red planet
    _paintCenterPlanet(canvas, center, size, const Color(0xFF4A90E2), size.width * 0.14, zoom, angleOffset: 0, hasRing: true); // Blue ringed planet in front

    // 5. ASTEROIDS
    for (int i = 0; i < 50; i++) {
      double depth = 0.3 + _rand.nextDouble() * 0.7;
      double angle = _rand.nextDouble() * 2 * pi + t * 0.6;
      double radius = (size.width * 0.6 + i * 20) * zoom / depth;
      double x = center.dx + cos(angle) * radius;
      double y = center.dy + sin(angle) * radius;
      double sizeRock = (2 + _rand.nextDouble() * 4) * depth * zoom;
      if (x > -50 && x < size.width + 50 && y > -50 && y < size.height + 50) {
        _paintAsteroid(canvas, Offset(x, y), sizeRock, t + i);
      }
    }
  }

  void _paintCenterPlanet(Canvas canvas, Offset center, Size size, Color color, double baseSize, double zoom, {required double angleOffset, required bool hasRing}) {
    // Planet stays at center, but rotates and scales with zoom
    double rotation = angleOffset + t * 2 * pi * 0.5; // slow rotation
    double planetSize = baseSize * zoom * 0.4; // grows as we zoom in

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation);

    // glow
    canvas.drawCircle(
      Offset.zero, planetSize * 1.6,
      Paint()..color = color.withOpacity(_clamp01(0.4 / (zoom * 0.5)))..maskFilter = MaskFilter.blur(BlurStyle.normal, planetSize),
    );

    // body with gradient to look 3D
    canvas.drawCircle(
      Offset.zero, planetSize,
      Paint()..shader = RadialGradient(
          center: const Alignment(-0.3, -0.3), // light from top-left
          colors: [color.withOpacity(0.95), color.withOpacity(0.3)]
      ).createShader(Rect.fromCircle(center: Offset.zero, radius: planetSize)),
    );

    // ring - rotates with planet
    if (hasRing) {
      canvas.drawOval(
        Rect.fromCenter(center: Offset.zero, width: planetSize * 3.2, height: planetSize * 0.9),
        Paint()..color = Colors.white.withOpacity(_clamp01(0.5 / (zoom * 0.5)))..style = PaintingStyle.stroke..strokeWidth = planetSize * 0.14..maskFilter = MaskFilter.blur(BlurStyle.normal, 4),
      );
    }
    canvas.restore();
  }

  void _paintAsteroid(Canvas canvas, Offset pos, double size, double seed) {
    final path = Path();
    for (int i = 0; i < 7; i++) {
      double angle = (i / 7) * 2 * pi;
      double r = size * (0.7 + 0.3 * sin(seed + i));
      double x = pos.dx + cos(angle) * r;
      double y = pos.dy + sin(angle) * r;
      if (i == 0) path.moveTo(x, y); else path.lineTo(x, y);
    }
    path.close();
    canvas.drawPath(path, Paint()..color = const Color(0xFF8B7355));
  }

  void _paintCloud(Canvas canvas, Size size, Offset center, Color color, double radius, double phase, double zoom) {
    final blobPath = _irregularBlob(center, radius * zoom, 14, phase);
    canvas.drawPath(blobPath, Paint()
      ..shader = RadialGradient(
        center: Alignment(0.1 * cos(t + phase), 0.1 * sin(t + phase)),
        colors: [color.withOpacity(_clamp01(0.45 / zoom)), color.withOpacity(_clamp01(0.12 / zoom)), Colors.transparent],
      ).createShader(blobPath.getBounds())
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 60 / zoom));
  }

  @override
  bool shouldRepaint(covariant UniversePainter oldDelegate) => true;
}