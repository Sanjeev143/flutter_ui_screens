import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const WeatherAnimationApp());

class WeatherAnimationApp extends StatelessWidget {
  const WeatherAnimationApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherAnimationScreen(),
    );
  }
}

class WeatherAnimationScreen extends StatefulWidget {
  const WeatherAnimationScreen({super.key});
  @override
  State<WeatherAnimationScreen> createState() => _WeatherAnimationScreenState();
}

class _WeatherAnimationScreenState extends State<WeatherAnimationScreen>
    with TickerProviderStateMixin {
  late AnimationController _rainController;
  late AnimationController _thunderController;
  late AnimationController _starController;

  final Random random = Random();
  final List<Particle> rains = List.generate(200, (i) => Particle());
  final List<Particle> stars = List.generate(100, (i) => Particle(isStar:
  true));

  @override
  void initState() {
    super.initState();

    _rainController = AnimationController(vsync: this, duration: const
    Duration(seconds: 4))
      ..repeat();
    _starController = AnimationController(vsync: this, duration: const
    Duration(seconds: 6))
      ..repeat();
    _thunderController = AnimationController(vsync: this, duration: const
    Duration(milliseconds: 500));

    // Random thunder every 3-6 seconds
    Future.doWhile(() async {
      await Future.delayed(Duration(seconds: 3 + random.nextInt(2)));
      _thunderController.forward(from: 0);
      return true;
    });
  }

  @override
  void dispose() {
    _rainController.dispose();
    _starController.dispose();
    _thunderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8ECF5),
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge([_rainController, _starController, _thunderController]),
          builder: (context, _) {
            return Stack(
              alignment: Alignment.center,
              children: [
                // 1. THUNDER FLASH
                if (_thunderController.value > 0)
                  Container(
                    color: Colors.white.withOpacity(0.8 * (1 - _thunderController.value)),
                  ),

                // 2. CLOUD
                CustomPaint(
                  size: const Size(450, 300),
                  painter: CloudPainter(thunderFlash: _thunderController.value),
                ),

                // 3. RAIN + STARS
                CustomPaint(
                  size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
                  painter: ParticlePainter(
                    rains: rains,
                    stars: stars,
                    rainProgress: _rainController.value,
                    starProgress: _starController.value,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// Particle class for rain and stars
class Particle {
  double x = Random().nextDouble();
  double y = Random().nextDouble();
  double size = Random().nextDouble() * 3 + 1;
  double speed = Random().nextDouble() * 2 + 1;
  bool isStar;
  Particle({this.isStar = false});
}

class ParticlePainter extends CustomPainter {
  final List<Particle> rains;
  final List<Particle> stars;
  final double rainProgress;
  final double starProgress;

  ParticlePainter({
    required this.rains,
    required this.stars,
    required this.rainProgress,
    required this.starProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rainPaint = Paint()..color = Colors.blue.withOpacity(0.6);
    final starPaint = Paint()..color = Colors.white;

    // RAIN
    for (var p in rains) {
      double yPos = (p.y + rainProgress * p.speed) % 1.0;
      double xPos = p.x;
      // start rain from under cloud
      if (yPos > 0.25 && yPos < 0.8) {
        canvas.drawCircle(Offset(xPos * size.width, yPos * size.height), p.size, rainPaint);
      }
      // reset when out of screen
      if (yPos > 0.8) {
        p.y = 0.2 + Random().nextDouble() * 0.05;
        p.x = 0.3 + Random().nextDouble() * 0.4; // under cloud
      }
    }

    // STARS / SNOWFLAKES
    for (var s in stars) {
      double yPos = (s.y + starProgress * 0.3) % 1.0;
      double xPos = s.x + sin(starProgress * 2 * pi + s.x * 10) * 0.01; // sway
      if (yPos > 0.25 && yPos < 0.8) {
        _drawStar(canvas, Offset(xPos * size.width, yPos * size.height), s.size + 2, starPaint);
      }
      if (yPos > 0.8) {
        s.y = 0.2 + Random().nextDouble() * 0.05;
        s.x = 0.3 + Random().nextDouble() * 0.4;
      }
    }
  }

  void _drawStar(Canvas canvas, Offset center, double size, Paint paint) {
    final path = Path();
    const sides = 6; // snowflake
    for (int i = 0; i < sides; i++) {
      double angle = (i * 2 * pi) / sides;
      double x = center.dx + size * cos(angle);
      double y = center.dy + size * sin(angle);
      if (i == 0) path.moveTo(x, y);
      else path.lineTo(x, y);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant ParticlePainter oldDelegate) => true;
}

class CloudPainter extends CustomPainter {
  final double thunderFlash;
  CloudPainter({required this.thunderFlash});

  @override
  void paint(Canvas canvas, Size size) {
    final cloudPaint = Paint()
      ..color = const Color(0xFFB0C4DE)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);

    final darkPaint = Paint()
      ..color = const Color(0xFF7A8BA6)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);

    // Main cloud blobs
    canvas.drawOval(Rect.fromLTWH(size.width * 0.1, size.height * 0.2, size.width * 0.4, size.height * 0.5), cloudPaint);
    canvas.drawOval(Rect.fromLTWH(size.width * 0.3, size.height * 0.1, size.width * 0.5, size.height * 0.6), cloudPaint);
    canvas.drawOval(Rect.fromLTWH(size.width * 0.5, size.height * 0.25, size.width * 0.4, size.height * 0.5), cloudPaint);

    // Dark bottom
    canvas.drawOval(Rect.fromLTWH(size.width * 0.15, size.height * 0.4, size.width * 0.7, size.height * 0.4), darkPaint);

    // Thunder glow inside cloud
    if (thunderFlash > 0) {
      final glow = Paint()
        ..color = Colors.cyanAccent.withOpacity(0.6 * thunderFlash)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30);
      canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), 40, glow);
    }
  }

  @override
  bool shouldRepaint(covariant CloudPainter oldDelegate) => oldDelegate.thunderFlash != thunderFlash;
}