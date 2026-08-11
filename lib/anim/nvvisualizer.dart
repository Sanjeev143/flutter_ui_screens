import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';

void main() => runApp(const NNVisualizerApp());

class NNVisualizerApp extends StatelessWidget {
  const NNVisualizerApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0E1A),
      ),
      home: const NNVisualizerScreen(),
    );
  }
}

class NNVisualizerScreen extends StatefulWidget {
  const NNVisualizerScreen({super.key});
  @override
  State<NNVisualizerScreen> createState() => _NNVisualizerScreenState();
}

class _NNVisualizerScreenState extends State<NNVisualizerScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _dataFlowController;

  // Neural network architecture: [input, hidden1, hidden2, output]
  final List<int> layers = [4, 6, 5, 3];
  final Random random = Random();

  @override
  void initState() {
    super.initState();

    // Controls neuron pulsing
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    // Controls data flowing through connections
    _dataFlowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    _dataFlowController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _dataFlowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Neural Network Visualizer by Amazevalley"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              // Animated background gradient
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF0A0E1A),
                      const Color(0xFF1A1F2E),
                    ],
                  ),
                ),
              ),

              // Main visualization
              Center(
                child: AnimatedBuilder(
                  animation: Listenable.merge([_pulseController, _dataFlowController]),
                  builder: (context, _) {
                    return CustomPaint(
                      size: Size(constraints.maxWidth, constraints.maxHeight * 0.7),
                      painter: NeuralNetworkPainter(
                        layers: layers,
                        pulseValue: _pulseController.value,
                        flowValue: _dataFlowController.value,
                      ),
                    );
                  },
                ),
              ),

              // Info panel
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: _InfoPanel(layers: layers),
              )
            ],
          );
        },
      ),
    );
  }
}

class NeuralNetworkPainter extends CustomPainter {
  final List<int> layers;
  final double pulseValue;
  final double flowValue;
  final Random random = Random();

  NeuralNetworkPainter({
    required this.layers,
    required this.pulseValue,
    required this.flowValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final layerSpacing = size.width / (layers.length + 1);
    final List<List<Offset>> neuronPositions = [];

    // 1. Calculate neuron positions for each layer
    for (int i = 0; i < layers.length; i++) {
      List<Offset> layer = [];
      final neuronCount = layers[i];
      final neuronSpacing = size.height / (neuronCount + 1);

      for (int j = 0; j < neuronCount; j++) {
        layer.add(Offset(
          layerSpacing * (i + 1),
          neuronSpacing * (j + 1),
        ));
      }
      neuronPositions.add(layer);
    }

    // 2. Draw connections with animated data flow
    final connectionPaint = Paint()
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < neuronPositions.length - 1; i++) {
      for (var start in neuronPositions[i]) {
        for (var end in neuronPositions[i + 1]) {
          // Gradient connection line
          final gradient = LinearGradient(
            colors: [
              Colors.cyan.withOpacity(0.2),
              Colors.purple.withOpacity(0.2),
            ],
          );
          connectionPaint.shader = gradient.createShader(
            Rect.fromPoints(start, end),
          );
          canvas.drawLine(start, end, connectionPaint);

          // Animated data packet
          final progress = (flowValue + random.nextDouble() * 0.3) % 1.0;
          final dataX = lerpDouble(start.dx, end.dx, progress)!;
          final dataY = lerpDouble(start.dy, end.dy, progress)!;

          final dataPaint = Paint()
            ..color = Colors.cyanAccent.withOpacity(0.8)
            ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

          canvas.drawCircle(Offset(dataX, dataY), 3, dataPaint);
        }
      }
    }

    // 3. Draw neurons with pulse animation
    for (int i = 0; i < neuronPositions.length; i++) {
      for (int j = 0; j < neuronPositions[i].length; j++) {
        final pos = neuronPositions[i][j];

        // Glow effect
        final glowPaint = Paint()
          ..color = Colors.cyan.withOpacity(0.3 * pulseValue)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);

        // Neuron body
        final neuronPaint = Paint()
          ..shader = RadialGradient(
            colors: [Colors.cyanAccent, Colors.blue.shade700],
          ).createShader(Rect.fromCircle(center: pos, radius: 20));

        final radius = 12 + pulseValue * 3;

        canvas.drawCircle(pos, radius + 10, glowPaint);
        canvas.drawCircle(pos, radius, neuronPaint);

        // Activation indicator
        final activationPaint = Paint()
          ..color = Colors.white.withOpacity(0.5 + pulseValue * 0.5);
        canvas.drawCircle(pos, radius * 0.4, activationPaint);
      }
    }

    // 4. Layer labels
    final textStyle = TextStyle(color: Colors.white70, fontSize: 14);
    final layerNames = ["Input", "Hidden 1", "Hidden 2", "Output"];

    for (int i = 0; i < neuronPositions.length; i++) {
      final x = layerSpacing * (i + 1);
      final textPainter = TextPainter(
        text: TextSpan(text: layerNames[i], style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();

      textPainter.paint(canvas, Offset(x - textPainter.width / 2, 20));

      // Neuron count
      final countPainter = TextPainter(
        text: TextSpan(text: "${layers[i]} neurons", style: textStyle.copyWith(fontSize: 12)),
        textDirection: TextDirection.ltr,
      )..layout();
      countPainter.paint(canvas, Offset(x - countPainter.width / 2, size.height - 30));
    }
  }

  @override
  bool shouldRepaint(covariant NeuralNetworkPainter oldDelegate) =>
      oldDelegate.pulseValue!= pulseValue || oldDelegate.flowValue!= flowValue;
}

class _InfoPanel extends StatelessWidget {
  final List<int> layers;
  const _InfoPanel({required this.layers});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.cyan.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _infoItem("Architecture", "${layers.join(' → ')}"),
          _infoItem("Total Neurons", "${layers.reduce((a, b) => a + b)}"),
          _infoItem("Status", "Training..."),
        ],
      ),
    );
  }

  Widget _infoItem(String label, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.cyanAccent, fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }
}