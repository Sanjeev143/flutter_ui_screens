import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const EFTDashboardApp());
}

class EFTDashboardApp extends StatelessWidget {
  const EFTDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EFT Energy Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'sans-serif',
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF070B14),
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _lightningController;

  @override
  void initState() {
    super.initState();
    _lightningController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _lightningController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation Bar
            _buildTopNavBar(),
            const Divider(height: 1, color: Color(0xFF1E293B)),

            // Main Map & Bottom Dashboard Cards
            Expanded(
              child: Stack(
                children: [
                  // Interactive Map Background with Lightning/Pulse Animation
                  _buildMapBackground(),

                  // Bottom Cards Overlay
                  Positioned(
                    bottom: 24,
                    left: 24,
                    right: 24,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(flex: 4, child: _buildProductionByFuelSourceCard()),
                        const SizedBox(width: 16),
                        Expanded(flex: 3, child: _buildProductionVsConsumptionCard()),
                        const SizedBox(width: 16),
                        Expanded(flex: 4, child: _buildWeatherConditionsCard()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopNavBar() {
    final zipCodes = ['98104', '19105', '37206', '46207', '53708', '48209', '72201', '55112', '87112', '70113', '94102', '96815', '98122'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [Colors.blue.shade400, Colors.indigo.shade700]),
                ),
                child: const Text('EFT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 1)),
              ),
            ],
          ),
          Row(
            children: [
              _navButton(Icons.mail_outline, 'By zip code'),
              const SizedBox(width: 10),
              _navButton(Icons.location_on_outlined, 'By Address'),
            ],
          ),
          Expanded(
            child: SizedBox(
              height: 36,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: zipCodes.length,
                itemBuilder: (context, index) {
                  final zip = zipCodes[index];
                  final isSelected = zip == '72201';
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Text(
                            zip,
                            style: TextStyle(
                              color: isSelected ? const Color(0xFF38BDF8) : const Color(0xFF475569),
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              fontSize: 12,
                            ),
                          ),
                          if (isSelected) ...[
                            const SizedBox(width: 4),
                            Container(width: 5, height: 5, decoration: const BoxDecoration(color: Color(0xFF38BDF8), shape: BoxShape.circle)),
                          ]
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navButton(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A).withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF1E293B)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 13, color: const Color(0xFF94A3B8)),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFFCBD5E1))),
        ],
      ),
    );
  }

  Widget _buildMapBackground() {
    return AnimatedBuilder(
      animation: _lightningController,
      builder: (context, child) {
        return CustomPaint(
          painter: MapLightningPainter(progress: _lightningController.value),
          child: Container(),
        );
      },
    );
  }

  Widget _buildProductionByFuelSourceCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF0B1120).withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1E293B)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 16, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Production by fuel source', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: _fuelBanner('Renewable energy', '89.5 MWh', '+32%', const Color(0xFF10B981), Icons.eco)),
              const SizedBox(width: 10),
              Expanded(child: _fuelBanner('Fossile energy', '193.5 MWh', '/ 68%', const Color(0xFFEF4444), Icons.oil_barrel)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _fuelBarItem('Solar', '123 kWh', Colors.amber, Icons.wb_sunny),
              _fuelBarItem('Biomass', '345 kWh', Colors.teal, Icons.energy_savings_leaf),
              _fuelBarItem('Wind', '567 kWh', Colors.purple, Icons.air),
              _fuelBarItem('Hidro', '894 kWh', Colors.blue, Icons.water_drop),
            ],
          ),
        ],
      ),
    );
  }

  Widget _fuelBanner(String title, stringVal, String percentage, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF1F2937)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [Icon(icon, size: 13, color: color), const SizedBox(width: 5), Text(title, style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8)))]),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(stringVal, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white)),
              Text(percentage, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _fuelBarItem(String label, String value, Color color, IconData icon) {
    return Column(
      children: [
        Container(
          width: 38,
          height: 75,
          decoration: BoxDecoration(
            color: const Color(0xFF111827),
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 38,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [color, color.withOpacity(0.15)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Icon(icon, size: 13, color: color),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
        Text(value, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.white)),
      ],
    );
  }

  Widget _buildProductionVsConsumptionCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF0B1120).withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1E293B)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 16, offset: const Offset(0, 8))],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 105,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: const Size(180, 90),
                  painter: GaugeArcPainter(progress: 0.65),
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 18),
                    Text('MWh', style: TextStyle(fontSize: 10, color: Color(0xFF64748B))),
                  ],
                ),
                Positioned(
                  bottom: 8,
                  left: 10,
                  child: Column(
                    children: [
                      const Text('1.03', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFFFB800))),
                      const Text('Production', style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 10,
                  child: Column(
                    children: [
                      const Text('0.94', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF38BDF8))),
                      const Text('Consumption', style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Text('\$89.5', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      Text('M', style: TextStyle(fontSize: 12, color: Color(0xFF38BDF8))),
                      Icon(Icons.arrow_drop_up, color: Colors.red, size: 16),
                    ],
                  ),
                  const Text('Total Spends', style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Text('\$120.32', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      Icon(Icons.arrow_drop_up, color: Colors.red, size: 16),
                    ],
                  ),
                  const Text('Avg. spend per sqft', style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherConditionsCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF0B1120).withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF1E293B)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 16, offset: const Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.wb_cloudy_outlined, color: Color(0xFF38BDF8), size: 16),
                  SizedBox(width: 6),
                  Text('Weather conditions parameters', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white)),
                ],
              ),
              const Icon(Icons.close, size: 15, color: Color(0xFF64748B)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _weatherTab('Rain', true, Icons.water_drop)),
              const SizedBox(width: 8),
              Expanded(child: _weatherTab('Snow', false, Icons.ac_unit)),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _weatherIntensityBox('Light', '0.1 - 2.5 mm', false)),
              const SizedBox(width: 6),
              Expanded(child: _weatherIntensityBox('Moderate', '2.6 - 7.6 mm', false)),
              const SizedBox(width: 6),
              Expanded(child: _weatherIntensityBox('Heavy', '7.7 - 50 mm', true)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Wind Speed (mph)', style: TextStyle(fontSize: 10, color: Color(0xFF94A3B8))),
              Icon(Icons.info_outline, size: 13, color: Color(0xFF64748B)),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: const [
              Text('5', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
              SizedBox(width: 8),
              Expanded(
                child: LinearProgressIndicator(
                  value: 0.35,
                  backgroundColor: Color(0xFF111827),
                  color: Color(0xFF38BDF8),
                ),
              ),
              SizedBox(width: 8),
              Text('201+', style: TextStyle(fontSize: 11, color: Color(0xFF94A3B8))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _weatherTab(String label, bool active, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
        color: active ? const Color(0xFF1E293B) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: active ? const Color(0xFF334155) : Colors.transparent),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 13, color: active ? const Color(0xFF38BDF8) : const Color(0xFF64748B)),
          const SizedBox(width: 5),
          Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: active ? Colors.white : const Color(0xFF64748B))),
        ],
      ),
    );
  }

  Widget _weatherIntensityBox(String title, String subtitle, bool selected) {
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF1E293B) : const Color(0xFF070B14),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: selected ? const Color(0xFF38BDF8) : const Color(0xFF1E293B)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: selected ? Colors.white : const Color(0xFF94A3B8))),
              Icon(selected ? Icons.check_circle : Icons.radio_button_unchecked, size: 11, color: selected ? const Color(0xFF38BDF8) : const Color(0xFF64748B)),
            ],
          ),
          const SizedBox(height: 3),
          Text(subtitle, style: const TextStyle(fontSize: 8, color: Color(0xFF64748B))),
        ],
      ),
    );
  }
}

// Custom Painter rendering the glowing map pathways and animated lightning pillars
class MapLightningPainter extends CustomPainter {
  final double progress;
  MapLightningPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    // Dark background
    final paintBg = Paint()
      ..color = const Color(0xFF070B14)
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paintBg);

    // Subtle grid lines
    final gridPaint = Paint()
      ..color = const Color(0xFF1E293B).withOpacity(0.2)
      ..strokeWidth = 1;

    for (double i = 0; i < size.width; i += 50) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), gridPaint);
    }
    for (double i = 0; i < size.height; i += 50) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), gridPaint);
    }

    // Power transmission highways
    final linePaint = Paint()
      ..color = const Color(0xFFFFB800).withOpacity(0.4)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(size.width * 0.12, size.height * 0.28);
    path.lineTo(size.width * 0.25, size.height * 0.42);
    path.lineTo(size.width * 0.38, size.height * 0.35);
    path.lineTo(size.width * 0.48, size.height * 0.52);
    path.lineTo(size.width * 0.62, size.height * 0.3);
    path.lineTo(size.width * 0.78, size.height * 0.48);
    path.lineTo(size.width * 0.88, size.height * 0.35);
    canvas.drawPath(path, linePaint);

    // Clustered high-rise 3D data tower locations across the map center
    final towers = [
      Offset(size.width * 0.36, size.height * 0.32),
      Offset(size.width * 0.39, size.height * 0.34),
      Offset(size.width * 0.42, size.height * 0.30),
      Offset(size.width * 0.44, size.height * 0.36),
      Offset(size.width * 0.47, size.height * 0.33),
      Offset(size.width * 0.50, size.height * 0.38),
      Offset(size.width * 0.53, size.height * 0.35),
      Offset(size.width * 0.35, size.height * 0.42),
      Offset(size.width * 0.40, size.height * 0.45),
      Offset(size.width * 0.46, size.height * 0.44),
      Offset(size.width * 0.52, size.height * 0.42),
      Offset(size.width * 0.25, size.height * 0.45),
      Offset(size.width * 0.62, size.height * 0.32),
      Offset(size.width * 0.72, size.height * 0.50),
    ];

    for (int i = 0; i < towers.length; i++) {
      final pos = towers[i];
      final pulse = math.sin((progress * math.pi * 2) + (i * 0.5)).abs();

      // Glow effect
      final glowPaint = Paint()
        ..color = Colors.cyanAccent.withOpacity(0.2 + (0.4 * pulse))
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);

      // Tower bar color gradient
      final towerPaint = Paint()
        ..color = Color.lerp(Colors.blue.shade300, Colors.cyanAccent, pulse)!
        ..style = PaintingStyle.fill;

      canvas.drawCircle(pos, 10 + (4 * pulse), glowPaint);

      // Vertical 3D Bar representation
      final rect = Rect.fromCenter(
        center: pos,
        width: 7,
        height: 22 + (16 * pulse),
      );
      canvas.drawRRect(RRect.fromRectAndRadius(rect, const Radius.circular(2)), towerPaint);
    }
  }

  @override
  bool shouldRepaint(covariant MapLightningPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

// Custom Painter for Semi-Circle Gauge Arc
class GaugeArcPainter extends CustomPainter {
  final double progress;
  GaugeArcPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCircle(center: Offset(size.width / 2, size.height), radius: 75);

    final bgPaint = Paint()
      ..color = const Color(0xFF1E293B)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, math.pi, math.pi, false, bgPaint);

    final productionPaint = Paint()
      ..color = const Color(0xFFFFB800)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, math.pi, math.pi * progress, false, productionPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}