import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const SolarGridApp());
}

class SolarGridApp extends StatelessWidget {
  const SolarGridApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Solar Grid Monitor',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF090D16),
        primaryColor: const Color(0xFF10B981),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF10B981),
          surface: Color(0xFF121826),
        ),
      ),
      home: const SolarDashboardScreen(),
    );
  }
}

// ==========================================
// GLASSMORPHIC CONTAINER HELPER
// ==========================================
class GlassCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? borderColor;

  const GlassCard({
    super.key,
    required this.child,
    this.borderRadius = 24,
    this.padding,
    this.margin,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            padding: padding ?? const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: borderColor ?? Colors.white.withOpacity(0.12),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

// ==========================================
// MAIN DASHBOARD SCREEN
// ==========================================
class SolarDashboardScreen extends StatefulWidget {
  const SolarDashboardScreen({super.key});

  @override
  State<SolarDashboardScreen> createState() => _SolarDashboardScreenState();
}

class _SolarDashboardScreenState extends State<SolarDashboardScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _flowController;
  Timer? _chargingTimer;

  // Real-time Power Values
  final double solarProduction = 5.8; // kW (Generating)
  final double homeConsumption = 3.2; // kW (Consuming)
  final double gridExport = 2.6; // kW (Exporting surplus)

  // Dynamic Battery Buffer State (Starts at 0%)
  double batteryStoragePercent = 0.0;
  double accumulatedEnergyKw = 0.0;

  @override
  void initState() {
    super.initState();

    // 1. Particle Flow Animation Loop
    _flowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    // 2. Real-time Energy Accumulation Timer (Updates every 3 sec)
    _startLiveChargingSimulation();
  }

  void _startLiveChargingSimulation() {
    _chargingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (batteryStoragePercent < 100) {
          batteryStoragePercent += 1.0; // Charge +1% every 3 seconds
          accumulatedEnergyKw += 0.12; // Accumulate energy in kWh
        } else {
          // Reset loop when full
          batteryStoragePercent = 0.0;
          accumulatedEnergyKw = 0.0;
        }
      });
    });
  }

  @override
  void dispose() {
    _flowController.dispose();
    _chargingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Ambient Light Blobs for Glassmorphic Glow
          Positioned(
            top: -50,
            left: -40,
            child: Container(
              width: 250,
              height: 250,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFA855F7),
                boxShadow: [
                  BoxShadow(color: Color(0xFFA855F7), blurRadius: 180, spreadRadius: 40),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -60,
            right: -40,
            child: Container(
              width: 280,
              height: 280,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFA855F7),
                boxShadow: [
                  BoxShadow(color: Color(0xFFA855F7), blurRadius: 200, spreadRadius: 50),
                ],
              ),
            ),
          ),

          // Main Layout
          SafeArea(
            child: Column(
              children: [
                // Header Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Glassmorphic Power Grid',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'ENERGY NETWORK - AMAZEVALLEY',
                            style: TextStyle(
                              fontSize: 8,
                              letterSpacing: 1.5,
                              color: Colors.white38,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      GlassCard(
                        borderRadius: 20,
                        padding: const EdgeInsets.symmetric(horizontal: 6,
                            vertical: 6),
                        child: const Row(
                          children: [
                            CircleAvatar(
                              radius: 4,
                              backgroundColor: Color(0xFF10B981),
                            ),
                            SizedBox(width: 6),
                            Text(
                              'REALTIME CHARGING',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF10B981),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Main Scrollable Area
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        // 1. ANIMATED VECTOR POWER FLOW SCHEMATIC
                        GlassCard(
                          padding: const EdgeInsets.all(16),
                          child: SizedBox(
                            height: 380,
                            width: double.infinity,
                            child: AnimatedBuilder(
                              animation: _flowController,
                              builder: (context, child) {
                                return CustomPaint(
                                  painter: NamedPowerFlowPainter(
                                    progress: _flowController.value,
                                    batteryPercent: batteryStoragePercent,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // 2. METRIC SUMMARY CARDS GRID
                        GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                          childAspectRatio: 1.35,
                          children: [
                            _MetricCard(
                              title: 'Node 4: Battery Storage',
                              value: '${batteryStoragePercent.toInt()}%',
                              subtitle: batteryStoragePercent == 100
                                  ? 'Fully Charged'
                                  : 'Stored: ${accumulatedEnergyKw.toStringAsFixed(2)} kWh',
                              icon: batteryStoragePercent == 0
                                  ? Icons.battery_0_bar_outlined
                                  : Icons.battery_charging_full_outlined,
                              accentColor: const Color(0xFF10B981),
                            ),
                            _MetricCard(
                              title: 'Node 1: Solar Array',
                              value: '$solarProduction kW',
                              subtitle: 'Generating Power',
                              icon: Icons.wb_sunny_outlined,
                              accentColor: const Color(0xFFF59E0B),
                            ),
                            _MetricCard(
                              title: 'Node 3: Home Load',
                              value: '$homeConsumption kW',
                              subtitle: 'Consuming Power',
                              icon: Icons.home_outlined,
                              accentColor: const Color(0xFF3B82F6),
                            ),

                            _MetricCard(
                              title: 'Node 5: Utility Grid',
                              value: '$gridExport kW',
                              subtitle: 'Exporting Surplus',
                              icon: Icons.power_outlined,
                              accentColor: const Color(0xFFA855F7),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// VECTOR POWER FLOW CUSTOM PAINTER
// ==========================================
class NamedPowerFlowPainter extends CustomPainter {
  final double progress;
  final double batteryPercent;

  NamedPowerFlowPainter({
    required this.progress,
    required this.batteryPercent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;

    // Defined Node Coordinates
    final Offset hubPos = Offset(centerX, centerY);              // Node 2: Smart Hub
    final Offset solarPos = Offset(centerX, 50);                  // Node 1: Solar Array
    final Offset homePos = Offset(size.width - 55, centerY);     // Node 3: Home Load
    final Offset batteryPos = Offset(centerX, size.height - 55); // Node 4: Battery Storage
    final Offset gridPos = Offset(55, centerY);                  // Node 5: Utility Grid

    // 1. CONNECTOR PIPELINES
    final Paint linePaint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    canvas.drawLine(solarPos, hubPos, linePaint);
    canvas.drawLine(hubPos, homePos, linePaint);
    canvas.drawLine(hubPos, batteryPos, linePaint);
    canvas.drawLine(hubPos, gridPos, linePaint);

    // 2. FLOWING ENERGY PARTICLES
    _drawFlowParticles(canvas, solarPos, hubPos, const Color(0xFFF59E0B)); // Solar -> Hub
    _drawFlowParticles(canvas, hubPos, homePos, const Color(0xFF3B82F6));  // Hub -> Home
    _drawFlowParticles(canvas, hubPos, batteryPos, const Color(0xFF10B981)); // Hub -> Battery
    _drawFlowParticles(canvas, hubPos, gridPos, const Color(0xFFA855F7));  // Hub -> Grid

    // 3. DRAW ALL 5 NODES
    _drawNamedNode(canvas, hubPos, Icons.hub, const Color(0xFF9CA3AF),
        'Node 2: Central Hub', 'Smart Router');
    _drawNamedNode(canvas, solarPos, Icons.wb_sunny_rounded, const Color(0xFFF59E0B),
        'Node 1: Solar Array', 'Producer (5.8 kW)');
    _drawNamedNode(canvas, homePos, Icons.home_rounded, const Color(0xFF3B82F6),
        'Node 3: Home Load', 'Consumer (3.2 kW)');
    _drawNamedNode(canvas, batteryPos, Icons.battery_charging_full_rounded, const Color(0xFF10B981),
        'Node 4: Battery', 'Buffer (${batteryPercent.toInt()}%)');
    _drawNamedNode(canvas, gridPos, Icons.power_rounded, const Color(0xFFA855F7),
        'Node 5: Utility Grid', 'Export (2.6 kW)');
  }

  void _drawFlowParticles(Canvas canvas, Offset start, Offset end, Color color) {
    final Paint particlePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Paint glowPaint = Paint()
      ..color = color.withOpacity(0.4)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);

    for (int i = 0; i < 3; i++) {
      double t = (progress + (i / 3.0)) % 1.0;
      double x = start.dx + (end.dx - start.dx) * t;
      double y = start.dy + (end.dy - start.dy) * t;

      Offset particlePos = Offset(x, y);

      canvas.drawCircle(particlePos, 7, glowPaint);
      canvas.drawCircle(particlePos, 3.5, particlePaint);
    }
  }

  void _drawNamedNode(
      Canvas canvas,
      Offset center,
      IconData icon,
      Color color,
      String title,
      String subtitle,
      ) {
    // Outer Glow Ring
    final Paint glowRing = Paint()
      ..color = color.withOpacity(0.2)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 24, glowRing);

    // Inner Glass Node Circle
    final Paint nodeBg = Paint()
      ..color = const Color(0xFF1E293B).withOpacity(0.9)
      ..style = PaintingStyle.fill;
    final Paint nodeBorder = Paint()
      ..color = color.withOpacity(0.8)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, 20, nodeBg);
    canvas.drawCircle(center, 20, nodeBorder);

    // Icon Rendering
    TextPainter iconPainter = TextPainter(textDirection: TextDirection.ltr);
    iconPainter.text = TextSpan(
      text: String.fromCharCode(icon.codePoint),
      style: TextStyle(
        fontSize: 18,
        fontFamily: icon.fontFamily,
        package: icon.fontPackage,
        color: color,
      ),
    );
    iconPainter.layout();
    iconPainter.paint(
      canvas,
      Offset(center.dx - iconPainter.width / 2, center.dy - iconPainter.height / 2),
    );

    // Title Text
    TextPainter titlePainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    titlePainter.text = TextSpan(
      text: title,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
    titlePainter.layout();
    titlePainter.paint(
      canvas,
      Offset(center.dx - titlePainter.width / 2, center.dy + 26),
    );

    // Subtitle Text
    TextPainter subPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    subPainter.text = TextSpan(
      text: subtitle,
      style: TextStyle(
        fontSize: 9,
        color: color.withOpacity(0.9),
        fontWeight: FontWeight.w500,
      ),
    );
    subPainter.layout();
    subPainter.paint(
      canvas,
      Offset(center.dx - subPainter.width / 2, center.dy + 38),
    );
  }

  @override
  bool shouldRepaint(covariant NamedPowerFlowPainter oldDelegate) => true;
}

// ==========================================
// REUSABLE METRIC CARD WIDGET
// ==========================================
class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color accentColor;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(14),
      borderColor: accentColor.withOpacity(0.25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white54,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(icon, size: 16, color: accentColor),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 9,
                  color: accentColor.withOpacity(0.9),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}