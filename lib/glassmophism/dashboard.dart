import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const LeadsDashboardApp());
}

class LeadsDashboardApp extends StatelessWidget {
  const LeadsDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leads Overview Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F0F11),
        colorScheme: const ColorScheme.dark(
          surface: Color(0xFF1B1B1E),
          primary: Color(0xFF7047EB),
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141417),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28.0),
            child: Container(
              color: const Color(0xFF1B1B1E),
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Navigation Top Bar
                    const TopNavHeader(),
                    const SizedBox(height: 20),

                    // 2. Title & Global Controls
                    const LeadsTitleHeader(),
                    const SizedBox(height: 20),

                    // 3. Top Row Charts
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 3, child: ConversionAreaChartCard()),
                        SizedBox(width: 16),
                        Expanded(flex: 2, child: LeadsStackedBarChartCard()),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // 4. Bottom Row Charts
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 3, child: ConversionPillBarCard()),
                        SizedBox(width: 16),
                        Expanded(flex: 2, child: LeadsProgressBreakdownCard()),
                        SizedBox(width: 16),
                        Expanded(flex: 3, child: LeadsDonutChartCard()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 1. NAVIGATION HEADER
// ==========================================
class TopNavHeader extends StatelessWidget {
  const TopNavHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // App Asterisk Logo Icon
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.ac_unit, color: Colors.black, size: 20),
        ),
        const Spacer(),

        // Pill Navigation Chips
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFF26262A),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              _buildNavPill('Dashboard', isSelected: true),
              _buildNavPill('Calendar'),
              _buildNavPill('Messages'),
              _buildNavPill('Resources'),
            ],
          ),
        ),
        const Spacer(),

        // Action Icons & Profile
        _buildIconAction(Icons.settings_outlined),
        const SizedBox(width: 10),
        _buildIconAction(Icons.notifications_none),
        const SizedBox(width: 12),
        const CircleAvatar(
          radius: 18,
          backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=11'),
        ),
      ],
    );
  }

  Widget _buildNavPill(String title, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.black : Colors.white70,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildIconAction(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF26262A),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white12),
      ),
      child: Icon(icon, color: Colors.white70, size: 18),
    );
  }
}

// ==========================================
// 2. LEADS TITLE HEADER
// ==========================================
class LeadsTitleHeader extends StatelessWidget {
  const LeadsTitleHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Text(
              'Leads overview',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(width: 16),
            _buildDateChip('Jun, 6, 2026'),
          ],
        ),
        Row(
          children: [
            const Text('Choose platform: ', style: TextStyle(color: Colors.white38, fontSize: 12)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF26262A),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white12),
              ),
              child: const Row(
                children: [
                  Icon(Icons.all_inclusive, color: Color(0xFF0084FF), size: 18),
                  SizedBox(width: 6),
                  Text('Meta', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                  SizedBox(width: 4),
                  Icon(Icons.keyboard_arrow_down, color: Colors.white54, size: 16),
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  static Widget _buildDateChip(String dateStr) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF26262A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        children: [
          const Icon(Icons.calendar_today_outlined, color: Colors.white54, size: 13),
          const SizedBox(width: 6),
          Text(dateStr, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }
}

// ==========================================
// 3. TOP-LEFT: CONVERSION AREA CHART CARD
// ==========================================
class ConversionAreaChartCard extends StatelessWidget {
  const ConversionAreaChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildCardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Conversion', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              LeadsTitleHeader._buildDateChip('Jun, 6, 2026'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildStatValue('Revenue', '\$ 33, 846', Colors.greenAccent, isUp: true),
              const SizedBox(width: 24),
              _buildStatValue('Expenses', '\$ 21, 124', Colors.orangeAccent, isUp: false),
              const SizedBox(width: 24),
              _buildStatValue('Total revenue', '\$ 13, 846', Colors.greenAccent, isUp: true),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 160,
            width: double.infinity,
            child: CustomPaint(painter: SmoothAreaLineChartPainter()),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('0', style: TextStyle(color: Colors.white38, fontSize: 11)),
              Text('Jan', style: TextStyle(color: Colors.white38, fontSize: 11)),
              Text('Feb', style: TextStyle(color: Colors.white38, fontSize: 11)),
              Text('Mar', style: TextStyle(color: Colors.white38, fontSize: 11)),
              Text('Apr', style: TextStyle(color: Colors.white38, fontSize: 11)),
              Text('May', style: TextStyle(color: Colors.white38, fontSize: 11)),
              PillMonthTag('Jun'),
              Text('Jul', style: TextStyle(color: Colors.white38, fontSize: 11)),
              Text('Aug', style: TextStyle(color: Colors.white38, fontSize: 11)),
              Text('Sep', style: TextStyle(color: Colors.white38, fontSize: 11)),
              Text('Oct', style: TextStyle(color: Colors.white38, fontSize: 11)),
              Text('Nov', style: TextStyle(color: Colors.white38, fontSize: 11)),
              Text('Dec', style: TextStyle(color: Colors.white38, fontSize: 11)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStatValue(String label, String value, Color indicatorColor, {required bool isUp}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 11)),
        const SizedBox(height: 4),
        Row(
          children: [
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(width: 6),
            Icon(isUp ? Icons.arrow_drop_up : Icons.arrow_drop_down, color: indicatorColor, size: 20),
          ],
        )
      ],
    );
  }
}

// Custom Area Chart Painter
class SmoothAreaLineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final strokePaint = Paint()
      ..color = const Color(0xFF6E3AFF)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [const Color(0xFF6E3AFF).withOpacity(0.3), Colors.transparent],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();
    path.moveTo(0, size.height * 0.8);
    path.quadraticBezierTo(size.width * 0.15, size.height * 0.5, size.width * 0.3, size.height * 0.65);
    path.quadraticBezierTo(size.width * 0.45, size.height * 0.3, size.width * 0.6, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.1, size.width * 0.85, size.height * 0.35);
    path.quadraticBezierTo(size.width * 0.92, size.height * 0.4, size.width, size.height * 0.3);

    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ==========================================
// 4. TOP-RIGHT: LEADS STACKED BAR CHART
// ==========================================
class LeadsStackedBarChartCard extends StatelessWidget {
  const LeadsStackedBarChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildCardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Leads', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              LeadsTitleHeader._buildDateChip('Jun, 6, 2026'),
            ],
          ),
          const SizedBox(height: 24),

          // Stacked Bars Row
          SizedBox(
            height: 160,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildStackedBar(0.5, 0.4, 'Mon'),
                _buildStackedBar(0.7, 0.2, 'Tue'),
                _buildStackedBar(0.6, 0.3, 'Wed'),
                _buildStackedBar(0.4, 0.2, 'Thu'),
                _buildStackedBar(0.5, 0.3, 'Fri'),
                _buildStackedBar(0.7, 0.2, 'Sat'),
                _buildStackedBar(0.6, 0.3, 'Sun'),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Bottom Action Link
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(color: const Color(0xFF28282D), borderRadius: BorderRadius.circular(16)),
            child: const Row(
              children: [
                Icon(Icons.hub_outlined, color: Colors.orangeAccent, size: 16),
                SizedBox(width: 8),
                Text('Leads overview', style: TextStyle(color: Colors.white70, fontSize: 12)),
                Spacer(),
                Text('Details', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStackedBar(double flex1, double flex2, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 22,
          height: 120,
          decoration: BoxDecoration(color: const Color(0xFF28282E), borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              Spacer(flex: (10 - (flex1 * 10)).toInt()),
              Container(
                width: 22,
                height: 120 * flex2,
                decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(12)),
              ),
              Container(
                width: 22,
                height: 120 * flex1,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Colors.orange, Colors.deepOrange]),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 11)),
      ],
    );
  }
}

// ==========================================
// 5. BOTTOM-LEFT: CONVERSION PILL BAR CARD
// ==========================================
class ConversionPillBarCard extends StatelessWidget {
  const ConversionPillBarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildCardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Conversion', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              LeadsTitleHeader._buildDateChip('Jun, 6, 2026'),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildPillColumn('24%', 0.3, 0.4, Colors.deepOrange),
              _buildPillColumn('56%', 0.5, 0.3, const Color(0xFF6E3AFF)),
              _buildPillColumn('26%', 0.2, 0.2, Colors.deepOrange),
              _buildPillColumn('44%', 0.4, 0.4, Colors.deepOrange),
              _buildPillColumn('48%', 0.3, 0.3, const Color(0xFF6E3AFF)),
              _buildPillColumn('43%', 0.3, 0.2, const Color(0xFF6E3AFF)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildPillColumn(String percentage, double h1, double h2, Color color) {
    return Column(
      children: [
        Text(percentage, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          width: 32,
          height: 140,
          decoration: BoxDecoration(color: const Color(0xFF28282E), borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(width: 32, height: 140 * h2, decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(20))),
              const SizedBox(height: 4),
              Container(width: 32, height: 140 * h1, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20))),
            ],
          ),
        )
      ],
    );
  }
}

// ==========================================
// 6. BOTTOM-MIDDLE: PROGRESS BREAKDOWN CARD
// ==========================================
class LeadsProgressBreakdownCard extends StatelessWidget {
  const LeadsProgressBreakdownCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildCardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Leads', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              LeadsTitleHeader._buildDateChip('Jun, 6, 2026'),
            ],
          ),
          const SizedBox(height: 16),

          // Segmented Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Row(
              children: [
                Expanded(flex: 60, child: Container(height: 32, color: Colors.greenAccent, child: const Center(child: Text('60%', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))))),
                const SizedBox(width: 4),
                Expanded(flex: 30, child: Container(height: 32, color: const Color(0xFF6E3AFF), child: const Center(child: Text('30%', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))))),
                const SizedBox(width: 4),
                Expanded(flex: 10, child: Container(height: 32, color: Colors.deepOrange, child: const Center(child: Text('10%', style: TextStyle(color: Colors.white, fontSize: 10))))),
              ],
            ),
          ),
          const SizedBox(height: 20),

          _buildRowItem(Icons.pie_chart_outline, 'Conversion', '\$ 12, 316', '+7%'),
          const SizedBox(height: 12),
          _buildRowItem(Icons.timelapse, 'Expenses', '\$ 31, 921', '-4%'),
          const SizedBox(height: 12),
          _buildRowItem(Icons.grid_view, 'Total revenue', '\$ 24, 827', '+6%'),
        ],
      ),
    );
  }

  Widget _buildRowItem(IconData icon, String label, String value, String tag) {
    return Row(
      children: [
        Icon(icon, color: Colors.white54, size: 18),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.white38, fontSize: 11)),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
          ],
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(12)),
          child: Text(tag, style: const TextStyle(color: Colors.white, fontSize: 11)),
        )
      ],
    );
  }
}

// ==========================================
// 7. BOTTOM-RIGHT: DONUT CHART CARD
// ==========================================
class LeadsDonutChartCard extends StatelessWidget {
  const LeadsDonutChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildCardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Leads', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              LeadsTitleHeader._buildDateChip('Jun, 6, 2026'),
            ],
          ),
          const SizedBox(height: 16),

          // Donut Chart with Center Callout
          SizedBox(
            height: 130,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomPaint(
                  size: const Size(130, 130),
                  painter: MultiColorDonutPainter(),
                ),
                const Text('+24%', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Bottom Metric Pills
          Row(
            children: [
              Expanded(child: _buildMetricBadge('Conversion', '+24%', Colors.deepOrange)),
              const SizedBox(width: 8),
              Expanded(child: _buildMetricBadge('Conversion', '+18%', Colors.greenAccent)),
              const SizedBox(width: 8),
              Expanded(child: _buildMetricBadge('Conversion', '+4%', const Color(0xFF6E3AFF))),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildMetricBadge(String label, String value, Color dotColor) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: const Color(0xFF28282D), borderRadius: BorderRadius.circular(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 6, height: 6, decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle)),
              const SizedBox(width: 4),
              Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10)),
            ],
          ),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// Donut Chart Custom Painter
class MultiColorDonutPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;
    final strokeWidth = 14.0;

    final paintGreen = Paint()..color = Colors.greenAccent..style = PaintingStyle.stroke..strokeWidth = strokeWidth..strokeCap = StrokeCap.round;
    final paintOrange = Paint()..color = Colors.deepOrange..style = PaintingStyle.stroke..strokeWidth = strokeWidth..strokeCap = StrokeCap.round;
    final paintPurple = Paint()..color = const Color(0xFF6E3AFF)..style = PaintingStyle.stroke..strokeWidth = strokeWidth..strokeCap = StrokeCap.round;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2, pi * 0.7, false, paintGreen);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), pi * 0.25, pi * 0.8, false, paintOrange);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), pi * 1.1, pi * 0.35, false, paintPurple);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Global Reusable Card Wrapper & Helper Widgets
Widget _buildCardWrapper({required Widget child}) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xFF212125),
      borderRadius: BorderRadius.circular(24),
      border: Border.all(color: Colors.white.withOpacity(0.05)),
    ),
    child: child,
  );
}

class PillMonthTag extends StatelessWidget {
  final String text;
  const PillMonthTag(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Text(text, style: const TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }
}