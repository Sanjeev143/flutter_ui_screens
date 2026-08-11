

import 'dart:math' as math;
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// APP ROOT
// ---------------------------------------------------------------------------
class GPUDashboard extends StatelessWidget {
  const GPUDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nerve',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B0D10),
        fontFamily: 'Roboto',
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF7CFF6B),
          surface: Color(0xFF12151A),
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}

// ---------------------------------------------------------------------------
// DESIGN TOKENS
// ---------------------------------------------------------------------------
class NervePalette {
  static const bg = Color(0xFF0B0D10);
  static const card = Color(0xFF12151A);
  static const cardAlt = Color(0xFF171B21);
  static const border = Color(0xFF23272E);
  static const textPrimary = Color(0xFFE6E8EC);
  static const textSecondary = Color(0xFF8A929E);
  static const textMuted = Color(0xFF5B636E);
  static const green = Color(0xFF7CFF6B);
  static const greenDim = Color(0xFF3AA84A);
  static const yellow = Color(0xFFE8D26A);
  static const orange = Color(0xFFE38A4A);
  static const red = Color(0xFFE05B5B);
  static const blue = Color(0xFF5DA9E9);
  static const purple = Color(0xFF8B7CE8);
}

// ---------------------------------------------------------------------------
// DASHBOARD SCREEN
// ---------------------------------------------------------------------------
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NervePalette.bg,
      body: SafeArea(
        child: Column(
          children: const [
            TopNavBar(),
            Expanded(child: DashboardBody()),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// TOP NAV
// ---------------------------------------------------------------------------
class TopNavBar extends StatelessWidget {
  const TopNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    const tabs = [
      'Dashboard',
      'Infrastructure',
      'Neural Jobs',
      'Projects',
      'Data Pipelines',
      'Audit Log',
    ];
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: NervePalette.border),
        ),
      ),
      child: Row(
        children: [
          // Logo
          Row(
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: NervePalette.green,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(Icons.bolt, size: 18, color: Colors.black),
              ),
              const SizedBox(width: 10),
              const Text(
                'Nerve',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: NervePalette.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(width: 40),
          // Tabs
          Expanded(
            child: Row(
              children: [
                for (int i = 0; i < tabs.length; i++)
                  NavTab(label: tabs[i], active: i == 0),
              ],
            ),
          ),
          // Deploy button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: NervePalette.green,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'DEPLOY NEW CLUSTER',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 12,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Avatar
          CircleAvatar(
            radius: 16,
            backgroundColor: NervePalette.cardAlt,
            child: const Icon(Icons.person, size: 18, color: NervePalette.textSecondary),
          ),
        ],
      ),
    );
  }
}

class NavTab extends StatelessWidget {
  final String label;
  final bool active;
  const NavTab({super.key, required this.label, required this.active});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 22),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: active ? NervePalette.textPrimary : NervePalette.textSecondary,
              fontWeight: active ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          const Spacer(),
          Container(
            height: 2,
            width: 40,
            color: active ? NervePalette.green : Colors.transparent,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// DASHBOARD BODY
// ---------------------------------------------------------------------------
class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome
          Row(
            children: const [
              Text(
                'Welcome Back, Jon',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: NervePalette.textPrimary,
                ),
              ),
              SizedBox(width: 8),
              Text('👋', style: TextStyle(fontSize: 22)),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Your neural clusters are operating at nominal efficiency.',
            style: TextStyle(color: NervePalette.textSecondary, fontSize: 13),
          ),
          const SizedBox(height: 20),

          // Row 1: Infrastructure | Workload | Alerts
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Expanded(flex: 5, child: InfrastructureNodesCard()),
                SizedBox(width: 16),
                Expanded(flex: 4, child: WorkloadAllocationCard()),
                SizedBox(width: 16),
                Expanded(flex: 5, child: RealtimeAlertsCard()),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Row 2: Heatmap | Convergence | Distributed nodes
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Expanded(flex: 4, child: ApiGatewayHeatmapCard()),
                SizedBox(width: 16),
                Expanded(flex: 5, child: NeuralConvergenceCard()),
                SizedBox(width: 16),
                Expanded(flex: 4, child: DistributedNodesCard()),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Row 3: Active workload queue
          const ActiveWorkloadQueueCard(),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// CARD SHELL
// ---------------------------------------------------------------------------
class NerveCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const NerveCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: NervePalette.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: NervePalette.border),
      ),
      child: child,
    );
  }
}

class CardTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;
  const CardTitle({super.key, required this.title, this.subtitle, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: NervePalette.textPrimary,
                ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(
                  subtitle!,
                  style: const TextStyle(fontSize: 11, color: NervePalette.textMuted),
                ),
              ],
            ],
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// INFRASTRUCTURE NODES CARD
// ---------------------------------------------------------------------------
class InfrastructureNodesCard extends StatelessWidget {
  const InfrastructureNodesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return NerveCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CardTitle(
            title: 'Infrastructure Nodes',
            subtitle: 'Active provisioning across 12 regions',
          ),
          const SizedBox(height: 20),
          Row(
            children: const [
              Expanded(child: _Metric(label: 'GPU Nodes', value: '14.2', unit: 'k', trend: '+2.3%', trendUp: true)),
              Expanded(child: _Metric(label: 'CPU Cores', value: '4,120', trend: '+0.8%', trendUp: true)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: const [
              Expanded(child: _Metric(label: 'Storage TB', value: '847', trend: '+5.1%', trendUp: true)),
              Expanded(child: _Metric(label: 'Bandwidth', value: '2.8', unit: 'Tb/s', trend: '-0.4%', trendUp: false)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: const [
              Expanded(child: _Metric(label: 'Uptime', value: '8.4', unit: 'k hrs', trend: '+1.2%', trendUp: true)),
              Expanded(child: SizedBox.shrink()),
            ],
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final String label;
  final String value;
  final String? unit;
  final String trend;
  final bool trendUp;
  const _Metric({
    required this.label,
    required this.value,
    this.unit,
    required this.trend,
    required this.trendUp,
  });

  @override
  Widget build(BuildContext context) {
    final trendColor = trendUp ? NervePalette.green : NervePalette.red;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: NervePalette.textMuted),
        ),
        const SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: NervePalette.textPrimary,
              ),
            ),
            if (unit != null)
              Padding(
                padding: const EdgeInsets.only(left: 3),
                child: Text(
                  unit!,
                  style: const TextStyle(
                    fontSize: 12,
                    color: NervePalette.textSecondary,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Icon(
              trendUp ? Icons.arrow_upward : Icons.arrow_downward,
              size: 10,
              color: trendColor,
            ),
            const SizedBox(width: 2),
            Text(
              trend,
              style: TextStyle(fontSize: 10, color: trendColor, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// WORKLOAD ALLOCATION CARD (donut)
// ---------------------------------------------------------------------------
class WorkloadAllocationCard extends StatelessWidget {
  const WorkloadAllocationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return NerveCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CardTitle(
            title: 'Workload Allocation',
            subtitle: 'Compute distribution by neural workload',
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              SizedBox(
                width: 120,
                height: 120,
                child: CustomPaint(
                  painter: DonutPainter(
                    segments: [
                      DonutSegment(0.6541, NervePalette.green),
                      DonutSegment(0.20, NervePalette.blue),
                      DonutSegment(0.10, NervePalette.orange),
                      DonutSegment(0.0459, NervePalette.purple),
                    ],
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '65.41%',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: NervePalette.textPrimary,
                          ),
                        ),
                        Text(
                          'Utilized',
                          style: TextStyle(fontSize: 10, color: NervePalette.textMuted),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _LegendRow(color: NervePalette.green, label: 'LLM Fine-Tune', value: '65%'),
                    SizedBox(height: 8),
                    _LegendRow(color: NervePalette.blue, label: 'Vision Nets', value: '20%'),
                    SizedBox(height: 8),
                    _LegendRow(color: NervePalette.orange, label: 'RL Agents', value: '10%'),
                    SizedBox(height: 8),
                    _LegendRow(color: NervePalette.purple, label: 'Diffusion', value: '5%'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: NervePalette.cardAlt,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: NervePalette.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Smart Rebalance Rebalancing',
                  style: TextStyle(fontSize: 11, color: NervePalette.textSecondary),
                ),
                const Spacer(),
                const Text(
                  '2.3 TFLOPs',
                  style: TextStyle(fontSize: 11, color: NervePalette.green, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendRow extends StatelessWidget {
  final Color color;
  final String label;
  final String value;
  const _LegendRow({required this.color, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 11, color: NervePalette.textSecondary),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 11, color: NervePalette.textPrimary, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class DonutSegment {
  final double fraction;
  final Color color;
  DonutSegment(this.fraction, this.color);
}

class DonutPainter extends CustomPainter {
  final List<DonutSegment> segments;
  DonutPainter({required this.segments});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final center = rect.center;
    final radius = math.min(size.width, size.height) / 2;
    final stroke = 14.0;
    double start = -math.pi / 2;
    for (final seg in segments) {
      final sweep = seg.fraction * math.pi * 2;
      final paint = Paint()
        ..color = seg.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.butt;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - stroke / 2),
        start + 0.01,
        sweep - 0.02,
        false,
        paint,
      );
      start += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// REALTIME ALERTS CARD
// ---------------------------------------------------------------------------
class RealtimeAlertsCard extends StatelessWidget {
  const RealtimeAlertsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final alerts = [
      _AlertData(
        color: NervePalette.green,
        title: 'GPU cluster ORDN-19 fully online',
        subtitle: '2 minutes ago · System auto-provisioned',
        tag: 'INFO',
      ),
      _AlertData(
        color: NervePalette.yellow,
        title: 'Training convergence lattice speed dispatched',
        subtitle: '18 min ago · Neural Job #2812',
        tag: 'WARN',
      ),
      _AlertData(
        color: NervePalette.red,
        title: 'Rate Anomaly Detected: Kernel Ring 7',
        subtitle: '32 min ago · Investigating',
        tag: 'CRIT',
      ),
      _AlertData(
        color: NervePalette.blue,
        title: 'Data pipeline sync completed successfully',
        subtitle: '54 min ago · Pipeline #P-104',
        tag: 'INFO',
      ),
      _AlertData(
        color: NervePalette.purple,
        title: 'Inference lag Response Time > 12ms',
        subtitle: '1 hr ago · Congestion normalizing',
        tag: 'WARN',
      ),
    ];

    return NerveCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CardTitle(
            title: 'Realtime alerts & events',
            subtitle: 'Live System Events, Sub-Second Fabric Feed',
          ),
          const SizedBox(height: 12),
          for (final a in alerts) ...[
            _AlertRow(data: a),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _AlertData {
  final Color color;
  final String title;
  final String subtitle;
  final String tag;
  _AlertData({required this.color, required this.title, required this.subtitle, required this.tag});
}

class _AlertRow extends StatelessWidget {
  final _AlertData data;
  const _AlertRow({required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.only(top: 5),
          decoration: BoxDecoration(color: data.color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.title,
                style: const TextStyle(fontSize: 12, color: NervePalette.textPrimary, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 2),
              Text(
                data.subtitle,
                style: const TextStyle(fontSize: 10, color: NervePalette.textMuted),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: data.color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            data.tag,
            style: TextStyle(fontSize: 9, color: data.color, fontWeight: FontWeight.w700, letterSpacing: 0.5),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// API GATEWAY HEATMAP CARD
// ---------------------------------------------------------------------------
class ApiGatewayHeatmapCard extends StatelessWidget {
  const ApiGatewayHeatmapCard({super.key});

  @override
  Widget build(BuildContext context) {
    // 7 days x 8 hour buckets grid
    final rand = math.Random(11);
    final rows = 7;
    final cols = 8;
    final data = List.generate(rows, (_) => List.generate(cols, (_) => rand.nextDouble()));
    final dayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final hourLabels = ['00', '03', '06', '09', '12', '15', '18', '21'];

    return NerveCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CardTitle(
            title: 'API Gateway Heatmap',
            subtitle: '4-Hour Regional Traffic Response Analysis',
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Column(
              children: [
                for (int r = 0; r < rows; r++)
                  Expanded(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 28,
                          child: Text(
                            dayLabels[r],
                            style: const TextStyle(fontSize: 9, color: NervePalette.textMuted),
                          ),
                        ),
                        for (int c = 0; c < cols; c++)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: _heatColor(data[r][c]),
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const SizedBox(width: 28),
                    for (final h in hourLabels)
                      Expanded(
                        child: Center(
                          child: Text(
                            h,
                            style: const TextStyle(fontSize: 9, color: NervePalette.textMuted),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _heatColor(double v) {
    if (v < 0.2) return const Color(0xFF1B2A22);
    if (v < 0.4) return const Color(0xFF2F5A3D);
    if (v < 0.6) return const Color(0xFF4E9B5A);
    if (v < 0.8) return const Color(0xFF7CFF6B);
    return const Color(0xFFB6FF9E);
  }
}

// ---------------------------------------------------------------------------
// NEURAL CONVERGENCE (LINE CHART)
// ---------------------------------------------------------------------------
class NeuralConvergenceCard extends StatelessWidget {
  const NeuralConvergenceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return NerveCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: CardTitle(
                  title: 'Neural Model Convergence',
                  subtitle: 'Realtime Loss Curves Across Active Training Jobs',
                ),
              ),
              _pill('Loss', NervePalette.green, filled: true),
              const SizedBox(width: 6),
              _pill('Accuracy', NervePalette.blue),
              const SizedBox(width: 6),
              _pill('Val Loss', NervePalette.orange),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: CustomPaint(
              painter: LineChartPainter(),
              child: Container(),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final l in ['0', '5k', '10k', '15k', '20k', '25k', '30k'])
                Text(l, style: const TextStyle(fontSize: 9, color: NervePalette.textMuted)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pill(String label, Color color, {bool filled = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: filled ? color.withOpacity(0.15) : Colors.transparent,
        border: Border.all(color: color.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 5),
          Text(label, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // grid
    final gridPaint = Paint()
      ..color = NervePalette.border
      ..strokeWidth = 0.5;
    for (int i = 0; i < 5; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Loss (green) - exp decay
    _drawCurve(
      canvas,
      size,
          (x) => math.exp(-x * 3.5) * 0.85 + 0.08,
      NervePalette.green,
      filled: true,
    );
    // Accuracy (blue) - inverted growth
    _drawCurve(
      canvas,
      size,
          (x) => 0.85 - (1 - math.exp(-x * 3)) * 0.55,
      NervePalette.blue,
    );
    // Val Loss (orange) - noisy exp decay
    _drawCurve(
      canvas,
      size,
          (x) => math.exp(-x * 2.5) * 0.7 + 0.15 + math.sin(x * 20) * 0.03,
      NervePalette.orange,
    );
  }

  void _drawCurve(Canvas canvas, Size size, double Function(double) fn, Color color,
      {bool filled = false}) {
    final path = Path();
    final steps = 100;
    for (int i = 0; i <= steps; i++) {
      final t = i / steps;
      final x = t * size.width;
      final y = fn(t) * size.height;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    if (filled) {
      final fill = Path.from(path)
        ..lineTo(size.width, size.height)
        ..lineTo(0, size.height)
        ..close();
      canvas.drawPath(
        fill,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [color.withOpacity(0.25), color.withOpacity(0.0)],
          ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)),
      );
    }

    canvas.drawPath(
      path,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// DISTRIBUTED TRAINING NODES CARD
// ---------------------------------------------------------------------------
class DistributedNodesCard extends StatelessWidget {
  const DistributedNodesCard({super.key});

  @override
  Widget build(BuildContext context) {
    final nodes = [
      _NodeBar('Node-Ashland', 0.82, NervePalette.green),
      _NodeBar('Node-Kyoto', 0.76, NervePalette.green),
      _NodeBar('Node-Berlin', 0.64, NervePalette.yellow),
      _NodeBar('Node-Cairo', 0.58, NervePalette.yellow),
      _NodeBar('Node-Lagos', 0.44, NervePalette.orange),
    ];
    return NerveCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CardTitle(
            title: 'Distributed training nodes',
            subtitle: 'Cluster Health Monitoring',
          ),
          const SizedBox(height: 18),
          for (final n in nodes) ...[
            _NodeBarRow(node: n),
            const SizedBox(height: 12),
          ],
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: NervePalette.cardAlt,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: NervePalette.border),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: NervePalette.green.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.traffic, size: 14, color: NervePalette.green),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Peak Traffic Balancer',
                        style: TextStyle(fontSize: 11, color: NervePalette.textPrimary, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Auto-scaling engaged',
                        style: TextStyle(fontSize: 10, color: NervePalette.textMuted),
                      ),
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

class _NodeBar {
  final String name;
  final double value;
  final Color color;
  _NodeBar(this.name, this.value, this.color);
}

class _NodeBarRow extends StatelessWidget {
  final _NodeBar node;
  const _NodeBarRow({required this.node});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 96,
          child: Text(
            node.name,
            style: const TextStyle(fontSize: 11, color: NervePalette.textSecondary),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 6,
                decoration: BoxDecoration(
                  color: NervePalette.cardAlt,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              FractionallySizedBox(
                widthFactor: node.value,
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: node.color,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 36,
          child: Text(
            '${(node.value * 100).toStringAsFixed(0)}%',
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 11, color: NervePalette.textPrimary, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// ACTIVE WORKLOAD QUEUE (TABLE)
// ---------------------------------------------------------------------------
class ActiveWorkloadQueueCard extends StatelessWidget {
  const ActiveWorkloadQueueCard({super.key});

  @override
  Widget build(BuildContext context) {
    final rows = [
      _JobRow('JOB-9812', 'Llama 3 Fine-tune', 'LLM Cluster A', 'Running', 0.72, 'High'),
      _JobRow('JOB-9811', 'Vision Encoder v4', 'Vision Cluster', 'Running', 0.54, 'Medium'),
      _JobRow('JOB-9810', 'RL Policy Search', 'RL Farm', 'Queued', 0.10, 'Low'),
      _JobRow('JOB-9809', 'Diffusion XL Prime', 'Diffusion Pod', 'Running', 0.88, 'High'),
      _JobRow('JOB-9808', 'Sentiment Model', 'NLP Cluster', 'Completed', 1.0, 'Medium'),
      _JobRow('JOB-9807', 'Audio Denoiser', 'Speech Nodes', 'Failed', 0.32, 'Medium'),
      _JobRow('JOB-9806', 'Medical Large 3', 'BioMed Cluster', 'Running', 0.61, 'High'),
    ];

    return NerveCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CardTitle(
            title: 'Active Workload Queue',
            subtitle: 'https://neuralnodes.nerve/queue',
          ),
          const SizedBox(height: 16),
          // Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              color: NervePalette.cardAlt,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: const [
                _HeaderCell('JOB ID', flex: 2),
                _HeaderCell('MODEL', flex: 3),
                _HeaderCell('NODES', flex: 3),
                _HeaderCell('STATUS', flex: 2),
                _HeaderCell('PROGRESS', flex: 3),
                _HeaderCell('PRIORITY', flex: 2),
              ],
            ),
          ),
          for (final r in rows) _JobTableRow(row: r),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text(
                'Showing 8 of 128 total jobs',
                style: TextStyle(fontSize: 11, color: NervePalette.textMuted),
              ),
              const Spacer(),
              _pageBtn('<'),
              const SizedBox(width: 6),
              _pageBtn('1', active: true),
              const SizedBox(width: 6),
              _pageBtn('2'),
              const SizedBox(width: 6),
              _pageBtn('3'),
              const SizedBox(width: 6),
              _pageBtn('>'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pageBtn(String label, {bool active = false}) {
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: active ? NervePalette.green : NervePalette.cardAlt,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          color: active ? Colors.black : NervePalette.textSecondary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String label;
  final int flex;
  const _HeaderCell(this.label, {this.flex = 1});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 10,
          color: NervePalette.textMuted,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

class _JobRow {
  final String id, model, nodes, status, priority;
  final double progress;
  _JobRow(this.id, this.model, this.nodes, this.status, this.progress, this.priority);
}

class _JobTableRow extends StatelessWidget {
  final _JobRow row;
  const _JobTableRow({required this.row});

  Color _statusColor(String s) {
    switch (s) {
      case 'Running':
        return NervePalette.green;
      case 'Queued':
        return NervePalette.blue;
      case 'Completed':
        return NervePalette.purple;
      case 'Failed':
        return NervePalette.red;
      default:
        return NervePalette.textSecondary;
    }
  }

  Color _priorityColor(String p) {
    switch (p) {
      case 'High':
        return NervePalette.red;
      case 'Medium':
        return NervePalette.yellow;
      case 'Low':
        return NervePalette.textSecondary;
      default:
        return NervePalette.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: NervePalette.border, width: 0.5)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              row.id,
              style: const TextStyle(
                fontSize: 12,
                color: NervePalette.textPrimary,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              row.model,
              style: const TextStyle(fontSize: 12, color: NervePalette.textPrimary),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              row.nodes,
              style: const TextStyle(fontSize: 12, color: NervePalette.textSecondary),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: _statusColor(row.status).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    row.status,
                    style: TextStyle(
                      fontSize: 10,
                      color: _statusColor(row.status),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          height: 5,
                          decoration: BoxDecoration(
                            color: NervePalette.cardAlt,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: row.progress,
                          child: Container(
                            height: 5,
                            decoration: BoxDecoration(
                              color: NervePalette.green,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: 34,
                    child: Text(
                      '${(row.progress * 100).toStringAsFixed(0)}%',
                      style: const TextStyle(fontSize: 11, color: NervePalette.textSecondary),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(color: _priorityColor(row.priority), shape: BoxShape.circle),
                ),
                const SizedBox(width: 6),
                Text(
                  row.priority,
                  style: const TextStyle(fontSize: 11, color: NervePalette.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


///Please contact for code in comment section. do like subscribe ... thank
///you ...!