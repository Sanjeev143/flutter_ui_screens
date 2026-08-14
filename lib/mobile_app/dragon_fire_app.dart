import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlyingDragonFireApp(),
    ),
  );
}

class FlyingDragonFireApp extends StatefulWidget {
  const FlyingDragonFireApp({super.key});

  @override
  State<FlyingDragonFireApp> createState() => _FlyingDragonFireAppState();
}

class _FlyingDragonFireAppState extends State<FlyingDragonFireApp>
    with SingleTickerProviderStateMixin {
  List<FireParticle> particles = [];
  late AnimationController _controller;
  Offset _currentTouchPosition = Offset.zero;
  bool _isTouching = false;

  @override
  void initState() {
    super.initState();
    // Animation controller drives 60 FPS repaint loop & wing flapping
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..addListener(_updateScene)
      ..repeat();
  }

  void _updateScene() {
    setState(() {
      // 1. Generate flame particles on touch/drag
      if (_isTouching) {
        for (int i = 0; i < 6; i++) {
          particles.add(FireParticle(pos: _currentTouchPosition));
        }
      }

      // 2. Animate and update existing particles
      for (var particle in particles) {
        particle.update();
      }

      // 3. Purge dead particles
      particles.removeWhere((p) => p.isDead);
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
      backgroundColor: const Color(0xFF070A0F),
      appBar: AppBar(
        title: const Text(
          "Flying Wyvern Simulation",
          style: TextStyle(
            letterSpacing: 1.5,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        backgroundColor: const Color(0xFF101C2B),
        centerTitle: true,
        elevation: 6,
      ),
      body: GestureDetector(
        onPanDown: (details) {
          _currentTouchPosition = details.localPosition;
          _isTouching = true;
        },
        onPanUpdate: (details) {
          _currentTouchPosition = details.localPosition;
        },
        onPanEnd: (_) => _isTouching = false,
        onPanCancel: () => _isTouching = false,
        child: CustomPaint(
          size: Size.infinite,
          painter: FlyingDragonAndFirePainter(
            particles: particles,
            animationValue: _controller.value,
            repaint: _controller,
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 1. Particle System for Fire
// ==========================================
class FireParticle {
  Offset pos;
  Offset vel;
  double size;
  double life;
  late Color color;
  static final Random _random = Random();

  FireParticle({required this.pos})
      : vel = Offset(
    (_random.nextDouble() - 0.5) * 5.5,
    (_random.nextDouble() - 1.5) * 6.5,
  ),
        size = _random.nextDouble() * 12 + 6,
        life = 1.0 {
    List<Color> fireColors = [
      Colors.cyanAccent,
      Colors.lightBlueAccent,
      Colors.blueAccent,
      Colors.white,
      Colors.amberAccent,
    ];
    color = fireColors[_random.nextInt(fireColors.length)];
  }

  bool get isDead => life <= 0;

  void update() {
    pos += vel;
    vel = Offset(vel.dx * 0.98, vel.dy - 0.15);
    size *= 0.95;
    life -= 0.025;
  }
}

// ==========================================
// 2. Flying Dragon & Fire Custom Painter
// ==========================================
class FlyingDragonAndFirePainter extends CustomPainter {
  final List<FireParticle> particles;
  final double animationValue;
  final Animation<double> repaint;

  FlyingDragonAndFirePainter({
    required this.particles,
    required this.animationValue,
    required this.repaint,
  }) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Render Fire Background
    _drawFire(canvas);

    // 2. Render Animated Flying Dragon
    _drawFlyingDragon(canvas, size);
  }

  void _drawFire(Canvas canvas) {
    for (var p in particles) {
      if (p.life <= 0) continue;

      final Paint firePaint = Paint()
        ..color = p.color.withOpacity(p.life)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(p.pos, p.size * p.life, firePaint);
    }
  }

  void _drawFlyingDragon(Canvas canvas, Size size) {
    final double originX = size.width / 2;

    // Body vertical bobbing with lift
    final double wingCycle = animationValue * 2 * pi;
    final double flapPhase = sin(wingCycle);
    final double bodyBob = sin(wingCycle) * 12.0;
    final double originY = size.height * 0.48 + bodyBob;

    canvas.save();
    canvas.translate(originX, originY);

    final double scaleFactor = (size.width / 390).clamp(0.85, 1.25);
    canvas.scale(scaleFactor);

    // --- 1. Tail with Harmonic Swaying ---
    _drawAnimatedTail(canvas, wingCycle);

    // --- 2. Hind Legs & Claws ---
    _drawHindLegs(canvas, flapPhase);

    // --- 3. Flapping Wings (Mirrored for Symmetry) ---
    _drawAnimatedWingHalf(canvas, true, flapPhase);

    canvas.save();
    canvas.scale(-1, 1);
    _drawAnimatedWingHalf(canvas, false, flapPhase);
    canvas.restore();

    // --- 4. Muscular Torso & Neck ---
    _drawTorsoAndNeck(canvas);

    // --- 5. Segmented Dorsal Ridge & Golden Scales ---
    _drawSpineAndDorsalRidge(canvas, wingCycle);

    // --- 6. Head & 3D Antler Crown Horns ---
    _drawHeadAndProminentHorns(canvas);

    canvas.restore();
  }

  void _drawAnimatedWingHalf(Canvas canvas, bool isRight, double flapPhase) {
    // Dynamic coordinate distortion based on wing flapping flapPhase (-1 to 1)
    final double wingSpanFactor = 1.0 - (flapPhase * 0.12);
    final double verticalCompression = flapPhase * 28.0;

    final Offset shoulder = const Offset(10, -65);
    final Offset elbow = Offset(88 * wingSpanFactor, -138 + verticalCompression * 0.8);
    final Offset mainTip = Offset(170 * wingSpanFactor, -158 + verticalCompression);
    final Offset rib1 = Offset(152 * wingSpanFactor, -60 + verticalCompression * 0.7);
    final Offset rib2 = Offset(122 * wingSpanFactor, 12 + verticalCompression * 0.4);
    final Offset lowerTip = Offset(76 * wingSpanFactor, 46 + verticalCompression * 0.2);

    // Membrane Shape
    final Path membranePath = Path()
      ..moveTo(shoulder.dx, shoulder.dy)
      ..lineTo(elbow.dx, elbow.dy)
      ..lineTo(mainTip.dx, mainTip.dy)
      ..cubicTo(
        160 * wingSpanFactor, -100 + verticalCompression * 0.85,
        rib1.dx + 6, -75 + verticalCompression * 0.75,
        rib1.dx, rib1.dy,
      )
      ..cubicTo(
        142 * wingSpanFactor, -15 + verticalCompression * 0.55,
        rib2.dx + 6, -5 + verticalCompression * 0.45,
        rib2.dx, rib2.dy,
      )
      ..cubicTo(
        106 * wingSpanFactor, 32 + verticalCompression * 0.3,
        lowerTip.dx + 6, 36 + verticalCompression * 0.25,
        lowerTip.dx, lowerTip.dy,
      )
      ..cubicTo(45, 15, 25, -10, shoulder.dx, shoulder.dy)
      ..close();

    final Paint membranePaint = Paint()
      ..shader = RadialGradient(
        center: const Alignment(0.28, -0.4),
        radius: 0.92,
        colors: const [
          Color(0xFFEADBCE),
          Color(0xFFD3BBA0),
          Color(0xFF6E8AA9),
          Color(0xFF263953),
        ],
        stops: const [0.15, 0.5, 0.8, 1.0],
      ).createShader(Rect.fromLTWH(0, -165 + verticalCompression, 180 * wingSpanFactor, 225));

    canvas.drawPath(membranePath, membranePaint);

    // Bone Highlights & Shadows
    final Paint boneShadow = Paint()
      ..color = const Color(0xFF111C2B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7.5
      ..strokeCap = StrokeCap.round;

    final Paint boneHighlight = Paint()
      ..color = const Color(0xFF5E85B2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    final Path armPath = Path()
      ..moveTo(shoulder.dx, shoulder.dy)
      ..lineTo(elbow.dx, elbow.dy)
      ..lineTo(mainTip.dx, mainTip.dy);

    canvas.drawPath(armPath, boneShadow);
    canvas.drawPath(armPath, boneHighlight);

    // Tendons & Finger Bones
    final Paint fingerPaint = Paint()
      ..color = const Color(0xFF385375)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(elbow, rib1, fingerPaint);
    canvas.drawLine(elbow, rib2, fingerPaint);
    canvas.drawLine(elbow, lowerTip, fingerPaint);

    // Wing Claws
    final Paint clawPaint = Paint()..color = const Color(0xFFD4A745);
    final Path clawPath = Path()
      ..moveTo(elbow.dx - 2, elbow.dy - 2)
      ..lineTo(elbow.dx - 7, elbow.dy - 13)
      ..lineTo(elbow.dx + 4, elbow.dy - 7)
      ..close();
    canvas.drawPath(clawPath, clawPaint);

    canvas.drawCircle(elbow, 3.5, Paint()..color = const Color(0xFF1E2F45));
    canvas.drawCircle(mainTip, 2.5, clawPaint);
  }

  void _drawAnimatedTail(Canvas canvas, double wingCycle) {
    final double sway1 = sin(wingCycle - 0.5) * 8.0;
    final double sway2 = sin(wingCycle - 1.0) * 16.0;

    final Path tailPath = Path()
      ..moveTo(0, 45)
      ..cubicTo(6 + sway1, 120, 3 + sway2, 230, sway2 * 1.3, 310)
      ..cubicTo(-3 + sway2, 230, -6 + sway1, 120, 0, 45);

    final Paint tailShader = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF23364D), Color(0xFF101824)],
      ).createShader(const Rect.fromLTWH(-20, 45, 40, 270));

    canvas.drawPath(tailPath, tailShader);

    // Tail spearhead tip
    final double tipX = sway2 * 1.3;
    final Path tipPath = Path()
      ..moveTo(tipX, 290)
      ..lineTo(tipX + 4.5, 308)
      ..lineTo(tipX, 318)
      ..lineTo(tipX - 4.5, 308)
      ..close();
    canvas.drawPath(tipPath, Paint()..color = const Color(0xFFD4A745));
  }

  void _drawHindLegs(Canvas canvas, double flapPhase) {
    final double legBob = flapPhase * 4.0;
    final Paint legBase = Paint()
      ..color = const Color(0xFF1C2A3D)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round;

    final Paint clawPaint = Paint()
      ..color = const Color(0xFFD4A745)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    // Right Leg & Digits
    canvas.drawLine(const Offset(8, 25), Offset(26, 42 + legBob), legBase);
    canvas.drawLine(Offset(26, 42 + legBob), Offset(34, 34 + legBob), legBase);
    canvas.drawLine(Offset(34, 34 + legBob), Offset(42, 30 + legBob), clawPaint);
    canvas.drawLine(Offset(34, 34 + legBob), Offset(42, 37 + legBob), clawPaint);

    // Left Leg & Digits
    canvas.drawLine(const Offset(-8, 25), Offset(-26, 42 + legBob), legBase);
    canvas.drawLine(Offset(-26, 42 + legBob), Offset(-34, 34 + legBob), legBase);
    canvas.drawLine(Offset(-34, 34 + legBob), Offset(-42, 30 + legBob), clawPaint);
    canvas.drawLine(Offset(-34, 34 + legBob), Offset(-42, 37 + legBob), clawPaint);
  }

  void _drawTorsoAndNeck(Canvas canvas) {
    final Path torsoPath = Path()
      ..moveTo(0, -120)
      ..cubicTo(12, -95, 15, -20, 10, 45)
      ..cubicTo(0, 55, 0, 55, 0, 55)
      ..cubicTo(-10, 45, -15, -20, -12, -95)
      ..close();

    final Paint torsoPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xFF162333),
          Color(0xFF4C6E97),
          Color(0xFF162333),
        ],
        stops: [0.0, 0.5, 1.0],
      ).createShader(const Rect.fromLTWH(-15, -120, 30, 175));

    canvas.drawPath(torsoPath, torsoPaint);
  }

  void _drawSpineAndDorsalRidge(Canvas canvas, double wingCycle) {
    final Paint spineRidge = Paint()
      ..color = const Color(0xFFE2B84D)
      ..style = PaintingStyle.fill;

    for (double y = -116; y <= 280; y += 9.5) {
      double scale = 1.0 - ((y + 116) / 450);
      double width = 3.6 * scale;
      double height = 7.0 * scale;

      // Subtle swaying down the lower tail
      double sway = 0;
      if (y > 45) {
        sway = sin(wingCycle - ((y - 45) / 200)) * ((y - 45) / 20);
      }

      final Path plate = Path()
        ..moveTo(sway, y)
        ..lineTo(sway + width, y + height * 0.4)
        ..lineTo(sway, y + height)
        ..lineTo(sway - width, y + height * 0.4)
        ..close();

      canvas.drawPath(plate, spineRidge);
    }
  }

  void _drawHeadAndProminentHorns(Canvas canvas) {
    // Sculpted Head Base
    final Path head = Path()
      ..moveTo(0, -150)
      ..lineTo(7.5, -135)
      ..lineTo(9, -122)
      ..lineTo(0, -118)
      ..lineTo(-9, -122)
      ..lineTo(-7.5, -135)
      ..close();

    final Paint headShader = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF385577), Color(0xFF141F2E)],
      ).createShader(const Rect.fromLTWH(-10, -150, 20, 35));

    canvas.drawPath(head, headShader);

    // Snout dorsal crest
    final Path snoutCrest = Path()
      ..moveTo(0, -148)
      ..lineTo(3, -133)
      ..lineTo(0, -124)
      ..lineTo(-3, -133)
      ..close();
    canvas.drawPath(snoutCrest, Paint()..color = const Color(0xFF5E85B2));

    // Eye Glints
    final Paint eyePaint = Paint()..color = const Color(0xFFFFD54F);
    canvas.drawCircle(const Offset(4.5, -134), 1.2, eyePaint);
    canvas.drawCircle(const Offset(-4.5, -134), 1.2, eyePaint);

    // 3D Horns
    _drawHorn(canvas, isRight: true);
    _drawHorn(canvas, isRight: false);

    // Center Crown Spikes
    final Paint centerCrownPaint = Paint()
      ..style = PaintingStyle.fill
      ..shader = const LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [Color(0xFF8A6214), Color(0xFFF3CD67)],
      ).createShader(const Rect.fromLTWH(-10, -145, 20, 25));

    final Path crownSpike1 = Path()
      ..moveTo(1, -130)
      ..lineTo(4, -142)
      ..lineTo(6, -130)
      ..close();
    canvas.drawPath(crownSpike1, centerCrownPaint);

    final Path crownSpike2 = Path()
      ..moveTo(-1, -130)
      ..lineTo(-4, -142)
      ..lineTo(-6, -130)
      ..close();
    canvas.drawPath(crownSpike2, centerCrownPaint);
  }

  void _drawHorn(Canvas canvas, {required bool isRight}) {
    final double dir = isRight ? 1.0 : -1.0;

    final Path hornPath = Path()
      ..moveTo(dir * 4, -127)
      ..quadraticBezierTo(dir * 18, -136, dir * 30, -158)
      ..quadraticBezierTo(dir * 14, -130, dir * 7.5, -122)
      ..close();

    final Rect hornRect = Rect.fromLTWH(
      dir > 0 ? 0 : -35,
      -160,
      35,
      40,
    );

    final Paint hornShader = Paint()
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: const [
          Color(0xFF5E400B),
          Color(0xFFB58422),
          Color(0xFFF7D97C),
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(hornRect);

    canvas.drawPath(hornPath, hornShader);

    final Paint ridgePaint = Paint()
      ..color = const Color(0xFF3B2704).withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    canvas.drawLine(
      Offset(dir * 9, -130),
      Offset(dir * 13, -134),
      ridgePaint,
    );
    canvas.drawLine(
      Offset(dir * 14, -137),
      Offset(dir * 19, -142),
      ridgePaint,
    );
  }

  @override
  bool shouldRepaint(covariant FlyingDragonAndFirePainter oldDelegate) => true;
}