import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: controller,
        builder: (_, __) {
          return CustomPaint(
            painter: SpacePainter(controller.value * 2 * pi),
            child: const SizedBox.expand(),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}



class SpacePainter extends CustomPainter {
  final double animation;

  SpacePainter(this.animation);

  final Random random = Random(107);
  // final Random random = Random(100);

  bool get showLightning => animation > 0.78 && animation < 0.83;



  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    //------------------------------------------
    // Background
    //------------------------------------------

    final bg = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xff040214),
          Color(0xff130022),
          Color(0xff03020f),
        ],
      ).createShader(rect);

    canvas.drawRect(rect, bg);

    //------------------------------------------
    // Nebula Clouds
    //------------------------------------------

    drawNebula(
      canvas,
      size,
      Offset(size.width * .50, size.height * .45),
      260,
      Colors.deepPurpleAccent.withOpacity(.35),
    );

    drawNebula(
      canvas,
      size,
      Offset(size.width * .30, size.height * .40),
      180,
      Colors.blueAccent.withOpacity(.25),
    );

    drawNebula(
      canvas,
      size,
      Offset(size.width * .72, size.height * .55),
      220,
      Colors.pinkAccent.withOpacity(.22),
    );

    drawNebula(
      canvas,
      size,
      Offset(size.width * .62, size.height * .25),
      120,
      Colors.white.withOpacity(.15),
    );

    if (showLightning) {
      canvas.drawRect(
        Offset.zero & size,
        Paint()
          ..color = Colors.white.withOpacity(.18),
      );
    }
    //------------------------------------------
    // Stars
    //------------------------------------------

    final Random starRandom = Random(15);
    // random.setSeed(15);

    for (int i = 0; i < 900; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;

      final r = random.nextDouble() * 1.7;

      final alpha =
      (.3 + .7 * sin(animation + starRandom.nextDouble() * pi))
          .clamp(0.0, 1.0);

      final star = Paint()
        ..color = Colors.white.withOpacity(alpha.toDouble());

      canvas.drawCircle(Offset(x, y), r, star);
    }

    /// Thundering
    drawCloudLayer(canvas, size);
    if (showLightning) {
      drawLightning(canvas, size);
    }


    //------------------------------------------
    // Bright Stars
    //------------------------------------------

    for (int i = 0; i < 12; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;

      drawGlowStar(
        canvas,
        Offset(x, y),
        25 + random.nextDouble() * 30,
      );
    }
  }

  void drawLightning(Canvas canvas, Size size) {
    final path = Path();

    final start = Offset(size.width * .55, 0);

    path.moveTo(start.dx, start.dy);

    final rnd = Random(5);

    double x = start.dx;
    double y = 0;

    while (y < size.height * .55) {
      x += rnd.nextDouble() * 40 - 20;
      y += 35 + rnd.nextDouble() * 30;

      path.lineTo(x, y);
    }

    final glow = Paint()
      ..color = Colors.lightBlueAccent.withOpacity(.35)
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        25,
      );

    canvas.drawPath(path, glow);

    final bolt = Paint()
      ..color = Colors.white
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, bolt);
  }

  void drawCloudLayer(Canvas canvas, Size size) {
    final cloudPaint = Paint()
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 80);

    final clouds = [
      Offset(size.width * .15, size.height * .22),
      Offset(size.width * .45, size.height * .18),
      Offset(size.width * .78, size.height * .25),
      Offset(size.width * .60, size.height * .35),
    ];

    for (final c in clouds) {
      final opacity = showLightning ? .65 : .35;

      cloudPaint.shader = RadialGradient(
        colors: [
          Colors.blueGrey.withOpacity(opacity),
          Colors.black.withOpacity(.2),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(center: c, radius: 170),
      );

      canvas.drawCircle(c, 170, cloudPaint);
    }
  }

  void drawNebula(
      Canvas canvas, Size size, Offset center, double radius, Color color) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          color,
          color.withOpacity(.4),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    canvas.drawCircle(center, radius, paint);
  }

  void drawGlowStar(Canvas canvas, Offset c, double r) {
    final glow = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.black26,
          Colors.lightBlueAccent.withOpacity(.8),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: c, radius: r));

    canvas.drawCircle(c, r, glow);

    final p = Paint()
      ..color = Colors.white
      ..strokeWidth = 1;

    // canvas.drawLine(
    //   Offset(c.dx - r, c.dy),
    //   Offset(c.dx + r, c.dy),
    //   p,
    // );

    // canvas.drawLine(
    //   Offset(c.dx, c.dy - r),
    //   Offset(c.dx, c.dy + r),
    //   p,
    // );
  }

  @override
  bool shouldRepaint(covariant SpacePainter oldDelegate) => true;
}