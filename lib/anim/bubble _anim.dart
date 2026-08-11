import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const BubbleApp());

class BubbleApp extends StatelessWidget {
  const BubbleApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazevalley',
      debugShowCheckedModeBanner: false,
      home: const BubbleScreen(),
    );
  }
}

class BubbleScreen extends StatefulWidget {
  const BubbleScreen({super.key});
  @override
  State<BubbleScreen> createState() => _BubbleScreenState();
}

class _BubbleScreenState extends State<BubbleScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  final Random random = Random();
  final List<Bubble> bubbles = [];

  final List<Color> bubbleColors = [
    const Color(0xFFFF6B6B), // red
    const Color(0xFF4ECDC4), // teal
    const Color(0xFF45B7D1), // blue
    const Color(0xFF96CEB4), // green
    const Color(0xFFFFEAA7), // yellow
    const Color(0xFFDDA0DD), // purple
    const Color(0xFFFFB6C1), // pink
  ];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 45; i++) {
      bubbles.add(Bubble.random(random, bubbleColors));
    }

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _controller.addListener(() {
      setState(() {
        for (var bubble in bubbles) {
          bubble.update();
        }
      });
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
          ),
        ),
        child: Stack(
          children: [
            CustomPaint(
              size: Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
              painter: BubblePainter(bubbles),
            ),
            Text(
              "Amazevalley",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w200,
                color: Colors.white.withOpacity(0.4),
                letterSpacing: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Bubble {
  double x;
  double y;
  double size;
  double speedX;
  double speedY;
  Color color;
  double opacity;
  double wobble;

  Bubble({
    required this.x,
    required this.y,
    required this.size,
    required this.speedX,
    required this.speedY,
    required this.color,
    required this.opacity,
    required this.wobble,
  });

  factory Bubble.random(Random random, List<Color> colors) { // using the passed random
    return Bubble(
      x: random.nextDouble(),
      y: random.nextDouble(),
      size: random.nextDouble() * 40 + 20,
      speedX: (random.nextDouble() - 0.5) * 0.001,
      speedY: -(random.nextDouble() * 0.002 + 0.001),
      color: colors[random.nextInt(colors.length)],
      opacity: random.nextDouble() * 0.4 + 0.3,
      wobble: random.nextDouble() * 2 * pi,
    );
  }

  void update() {
    x += speedX;
    y += speedY;
    wobble += 0.02;
    x += sin(wobble) * 0.0005;

    // Reset bubble when off screen
    if (y < -0.1) {
      y = 1.1;
      x = Random().nextDouble(); // create new Random here instead of static
    }
    if (x < -0.1) x = 1.1;
    if (x > 1.1) x = -0.1;
  }
}

class BubblePainter extends CustomPainter {
  final List<Bubble> bubbles;
  BubblePainter(this.bubbles);

  @override
  void paint(Canvas canvas, Size size) {
    for (var bubble in bubbles) {
      final paint = Paint()
        ..style = PaintingStyle.fill;

      final borderPaint = Paint()
        ..color = Colors.white.withOpacity(bubble.opacity * 0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;

      final center = Offset(bubble.x * size.width, bubble.y * size.height);

      final gradient = RadialGradient(
        center: const Alignment(-0.3, -0.3),
        radius: 1.0,
        colors: [
          Colors.white.withOpacity(bubble.opacity * 0.8),
          bubble.color.withOpacity(bubble.opacity),
        ],
        stops: const [0.0, 1.0],
      );

      paint.shader = gradient.createShader(Rect.fromCircle(center: center, radius: bubble.size));

      canvas.drawCircle(center, bubble.size, paint);
      canvas.drawCircle(center, bubble.size, borderPaint);

      final highlight = Paint()..color = Colors.white.withOpacity(bubble.opacity * 0.6);
      canvas.drawCircle(
        Offset(center.dx - bubble.size * 0.3, center.dy - bubble.size * 0.3),
        bubble.size * 0.15,
        highlight,
      );
    }
  }

  @override
  bool shouldRepaint(covariant BubblePainter oldDelegate) => true;
}