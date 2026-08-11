import 'dart:math' as math;
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// APP ROOT
// ---------------------------------------------------------------------------
class SalesDashboard extends StatelessWidget {
  const SalesDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazevalley.',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: VitaraPalette.appBg,
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}

// ---------------------------------------------------------------------------
// DESIGN TOKENS
// ---------------------------------------------------------------------------
class VitaraPalette {
  static const appBg = Color(0xFFEFEFEF);
  static const card = Colors.white;
  static const border = Color(0xFFEDEDED);
  static const softBorder = Color(0xFFF2F2F2);

  static const ink = Color(0xFF1B1B1B);
  static const inkSoft = Color(0xFF5C5C5C);
  static const muted = Color(0xFF9A9A9A);

  static const purple = Color(0xFFB4A7F5); // primary
  static const purpleDeep = Color(0xFF8A79E8);
  static const green = Color(0xFFBFE9C6); // secondary
  static const greenDeep = Color(0xFF7BCD8B);
  static const pink = Color(0xFFF5B7C1);
  static const yellow = Color(0xFFF5D77A);
  static const red = Color(0xFFE84C3D);
  static const chipBg = Color(0xFFF6F6F6);
}

// ---------------------------------------------------------------------------
// DASHBOARD SCREEN
// ---------------------------------------------------------------------------
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VitaraPalette.appBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              color: VitaraPalette.appBg,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                SideNav(),
                SizedBox(width: 16),
                Expanded(child: DashboardContent()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SIDE NAV
// ---------------------------------------------------------------------------
class SideNav extends StatelessWidget {
  const SideNav({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      Icons.speed_outlined,
      Icons.grid_view_outlined,
      Icons.pie_chart_outline,
      Icons.description_outlined,
      Icons.history,
      Icons.layers_outlined,
      Icons.note_add_outlined,
      Icons.settings_outlined,
    ];
    return SizedBox(
      width: 68,
      child: Column(
        children: [
          const SizedBox(height: 8),
          for (int i = 0; i < items.length; i++) ...[
            _NavIcon(icon: items[i], active: i == 0),
            const SizedBox(height: 10),
          ],
          const Spacer(),
          _NavIcon(icon: Icons.logout, active: false, subtle: true),
          const SizedBox(height: 12),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: VitaraPalette.card,
              border: Border.all(color: VitaraPalette.border),
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.person, color: VitaraPalette.inkSoft, size: 22),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final bool active;
  final bool subtle;
  const _NavIcon({required this.icon, required this.active, this.subtle = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: active ? VitaraPalette.ink : (subtle ? VitaraPalette.card : Colors.transparent),
        borderRadius: BorderRadius.circular(14),
        border: subtle ? Border.all(color: VitaraPalette.border) : null,
      ),
      child: Icon(
        icon,
        size: 20,
        color: active ? VitaraPalette.green : VitaraPalette.inkSoft,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// DASHBOARD CONTENT
// ---------------------------------------------------------------------------
class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          TopBar(),
          SizedBox(height: 14),
          _TopRow(),
          SizedBox(height: 14),
          _BottomRow(),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// TOP BAR
// ---------------------------------------------------------------------------
class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Logo
        Container(
          width: 44,
          height: 44,
          decoration: const BoxDecoration(
            color: VitaraPalette.green,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.swap_horiz_rounded, color: VitaraPalette.ink, size: 22),
        ),
        const SizedBox(width: 12),
        const Text(
          'Amazevalley.',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: VitaraPalette.ink,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(width: 40),
        // Search
        Expanded(
          child: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            decoration: BoxDecoration(
              color: VitaraPalette.card,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: VitaraPalette.border),
            ),
            child: Row(
              children: const [
                Expanded(
                  child: Text(
                    'Search something...',
                    style: TextStyle(color: VitaraPalette.muted, fontSize: 13),
                  ),
                ),
                Icon(Icons.search, size: 18, color: VitaraPalette.inkSoft),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        // Export
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: VitaraPalette.card,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: VitaraPalette.muted, style: BorderStyle.solid),
          ),
          child: Row(
            children: const [
              Icon(Icons.add, size: 16, color: VitaraPalette.ink),
              SizedBox(width: 8),
              Text(
                'Export New Report',
                style: TextStyle(
                  color: VitaraPalette.ink,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        _themeToggle(),
        const SizedBox(width: 10),
        _countryPill(),
        const SizedBox(width: 10),
        _iconBubble(Icons.notifications_outlined, badge: true),
        const SizedBox(width: 8),
        _iconBubble(Icons.settings_outlined),
      ],
    );
  }

  Widget _themeToggle() {
    return Container(
      height: 44,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: VitaraPalette.card,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: VitaraPalette.border),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(color: VitaraPalette.ink, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: const Icon(Icons.wb_sunny_outlined, size: 16, color: VitaraPalette.green),
          ),
          const SizedBox(width: 4),
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            child: const Icon(Icons.nightlight_outlined, size: 16, color: VitaraPalette.inkSoft),
          ),
        ],
      ),
    );
  }

  Widget _countryPill() {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: VitaraPalette.card,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: VitaraPalette.border),
      ),
      child: Row(
        children: [
          Container(
            width: 18,
            height: 18,
            decoration: const BoxDecoration(color: VitaraPalette.red, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          const Text(
            'IND',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: VitaraPalette.ink),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down, size: 16, color: VitaraPalette.inkSoft),
        ],
      ),
    );
  }

  Widget _iconBubble(IconData icon, {bool badge = false}) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: VitaraPalette.card,
        shape: BoxShape.circle,
        border: Border.all(color: VitaraPalette.border),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(icon, size: 18, color: VitaraPalette.ink),
          if (badge)
            const Positioned(
              top: 12,
              right: 12,
              child: CircleAvatar(radius: 4, backgroundColor: VitaraPalette.red),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// LAYOUT ROWS
// ---------------------------------------------------------------------------
class _TopRow extends StatelessWidget {
  const _TopRow();

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Expanded(flex: 4, child: PerformanceSummaryCard()),
          SizedBox(width: 14),
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Expanded(child: SalesComparisonCard()),
                SizedBox(height: 14),
                Expanded(child: TransactionRecordsCard()),
              ],
            ),
          ),
          SizedBox(width: 14),
          Expanded(flex: 4, child: GrowthPerformanceCard()),
        ],
      ),
    );
  }
}

class _BottomRow extends StatelessWidget {
  const _BottomRow();

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Expanded(flex: 4, child: RevenueContributionCard()),
          SizedBox(width: 14),
          Expanded(flex: 8, child: RevenuePipelineTrendsCard()),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// CARD SHELL
// ---------------------------------------------------------------------------
class VitaraCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const VitaraCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: VitaraPalette.card,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}

class CardHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  const CardHeader({super.key, required this.icon, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: VitaraPalette.chipBg,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 16, color: VitaraPalette.ink),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: VitaraPalette.ink,
            ),
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

Widget _moreDots() {
  return Container(
    width: 32,
    height: 24,
    decoration: BoxDecoration(
      color: VitaraPalette.chipBg,
      borderRadius: BorderRadius.circular(8),
    ),
    alignment: Alignment.center,
    child: const Icon(Icons.more_horiz, size: 16, color: VitaraPalette.inkSoft),
  );
}

// ---------------------------------------------------------------------------
// PERFORMANCE SUMMARY
// ---------------------------------------------------------------------------
class PerformanceSummaryCard extends StatelessWidget {
  const PerformanceSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return VitaraCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardHeader(
            icon: Icons.bar_chart,
            title: 'Performance Summary',
            trailing: _moreDots(),
          ),
          const SizedBox(height: 20),
          Row(
            children: const [
              _LegendDot(color: VitaraPalette.purple, label: 'Total Revenue'),
              SizedBox(width: 16),
              _LegendDot(color: VitaraPalette.green, label: 'Qualified Leads'),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 190,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '+23%',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: VitaraPalette.ink,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Increase in sales\nperformance',
                        style: TextStyle(fontSize: 11, color: VitaraPalette.inkSoft),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: VitaraPalette.pink.withOpacity(0.35),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.arrow_downward, size: 12, color: VitaraPalette.red),
                            SizedBox(width: 4),
                            Text('14.6%',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: VitaraPalette.red,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        '+36%',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: VitaraPalette.ink,
                          letterSpacing: -1,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Growth compared to\nlast week',
                        style: TextStyle(fontSize: 11, color: VitaraPalette.inkSoft),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Expanded(child: _Bar(height: 90, color: VitaraPalette.purple, striped: true)),
                      SizedBox(width: 10),
                      Expanded(child: _Bar(height: 130, color: VitaraPalette.green)),
                      SizedBox(width: 10),
                      Expanded(child: _Bar(height: 170, color: VitaraPalette.purple)),
                      SizedBox(width: 10),
                      Expanded(child: _Bar(height: 110, color: VitaraPalette.green)),
                    ],
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

class _Bar extends StatelessWidget {
  final double height;
  final Color color;
  final bool striped;
  const _Bar({required this.height, required this.color, this.striped = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: striped
          ? CustomPaint(
        painter: _StripePainter(),
        child: Container(),
      )
          : null,
    );
  }
}

class _StripePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.35)
      ..strokeWidth = 1.5;
    for (double i = -size.height; i < size.width; i += 8) {
      canvas.drawLine(Offset(i, size.height), Offset(i + size.height, 0), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
        ),
        const SizedBox(width: 6),
        Text(label,
            style: const TextStyle(fontSize: 11, color: VitaraPalette.inkSoft, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// SALES COMPARISON
// ---------------------------------------------------------------------------
class SalesComparisonCard extends StatelessWidget {
  const SalesComparisonCard({super.key});

  @override
  Widget build(BuildContext context) {
    // horizontal ranges per row (start-end as fraction 0..1)
    final rows = [
      _RangeRow('Online', 0.15, 0.75, VitaraPalette.purple),
      _RangeRow('Direct', 0.05, 0.60, VitaraPalette.green),
      _RangeRow('Inbound', 0.20, 0.55, VitaraPalette.purple.withOpacity(0.6)),
    ];
    final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

    return VitaraCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardHeader(
            icon: Icons.bar_chart_outlined,
            title: 'Sales Comparison',
            trailing: _moreDots(),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Stack(
              children: [
                Column(
                  children: [
                    for (final r in rows) ...[
                      Expanded(child: _rangeRowWidget(r)),
                    ],
                    SizedBox(
                      height: 22,
                      child: Row(
                        children: [
                          const SizedBox(width: 56),
                          for (final d in days)
                            Expanded(
                              child: Center(
                                child: Text(
                                  d,
                                  style: const TextStyle(fontSize: 10, color: VitaraPalette.muted),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Tooltip
                Positioned(
                  left: 56 + (7 * 30.0),
                  top: 14,
                  child: _tooltip(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _rangeRowWidget(_RangeRow r) {
    // Convert fractional positions (0..1) into integer flex weights (0..100).
    // Row of Expanded widgets = same visual result, no LayoutBuilder needed.
    final leftFlex  = (r.start * 100).round();
    final barFlex   = ((r.end - r.start) * 100).round();
    final rightFlex = 100 - leftFlex - barFlex;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          // Row label ("Online" / "Direct" / "Inbound")
          SizedBox(
            width: 56,
            child: Text(
              r.label,
              style: const TextStyle(fontSize: 11, color: VitaraPalette.inkSoft),
            ),
          ),

          // Track area
          Expanded(
            child: Stack(
              children: [
                // Dashed baseline that spans full track
                Positioned.fill(
                  child: CustomPaint(
                    painter: _DottedLinePainter(color: VitaraPalette.border),
                  ),
                ),

                // Flex-based positioning of the colored bar
                Row(
                  children: [
                    if (leftFlex > 0)
                      Expanded(flex: leftFlex, child: const SizedBox()),
                    Expanded(
                      flex: barFlex,
                      child: Container(
                        height: 14,
                        decoration: BoxDecoration(
                          color: r.color,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    if (rightFlex > 0)
                      Expanded(flex: rightFlex, child: const SizedBox()),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tooltip() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: VitaraPalette.ink,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: const [
              Text('\$328.85',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
              Text('Daily Revenue',
                  style: TextStyle(color: Colors.white70, fontSize: 9)),
            ],
          ),
        ),
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(top: 4),
          decoration: const BoxDecoration(color: VitaraPalette.ink, shape: BoxShape.circle),
        ),
      ],
    );
  }
}

class _RangeRow {
  final String label;
  final double start, end;
  final Color color;
  _RangeRow(this.label, this.start, this.end, this.color);
}

class _DottedLinePainter extends CustomPainter {
  final Color color;
  _DottedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;
    final y = size.height / 2;
    double x = 0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, y), Offset(x + 3, y), paint);
      x += 6;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// TRANSACTION RECORDS
// ---------------------------------------------------------------------------
class TransactionRecordsCard extends StatelessWidget {
  const TransactionRecordsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return VitaraCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardHeader(
            icon: Icons.receipt_long_outlined,
            title: 'Transaction Records',
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: VitaraPalette.chipBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text('Customize',
                      style: TextStyle(fontSize: 11, color: VitaraPalette.ink, fontWeight: FontWeight.w500)),
                  SizedBox(width: 4),
                  Icon(Icons.tune, size: 12, color: VitaraPalette.inkSoft),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: const [
              Expanded(flex: 3, child: _TxHeader('Order ID')),
              Expanded(flex: 2, child: _TxHeader('Channel')),
              Expanded(flex: 2, child: _TxHeader('Revenue')),
              Expanded(flex: 2, child: _TxHeader('Performance')),
            ],
          ),
          const SizedBox(height: 12),
          _txRow('#SGR-24071', 'Inbound', '\$214.60', 'Low Risk', VitaraPalette.purpleDeep),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: DottedDivider(),
          ),
          _txRow('#SGR-24084', 'Direct', '\$146.20', 'High Risk', VitaraPalette.pink),
        ],
      ),
    );
  }

  Widget _txRow(String id, String channel, String rev, String perf, Color perfColor) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(id,
              style: const TextStyle(fontSize: 12, color: VitaraPalette.ink, fontWeight: FontWeight.w600)),
        ),
        Expanded(
          flex: 2,
          child: Text(channel,
              style: const TextStyle(fontSize: 12, color: VitaraPalette.inkSoft)),
        ),
        Expanded(
          flex: 2,
          child: Text(rev,
              style: const TextStyle(fontSize: 12, color: VitaraPalette.ink, fontWeight: FontWeight.w600)),
        ),
        Expanded(
          flex: 2,
          child: Text(perf,
              style: TextStyle(fontSize: 12, color: perfColor, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}

class _TxHeader extends StatelessWidget {
  final String label;
  const _TxHeader(this.label);
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(fontSize: 11, color: VitaraPalette.muted, fontWeight: FontWeight.w500),
    );
  }
}

class DottedDivider extends StatelessWidget {
  const DottedDivider({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1,
      child: CustomPaint(
        painter: _DottedLinePainter(color: VitaraPalette.border),
        size: const Size(double.infinity, 1),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// GROWTH PERFORMANCE (Donut)
// ---------------------------------------------------------------------------
class GrowthPerformanceCard extends StatelessWidget {
  const GrowthPerformanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return VitaraCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardHeader(
            icon: Icons.donut_large_outlined,
            title: 'Growth Performance',
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: VitaraPalette.chipBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text('Weekly',
                      style: TextStyle(fontSize: 11, color: VitaraPalette.ink, fontWeight: FontWeight.w500)),
                  SizedBox(width: 4),
                  Icon(Icons.keyboard_arrow_down, size: 14, color: VitaraPalette.inkSoft),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // labels on ring
                  const Positioned(
                    top: 6,
                    left: 20,
                    child: Text('31%',
                        style: TextStyle(fontSize: 13, color: VitaraPalette.ink, fontWeight: FontWeight.w600)),
                  ),
                  const Positioned(
                    top: 60,
                    right: 20,
                    child: Text('42%',
                        style: TextStyle(fontSize: 13, color: VitaraPalette.ink, fontWeight: FontWeight.w600)),
                  ),
                  const Positioned(
                    bottom: 30,
                    left: 30,
                    child: Text('12%',
                        style: TextStyle(fontSize: 13, color: VitaraPalette.ink, fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(
                    width: 220,
                    height: 220,
                    child: CustomPaint(
                      painter: GrowthDonutPainter(),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text('85.2%',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                    color: VitaraPalette.ink,
                                    letterSpacing: -1)),
                            SizedBox(height: 2),
                            Text('Sales Growth',
                                style: TextStyle(fontSize: 12, color: VitaraPalette.inkSoft)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _pill(VitaraPalette.purpleDeep, 'Primary')),
              const SizedBox(width: 8),
              Expanded(child: _pill(VitaraPalette.purple, 'Supporting')),
              const SizedBox(width: 8),
              Expanded(child: _pill(VitaraPalette.green, 'Secondary')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pill(Color color, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: VitaraPalette.chipBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
          ),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 11, color: VitaraPalette.ink)),
        ],
      ),
    );
  }
}

class GrowthDonutPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 12;
    final stroke = 26.0;

    // three segments with small gaps
    final segments = [
      _Seg(0.42, VitaraPalette.green),
      _Seg(0.12, VitaraPalette.purple),
      _Seg(0.31, VitaraPalette.purpleDeep),
    ];
    double start = -math.pi / 2;
    for (final s in segments) {
      final sweep = s.frac * math.pi * 2;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        start + 0.05,
        sweep - 0.1,
        false,
        Paint()
          ..color = s.color
          ..style = PaintingStyle.stroke
          ..strokeWidth = stroke
          ..strokeCap = StrokeCap.round,
      );
      start += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _Seg {
  final double frac;
  final Color color;
  _Seg(this.frac, this.color);
}

// ---------------------------------------------------------------------------
// REVENUE CONTRIBUTION (bubble chart)
// ---------------------------------------------------------------------------
class RevenueContributionCard extends StatelessWidget {
  const RevenueContributionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return VitaraCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CardHeader(
            icon: Icons.pie_chart_outline,
            title: 'Revenue Contribution',
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: VitaraPalette.chipBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Text('View Details',
                      style: TextStyle(fontSize: 11, color: VitaraPalette.ink, fontWeight: FontWeight.w500)),
                  SizedBox(width: 4),
                  Icon(Icons.chevron_right, size: 14, color: VitaraPalette.inkSoft),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 260,
            child: Stack(
              children: [
                Positioned(
                  left: 20,
                  top: 20,
                  child: _bubble(160, VitaraPalette.purple, '48%', big: true),
                ),
                Positioned(
                  right: 30,
                  top: 30,
                  child: _bubble(120, VitaraPalette.green, '31%', big: true),
                ),
                Positioned(
                  left: 130,
                  bottom: 10,
                  child: _bubble(80, VitaraPalette.pink, '15%'),
                ),
                Positioned(
                  left: 60,
                  bottom: 20,
                  child: _bubble(50, VitaraPalette.yellow, '12%', small: true),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const DottedDivider(),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: _statTile(VitaraPalette.purpleDeep, 'Enterprise Sales', '\$812.40')),
              Expanded(child: _statTile(VitaraPalette.green, 'Direct Sales', '\$676.85')),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _statTile(VitaraPalette.yellow, 'Inbound Sales', '\$543.20')),
              Expanded(child: _statTile(VitaraPalette.pink, 'Partner Channel', '\$389.95')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _bubble(double size, Color color, String label, {bool big = false, bool small = false}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          fontSize: big ? 24 : (small ? 12 : 18),
          fontWeight: FontWeight.w700,
          color: VitaraPalette.ink,
        ),
      ),
    );
  }

  Widget _statTile(Color color, String label, String value) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          margin: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontSize: 11, color: VitaraPalette.inkSoft)),
            const SizedBox(height: 2),
            Text(value,
                style: const TextStyle(
                    fontSize: 15, color: VitaraPalette.ink, fontWeight: FontWeight.w700)),
          ],
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// REVENUE & PIPELINE TRENDS (dot scatter chart)
// ---------------------------------------------------------------------------
class RevenuePipelineTrendsCard extends StatelessWidget {
  const RevenuePipelineTrendsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return VitaraCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: CardHeader(
                  icon: Icons.show_chart,
                  title: 'Revenue & Pipeline Trends',
                ),
              ),
              _rangeToggle(),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _seriesPill(VitaraPalette.purpleDeep, 'Revenue'),
              const SizedBox(width: 8),
              _seriesPill(VitaraPalette.purple, 'Qualified Leads'),
              const SizedBox(width: 8),
              _seriesPill(VitaraPalette.green, 'Opportunities'),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Stack(
              children: [
                CustomPaint(
                  painter: DotChartPainter(),
                  size: Size.infinite,
                ),
                Positioned(
                  right: 20,
                  top: 8,
                  child: _chartTooltip(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const SizedBox(width: 40),
              for (final m in ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'])
                Expanded(
                  child: Center(
                    child: Text(m, style: const TextStyle(fontSize: 10, color: VitaraPalette.muted)),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _seriesPill(Color color, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: VitaraPalette.chipBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
          ),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontSize: 11, color: VitaraPalette.ink)),
        ],
      ),
    );
  }

  Widget _rangeToggle() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: VitaraPalette.chipBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          _rangeBtn('Day', false),
          _rangeBtn('Month', true),
          _rangeBtn('Year', false),
        ],
      ),
    );
  }

  Widget _rangeBtn(String label, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: active ? VitaraPalette.card : Colors.transparent,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: active ? VitaraPalette.ink : VitaraPalette.inkSoft,
          fontWeight: active ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
    );
  }

  Widget _chartTooltip() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: VitaraPalette.card,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: VitaraPalette.border),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('July 2025',
              style: TextStyle(fontSize: 11, color: VitaraPalette.ink, fontWeight: FontWeight.w700)),
          const SizedBox(height: 6),
          _tipRow(VitaraPalette.green, 'Opportunities', '148'),
          _tipRow(VitaraPalette.purple, 'Qualified Leads', '240'),
          _tipRow(VitaraPalette.purpleDeep, 'Total Revenue', '\$928.41'),
        ],
      ),
    );
  }

  Widget _tipRow(Color color, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
          const SizedBox(width: 6),
          SizedBox(
            width: 100,
            child: Text(label, style: const TextStyle(fontSize: 10, color: VitaraPalette.inkSoft)),
          ),
          const SizedBox(width: 12),
          Text(value, style: const TextStyle(fontSize: 10, color: VitaraPalette.ink, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class DotChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final leftPad = 40.0;
    final chartWidth = size.width - leftPad;
    final chartHeight = size.height;

    // grid lines + Y labels
    final labels = ['24K', '16K', '8K', '4K', '0K'];
    final gridPaint = Paint()..color = VitaraPalette.border..strokeWidth = 0.5;
    for (int i = 0; i < labels.length; i++) {
      final y = chartHeight * i / (labels.length - 1);
      canvas.drawLine(Offset(leftPad, y), Offset(size.width, y), gridPaint);
      final tp = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: const TextStyle(fontSize: 9, color: VitaraPalette.muted),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(leftPad - tp.width - 8, y - tp.height / 2));
    }

    // dots per month column - stacked vertically forming towers
    final rand = math.Random(42);
    final months = 12;
    final colWidth = chartWidth / months;

    for (int m = 0; m < months; m++) {
      final cx = leftPad + colWidth * m + colWidth / 2;
      // random tower height
      final baseCount = 8 + rand.nextInt(20);
      final tallerCount = m == 6 ? baseCount + 20 : baseCount + rand.nextInt(15); // July tall

      // stack dots from bottom up
      for (int d = 0; d < tallerCount; d++) {
        final yFrac = d / 45.0;
        final y = chartHeight - yFrac * chartHeight - 6;
        if (y < 0) break;
        // dot color/opacity
        final r = rand.nextDouble();
        Color color;
        if (r < 0.55) {
          color = VitaraPalette.purple.withOpacity(0.55 + rand.nextDouble() * 0.45);
        } else if (r < 0.85) {
          color = VitaraPalette.purpleDeep.withOpacity(0.7);
        } else {
          color = VitaraPalette.green.withOpacity(0.85);
        }
        // horizontal jitter forming small cluster of 2-3 dots
        final jitter = (rand.nextDouble() - 0.5) * (colWidth * 0.7);
        canvas.drawCircle(Offset(cx + jitter, y), 5.2, Paint()..color = color);
      }
    }

    // highlighted point (July peak) - black
    final peakX = leftPad + colWidth * 6.5;
    canvas.drawCircle(Offset(peakX, chartHeight * 0.18), 7.5, Paint()..color = VitaraPalette.ink);

    // dotted vertical line for July
    final dashPaint = Paint()
      ..color = VitaraPalette.muted.withOpacity(0.4)
      ..strokeWidth = 0.8;
    double dy = 0;
    while (dy < chartHeight) {
      canvas.drawLine(Offset(peakX, dy), Offset(peakX, dy + 3), dashPaint);
      dy += 6;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Observation: Create successful: /app/vitara_dashboard.dart