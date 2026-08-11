import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const FuturisticDashboard());
}

class FuturisticDashboard extends StatelessWidget {
  const FuturisticDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with TickerProviderStateMixin {
  late final AnimationController ambientController;
  late final AnimationController pulseController;
  late final AnimationController roadController;
  late final AnimationController reflectionController;

  @override
  void initState() {
    super.initState();

    ambientController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();

    pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    roadController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    reflectionController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();
  }

  @override
  void dispose() {
    ambientController.dispose();
    pulseController.dispose();
    roadController.dispose();
    reflectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        ambientController,
        pulseController,
        roadController,
        reflectionController,
      ]),
      builder: (_, __) {
        return Scaffold(
          backgroundColor: const Color(0xff05070D),
          body: Stack(
            children: [
              CustomPaint(
                size: Size.infinite,
                painter: BackgroundPainter(
                  ambientController.value,
                ),
              ),
              CustomPaint(
                size: Size.infinite,
                painter: AmbientGlowPainter(
                  pulseController.value,
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      buildTopBar(),
                      const SizedBox(height: 20),
                      Expanded(
                        child: buildDashboardFrame(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildTopBar() {
    return Row(
      children: [
        const Icon(Icons.arrow_back_ios,
            color: Colors.white70),
        const Spacer(),
        Text(
          "Driving Assistant",
          style: TextStyle(
            color: Colors.white.withOpacity(.9),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        const Spacer(),
        const Icon(Icons.settings,
            color: Colors.white70),
      ],
    );
  }

  Widget buildDashboardFrame() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(45),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 20,
          sigmaY: 20,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.05),
            borderRadius: BorderRadius.circular(45),
            border: Border.all(
              color: Colors.white.withOpacity(.10),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple.withOpacity(.20),
                blurRadius: 40,
                spreadRadius: 3,
              )
            ],
          ),
          child: Stack(
            children: [
              CustomPaint(
                size: Size.infinite,
                painter: DashboardFramePainter(),
              ),
              CustomPaint(
                size: Size.infinite,
                painter: ReflectionPainter(
                  reflectionController.value,
                ),
              ),

              Positioned.fill(
                child: CustomPaint(
                  painter: RoadPainter(roadController.value),
                ),
              ),

              Positioned.fill(
                child: CustomPaint(
                  painter: NavigationGridPainter(
                    roadController.value,
                  ),
                ),
              ),

              Positioned.fill(
                child: CustomPaint(
                  painter: CarPainter(
                    pulseController.value,
                  ),
                ),
              ),

              Positioned.fill(
                child: CustomPaint(
                  painter: GlassReflectionPainter(
                    reflectionController.value,
                  ),
                ),
              ),

              Positioned.fill(
                child: CustomPaint(
                  painter: DashboardGlowPainter(
                    pulseController.value,
                  ),
                ),
              ),

              Positioned(
                bottom: 18,
                left: 30,
                right: 30,
                child: BottomHud(
                  pulse: pulseController.value,
                ),
              ),

              Positioned.fill(
                child: CustomPaint(
                  painter: HeadlightPainter(pulseController.value),
                ),
              ),

              Positioned.fill(
                child: CustomPaint(
                  painter: CarAheadPainter(),
                ),
              ),

              Positioned(
                left: 40,
                bottom: 120,
                child: SpeedLimitWidget(),
              ),
              Positioned(
                left: 25,
                top: 35,
                child: SpeedPanel(
                  speed: 82,
                ),
              ),

              Positioned(
                right: 25,
                top: 35,
                child: BatteryPanel(
                  battery: 75,
                ),
              ),

              Positioned(
                left: 35,
                bottom: 30,
                child: GearPanel(),
              ),

              Positioned(
                top: 18,
                left: 150,
                right: 150,
                child: TopHud(),
              ),

              // Positioned(
              //   left: 30,
              //   top: 180,
              //   child: LightStatus(),
              // ),

              Positioned(
                left: 25,
                top: 150,
                child: SizedBox(
                  width: 50,
                  height: 160,
                  child: CustomPaint(
                    painter: IndicatorPainter(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  final double t;

  BackgroundPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff0A1020),
            Color(0xff04060B),
          ],
        ).createShader(rect),
    );

    drawBlob(
      canvas,
      size,
      Offset(size.width * .20, size.height * .20),
      260,
      Colors.deepPurpleAccent,
    );

    drawBlob(
      canvas,
      size,
      Offset(size.width * .90, size.height * .30),
      240,
      Colors.blueAccent,
    );

    drawBlob(
      canvas,
      size,
      Offset(size.width * .60, size.height * .90),
      300,
      Colors.purple,
    );
  }

  void drawBlob(
      Canvas canvas,
      Size size,
      Offset center,
      double radius,
      Color color,
      ) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          color.withOpacity(.25),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(
          center: center,
          radius: radius,
        ),
      );

    canvas.drawCircle(
      center,
      radius,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class AmbientGlowPainter extends CustomPainter {
  final double t;

  AmbientGlowPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final glow = Paint()
      ..maskFilter =
      const MaskFilter.blur(BlurStyle.normal, 80);

    glow.color =
        Colors.purple.withOpacity(.10 + .08 * t);

    canvas.drawCircle(
      Offset(size.width * .5, size.height * .5),
      300,
      glow,
    );
  }

  @override
  bool shouldRepaint(covariant AmbientGlowPainter oldDelegate) => true;
}

class DashboardFramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Colors.white.withOpacity(.08);

    final path = Path();

    path.moveTo(35, 40);

    path.quadraticBezierTo(
      size.width / 2,
      0,
      size.width - 35,
      40,
    );

    path.lineTo(size.width - 10, size.height - 40);

    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      10,
      size.height - 40,
    );

    path.close();

    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class ReflectionPainter extends CustomPainter {
  final double t;

  ReflectionPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.white.withOpacity(.10),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(
            size.width * (.2 + .6 * t),
            -40,
          ),
          radius: 220,
        ),
      );

    canvas.drawOval(
      Rect.fromLTWH(
        0,
        -100,
        size.width,
        220,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(
      covariant ReflectionPainter oldDelegate) =>
      true;
}

class RoadPainter extends CustomPainter {
  final double t;

  RoadPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {

    final roadPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xff22252B),
          Color(0xff0B0C10),
        ],
      ).createShader(
        Rect.fromLTWH(
          size.width * .30,
          size.height * .25,
          size.width * .40,
          size.height,
        ),
      );

    final road = Path();

    road.moveTo(size.width * .44, size.height * .28);
    road.lineTo(size.width * .56, size.height * .28);

    road.lineTo(size.width * .78, size.height);

    road.lineTo(size.width * .22, size.height);

    road.close();

    canvas.drawPath(road, roadPaint);

    final lanePaint = Paint()
      ..color = Colors.white70
      ..strokeWidth = 3;

    for (int i = 0; i < 18; i++) {

      double y = size.height - ((i * 70 + t * 500) % size.height);

      double width = (size.height - y) / 12;

      canvas.drawLine(
        Offset(size.width / 2, y),
        Offset(size.width / 2, y - width),
        lanePaint,
      );
    }

    final edge = Paint()
      ..color = Colors.cyanAccent.withOpacity(.35)
      ..strokeWidth = 2;

    canvas.drawLine(
      Offset(size.width * .44, size.height * .28),
      Offset(size.width * .22, size.height),
      edge,
    );

    canvas.drawLine(
      Offset(size.width * .56, size.height * .28),
      Offset(size.width * .78, size.height),
      edge,
    );
  }

  @override
  bool shouldRepaint(RoadPainter oldDelegate) => true;
}

class HeadlightPainter extends CustomPainter {

  final double t;

  HeadlightPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {

    final beam = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.blue.withOpacity(.22 + .08 * t),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(
            size.width * .5,
            size.height * .72,
          ),
          radius: 260,
        ),
      );

    final left = Path();

    left.moveTo(size.width * .48, size.height * .70);
    left.lineTo(size.width * .15, size.height);
    left.lineTo(size.width * .34, size.height);
    left.close();

    canvas.drawPath(left, beam);

    final right = Path();

    right.moveTo(size.width * .52, size.height * .70);
    right.lineTo(size.width * .85, size.height);
    right.lineTo(size.width * .66, size.height);
    right.close();

    canvas.drawPath(right, beam);
  }

  @override
  bool shouldRepaint(HeadlightPainter oldDelegate) => true;
}

class CarAheadPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {

    final body = Paint()
      ..color = Colors.white;

    final glow = Paint()
      ..color = Colors.white.withOpacity(.18)
      ..maskFilter =
      const MaskFilter.blur(BlurStyle.normal, 15);

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(
          size.width / 2,
          size.height * .42,
        ),
        width: 65,
        height: 25,
      ),
      glow,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(
            size.width / 2,
            size.height * .42,
          ),
          width: 42,
          height: 18,
        ),
        const Radius.circular(5),
      ),
      body,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class SpeedLimitWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Container(

      width: 82,

      height: 100,

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(18),

        border: Border.all(
          color: Colors.red,
          width: 5,
        ),

      ),

      child: const Column(

        mainAxisAlignment:
        MainAxisAlignment.center,

        children: [

          Text(
            "90",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 34,
            ),
          ),

          Divider(),

          Text("LIMIT"),

        ],
      ),
    );
  }
}

class SpeedPanel extends StatelessWidget {
  final int speed;

  const SpeedPanel({
    super.key,
    required this.speed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.35),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.cyanAccent.withOpacity(.25),
        ),
      ),
      child: Column(
        children: [
          Text(
            "$speed",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 54,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "KM/H",
            style: TextStyle(
              color: Colors.white70,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}

class BatteryPanel extends StatelessWidget {
  final int battery;

  const BatteryPanel({
    super.key,
    required this.battery,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.35),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [

          const Icon(
            Icons.battery_charging_full,
            color: Colors.greenAccent,
            size: 40,
          ),

          const SizedBox(height: 10),

          Text(
            "$battery %",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: battery / 100,
              minHeight: 8,
              backgroundColor: Colors.white12,
              color: Colors.greenAccent,
            ),
          ),
        ],
      ),
    );
  }
}

class GearPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.40),
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [

          Text("P",
              style: TextStyle(
                  color: Colors.white54,
                  fontSize: 22)),

          Text("R",
              style: TextStyle(
                  color: Colors.white54,
                  fontSize: 22)),

          Text("N",
              style: TextStyle(
                  color: Colors.white54,
                  fontSize: 22)),

          Text(
            "D",
            style: TextStyle(
              color: Colors.greenAccent,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}

class TopHud extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
      MainAxisAlignment.spaceEvenly,
      children: const [

        Icon(
          Icons.gps_fixed,
          color: Colors.cyanAccent,
        ),

        Icon(
          Icons.wifi,
          color: Colors.white70,
        ),

        Icon(
          Icons.bluetooth,
          color: Colors.white70,
        ),

        Icon(
          Icons.network_cell,
          color: Colors.greenAccent,
        ),
      ],
    );
  }
}

class LightStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Icon(
          Icons.light_mode,
          color: Colors.amber.shade300,
          size: 30,
        ),

        const SizedBox(height: 18),

        const Icon(
          Icons.foggy,
          color: Colors.white70,
          size: 28,
        ),

        const SizedBox(height: 18),

        const Icon(
          Icons.warning_amber,
          color: Colors.orange,
          size: 28,
        ),
      ],
    );
  }
}

class NavigationGridPainter extends CustomPainter {
  final double t;

  NavigationGridPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.cyanAccent.withOpacity(.10)
      ..strokeWidth = 1;

    const rows = 18;
    const cols = 10;

    final topY = size.height * .28;
    final bottomY = size.height * .95;

    for (int r = 0; r <= rows; r++) {
      final p = r / rows;

      final y = lerpDouble(topY, bottomY, p)!;

      final left = lerpDouble(
        size.width * .47,
        size.width * .18,
        p,
      )!;

      final right = lerpDouble(
        size.width * .53,
        size.width * .82,
        p,
      )!;

      canvas.drawLine(
        Offset(left, y),
        Offset(right, y),
        paint,
      );
    }

    for (int c = 0; c <= cols; c++) {
      final x = c / cols;

      final top = Offset(
        lerpDouble(
          size.width * .47,
          size.width * .53,
          x,
        )!,
        topY,
      );

      final bottom = Offset(
        lerpDouble(
          size.width * .18,
          size.width * .82,
          x,
        )!,
        bottomY,
      );

      canvas.drawLine(top, bottom, paint);
    }

    final route = Paint()
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..shader = const LinearGradient(
        colors: [
          Colors.blue,
          Colors.cyanAccent,
        ],
      ).createShader(
        Rect.fromLTWH(
          0,
          0,
          size.width,
          size.height,
        ),
      );

    final path = Path();

    path.moveTo(
      size.width * .50,
      bottomY,
    );

    path.quadraticBezierTo(
      size.width * (.48 + .04 * sin(t * pi * 2)),
      size.height * .65,
      size.width * .52,
      size.height * .40,
    );

    canvas.drawPath(path, route);
  }

  @override
  bool shouldRepaint(covariant NavigationGridPainter oldDelegate) => true;
}

class CarPainter extends CustomPainter {
  final double pulse;

  CarPainter(this.pulse);

  @override
  void paint(Canvas canvas, Size size) {
    final shadow = Paint()
      ..color = Colors.cyanAccent.withOpacity(.15)
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        18,
      );

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(
          size.width * .5,
          size.height * .72,
        ),
        width: 120,
        height: 26,
      ),
      shadow,
    );

    final body = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xffF5F5F5),
          Color(0xffBDBDBD),
        ],
      ).createShader(
        Rect.fromLTWH(0, 0, 120, 40),
      );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(
            size.width * .5,
            size.height * .67,
          ),
          width: 86,
          height: 28,
        ),
        const Radius.circular(10),
      ),
      body,
    );

    final light = Paint()
      ..color = Colors.redAccent.withOpacity(
        .5 + .4 * pulse,
      );

    canvas.drawCircle(
      Offset(
        size.width * .47,
        size.height * .67,
      ),
      3,
      light,
    );

    canvas.drawCircle(
      Offset(
        size.width * .53,
        size.height * .67,
      ),
      3,
      light,
    );
  }

  @override
  bool shouldRepaint(covariant CarPainter oldDelegate) => true;
}

class GlassReflectionPainter extends CustomPainter {
  final double t;

  GlassReflectionPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final shader = RadialGradient(
      colors: [
        Colors.white.withOpacity(.10),
        Colors.transparent,
      ],
    ).createShader(
      Rect.fromCircle(
        center: Offset(
          size.width * (.15 + .70 * t),
          20,
        ),
        radius: 220,
      ),
    );

    final paint = Paint()..shader = shader;

    final path = Path();

    path.moveTo(40, 30);

    path.quadraticBezierTo(
      size.width / 2,
      -50,
      size.width - 40,
      30,
    );

    path.lineTo(size.width - 40, 120);

    path.quadraticBezierTo(
      size.width / 2,
      60,
      40,
      120,
    );

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(
      covariant GlassReflectionPainter oldDelegate) {
    return true;
  }
}

class DashboardGlowPainter extends CustomPainter {

  final double pulse;

  DashboardGlowPainter(this.pulse);

  @override
  void paint(Canvas canvas, Size size) {

    final border = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..shader = LinearGradient(
        colors: [

          Colors.deepPurple.withOpacity(.9),

          Colors.cyanAccent.withOpacity(
            .5 + pulse * .4,
          ),

          Colors.deepPurple.withOpacity(.9),

        ],
      ).createShader(
        Offset.zero & size,
      );

    final glow = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..shader = border.shader
      ..maskFilter =
      const MaskFilter.blur(
        BlurStyle.normal,
        18,
      );

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        10,
        10,
        size.width - 20,
        size.height - 20,
      ),
      const Radius.circular(42),
    );

    canvas.drawRRect(rect, glow);
    canvas.drawRRect(rect, border);

    final ambient = Paint()
      ..shader = RadialGradient(
        colors: [
          Colors.purple.withOpacity(
            .10 + pulse * .05,
          ),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromCircle(
          center: Offset(
            size.width / 2,
            size.height * .45,
          ),
          radius: 350,
        ),
      );

    canvas.drawCircle(
      Offset(
        size.width / 2,
        size.height * .45,
      ),
      350,
      ambient,
    );
  }

  @override
  bool shouldRepaint(
      DashboardGlowPainter oldDelegate) =>
      true;
}

class BottomHud extends StatelessWidget {

  final double pulse;

  const BottomHud({
    super.key,
    required this.pulse,
  });

  @override
  Widget build(BuildContext context) {

    return ClipRRect(

      borderRadius:
      BorderRadius.circular(30),

      child: BackdropFilter(

        filter: ImageFilter.blur(
          sigmaX: 18,
          sigmaY: 18,
        ),

        child: Container(

          height: 90,

          decoration: BoxDecoration(

            color: Colors.white.withOpacity(.06),

            borderRadius:
            BorderRadius.circular(30),

            border: Border.all(
              color:
              Colors.white.withOpacity(.08),
            ),
          ),

          child: Padding(

            padding:
            const EdgeInsets.symmetric(
              horizontal: 25,
            ),

            child: Row(

              children: [

                _info(
                  "TRIP A",
                  "182.4 km",
                ),

                const Spacer(),

                _gear(),

                const Spacer(),

                _info(
                  "SPORT",
                  "70994 km",
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _info(
      String title,
      String value,
      ) {

    return Column(

      mainAxisAlignment:
      MainAxisAlignment.center,

      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [

        Text(
          title,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 12,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _gear() {

    return Row(

      children: [

        _letter("P", false),

        _letter("R", false),

        _letter("N", false),

        _letter("D", true),

      ],
    );
  }

  Widget _letter(
      String text,
      bool active,
      ) {

    return AnimatedContainer(

      duration:
      const Duration(milliseconds:300),

      margin:
      const EdgeInsets.symmetric(
        horizontal: 5,
      ),

      width: 38,

      height: 38,

      decoration: BoxDecoration(

        shape: BoxShape.circle,

        color: active
            ? Colors.cyanAccent
            .withOpacity(.20)
            : Colors.transparent,

      ),

      child: Center(

        child: Text(

          text,

          style: TextStyle(

            color: active
                ? Colors.cyanAccent
                : Colors.white54,

            fontWeight: FontWeight.bold,

          ),
        ),
      ),
    );
  }
}

class IndicatorPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {

    final yellow = Paint()
      ..color = Colors.amber;

    final white = Paint()
      ..color = Colors.white70;

    for(int i=0;i<3;i++){

      final y=25+i*45;

      canvas.drawCircle(
        Offset(25,y.toDouble()),
        10,
        i==0?yellow:white,
      );

      canvas.drawArc(

        Rect.fromCircle(
          center: Offset(25,y.toDouble()),
          radius:18,
        ),

        -.5,

        1,

        false,

        Paint()

          ..color=(i==0)
              ?Colors.amber
              :Colors.white54

          ..strokeWidth=2

          ..style=PaintingStyle.stroke,

      );

    }

  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate)=>false;

}

