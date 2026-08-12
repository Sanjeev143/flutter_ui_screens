import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

void main() {
  runApp(const MathematicalFractalsApp());
}

class MathematicalFractalsApp extends StatelessWidget {
  const MathematicalFractalsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Math Fractals Studio',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0E17),
        primaryColor: const Color(0xFF00E5FF),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00E5FF),
          secondary: Color(0xFF7C4DFF),
          surface: Color(0xFF121826),
        ),
      ),
      home: const FractalStudioScreen(),
    );
  }
}

// ==========================================
// MAIN FRACTAL STUDIO SCREEN
// ==========================================
class FractalStudioScreen extends StatefulWidget {
  const FractalStudioScreen({super.key});

  @override
  State<FractalStudioScreen> createState() => _FractalStudioScreenState();
}

class _FractalStudioScreenState extends State<FractalStudioScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  // Fractal Configuration Parameters
  int _fractalType = 0; // 0: Animated Tree, 1: Julia/Mandelbrot Canvas
  double _maxDepth = 10.0;
  double _branchAngle = 25.0; // degrees
  double _lengthRatio = 0.72;
  double _zoomLevel = 1.0;
  Offset _panOffset = Offset.zero;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _resetTransformations() {
    setState(() {
      _panOffset = Offset.zero;
      _zoomLevel = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. INTERACTIVE FRACTAL CANVAS
          GestureDetector(
            onScaleUpdate: (ScaleUpdateDetails details) {
              setState(() {
                // 1. Handle Pan (Drag) using focalPointDelta
                _panOffset += details.focalPointDelta;

                // 2. Handle Zoom (Scale) only when multiple fingers pinch/zoom
                if (details.scale != 1.0) {
                  _zoomLevel = (_zoomLevel * details.scale).clamp(0.5, 4.0);
                }
              });
            },
            child: AnimatedBuilder(
              animation: _animController,
              builder: (context, child) {
                return CustomPaint(
                  size: Size.infinite,
                  painter: _fractalType == 0
                      ? RecursiveTreePainter(
                    depth: _maxDepth.toInt(),
                    angle: _branchAngle,
                    lengthRatio: _lengthRatio,
                    animationValue: _animController.value,
                    offset: _panOffset,
                    scale: _zoomLevel,
                  )
                      : JuliaFractalPainter(
                    animationValue: _animController.value,
                    offset: _panOffset,
                    scale: _zoomLevel,
                    maxIterations: (_maxDepth * 5).toInt(),
                  ),
                );
              },
            ),
          ),

          // 2. HEADER BRANDING OVERLAY
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'MATHEMATICAL FRACTALS- Amazevalley',
                        style: TextStyle(
                          fontSize: 10,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00E5FF),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _fractalType == 0 ? 'Recursive Tree' : 'Julia Set Orbit',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: _resetTransformations,
                    icon: const Icon(Icons.center_focus_strong, color: Colors.white70),
                    tooltip: 'Reset Pan/Zoom',
                  ),
                ],
              ),
            ),
          ),

          // 3. BOTTOM CONTROL PANEL
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF121826).withOpacity(0.85),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withOpacity(0.12)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Switcher Buttons
                    Row(
                      children: [
                        Expanded(
                          child: _typeButton(0, 'Recursive Tree', Icons.park_outlined),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _typeButton(1, 'Julia Complex Set', Icons.grain_outlined),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Slider 1: Recursion Depth / Iterations
                    _sliderRow(
                      label: _fractalType == 0 ? 'Depth Level' : 'Iterations',
                      value: _maxDepth,
                      min: 3,
                      max: 12,
                      divisions: 9,
                      valueText: '${_maxDepth.toInt()}',
                      onChanged: (v) => setState(() => _maxDepth = v),
                    ),

                    if (_fractalType == 0) ...[
                      const SizedBox(height: 8),
                      // Slider 2: Branch Angle
                      _sliderRow(
                        label: 'Branch Angle',
                        value: _branchAngle,
                        min: 10,
                        max: 60,
                        divisions: 50,
                        valueText: '${_branchAngle.toInt()}°',
                        onChanged: (v) => setState(() => _branchAngle = v),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _typeButton(int index, String label, IconData icon) {
    final bool isSelected = _fractalType == index;
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? const Color(0xFF00E5FF) : Colors.white10,
        foregroundColor: isSelected ? Colors.black : Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () => setState(() => _fractalType = index),
      icon: Icon(icon, size: 18),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }

  Widget _sliderRow({
    required String label,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required String valueText,
    required ValueChanged<double> onChanged,
  }) {
    return Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(label, style: const TextStyle(fontSize: 11, color: Colors.white70)),
        ),
        Expanded(
          child: SliderTheme(
            data: SliderThemeData(
              activeTrackColor: const Color(0xFF00E5FF),
              thumbColor: const Color(0xFF00E5FF),
              inactiveTrackColor: Colors.white12,
              trackHeight: 3,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
            ),
            child: Slider(
              value: value,
              min: min,
              max: max,
              divisions: divisions,
              onChanged: onChanged,
            ),
          ),
        ),
        SizedBox(
          width: 35,
          child: Text(
            valueText,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF00E5FF)),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}

// ==========================================
// 1. RECURSIVE FRACTAL TREE PAINTER
// ==========================================
class RecursiveTreePainter extends CustomPainter {
  final int depth;
  final double angle;
  final double lengthRatio;
  final double animationValue;
  final Offset offset;
  final double scale;

  RecursiveTreePainter({
    required this.depth,
    required this.angle,
    required this.lengthRatio,
    required this.animationValue,
    required this.offset,
    required this.scale,
  });

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    // Center origin at bottom center + pan/zoom transformations
    canvas.translate(size.width / 2 + offset.dx, size.height * 0.82 + offset.dy);
    canvas.scale(scale);

    final double baseLength = size.height * 0.18;
    // Oscillate angle with animation controller
    final double dynamicAngle = (angle + math.sin(animationValue * math.pi * 2) * 4) * math.pi / 180;

    _drawBranch(canvas, baseLength, depth, dynamicAngle);
    canvas.restore();
  }

  void _drawBranch(Canvas canvas, double length, int currentDepth, double currentAngle) {
    if (currentDepth <= 0) return;

    final Paint branchPaint = Paint()
      ..color = Color.lerp(
        const Color(0xFF7C4DFF),
        const Color(0xFF00E5FF),
        currentDepth / depth,
      )!
      ..strokeWidth = currentDepth * 1.2
      ..strokeCap = StrokeCap.round;

    // Draw main trunk line
    canvas.drawLine(Offset.zero, Offset(0, -length), branchPaint);

    // Translate canvas to the tip of current branch
    canvas.save();
    canvas.translate(0, -length);

    // Right Branch
    canvas.save();
    canvas.rotate(currentAngle);
    _drawBranch(canvas, length * lengthRatio, currentDepth - 1, currentAngle);
    canvas.restore();

    // Left Branch
    canvas.save();
    canvas.rotate(-currentAngle);
    _drawBranch(canvas, length * lengthRatio, currentDepth - 1, currentAngle);
    canvas.restore();

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant RecursiveTreePainter oldDelegate) => true;
}

// ==========================================
// 2. JULIA SET COMPLEX FRACTAL PAINTER
// ==========================================
class JuliaFractalPainter extends CustomPainter {
  final double animationValue;
  final Offset offset;
  final double scale;
  final int maxIterations;

  JuliaFractalPainter({
    required this.animationValue,
    required this.offset,
    required this.scale,
    required this.maxIterations,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double cx = -0.7 + math.sin(animationValue * math.pi * 2) * 0.1;
    final double cy = 0.27015 + math.cos(animationValue * math.pi * 2) * 0.05;

    final double width = size.width;
    final double height = size.height;

    final Paint dotPaint = Paint()..strokeWidth = 2.0;

    // Render matrix dots representing complex Julia escape time values
    const int step = 6; // Grid resolution step
    for (double px = 0; px < width; px += step) {
      for (double py = 0; py < height; py += step) {
        // Map canvas coordinates to complex plane coordinates
        double zx = 1.5 * (px - width / 2 - offset.dx) / (0.5 * scale * width);
        double zy = (py - height / 2 - offset.dy) / (0.5 * scale * height);

        int i = maxIterations;
        while (zx * zx + zy * zy < 4 && i > 0) {
          double tmp = zx * zx - zy * zy + cx;
          zy = 2.0 * zx * zy + cy;
          zx = tmp;
          i--;
        }

        if (i > 0) {
          final double hue = (i / maxIterations) * 360;
          dotPaint.color = HSVColor.fromAHSV(1.0, hue, 0.8, 0.9).toColor();
          canvas.drawCircle(Offset(px, py), 2.0, dotPaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant JuliaFractalPainter oldDelegate) => true;
}