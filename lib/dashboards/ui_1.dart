import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

// void main() {
//   runApp(const EnergyOrbApp());
// }

class EnergyOrbApp extends StatelessWidget {
  const EnergyOrbApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Energy Orb',
      theme: ThemeData.dark(),
      home: const EnergyOrbScreen(),
    );
  }
}

class EnergyOrbScreen extends StatefulWidget {
  const EnergyOrbScreen({super.key});

  @override
  State<EnergyOrbScreen> createState() =>
      _EnergyOrbScreenState();
}

class _EnergyOrbScreenState extends State<EnergyOrbScreen>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xff05030A),
      body: AnimatedBuilder(
        animation: controller,
        builder: (_, __) {

          return CustomPaint(
            painter: EnergyPainter(controller.value),
            child: const SizedBox.expand(),
          );
        },
      ),
    );
  }
}

class EnergyPainter extends CustomPainter {

  final double t;

  EnergyPainter(this.t);

  final Random random = Random(4);

  @override
  void paint(Canvas canvas, Size size) {

    final center =
    Offset(size.width / 2, size.height / 2);

    drawBackground(canvas, size);

    drawStars(canvas, size);

    drawBloom(canvas, center);

    drawColorWave(canvas, center);

    drawOuterGlow(canvas, center);

    drawLightTrails(canvas, center);

    drawOrbitRings(canvas, center);

    drawPlasma(canvas, center);

    drawParticles(canvas, center);

    drawSparkBurst(canvas, center);

    // drawCore(canvas, center);

    drawHighlights(canvas, center);
  }

  //------------------------------------------------------------
  // BACKGROUND
  //------------------------------------------------------------

  void drawBackground(Canvas canvas, Size size) {

    Rect rect = Offset.zero & size;

    Paint paint = Paint()
      ..shader = const RadialGradient(
        colors: [
          Color(0xff18122B),
          Color(0xff09070F),
          Color(0xff040205),
        ],
        stops: [
          .1,
          .5,
          1,
        ],
      ).createShader(rect);

    canvas.drawRect(rect, paint);
  }

  //------------------------------------------------------------
  // GLOW
  //------------------------------------------------------------

  void drawOuterGlow(
      Canvas canvas,
      Offset center,
      ) {

    double pulse =
        140 + sin(t * pi * 2) * 10;

    Paint glow = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.purple.withOpacity(.45),
          Colors.deepPurple.withOpacity(.18),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(
          center: center,
          radius: pulse,
        ),
      );

    canvas.drawCircle(
      center,
      pulse,
      glow,
    );
  }

  //------------------------------------------------------------
  // ORBITS
  //------------------------------------------------------------

  void drawOrbitRings(
      Canvas canvas,
      Offset center,
      ) {

    for (int i = 0; i < 10; i++) {

      canvas.save();

      double angle =
          (t * 360 * (i.isEven ? 1 : -1)) +
              i * 18;

      canvas.translate(center.dx, center.dy);

      canvas.rotate(angle * pi / 180);

      double rx = 60 + i * 12;

      double ry = 18 + i * 5;

      Rect rect = Rect.fromCenter(
        center: Offset.zero,
        width: rx * 2,
        height: ry * 2,
      );

      Paint paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.2
        ..maskFilter =
        const MaskFilter.blur(BlurStyle.normal, 5)
        ..shader = SweepGradient(
          colors: [
            Colors.transparent,
            Colors.purpleAccent,
            Colors.white,
            Colors.deepPurple,
            Colors.transparent,
          ],
          stops: const [
            0,
            .25,
            .50,
            .75,
            1,
          ],
          transform:
          GradientRotation(t * pi * 2),
        ).createShader(rect);

      canvas.drawOval(rect, paint);

      canvas.restore();
    }
  }

  //------------------------------------------------------------
  // PARTICLES
  //------------------------------------------------------------

  void drawParticles(
      Canvas canvas,
      Offset center,
      ) {

    for (int i = 0; i < 140; i++) {

      double a =
          random.nextDouble() * pi * 2 +
              t * pi;

      double r =
          70 + random.nextDouble() * 140;

      Offset p = Offset(
        center.dx + cos(a) * r,
        center.dy + sin(a) * r,
      );

      double radius =
          random.nextDouble() * 2.5 + .5;

      Paint particle = Paint()
        ..color =
        Colors.white.withOpacity(.8)
        ..maskFilter =
        const MaskFilter.blur(
          BlurStyle.normal,
          4,
        );

      canvas.drawCircle(
        p,
        radius,
        particle,
      );
    }
  }
  //------------------------------------------------------------
  // ENERGY CORE
  //------------------------------------------------------------

  void drawCore(
      Canvas canvas,
      Offset center,
      ) {
    double pulse = 1 + sin(t * pi * 2) * .05;

    canvas.save();

    canvas.translate(center.dx, center.dy);
    canvas.scale(pulse);

    // Outer glow
    Paint glow = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.deepPurpleAccent.withOpacity(.85),
          Colors.purple.withOpacity(.45),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset.zero,
          radius: 90,
        ),
      );

    canvas.drawCircle(
      Offset.zero,
      90,
      glow,
    );

    // Middle glow
    Paint middle = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white,
          Colors.purpleAccent,
          const Color(0xff4A148C),
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset.zero,
          radius: 55,
        ),
      );

    canvas.drawCircle(
      Offset.zero,
      55,
      middle,
    );

    // Inner core
    Paint core = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white,
          const Color(0xffE1BEE7),
          Colors.deepPurple,
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset.zero,
          radius: 28,
        ),
      );

    canvas.drawCircle(
      Offset.zero,
      28,
      core,
    );

    canvas.restore();

    drawEnergyVeins(canvas, center);
  }

  //------------------------------------------------------------
  // ENERGY VEINS
  //------------------------------------------------------------

  void drawEnergyVeins(
      Canvas canvas,
      Offset center,
      ) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..maskFilter =
      const MaskFilter.blur(BlurStyle.normal, 6)
      ..color = Colors.white.withOpacity(.55);

    for (int i = 0; i < 14; i++) {
      double angle = (360 / 14) * i;

      double rad =
          (angle + t * 360) * pi / 180;

      Path path = Path();

      path.moveTo(
        center.dx + cos(rad) * 35,
        center.dy + sin(rad) * 35,
      );

      path.quadraticBezierTo(
        center.dx + cos(rad) * 65,
        center.dy + sin(rad) * 65,
        center.dx + cos(rad) * 95,
        center.dy + sin(rad) * 95,
      );

      canvas.drawPath(path, paint);
    }
  }

  //------------------------------------------------------------
  // HIGHLIGHTS
  //------------------------------------------------------------

  void drawHighlights(
      Canvas canvas,
      Offset center,
      ) {
    Paint paint = Paint()
      ..maskFilter =
      const MaskFilter.blur(BlurStyle.normal, 12);

    for (int i = 0; i < 8; i++) {
      double angle =
          (360 / 8) * i + t * 360;

      double rad = angle * pi / 180;

      Offset point = Offset(
        center.dx + cos(rad) * 115,
        center.dy + sin(rad) * 35,
      );

      paint.color = Colors.white.withOpacity(.8);

      canvas.drawCircle(
        point,
        4,
        paint,
      );
    }

    drawInnerOrbit(canvas, center);
  }

  //------------------------------------------------------------
  // INNER ORBIT
  //------------------------------------------------------------

  void drawInnerOrbit(
      Canvas canvas,
      Offset center,
      ) {
    canvas.save();

    canvas.translate(center.dx, center.dy);

    canvas.rotate(-t * pi * 2);

    Rect rect = Rect.fromCenter(
      center: Offset.zero,
      width: 160,
      height: 70,
    );

    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..maskFilter =
      const MaskFilter.blur(BlurStyle.normal, 8)
      ..shader = SweepGradient(
        colors: [
          Colors.transparent,
          Colors.white,
          Colors.purpleAccent,
          Colors.deepPurple,
          Colors.transparent,
        ],
      ).createShader(rect);

    canvas.drawOval(rect, paint);

    canvas.restore();
  }
  //------------------------------------------------------------
  // LIGHT TRAILS
  //------------------------------------------------------------

  void drawLightTrails(
      Canvas canvas,
      Offset center,
      ) {
    for (int i = 0; i < 5; i++) {
      canvas.save();

      canvas.translate(center.dx, center.dy);

      canvas.rotate((t * 2 * pi) + (i * pi / 5));

      Path path = Path();

      path.moveTo(-140, 0);

      path.cubicTo(
        -60,
        -40,
        60,
        40,
        140,
        0,
      );

      Paint paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.8
        ..maskFilter =
        const MaskFilter.blur(
          BlurStyle.normal,
          8,
        )
        ..shader = const LinearGradient(
          colors: [
            Colors.transparent,
            Colors.purpleAccent,
            Colors.white,
            Colors.deepPurpleAccent,
            Colors.transparent,
          ],
        ).createShader(
          const Rect.fromLTWH(
            -150,
            -60,
            300,
            120,
          ),
        );

      canvas.drawPath(path, paint);

      canvas.restore();
    }
  }

  //------------------------------------------------------------
  // PLASMA
  //------------------------------------------------------------

  void drawPlasma(
      Canvas canvas,
      Offset center,
      ) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2
      ..maskFilter =
      const MaskFilter.blur(
        BlurStyle.normal,
        5,
      );

    for (int i = 0; i < 18; i++) {
      double angle =
          (360 / 18) * i;

      double r =
          angle * pi / 180;

      Path p = Path();

      p.moveTo(
        center.dx + cos(r) * 50,
        center.dy + sin(r) * 50,
      );

      p.quadraticBezierTo(
        center.dx +
            cos(r + sin(t * pi * 2)) *
                90,
        center.dy +
            sin(r + sin(t * pi * 2)) *
                90,
        center.dx + cos(r) * 120,
        center.dy + sin(r) * 120,
      );

      paint.color = Colors.white
          .withOpacity(.35);

      canvas.drawPath(p, paint);
    }
  }

  //------------------------------------------------------------
  // SPARKS
  //------------------------------------------------------------

  void drawSparkBurst(
      Canvas canvas,
      Offset center,
      ) {
    Paint paint = Paint()
      ..maskFilter =
      const MaskFilter.blur(
        BlurStyle.normal,
        4,
      );

    for (int i = 0; i < 80; i++) {
      double angle =
          random.nextDouble() *
              pi *
              2;

      double radius =
          25 +
              random.nextDouble() *
                  160;

      Offset point = Offset(
        center.dx +
            cos(angle + t * pi) *
                radius,
        center.dy +
            sin(angle + t * pi) *
                radius,
      );

      paint.color = Colors.white
          .withOpacity(
        random.nextDouble(),
      );

      canvas.drawCircle(
        point,
        random.nextDouble() * 2 + .5,
        paint,
      );
    }
  }

  //------------------------------------------------------------
  // BLOOM
  //------------------------------------------------------------

  void drawBloom(
      Canvas canvas,
      Offset center,
      ) {
    double bloom =
        180 +
            sin(t * pi * 2) * 12;

    Paint paint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white.withOpacity(.08),
          Colors.purple.withOpacity(.05),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(
          center: center,
          radius: bloom,
        ),
      );

    canvas.drawCircle(
      center,
      bloom,
      paint,
    );
  }

  //------------------------------------------------------------
  // STAR FIELD
  //------------------------------------------------------------

  void drawStars(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..maskFilter =
      const MaskFilter.blur(BlurStyle.normal, 2);

    final random = Random(100);

    for (int i = 0; i < 220; i++) {
      paint.color = Colors.white.withOpacity(
        random.nextDouble() * .8,
      );

      canvas.drawCircle(
        Offset(
          random.nextDouble() * size.width,
          random.nextDouble() * size.height,
        ),
        random.nextDouble() * 1.5,
        paint,
      );
    }
  }

  //------------------------------------------------------------
  // OPTIONAL COLOR WAVE
  //------------------------------------------------------------

  void drawColorWave(
      Canvas canvas,
      Offset center,
      ) {

    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..maskFilter =
      const MaskFilter.blur(
          BlurStyle.normal, 12);

    for (int i = 0; i < 4; i++) {

      double radius =
          90 +
              sin(
                  t * pi * 2 +
                      i)
                  * 6;

      paint.color = Color.lerp(
        Colors.deepPurple,
        Colors.purpleAccent,
        sin(t * pi * 2 + i)
            .abs(),
      )!
          .withOpacity(.35);

      canvas.drawCircle(
        center,
        radius,
        paint,
      );
    }
  }

  //------------------------------------------------------------
  // REPAINT
  //------------------------------------------------------------

  @override
  bool shouldRepaint(
      covariant CustomPainter oldDelegate) {
    return true;
  }
}
