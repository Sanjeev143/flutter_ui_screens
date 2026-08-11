import 'package:flutter/material.dart';
import 'package:ui_screens_exmp/dashboards/wave_painter.dart';

class AnimatedWaveWidget extends StatefulWidget {
  final double amplitude;

  const AnimatedWaveWidget({
    super.key,
    required this.amplitude,
  });

  @override
  State<AnimatedWaveWidget> createState() =>
      _AnimatedWaveWidgetState();
}

class _AnimatedWaveWidgetState
    extends State<AnimatedWaveWidget>
    with SingleTickerProviderStateMixin {

  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {

        return CustomPaint(
          painter: WavePainter(
            animation: controller.value,
            amplitude: widget.amplitude,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}