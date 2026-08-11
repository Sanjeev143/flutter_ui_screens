import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

void main() {
  runApp(const FlagApp());
}

class FlagApp extends StatelessWidget {
  const FlagApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wavy Indian Flag with Water Drops By Amazevalley',
      theme: ThemeData.dark(),
      home: const FlagScreen(),
    );
  }
}

class FlagScreen extends StatefulWidget {
  const FlagScreen({super.key});

  @override
  State<FlagScreen> createState() => _FlagScreenState();
}

class _FlagScreenState extends State<FlagScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<WaterDrop> _drops;
  final int _dropCount = 45;

  @override
  void initState() {
    super.initState();
    // Continuous animation loop driving both the flag wave & water drops
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    // Initialize random water drops
    _drops = List.generate(
      _dropCount,
          (index) => WaterDrop.random(index),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030A16), // Deep water navy background
      appBar: AppBar(
        title: const Text('Floating Flag & Water Drops \nBy Amazevalley Jai '
            'Hind',
          textAlign: TextAlign.center,),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            size: Size.infinite,
            painter: FloatingFlagPainter(
              animationValue: _controller.value,
              drops: _drops,
            ),
          );
        },
      ),
    );
  }
}

// ==========================================
// CUSTOM PAINTER (FLAG + WATER DROPS)
// ==========================================
class FloatingFlagPainter extends CustomPainter {
  final double animationValue;
  final List<WaterDrop> drops;

  FloatingFlagPainter({
    required this.animationValue,
    required this.drops,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. RENDER ANIMATED WATER DROPS
    _drawWaterDrops(canvas, size);

    // 2. RENDER WAVING INDIAN FLAG
    _drawWavyFlag(canvas, size);
  }

  // --- WATER DROPS RENDERING ---
  void _drawWaterDrops(Canvas canvas, Size size) {
    for (var drop in drops) {
      // Calculate vertical falling animation progress
      double currentY = ((drop.initialY + animationValue * drop.speed) % 1.0) * size.height;
      double currentX = drop.x * size.width;

      // Draw drop tail (streak line)
      final Paint dropPaint = Paint()
        ..color = Colors.cyanAccent.withOpacity(drop.opacity)
        ..strokeWidth = drop.size
        ..strokeCap = StrokeCap.round;

      canvas.drawLine(
        Offset(currentX, currentY - drop.length),
        Offset(currentX, currentY),
        dropPaint,
      );

      // Draw drop glowing tip
      final Paint tipPaint = Paint()
        ..color = Colors.white.withOpacity(drop.opacity * 0.9)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.0);

      canvas.drawCircle(Offset(currentX, currentY), drop.size * 0.8, tipPaint);
    }
  }

  // --- WAVY INDIAN FLAG RENDERING ---
  void _drawWavyFlag(Canvas canvas, Size size) {
    final double flagWidth = size.width * 0.75;
    final double flagHeight = flagWidth * 0.66; // 3:2 standard flag ratio
    final double startX = (size.width - flagWidth) / 2;
    final double startY = (size.height - flagHeight) / 2;
    final double stripeHeight = flagHeight / 3;

    // Flag Colors
    const Color saffron = Color(0xFFFF9933);
    const Color white = Color(0xFFFFFFFF);
    const Color green = Color(0xFF138808);
    const Color navyBlue = Color(0xFF000080);

    // Sine wave parameters for realistic cloth oscillation
    final double waveFrequency = 2.5; // Number of ripples across width
    final double waveAmplitude = 12.0; // Height of the wave
    final double phaseShift = animationValue * math.pi * 2;

    // Helper to draw a wavy stripe
    void drawWavyStripe(Color color, double topOffset) {
      final Path path = Path();

      // Top edge curve
      for (double x = 0; x <= flagWidth; x += 2) {
        double y = topOffset + math.sin((x / flagWidth) * waveFrequency * math.pi * 2 - phaseShift) * waveAmplitude;
        if (x == 0) {
          path.moveTo(startX + x, startY + y);
        } else {
          path.lineTo(startX + x, startY + y);
        }
      }

      // Bottom edge curve
      for (double x = flagWidth; x >= 0; x -= 2) {
        double y = topOffset + stripeHeight + math.sin((x / flagWidth) * waveFrequency * math.pi * 2 - phaseShift) * waveAmplitude;
        path.lineTo(startX + x, startY + y);
      }

      path.close();

      final Paint stripePaint = Paint()
        ..color = color
        ..style = PaintingStyle.fill;

      canvas.drawPath(path, stripePaint);
    }

    // Draw 3 Tricolour Stripes
    drawWavyStripe(saffron, 0);
    drawWavyStripe(white, stripeHeight);
    drawWavyStripe(green, stripeHeight * 2);

    // Calculate center point of the middle white stripe (accounting for wave displacement)
    final double centerRatio = 0.5;
    final double centerX = startX + (flagWidth * centerRatio);
    final double waveYDisplacement = math.sin(centerRatio * waveFrequency * math.pi * 2 - phaseShift) * waveAmplitude;
    final double centerY = startY + (stripeHeight * 1.5) + waveYDisplacement;
    final double chakraRadius = stripeHeight * 0.42;

    // Draw Ashoka Chakra
    _drawAshokaChakra(canvas, Offset(centerX, centerY), chakraRadius, navyBlue);
  }

  // --- ASHOKA CHAKRA (24 SPOKES) ---
  void _drawAshokaChakra(Canvas canvas, Offset center, double radius, Color color) {
    final Paint ringPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2;

    // Outer Circle Ring
    canvas.drawCircle(center, radius, ringPaint);

    // Inner Hub
    final Paint hubPaint = Paint()..color = color;
    canvas.drawCircle(center, radius * 0.15, hubPaint);

    // 24 Spokes
    final Paint spokePaint = Paint()
      ..color = color
      ..strokeWidth = 1.2;

    for (int i = 0; i < 24; i++) {
      double angle = (i * 360 / 24) * (math.pi / 180);
      double endX = center.dx + radius * math.cos(angle);
      double endY = center.dy + radius * math.sin(angle);
      canvas.drawLine(center, Offset(endX, endY), spokePaint);
    }
  }

  @override
  bool shouldRepaint(covariant FloatingFlagPainter oldDelegate) {
    return true; // Continuously redraw for smooth 60 FPS animation
  }
}

// ==========================================
// WATER DROP MODEL
// ==========================================
class WaterDrop {
  final double x; // Horizontal position ratio (0.0 to 1.0)
  final double initialY; // Starting vertical offset
  final double speed; // Fall speed multiplier
  final double size; // Thickness of the droplet
  final double length; // Length of the droplet tail streak
  final double opacity; // Alpha opacity

  WaterDrop({
    required this.x,
    required this.initialY,
    required this.speed,
    required this.size,
    required this.length,
    required this.opacity,
  });

  factory WaterDrop.random(int index) {
    final math.Random random = math.Random(index);
    return WaterDrop(
      x: random.nextDouble(),
      initialY: random.nextDouble(),
      speed: random.nextDouble() * 1.5 + 1.0,
      size: random.nextDouble() * 1.5 + 1.0,
      length: random.nextDouble() * 15.0 + 8.0,
      opacity: random.nextDouble() * 0.6 + 0.3,
    );
  }
}