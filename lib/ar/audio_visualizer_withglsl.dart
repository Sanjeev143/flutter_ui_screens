import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AudioVisualizerScreen(),
  ));
}

class AudioVisualizerScreen extends StatefulWidget {
  const AudioVisualizerScreen({super.key});

  @override
  State<AudioVisualizerScreen> createState() => _AudioVisualizerScreenState();
}

class _AudioVisualizerScreenState extends State<AudioVisualizerScreen>
    with SingleTickerProviderStateMixin {
  ui.FragmentShader? _shader;
  late Ticker _ticker;
  double _elapsedTime = 0.0;

  // 4 Frequency bands: Low, Mid-Low, Mid-High, High (0.0 to 1.0)
  List<double> _frequencies = [0.2, 0.5, 0.8, 0.4];

  @override
  void initState() {
    super.initState();
    _loadShader();
    _ticker = createTicker((elapsed) {
      setState(() {
        _elapsedTime = elapsed.inMicroseconds / 1000000.0;
        // Mock FFT audio fluctuation (replace with real audio stream data)
        _frequencies = [
          (math.sin(_elapsedTime * 4.0).abs() * 0.8) + 0.2,
          (math.cos(_elapsedTime * 6.0).abs() * 0.9) + 0.1,
          (math.sin(_elapsedTime * 8.0).abs() * 0.7) + 0.3,
          (math.cos(_elapsedTime * 10.0).abs() * 0.6) + 0.4,
        ];
      });
    });
  }

  Future<void> _loadShader() async {
    final program = await ui.FragmentProgram.fromAsset(
      'shaders/visualizer.frag',
    );
    setState(() {
      _shader = program.fragmentShader();
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    _shader?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_shader == null) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: CustomPaint(
          painter: ShaderPainter(
            shader: _shader!,
            time: _elapsedTime,
            frequencies: _frequencies,
          ),
        ),
      ),
    );
  }
}

class ShaderPainter extends CustomPainter {
  final ui.FragmentShader shader;
  final double time;
  final List<double> frequencies;

  ShaderPainter({
    required this.shader,
    required this.time,
    required this.frequencies,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // 1. uResolution (vec2) -> indices 0, 1
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);

    // 2. uTime (float) -> index 2
    shader.setFloat(2, time);

    // 3. uFrequencies (vec4) -> indices 3, 4, 5, 6
    shader.setFloat(3, frequencies[0]);
    shader.setFloat(4, frequencies[1]);
    shader.setFloat(5, frequencies[2]);
    shader.setFloat(6, frequencies[3]);

    final paint = Paint()..shader = shader;
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant ShaderPainter oldDelegate) => true;
}