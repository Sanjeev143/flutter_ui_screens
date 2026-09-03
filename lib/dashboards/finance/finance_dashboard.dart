import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() {
  runApp(const FinFlowApp());
}

// =============================================================================
// DESIGN TOKENS & ATOMIC SPECIFICATIONS (1440x900 Optimized)
// =============================================================================
class AppColors {
  static const Color background = Color(0xFFF4F5F7);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color accent = Color(0xFFF25A3A); // Warm Orange CTA Accent
  static const Color accentHover = Color(0xFFD94D30);
  static const Color accentLight = Color(0xFFFFF3F0);

  static const Color textMain = Color(0xFF1E293B);
  static const Color textSub = Color(0xFF64748B);
  static const Color textMuted = Color(0xFF94A3B8);

  static const Color border = Color(0xFFF1F5F9);
  static const Color cardShadow = Color(0x0A000000);
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFECFDF5);
}

class AppTypography {
  static const TextStyle h1 = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w800,
    color: AppColors.textMain,
    letterSpacing: -1.2,
    height: 1.15,
  );
  static const TextStyle h2 = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w700,
    color: AppColors.textMain,
    letterSpacing: -0.8,
  );
  static const TextStyle h3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.textMain,
  );
  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textMain,
  );
  static const TextStyle bodyBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textMain,
  );
  static const TextStyle small = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textSub,
  );
  static const TextStyle tiny = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textMuted,
  );
}

class AppDecorations {
  static final BorderRadius cardRadius = BorderRadius.circular(24.0);

  static final List<BoxShadow> softCardShadow = [
    const BoxShadow(
      color: Color(0x08000000),
      blurRadius: 28,
      offset: Offset(0, 10),
    ),
    const BoxShadow(
      color: Color(0x03000000),
      blurRadius: 4,
      offset: Offset(0, 2),
    ),
  ];

  static final List<BoxShadow> hoverCardShadow = [
    const BoxShadow(
      color: Color(0x10000000),
      blurRadius: 36,
      offset: Offset(0, 16),
    ),
  ];
}

// =============================================================================
// MAIN APPLICATION ROOT
// =============================================================================
class FinFlowApp extends StatelessWidget {
  const FinFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinFlow High-Fidelity Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.accent,
          surface: AppColors.surface,
          primary: AppColors.accent,
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}

// =============================================================================
// DASHBOARD VIEWPORT CONTROLLER (1440x900 Adaptive Engine)
// =============================================================================
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double width = constraints.maxWidth;
            final bool isDesktop = width >= 1180;
            final bool isTablet = width < 1180 && width >= 768;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 36.0 : (isTablet ? 24.0 : 16.0),
                vertical: 24.0,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1440),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const DashboardHeader(),
                      const SizedBox(height: 24),
                      const DashboardHero(),
                      const SizedBox(height: 28),
                      if (isDesktop)
                        const DesktopResponsiveGrid()
                      else if (isTablet)
                        const TabletResponsiveGrid()
                      else
                        const MobileResponsiveGrid(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// =============================================================================
// SECTION 1: TOP HEADER
// =============================================================================
class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return HoverElevatedCard(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < 720;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left: Logo & Circular Hamburger Menu
              Row(
                children: [
                  CustomCircularButton(
                    icon: Icons.menu_rounded,
                    tooltip: "Toggle Menu",
                    onTap: () {},
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppColors.textMain,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'F',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  RichText(
                    text: const TextSpan(
                      text: 'FinFlow',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textMain,
                      ),
                      children: [
                        TextSpan(
                          text: '.',
                          style: TextStyle(color: AppColors.accent),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Right: Search Input, Action Icons, Profile Avatar
              Row(
                children: [
                  if (!isCompact)
                    Container(
                      width: 280,
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search_rounded,
                              size: 18, color: AppColors.textMuted),
                          const SizedBox(width: 8),
                          const Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search ledger, tags...',
                                hintStyle: AppTypography.tiny,
                                border: InputBorder.none,
                                isDense: true,
                              ),
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: const Text('⌘K',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textMuted)),
                          ),
                        ],
                      ),
                    ),
                  if (!isCompact) const SizedBox(width: 12),
                  CustomCircularButton(
                    icon: Icons.mic_none_rounded,
                    tooltip: "Voice Command",
                    onTap: () {},
                  ),
                  const SizedBox(width: 8),
                  CustomCircularButton(
                    icon: Icons.add_rounded,
                    tooltip: "Quick Transaction",
                    onTap: () {},
                  ),
                  const SizedBox(width: 14),
                  Container(height: 24, width: 1, color: AppColors.border),
                  const SizedBox(width: 14),
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppColors.accent.withOpacity(0.4),
                              width: 2),
                        ),
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.background,
                          child: Icon(Icons.person, color: AppColors.textSub),
                        ),
                      ),
                      Positioned(
                        right: 2,
                        bottom: 2,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: AppColors.success,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

// =============================================================================
// SECTION 2: HERO BANNER (Conversion & Onboarding Focus)
// =============================================================================
class DashboardHero extends StatelessWidget {
  const DashboardHero({super.key});

  @override
  Widget build(BuildContext context) {
    return HoverElevatedCard(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isStacked = constraints.maxWidth < 800;

          return Flex(
            direction: isStacked ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: isStacked
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              // Left: Circular Date Badge & Title Greeting
              Row(
                children: [
                  Container(
                    width: 68,
                    height: 68,
                    decoration: BoxDecoration(
                      color: AppColors.accentLight,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: AppColors.accent.withOpacity(0.35), width: 2),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '28',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: AppColors.accent,
                            height: 1.0,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'SEP',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: AppColors.accent,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Hey, Need help?',
                            style: AppTypography.h2.copyWith(
                              fontSize: isStacked ? 26 : 32,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text('👋', style: TextStyle(fontSize: 26)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Your assets are growing 12.4% faster than last month. Vault secured.',
                        style: AppTypography.small.copyWith(
                          color: AppColors.textSub,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (isStacked) const SizedBox(height: 20),

              // Right: Tasks CTA Pill & Action Calendar Icon
              Row(
                children: [
                  CustomCircularButton(
                    icon: Icons.calendar_today_rounded,
                    tooltip: "Schedule View",
                    onTap: () {},
                  ),
                  const SizedBox(width: 14),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shadowColor: AppColors.accent.withOpacity(0.35),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 26, vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Show my Tasks',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w700)),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward_rounded, size: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

// =============================================================================
// GRID ARCHITECTURES (DESKTOP, TABLET, MOBILE)
// =============================================================================
class DesktopResponsiveGrid extends StatelessWidget {
  const DesktopResponsiveGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Column 1: Financial Cards & Verification
        Expanded(
          flex: 10,
          child: Column(
            children: [
              VisaPaymentCard(),
              SizedBox(height: 24),
              WalletVerificationCard(),
            ],
          ),
        ),
        SizedBox(width: 24),

        // Column 2: Income / Expense Flow & Activity Ledger
        Expanded(
          flex: 11,
          child: Column(
            children: [
              IncomePaidSummaryStack(),
              SizedBox(height: 24),
              ActivityManagerCard(),
            ],
          ),
        ),
        SizedBox(width: 24),

        // Column 3: Performance Charts & Real-time Markets
        Expanded(
          flex: 11,
          child: Column(
            children: [
              ConcentricProfitsCard(),
              SizedBox(height: 24),
              RadialGrowthCard(),
              SizedBox(height: 24),
              StocksTimelineCard(),
            ],
          ),
        ),
      ],
    );
  }
}

class TabletResponsiveGrid extends StatelessWidget {
  const TabletResponsiveGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: VisaPaymentCard()),
            SizedBox(width: 20),
            Expanded(child: WalletVerificationCard()),
          ],
        ),
        SizedBox(height: 20),
        IncomePaidSummaryStack(),
        SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: ConcentricProfitsCard()),
            SizedBox(width: 20),
            Expanded(child: RadialGrowthCard()),
          ],
        ),
        SizedBox(height: 20),
        StocksTimelineCard(),
        SizedBox(height: 20),
        ActivityManagerCard(),
      ],
    );
  }
}

class MobileResponsiveGrid extends StatelessWidget {
  const MobileResponsiveGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        VisaPaymentCard(),
        SizedBox(height: 18),
        IncomePaidSummaryStack(),
        SizedBox(height: 18),
        ConcentricProfitsCard(),
        SizedBox(height: 18),
        RadialGrowthCard(),
        SizedBox(height: 18),
        StocksTimelineCard(),
        SizedBox(height: 18),
        ActivityManagerCard(),
        SizedBox(height: 18),
        WalletVerificationCard(),
      ],
    );
  }
}

// =============================================================================
// COMPONENT 1: VISA PAYMENT CARD
// =============================================================================
class VisaPaymentCard extends StatelessWidget {
  const VisaPaymentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return HoverElevatedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('PRIMARY VAULT',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                      color: AppColors.textMuted)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.textMain,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text('VISA',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Linked Balance', style: AppTypography.tiny),
          const SizedBox(height: 4),
          RichText(
            text: const TextSpan(
              text: r'$38,420.',
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textMain,
                  letterSpacing: -0.5),
              children: [
                TextSpan(
                  text: '00',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textMuted),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('•••• •••• •••• 9842',
                    style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2.0,
                        color: AppColors.textSub)),
                Icon(Icons.visibility_outlined,
                    size: 16, color: AppColors.textMuted),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Monthly Maint. Fee', style: AppTypography.tiny),
              Text('\$0.00 (Waived)',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.success)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_downward_rounded, size: 16),
                  label: const Text('Receive'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_upward_rounded, size: 16),
                  label: const Text('Send'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textMain,
                    side: const BorderSide(color: AppColors.border),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// COMPONENT 2: INCOME & EXPENSES SUMMARY STACK
// =============================================================================
class IncomePaidSummaryStack extends StatelessWidget {
  const IncomePaidSummaryStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildMetricRow(
          title: 'Total Income',
          amount: r'$14,820.50',
          growth: '+18.2%',
          icon: Icons.trending_up_rounded,
          iconColor: AppColors.success,
          bgColor: AppColors.successLight,
        ),
        const SizedBox(height: 16),
        _buildMetricRow(
          title: 'Total Expenses',
          amount: r'$3,240.10',
          growth: '-4.6%',
          icon: Icons.trending_down_rounded,
          iconColor: AppColors.accent,
          bgColor: AppColors.accentLight,
        ),
      ],
    );
  }

  Widget _buildMetricRow({
    required String title,
    required String amount,
    required String growth,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
  }) {
    return HoverElevatedCard(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTypography.tiny),
                  const SizedBox(height: 4),
                  Text(amount, style: AppTypography.h3),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Text('Weekly',
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSub)),
                    Icon(Icons.keyboard_arrow_down_rounded,
                        size: 14, color: AppColors.textSub),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text(growth,
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: iconColor)),
            ],
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// COMPONENT 3: CONCENTRIC CIRCULAR CHART (Annual Profits)
// =============================================================================
class ConcentricProfitsCard extends StatelessWidget {
  const ConcentricProfitsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return HoverElevatedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Annual Profits', style: AppTypography.h3),
              Icon(Icons.pie_chart_outline_rounded,
                  size: 18, color: AppColors.textMuted),
            ],
          ),
          const SizedBox(height: 4),
          const Text('Concentric dynamic target index',
              style: AppTypography.tiny),
          const SizedBox(height: 20),
          Center(
            child: SizedBox(
              width: 150,
              height: 150,
              child: CustomPaint(
                painter: ConcentricChartPainter(),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('+84.2%',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textMain)),
                      Text('Yield Goal',
                          style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textMuted)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _indicatorItem('Realized', r'$18.4K', AppColors.accent),
              _indicatorItem('Pending', r'$6.2K', const Color(0xFFFBBF24)),
              _indicatorItem('Target', r'$32.0K', AppColors.border),
            ],
          ),
        ],
      ),
    );
  }

  Widget _indicatorItem(String label, String value, Color color) {
    return Column(
      children: [
        Row(
          children: [
            Container(
                width: 8,
                height: 8,
                decoration:
                BoxDecoration(color: color, shape: BoxShape.circle)),
            const SizedBox(width: 6),
            Text(label, style: AppTypography.tiny),
          ],
        ),
        const SizedBox(height: 2),
        Text(value,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.textMain)),
      ],
    );
  }
}

class ConcentricChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    void drawArc(double radius, double strokeWidth, Color color, double sweep) {
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
          -math.pi / 2, sweep, false, paint);
    }

    // Outer Target Ring
    drawArc(68, 6, AppColors.border, math.pi * 2);
    drawArc(68, 6, AppColors.accent, math.pi * 1.6);

    // Mid Secondary Ring
    drawArc(54, 6, AppColors.border, math.pi * 2);
    drawArc(54, 6, const Color(0xFFFBBF24), math.pi * 1.1);

    // Inner Ring
    drawArc(40, 6, AppColors.border, math.pi * 2);
    drawArc(40, 6, AppColors.success, math.pi * 1.8);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// COMPONENT 4: RADIAL GAUGE (36% Growth)
// =============================================================================
class RadialGrowthCard extends StatelessWidget {
  const RadialGrowthCard({super.key});

  @override
  Widget build(BuildContext context) {
    return HoverElevatedCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Portfolio Gauge', style: AppTypography.h3),
              SizedBox(height: 4),
              Text('Trailing 30-Day metric', style: AppTypography.tiny),
              SizedBox(height: 12),
              Text('+36% Growth',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: AppColors.accent)),
              Text('Velocity target matched',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: AppColors.success)),
            ],
          ),
          SizedBox(
            width: 90,
            height: 90,
            child: CustomPaint(
              painter: RadialGaugePainter(percentage: 0.36),
              child: const Center(
                child: Text('36%',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textMain)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RadialGaugePainter extends CustomPainter {
  final double percentage;
  RadialGaugePainter({required this.percentage});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;

    final bgPaint = Paint()
      ..color = AppColors.border
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..color = AppColors.accent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2, math.pi * 2, false, bgPaint);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2, math.pi * 2 * percentage, false, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// COMPONENT 5: STOCKS CARD WITH SPARKLINE TIMELINE
// =============================================================================
class StocksTimelineCard extends StatelessWidget {
  const StocksTimelineCard({super.key});

  @override
  Widget build(BuildContext context) {
    return HoverElevatedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('S&P 500 Index', style: AppTypography.h3),
                  SizedBox(height: 2),
                  Text('Market Tracking', style: AppTypography.tiny),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.successLight,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Text('+4.82%',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.success)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text('5,492.10 USD',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textMain)),
          const SizedBox(height: 10),
          SizedBox(
            height: 60,
            width: double.infinity,
            child: CustomPaint(
              painter: SparklinePainter(),
            ),
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('09:30 AM', style: AppTypography.tiny),
              Text('01:00 PM', style: AppTypography.tiny),
              Text('04:00 PM', style: AppTypography.tiny),
            ],
          ),
        ],
      ),
    );
  }
}

class SparklinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final points = [
      Offset(0, size.height * 0.8),
      Offset(size.width * 0.2, size.height * 0.7),
      Offset(size.width * 0.4, size.height * 0.45),
      Offset(size.width * 0.6, size.height * 0.55),
      Offset(size.width * 0.8, size.height * 0.2),
      Offset(size.width, size.height * 0.05),
    ];

    final path = Path()..moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          AppColors.accent.withOpacity(0.25),
          AppColors.accent.withOpacity(0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final linePaint = Paint()
      ..color = AppColors.accent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, linePaint);

    final dotPaint = Paint()..color = Colors.white;
    final dotRing = Paint()
      ..color = AppColors.accent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(points.last, 4, dotPaint);
    canvas.drawCircle(points.last, 4, dotRing);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// COMPONENT 6: ACTIVITY MANAGER
// =============================================================================
class ActivityManagerCard extends StatelessWidget {
  const ActivityManagerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return HoverElevatedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Activity Manager', style: AppTypography.h3),
              Text('18 Total', style: AppTypography.tiny),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _buildFilterChip('All', isSelected: true),
              const SizedBox(width: 8),
              _buildFilterChip('Received'),
              const SizedBox(width: 8),
              _buildFilterChip('Transfers'),
            ],
          ),
          const SizedBox(height: 14),
          _buildTransactionRow(
            title: 'Stripe Settlement',
            date: 'Today, 03:45 PM',
            amount: r'+$2,450.00',
            isPositive: true,
          ),
          _buildTransactionRow(
            title: 'AWS Cloud Infrastructure',
            date: 'Yesterday',
            amount: r'-$340.20',
            isPositive: false,
          ),
          _buildTransactionRow(
            title: 'Figma Enterprise Seat',
            date: '24 Sep 2026',
            amount: r'-$45.00',
            isPositive: false,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.accent : AppColors.background,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: isSelected ? Colors.white : AppColors.textSub,
        ),
      ),
    );
  }

  Widget _buildTransactionRow({
    required String title,
    required String date,
    required String amount,
    required bool isPositive,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isPositive
                      ? AppColors.successLight
                      : AppColors.background,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  isPositive
                      ? Icons.call_received_rounded
                      : Icons.arrow_outward_rounded,
                  size: 16,
                  color: isPositive ? AppColors.success : AppColors.textSub,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textMain)),
                  Text(date, style: AppTypography.tiny),
                ],
              ),
            ],
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: isPositive ? AppColors.success : AppColors.textMain,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// COMPONENT 7: WALLET VERIFICATION CARD
// =============================================================================
class WalletVerificationCard extends StatelessWidget {
  const WalletVerificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return HoverElevatedCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.accentLight,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.security_rounded,
                    color: AppColors.accent, size: 22),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF3C7),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text('ACTION REQ',
                    style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                        color: Color(0xFFD97706))),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Wallet Verification', style: AppTypography.h3),
          const SizedBox(height: 6),
          const Text(
            'Confirm secondary multi-signature approval to enable unlimited real-time settlements across accounts.',
            style: TextStyle(
                fontSize: 12,
                color: AppColors.textSub,
                height: 1.45),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text('Enable Vault Auth',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// REUSABLE PRIMITIVES: CARDS & INTERACTIVE BUTTONS
// =============================================================================
class HoverElevatedCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const HoverElevatedCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
  });

  @override
  State<HoverElevatedCard> createState() => _HoverElevatedCardState();
}

class _HoverElevatedCardState extends State<HoverElevatedCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, _isHovered ? -3 : 0, 0),
        padding: widget.padding,
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: AppDecorations.cardRadius,
          boxShadow: _isHovered
              ? AppDecorations.hoverCardShadow
              : AppDecorations.softCardShadow,
        ),
        child: widget.child,
      ),
    );
  }
}

class CustomCircularButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const CustomCircularButton({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(100),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.background,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.border),
          ),
          child: Icon(icon, size: 18, color: AppColors.textSub),
        ),
      ),
    );
  }
}