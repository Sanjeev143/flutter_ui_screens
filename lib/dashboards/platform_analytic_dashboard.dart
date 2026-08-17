import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() {
  runApp(const ZentraApp());
}

class ZentraApp extends StatelessWidget {
  const ZentraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amaze Valley Analytics',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFECEEF2),
        fontFamily: 'Inter',
      ),
      home: const DashboardShell(),
    );
  }
}

// ---------------------------------------------------------------------------
// SHELL WITH RESPONSIVE NAV & ROUTING
// ---------------------------------------------------------------------------
class DashboardShell extends StatefulWidget {
  const DashboardShell({super.key});

  @override
  State<DashboardShell> createState() => _DashboardShellState();
}

class _DashboardShellState extends State<DashboardShell> {
  String _selectedMenu = 'Home';

  final List<String> _menuItems = [
    'Home',
    'Payments',
    'Balances',
    'Customers',
    'Products',
    'Billing',
    'Reports',
    'Connect',
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;

    return Scaffold(
      backgroundColor: const Color(0xFFECEEF2),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 28,
            vertical: isMobile ? 12 : 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopNavBar(isMobile),
              const SizedBox(height: 18),
              _buildTitleAndFilters(isMobile),
              const SizedBox(height: 18),
              _renderCurrentScreen(isMobile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderCurrentScreen(bool isMobile) {
    switch (_selectedMenu) {
      case 'Home':
        return OverviewDashboardView(isMobile: isMobile);
      case 'Payments':
        return PaymentsPageView(isMobile: isMobile);
      case 'Balances':
        return BalancesPageView(isMobile: isMobile);
      case 'Customers':
        return CustomersPageView(isMobile: isMobile);
      case 'Products':
        return ProductsPageView(isMobile: isMobile);
      case 'Billing':
        return BillingPageView(isMobile: isMobile);
      case 'Reports':
        return ReportsPageView(isMobile: isMobile);
      case 'Connect':
        return ConnectIntegrationsPageView(isMobile: isMobile);
      default:
        return OverviewDashboardView(isMobile: isMobile);
    }
  }

  Widget _buildTopNavBar(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Brand Logo
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFFFF9500),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Icon(
                  Icons.crop_square_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Amaze-valley',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E242B),
                letterSpacing: -0.5,
              ),
            ),

            if (!isMobile) ...[
              const SizedBox(width: 36),
              Expanded(child: _buildNavTabs()),
            ] else
              const Spacer(),

            // Right Action Buttons
            _buildCircleButton(Icons.search),
            const SizedBox(width: 8),
            _buildCircleButton(
              Icons.notifications_none_rounded,
              hasBadge: true,
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE27D60), width: 1.8),
              ),
              child: const CircleAvatar(
                radius: 14,
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/100?img=68',
                ),
              ),
            ),
          ],
        ),
        if (isMobile) ...[
          const SizedBox(height: 14),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: _buildNavTabs(),
          ),
        ],
      ],
    );
  }

  Widget _buildNavTabs() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: _menuItems.map((item) {
        final isSelected = _selectedMenu == item;
        return Padding(
          padding: const EdgeInsets.only(right: 6.0),
          child: InkWell(
            onTap: () => setState(() => _selectedMenu = item),
            borderRadius: BorderRadius.circular(20),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF1F242D)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                item,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? Colors.white : const Color(0xFF555F6D),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCircleButton(IconData icon, {bool hasBadge = false}) {
    return Stack(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFE1E6EB)),
          ),
          child: Icon(icon, size: 17, color: const Color(0xFF333D4B)),
        ),
        if (hasBadge)
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Color(0xFFFF5C00),
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildTitleAndFilters(bool isMobile) {
    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Overview',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF191F28),
                  letterSpacing: -0.6,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.link,
                  size: 14,
                  color: Color(0xFF6B7684),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildDateDropdown('Jan 01 – July 31'),
                const SizedBox(width: 6),
                _buildFilterTag('compared to'),
                const SizedBox(width: 6),
                _buildDateDropdown('Aug 01 – Dec 31'),
                const SizedBox(width: 6),
                _buildDateDropdown('Daily', hasIcon: false),
                const SizedBox(width: 6),
                _buildActionWidgetBtn(),
              ],
            ),
          ),
        ],
      );
    }

    return Row(
      children: [
        const Text(
          'Overview',
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w800,
            color: Color(0xFF191F28),
            letterSpacing: -0.8,
          ),
        ),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.link, size: 16, color: Color(0xFF6B7684)),
        ),
        const Spacer(),
        _buildDateDropdown('Jan 01 – July 31'),
        const SizedBox(width: 8),
        _buildFilterTag('compared to'),
        const SizedBox(width: 8),
        _buildDateDropdown('Aug 01 – Dec 31'),
        const SizedBox(width: 8),
        _buildDateDropdown('Daily', hasIcon: false),
        const SizedBox(width: 8),
        _buildActionWidgetBtn(),
      ],
    );
  }

  Widget _buildDateDropdown(String text, {bool hasIcon = true}) {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE3E7ED)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hasIcon) ...[
            const Icon(
              Icons.calendar_today_outlined,
              size: 13,
              color: Color(0xFF4E5968),
            ),
            const SizedBox(width: 6),
          ],
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333D4B),
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.keyboard_arrow_down,
            size: 15,
            color: Color(0xFF4E5968),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE0E5EB),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 11, color: Color(0xFF6B7684)),
      ),
    );
  }

  Widget _buildActionWidgetBtn() {
    return Container(
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFE0E5EB),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: Text(
          'Add widget +',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF333D4B),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// RESPONSIVE OVERVIEW VIEW
// ---------------------------------------------------------------------------
class OverviewDashboardView extends StatelessWidget {
  final bool isMobile;
  const OverviewDashboardView({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    if (isMobile) {
      return Column(
        children: const [
          PaymentsFunnelCard(isMobile: true),
          SizedBox(height: 16),
          GrossVolumeCard(),
          SizedBox(height: 16),
          RetentionChartCard(),
          SizedBox(height: 16),
          MiniStatsCard(
            title: 'Transactions',
            value: '106k',
            badge: 'Peak: Wed',
            diffText: '+34,002',
            chartColor: Color(0xFF22C55E),
            pattern: [2, 3, 5, 8, 4, 3, 2, 2],
          ),
          SizedBox(height: 16),
          MiniStatsCard(
            title: 'Customers',
            value: '1,284',
            badge: 'Highest: Thu',
            diffText: '+320',
            chartColor: Color(0xFF2563EB),
            pattern: [2, 3, 4, 9, 3, 2, 2],
          ),
          SizedBox(height: 16),
          InsightsBannerCard(),
        ],
      );
    }

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Expanded(flex: 12, child: PaymentsFunnelCard(isMobile: false)),
            SizedBox(width: 20),
            Expanded(flex: 7, child: GrossVolumeCard()),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Expanded(flex: 6, child: RetentionChartCard()),
            SizedBox(width: 20),
            Expanded(
              flex: 8,
              child: Column(
                children: [
                  MiniStatsCard(
                    title: 'Transactions',
                    value: '106k',
                    badge: 'Peak: Wed',
                    diffText: '+34,002',
                    chartColor: Color(0xFF22C55E),
                    pattern: [2, 3, 5, 8, 4, 3, 2, 2],
                  ),
                  SizedBox(height: 20),
                  MiniStatsCard(
                    title: 'Customers',
                    value: '1,284',
                    badge: 'Highest: Thu',
                    diffText: '+320',
                    chartColor: Color(0xFF2563EB),
                    pattern: [2, 3, 4, 9, 3, 2, 2],
                  ),
                ],
              ),
            ),
            SizedBox(width: 20),
            Expanded(flex: 7, child: InsightsBannerCard()),
          ],
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// 1. PAYMENTS FUNNEL CARD
// ---------------------------------------------------------------------------
class PaymentsFunnelCard extends StatelessWidget {
  final bool isMobile;
  const PaymentsFunnelCard({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Payments',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF191F28),
                ),
              ),
              Icon(Icons.more_horiz, color: Color(0xFF8B95A1)),
            ],
          ),
          const SizedBox(height: 14),

          // Scrollable Funnel Stats on mobile
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: const [
                _FunnelHeaderItem(
                  'Initiated Payments',
                  '65.2k',
                  isGhosted: true,
                ),
                SizedBox(width: 18),
                _FunnelHeaderItem(
                  'Authorized Payments',
                  '54.8k',
                  isGhosted: true,
                ),
                SizedBox(width: 18),
                _FunnelHeaderItem(
                  'Successful Payments',
                  '48.6k',
                  isGhosted: false,
                ),
                SizedBox(width: 18),
                _FunnelHeaderItem(
                  'Payouts to Merchants',
                  '38.3k',
                  isGhosted: true,
                ),
                SizedBox(width: 18),
                _FunnelHeaderItem(
                  'Completed Transactions',
                  '32.9k',
                  isGhosted: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Responsive Canvas Height & Tooltip
          SizedBox(
            height: isMobile ? 170 : 200,
            width: double.infinity,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    Positioned.fill(
                      child: CustomPaint(painter: FunnelChartPainter()),
                    ),
                    Positioned(
                      left: constraints.maxWidth * 0.38,
                      top: 40,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: isMobile ? 9.5 : 11,
                              color: const Color(0xFF333D4B),
                            ),
                            children: const [
                              TextSpan(
                                text: '48.6k ',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              TextSpan(text: 'tx | Conv: '),
                              TextSpan(
                                text: '89% ',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              TextSpan(text: '| Drop: '),
                              TextSpan(
                                text: '-11%',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 12),

          // Responsive AI Explorer Field
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF4C82FB).withOpacity(0.12),
                  const Color(0xFF70B4FF).withOpacity(0.08),
                  Colors.white,
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFD6E4FF)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Icon(
                      Icons.auto_awesome,
                      size: 14,
                      color: Color(0xFF3B82F6),
                    ),
                    SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        'What would you like to explore next?',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4B5563),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Text(
                        'Drop-off from authorized to ',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF4B5563),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFEDD5),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: const Color(0xFFFDBA74)),
                        ),
                        child: const Text(
                          '/successful payments',
                          style: TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFC2410C),
                          ),
                        ),
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

class _FunnelHeaderItem extends StatelessWidget {
  final String label;
  final String value;
  final bool isGhosted;

  const _FunnelHeaderItem(this.label, this.value, {required this.isGhosted});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: isGhosted
                ? const Color(0xFF9CA3AF)
                : const Color(0xFF4B5563),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: isGhosted
                ? const Color(0xFF9CA3AF)
                : const Color(0xFF191F28),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// 2. GROSS VOLUME CARD
// ---------------------------------------------------------------------------
class GrossVolumeCard extends StatelessWidget {
  const GrossVolumeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Gross Volume',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF191F28),
                ),
              ),
              Icon(Icons.more_horiz, color: Color(0xFF8B95A1)),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Text(
                r'$41,540',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF191F28),
                  letterSpacing: -0.8,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.arrow_drop_up,
                      size: 14,
                      color: Color(0xFF16A34A),
                    ),
                    Text(
                      '15%',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF16A34A),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const _VolumeSegmentBar(
            title: 'Online Payments',
            amount: r'$26,800',
            fillPercentage: 0.85,
            primaryColor: Color(0xFF10B981),
            secondaryColor: Color(0xFF059669),
          ),
          const SizedBox(height: 14),
          const _VolumeSegmentBar(
            title: 'Subscriptions',
            amount: r'$10,400',
            fillPercentage: 0.55,
            primaryColor: Color(0xFF3B82F6),
            secondaryColor: Color(0xFF1D4ED8),
          ),
          const SizedBox(height: 14),
          const _VolumeSegmentBar(
            title: 'In-Store Sales',
            amount: r'$4,340',
            fillPercentage: 0.35,
            primaryColor: Color(0xFFF43F5E),
            secondaryColor: Color(0xFFBE123C),
          ),
        ],
      ),
    );
  }
}

class _VolumeSegmentBar extends StatelessWidget {
  final String title;
  final String amount;
  final double fillPercentage;
  final Color primaryColor;
  final Color secondaryColor;

  const _VolumeSegmentBar({
    required this.title,
    required this.amount,
    required this.fillPercentage,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 12.5,
                color: Color(0xFF4B5563),
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              amount,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF191F28),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: 10,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFFF1F4F8),
            borderRadius: BorderRadius.circular(5),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Align(
                alignment: Alignment.centerLeft,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: SizedBox(
                    width: constraints.maxWidth * fillPercentage,
                    height: 10,
                    child: CustomPaint(
                      painter: StripedBarPainter(primaryColor, secondaryColor),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// 3. RETENTION CARD
// ---------------------------------------------------------------------------
class RetentionChartCard extends StatelessWidget {
  const RetentionChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Retention',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF191F28),
                ),
              ),
              Icon(Icons.more_horiz, color: Color(0xFF8B95A1)),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 130,
            width: double.infinity,
            child: Stack(
              children: [
                Positioned.fill(
                  child: CustomPaint(painter: RetentionStepPainter()),
                ),
                Positioned(
                  top: 0,
                  left: 60,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: const Text(
                      '42%',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _MonthText('Jan'),
              _MonthText('Feb'),
              _MonthText('Mar'),
              _MonthText('Apr'),
              _MonthText('May'),
              _MonthText('Jun'),
            ],
          ),
        ],
      ),
    );
  }
}

class _MonthText extends StatelessWidget {
  final String text;
  const _MonthText(this.text);
  @override
  Widget build(BuildContext context) => Text(
    text,
    style: const TextStyle(fontSize: 11, color: Color(0xFF9CA3AF)),
  );
}

// ---------------------------------------------------------------------------
// 4. MINI STATS CARD
// ---------------------------------------------------------------------------
class MiniStatsCard extends StatelessWidget {
  final String title;
  final String value;
  final String badge;
  final String diffText;
  final Color chartColor;
  final List<int> pattern;

  const MiniStatsCard({
    super.key,
    required this.title,
    required this.value,
    required this.badge,
    required this.diffText,
    required this.chartColor,
    required this.pattern,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF191F28),
                ),
              ),
              const Icon(Icons.more_horiz, color: Color(0xFF8B95A1)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF191F28),
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      badge,
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: pattern.map((count) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 1.5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            count,
                            (index) => Container(
                              margin: const EdgeInsets.symmetric(vertical: 1),
                              width: 4.5,
                              height: 4.5,
                              decoration: BoxDecoration(
                                color: chartColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'vs last period',
                    style: TextStyle(fontSize: 9.5, color: Color(0xFF9CA3AF)),
                  ),
                  Text(
                    diffText,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF191F28),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 5. INSIGHTS BANNER
// ---------------------------------------------------------------------------
class InsightsBannerCard extends StatelessWidget {
  const InsightsBannerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const RadialGradient(
          center: Alignment(0.8, -0.6),
          radius: 1.4,
          colors: [
            Color(0xFFFDBA74),
            Color(0xFFEA580C),
            Color(0xFF2563EB),
            Color(0xFF1E3A8A),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.lightbulb_outline, color: Colors.white, size: 12),
                SizedBox(width: 4),
                Text(
                  'Insights',
                  style: TextStyle(
                    fontSize: 10.5,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            '75%',
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Authorization rate increased\nby 4% compared to last week.',
            style: TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'This improvement reduced failed transactions by 950 and is projected to recover \$12,400.',
            style: TextStyle(
              fontSize: 11,
              color: Colors.white.withOpacity(0.8),
              height: 1.3,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Container(
                  height: 3,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Container(
                  height: 3,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
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

// ---------------------------------------------------------------------------
// 6. GENERIC PLACEHOLDER - Not using
// ---------------------------------------------------------------------------
class _GenericPlaceholderScreen extends StatelessWidget {
  final String title;
  const _GenericPlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.dashboard_customize_outlined,
            size: 48,
            color: Colors.blueGrey.shade300,
          ),
          const SizedBox(height: 12),
          Text(
            '$title Screen',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF191F28),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Content for $title is loaded here.',
            style: const TextStyle(color: Color(0xFF6B7684), fontSize: 13),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// CUSTOM PAINTERS
// ---------------------------------------------------------------------------
class StripedBarPainter extends CustomPainter {
  final Color c1, c2;
  StripedBarPainter(this.c1, this.c2);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = c1);
    final stripePaint = Paint()
      ..color = c2
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    for (double i = -size.height; i < size.width + size.height; i += 5.0) {
      canvas.drawLine(
        Offset(i, size.height),
        Offset(i + size.height, 0),
        stripePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class FunnelChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final stepWidth = size.width / 5;
    final heights = [
      size.height * 0.85,
      size.height * 0.70,
      size.height * 0.55,
      size.height * 0.38,
      size.height * 0.25,
    ];

    for (int i = 0; i < 5; i++) {
      final left = i * stepWidth + 4;
      final right = (i + 1) * stepWidth - 4;
      final top = size.height - heights[i];
      final rect = Rect.fromLTRB(left, top, right, size.height);

      if (i == 2) {
        final solidPaint = Paint()
          ..shader = const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0070F3), Color(0xFF003FB0)],
          ).createShader(rect);
        canvas.drawRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(5)),
          solidPaint,
        );
      } else {
        canvas.drawRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(5)),
          Paint()..color = const Color(0xFF3B82F6).withOpacity(0.12),
        );
        final stripePaint = Paint()
          ..color = const Color(0xFF3B82F6).withOpacity(0.5)
          ..strokeWidth = 1.6;
        canvas.save();
        canvas.clipRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(5)),
        );
        for (double x = left - heights[i]; x < right + heights[i]; x += 6) {
          canvas.drawLine(
            Offset(x, size.height),
            Offset(x + heights[i], top),
            stripePaint,
          );
        }
        canvas.restore();
      }

      final capRect = Rect.fromCenter(
        center: Offset((left + right) / 2, top - 4),
        width: (right - left) * 0.45,
        height: 3,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(capRect, const Radius.circular(2)),
        Paint()
          ..color = (i == 2)
              ? const Color(0xFF0070F3)
              : const Color(0xFF93C5FD),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class RetentionStepPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFF43F5E)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFFF43F5E).withOpacity(0.15),
          const Color(0xFFF43F5E).withOpacity(0.0),
        ],
      ).createShader(Offset.zero & size)
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.lineTo(size.width * 0.15, size.height * 0.7);
    path.lineTo(size.width * 0.15, size.height * 0.55);
    path.lineTo(size.width * 0.32, size.height * 0.55);
    path.lineTo(size.width * 0.32, size.height * 0.22);
    path.lineTo(size.width * 0.45, size.height * 0.22);
    path.lineTo(size.width * 0.45, size.height * 0.35);
    path.lineTo(size.width * 0.58, size.height * 0.35);
    path.lineTo(size.width * 0.58, size.height * 0.65);
    path.lineTo(size.width * 0.75, size.height * 0.65);
    path.lineTo(size.width * 0.75, size.height * 0.75);
    path.lineTo(size.width, size.height * 0.75);

    canvas.drawPath(path, paint);

    final fillPath = Path.from(path);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();
    canvas.drawPath(fillPath, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class PaymentsPageView extends StatelessWidget {
  final bool isMobile;
  const PaymentsPageView({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final transactions = [
      {
        'id': '#TX-9021',
        'client': 'Stripe Connect',
        'amount': r'$1,450.00',
        'status': 'Succeeded',
        'color': Color(0xFF10B981),
      },
      {
        'id': '#TX-9020',
        'client': 'Shopify Merchant',
        'amount': r'$840.50',
        'status': 'Succeeded',
        'color': Color(0xFF10B981),
      },
      {
        'id': '#TX-9019',
        'client': 'Apple Pay Direct',
        'amount': r'$2,100.00',
        'status': 'Processing',
        'color': Color(0xFFF59E0B),
      },
      {
        'id': '#TX-9018',
        'client': 'Global Gateway',
        'amount': r'$130.00',
        'status': 'Refunded',
        'color': Color(0xFFEF4444),
      },
      {
        'id': '#TX-9021',
        'client': 'Stripe Connect',
        'amount': r'$1,450.00',
        'status': 'Succeeded',
        'color': Color(0xFF10B981),
      },
      {
        'id': '#TX-9020',
        'client': 'Shopify Merchant',
        'amount': r'$840.50',
        'status': 'Succeeded',
        'color': Color(0xFF10B981),
      },
      {
        'id': '#TX-9019',
        'client': 'Apple Pay Direct',
        'amount': r'$2,100.00',
        'status': 'Processing',
        'color': Color(0xFFF59E0B),
      },
      {
        'id': '#TX-9018',
        'client': 'Global Gateway',
        'amount': r'$130.00',
        'status': 'Refunded',
        'color': Color(0xFFEF4444),
      },
      {
        'id': '#TX-9021',
        'client': 'Stripe Connect',
        'amount': r'$1,450.00',
        'status': 'Succeeded',
        'color': Color(0xFF10B981),
      },
      {
        'id': '#TX-9020',
        'client': 'Shopify Merchant',
        'amount': r'$840.50',
        'status': 'Succeeded',
        'color': Color(0xFF10B981),
      },
      {
        'id': '#TX-9019',
        'client': 'Apple Pay Direct',
        'amount': r'$2,100.00',
        'status': 'Processing',
        'color': Color(0xFFF59E0B),
      },
      {
        'id': '#TX-9018',
        'client': 'Global Gateway',
        'amount': r'$130.00',
        'status': 'Refunded',
        'color': Color(0xFFEF4444),
      },
      {
        'id': '#TX-9021',
        'client': 'Stripe Connect',
        'amount': r'$1,450.00',
        'status': 'Succeeded',
        'color': Color(0xFF10B981),
      },
      {
        'id': '#TX-9020',
        'client': 'Shopify Merchant',
        'amount': r'$840.50',
        'status': 'Succeeded',
        'color': Color(0xFF10B981),
      },
      {
        'id': '#TX-9019',
        'client': 'Apple Pay Direct',
        'amount': r'$2,100.00',
        'status': 'Processing',
        'color': Color(0xFFF59E0B),
      },
      {
        'id': '#TX-9018',
        'client': 'Global Gateway',
        'amount': r'$130.00',
        'status': 'Refunded',
        'color': Color(0xFFEF4444),
      },
      {
        'id': '#TX-9021',
        'client': 'Stripe Connect',
        'amount': r'$1,450.00',
        'status': 'Succeeded',
        'color': Color(0xFF10B981),
      },
      {
        'id': '#TX-9020',
        'client': 'Shopify Merchant',
        'amount': r'$840.50',
        'status': 'Succeeded',
        'color': Color(0xFF10B981),
      },
      {
        'id': '#TX-9019',
        'client': 'Apple Pay Direct',
        'amount': r'$2,100.00',
        'status': 'Processing',
        'color': Color(0xFFF59E0B),
      },
      {
        'id': '#TX-9018',
        'client': 'Global Gateway',
        'amount': r'$130.00',
        'status': 'Refunded',
        'color': Color(0xFFEF4444),
      },
      {
        'id': '#TX-9021',
        'client': 'Stripe Connect',
        'amount': r'$1,450.00',
        'status': 'Succeeded',
        'color': Color(0xFF10B981),
      },
      {
        'id': '#TX-9020',
        'client': 'Shopify Merchant',
        'amount': r'$840.50',
        'status': 'Succeeded',
        'color': Color(0xFF10B981),
      },
      {
        'id': '#TX-9019',
        'client': 'Apple Pay Direct',
        'amount': r'$2,100.00',
        'status': 'Processing',
        'color': Color(0xFFF59E0B),
      },
      {
        'id': '#TX-9018',
        'client': 'Global Gateway',
        'amount': r'$130.00',
        'status': 'Refunded',
        'color': Color(0xFFEF4444),
      },
      {
        'id': '#TX-9021',
        'client': 'Stripe Connect',
        'amount': r'$1,450.00',
        'status': 'Succeeded',
        'color': Color(0xFF10B981),
      },
      {
        'id': '#TX-9020',
        'client': 'Shopify Merchant',
        'amount': r'$840.50',
        'status': 'Succeeded',
        'color': Color(0xFF10B981),
      },
      {
        'id': '#TX-9019',
        'client': 'Apple Pay Direct',
        'amount': r'$2,100.00',
        'status': 'Processing',
        'color': Color(0xFFF59E0B),
      },
      {
        'id': '#TX-9018',
        'client': 'Global Gateway',
        'amount': r'$130.00',
        'status': 'Refunded',
        'color': Color(0xFFEF4444),
      },
      {
        'id': '#TX-9021',
        'client': 'Stripe Connect',
        'amount': r'$1,450.00',
        'status': 'Succeeded',
        'color': Color(0xFF10B981),
      },
      {
        'id': '#TX-9020',
        'client': 'Shopify Merchant',
        'amount': r'$840.50',
        'status': 'Succeeded',
        'color': Color(0xFF10B981),
      },
      {
        'id': '#TX-9019',
        'client': 'Apple Pay Direct',
        'amount': r'$2,100.00',
        'status': 'Processing',
        'color': Color(0xFFF59E0B),
      },
      {
        'id': '#TX-9018',
        'client': 'Global Gateway',
        'amount': r'$130.00',
        'status': 'Refunded',
        'color': Color(0xFFEF4444),
      },
    ];

    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Recent Transactions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF191F28),
                ),
              ),
              Text(
                'Export CSV',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF2563EB),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(const Color(0xFFF8FAFC)),
              columns: const [
                DataColumn(
                  label: Text(
                    'Transaction ID',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Source / Merchant',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Amount',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Status',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              rows: transactions.map((tx) {
                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        tx['id'] as String,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    DataCell(Text(tx['client'] as String)),
                    DataCell(
                      Text(
                        tx['amount'] as String,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: (tx['color'] as Color).withOpacity(0.12),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          tx['status'] as String,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: tx['color'] as Color,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 2. BALANCES VIEW (Currency Payouts & Reserve)
// ---------------------------------------------------------------------------
class BalancesPageView extends StatelessWidget {
  final bool isMobile;
  const BalancesPageView({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Expanded(
              child: _BalanceMetricCard(
                title: 'Available Balance',
                value: r'$128,490.00',
                change: '+12.4% vs last week',
                isPositive: true,
              ),
            ),
            SizedBox(width: 14),
            Expanded(
              child: _BalanceMetricCard(
                title: 'Pending Payouts',
                value: r'$14,210.50',
                change: 'Scheduled in 2 days',
                isPositive: false,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(isMobile ? 16 : 22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Currency Breakdown',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 14),
              _CurrencyRow(
                'USD - US Dollar',
                r'$98,340.00',
                '76.5%',
                const Color(0xFF2563EB),
              ),
              _CurrencyRow(
                'EUR - Euro',
                '€24,150.00',
                '18.8%',
                const Color(0xFF10B981),
              ),
              _CurrencyRow(
                'GBP - British Pound',
                '£6,000.00',
                '4.7%',
                const Color(0xFFF59E0B),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BalanceMetricCard extends StatelessWidget {
  final String title, value, change;
  final bool isPositive;
  const _BalanceMetricCard({
    required this.title,
    required this.value,
    required this.change,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Color(0xFF6B7684), fontSize: 13),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Color(0xFF191F28),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            change,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isPositive
                  ? const Color(0xFF16A34A)
                  : const Color(0xFF6B7684),
            ),
          ),
        ],
      ),
    );
  }
}

class _CurrencyRow extends StatelessWidget {
  final String currency, amount, percentage;
  final Color color;
  const _CurrencyRow(this.currency, this.amount, this.percentage, this.color);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 4, backgroundColor: color),
              const SizedBox(width: 8),
              Text(
                currency,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                amount,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.5,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                percentage,
                style: const TextStyle(color: Color(0xFF6B7684), fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 3. CUSTOMERS VIEW (Directory list)
// ---------------------------------------------------------------------------
class CustomersPageView extends StatelessWidget {
  final bool isMobile;
  const CustomersPageView({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final customers = [
      {
        'name': 'Marcus Vance',
        'email': 'marcus.v@acme.inc',
        'spend': r'$4,920',
        'avatar': 'https://i.pravatar.cc/100?img=12',
      },
      {
        'name': 'Sophia Chen',
        'email': 'sophia@aurora.design',
        'spend': r'$8,130',
        'avatar': 'https://i.pravatar.cc/100?img=32',
      },
      {
        'name': 'Liam Gallagher',
        'email': 'liam.g@cloudtech.io',
        'spend': r'$2,410',
        'avatar': 'https://i.pravatar.cc/100?img=59',
      },
      {
        'name': 'Elena Rostova',
        'email': 'elena@novacorp.com',
        'spend': r'$11,850',
        'avatar': 'https://i.pravatar.cc/100?img=47',
      },
      {
        'name': 'Marcus Vance',
        'email': 'marcus.v@acme.inc',
        'spend': r'$4,920',
        'avatar': 'https://i.pravatar.cc/100?img=12',
      },
      {
        'name': 'Sophia Chen',
        'email': 'sophia@aurora.design',
        'spend': r'$8,130',
        'avatar': 'https://i.pravatar.cc/100?img=32',
      },
      {
        'name': 'Liam Gallagher',
        'email': 'liam.g@cloudtech.io',
        'spend': r'$2,410',
        'avatar': 'https://i.pravatar.cc/100?img=59',
      },
      {
        'name': 'Elena Rostova',
        'email': 'elena@novacorp.com',
        'spend': r'$11,850',
        'avatar': 'https://i.pravatar.cc/100?img=47',
      },
      {
        'name': 'Marcus Vance',
        'email': 'marcus.v@acme.inc',
        'spend': r'$4,920',
        'avatar': 'https://i.pravatar.cc/100?img=12',
      },
      {
        'name': 'Sophia Chen',
        'email': 'sophia@aurora.design',
        'spend': r'$8,130',
        'avatar': 'https://i.pravatar.cc/100?img=32',
      },
      {
        'name': 'Liam Gallagher',
        'email': 'liam.g@cloudtech.io',
        'spend': r'$2,410',
        'avatar': 'https://i.pravatar.cc/100?img=59',
      },
      {
        'name': 'Elena Rostova',
        'email': 'elena@novacorp.com',
        'spend': r'$11,850',
        'avatar': 'https://i.pravatar.cc/100?img=47',
      },
      {
        'name': 'Marcus Vance',
        'email': 'marcus.v@acme.inc',
        'spend': r'$4,920',
        'avatar': 'https://i.pravatar.cc/100?img=12',
      },
      {
        'name': 'Sophia Chen',
        'email': 'sophia@aurora.design',
        'spend': r'$8,130',
        'avatar': 'https://i.pravatar.cc/100?img=32',
      },
      {
        'name': 'Liam Gallagher',
        'email': 'liam.g@cloudtech.io',
        'spend': r'$2,410',
        'avatar': 'https://i.pravatar.cc/100?img=59',
      },
      {
        'name': 'Elena Rostova',
        'email': 'elena@novacorp.com',
        'spend': r'$11,850',
        'avatar': 'https://i.pravatar.cc/100?img=47',
      },
    ];

    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Customer Directory',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          ...customers.map(
            (c) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                backgroundImage: NetworkImage(c['avatar']!),
              ),
              title: Text(
                c['name']!,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              subtitle: Text(
                c['email']!,
                style: const TextStyle(fontSize: 12, color: Color(0xFF6B7684)),
              ),
              trailing: Text(
                c['spend']!,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  color: Color(0xFF191F28),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 4. PRODUCTS VIEW (SKU & Catalog Grid)
// ---------------------------------------------------------------------------
class ProductsPageView extends StatelessWidget {
  final bool isMobile;
  const ProductsPageView({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final products = [
      {
        'name': 'Enterprise API Plan',
        'active': '342 Subs',
        'price': r'$299/mo',
        'icon': Icons.api_rounded,
      },
      {
        'name': 'Team Workspace Tier',
        'active': '1,120 Subs',
        'price': r'$49/mo',
        'icon': Icons.groups_rounded,
      },
      {
        'name': 'Single Developer License',
        'active': '4,890 Subs',
        'price': r'$12/mo',
        'icon': Icons.code_rounded,
      },
      {
        'name': 'Enterprise API Plan',
        'active': '342 Subs',
        'price': r'$299/mo',
        'icon': Icons.api_rounded,
      },
      {
        'name': 'Team Workspace Tier',
        'active': '1,120 Subs',
        'price': r'$49/mo',
        'icon': Icons.groups_rounded,
      },
      {
        'name': 'Single Developer License',
        'active': '4,890 Subs',
        'price': r'$12/mo',
        'icon': Icons.code_rounded,
      },
      {
        'name': 'Enterprise API Plan',
        'active': '342 Subs',
        'price': r'$299/mo',
        'icon': Icons.api_rounded,
      },
      {
        'name': 'Team Workspace Tier',
        'active': '1,120 Subs',
        'price': r'$49/mo',
        'icon': Icons.groups_rounded,
      },
      {
        'name': 'Single Developer License',
        'active': '4,890 Subs',
        'price': r'$12/mo',
        'icon': Icons.code_rounded,
      },
      {
        'name': 'Enterprise API Plan',
        'active': '342 Subs',
        'price': r'$299/mo',
        'icon': Icons.api_rounded,
      },
      {
        'name': 'Team Workspace Tier',
        'active': '1,120 Subs',
        'price': r'$49/mo',
        'icon': Icons.groups_rounded,
      },
      {
        'name': 'Single Developer License',
        'active': '4,890 Subs',
        'price': r'$12/mo',
        'icon': Icons.code_rounded,
      },
      {
        'name': 'Enterprise API Plan',
        'active': '342 Subs',
        'price': r'$299/mo',
        'icon': Icons.api_rounded,
      },
      {
        'name': 'Team Workspace Tier',
        'active': '1,120 Subs',
        'price': r'$49/mo',
        'icon': Icons.groups_rounded,
      },
      {
        'name': 'Single Developer License',
        'active': '4,890 Subs',
        'price': r'$12/mo',
        'icon': Icons.code_rounded,
      },
    ];

    return Column(
      children: products.map((p) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF2FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  p['icon'] as IconData,
                  color: const Color(0xFF4F46E5),
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p['name'] as String,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      p['active'] as String,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6B7684),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                p['price'] as String,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                  color: Color(0xFF191F28),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ---------------------------------------------------------------------------
// 5. BILLING VIEW
// ---------------------------------------------------------------------------
class BillingPageView extends StatelessWidget {
  final bool isMobile;
  const BillingPageView({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Invoicing & Subscriptions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Expanded(
                child: _BillingStatusPill(
                  'Pending Invoices',
                  r'$8,420',
                  Color(0xFFF59E0B),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: _BillingStatusPill(
                  'Collected MTD',
                  r'$45,210',
                  Color(0xFF10B981),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BillingStatusPill extends StatelessWidget {
  final String label, value;
  final Color color;
  const _BillingStatusPill(this.label, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 11.5, color: Color(0xFF64748B)),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 6. REPORTS VIEW
// ---------------------------------------------------------------------------
class ReportsPageView extends StatelessWidget {
  final bool isMobile;
  const ReportsPageView({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final reports = [
      {
        'name': 'Q2 Financial Audit Summary.pdf',
        'date': 'July 31, 2026',
        'size': '2.4 MB',
      },
      {
        'name': 'Monthly Cohort Retention Analysis.csv',
        'date': 'July 15, 2026',
        'size': '840 KB',
      },
      {
        'name': 'Payment Gateway Reconciliation.xlsx',
        'date': 'July 01, 2026',
        'size': '4.1 MB',
      },
      {
        'name': 'Q2 Financial Audit Summary.pdf',
        'date': 'July 31, 2026',
        'size': '2.4 MB',
      },
      {
        'name': 'Monthly Cohort Retention Analysis.csv',
        'date': 'July 15, 2026',
        'size': '840 KB',
      },
      {
        'name': 'Payment Gateway Reconciliation.xlsx',
        'date': 'July 01, 2026',
        'size': '4.1 MB',
      },
      {
        'name': 'Q2 Financial Audit Summary.pdf',
        'date': 'July 31, 2026',
        'size': '2.4 MB',
      },
      {
        'name': 'Monthly Cohort Retention Analysis.csv',
        'date': 'July 15, 2026',
        'size': '840 KB',
      },
      {
        'name': 'Payment Gateway Reconciliation.xlsx',
        'date': 'July 01, 2026',
        'size': '4.1 MB',
      },
      {
        'name': 'Q2 Financial Audit Summary.pdf',
        'date': 'July 31, 2026',
        'size': '2.4 MB',
      },
      {
        'name': 'Monthly Cohort Retention Analysis.csv',
        'date': 'July 15, 2026',
        'size': '840 KB',
      },
      {
        'name': 'Payment Gateway Reconciliation.xlsx',
        'date': 'July 01, 2026',
        'size': '4.1 MB',
      },
      {
        'name': 'Q2 Financial Audit Summary.pdf',
        'date': 'July 31, 2026',
        'size': '2.4 MB',
      },
      {
        'name': 'Monthly Cohort Retention Analysis.csv',
        'date': 'July 15, 2026',
        'size': '840 KB',
      },
      {
        'name': 'Payment Gateway Reconciliation.xlsx',
        'date': 'July 01, 2026',
        'size': '4.1 MB',
      },
      {
        'name': 'Q2 Financial Audit Summary.pdf',
        'date': 'July 31, 2026',
        'size': '2.4 MB',
      },
      {
        'name': 'Monthly Cohort Retention Analysis.csv',
        'date': 'July 15, 2026',
        'size': '840 KB',
      },
      {
        'name': 'Payment Gateway Reconciliation.xlsx',
        'date': 'July 01, 2026',
        'size': '4.1 MB',
      },
      {
        'name': 'Q2 Financial Audit Summary.pdf',
        'date': 'July 31, 2026',
        'size': '2.4 MB',
      },
      {
        'name': 'Monthly Cohort Retention Analysis.csv',
        'date': 'July 15, 2026',
        'size': '840 KB',
      },
      {
        'name': 'Payment Gateway Reconciliation.xlsx',
        'date': 'July 01, 2026',
        'size': '4.1 MB',
      },
      {
        'name': 'Q2 Financial Audit Summary.pdf',
        'date': 'July 31, 2026',
        'size': '2.4 MB',
      },
      {
        'name': 'Monthly Cohort Retention Analysis.csv',
        'date': 'July 15, 2026',
        'size': '840 KB',
      },
      {
        'name': 'Payment Gateway Reconciliation.xlsx',
        'date': 'July 01, 2026',
        'size': '4.1 MB',
      },
      {
        'name': 'Q2 Financial Audit Summary.pdf',
        'date': 'July 31, 2026',
        'size': '2.4 MB',
      },
      {
        'name': 'Monthly Cohort Retention Analysis.csv',
        'date': 'July 15, 2026',
        'size': '840 KB',
      },
      {
        'name': 'Payment Gateway Reconciliation.xlsx',
        'date': 'July 01, 2026',
        'size': '4.1 MB',
      },
      {
        'name': 'Q2 Financial Audit Summary.pdf',
        'date': 'July 31, 2026',
        'size': '2.4 MB',
      },
      {
        'name': 'Monthly Cohort Retention Analysis.csv',
        'date': 'July 15, 2026',
        'size': '840 KB',
      },
      {
        'name': 'Payment Gateway Reconciliation.xlsx',
        'date': 'July 01, 2026',
        'size': '4.1 MB',
      },
    ];

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Generated Reports & Statements',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          ...reports.map(
            (r) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.insert_drive_file_outlined,
                color: Color(0xFF2563EB),
              ),
              title: Text(
                r['name']!,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13.5,
                ),
              ),
              subtitle: Text(
                '${r['date']} • ${r['size']}',
                style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
              ),
              trailing: const Icon(
                Icons.file_download_outlined,
                size: 20,
                color: Color(0xFF475569),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 7. CONNECT VIEW (Integration Toggles)
// ---------------------------------------------------------------------------
class ConnectIntegrationsPageView extends StatelessWidget {
  final bool isMobile;
  const ConnectIntegrationsPageView({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    final integrations = [
      {
        'name': 'QuickBooks Online',
        'desc': 'Automate general ledger syncing',
        'connected': true,
      },
      {
        'name': 'Shopify Webhooks',
        'desc': 'Real-time order and refund events',
        'connected': true,
      },
      {
        'name': 'Salesforce CRM',
        'desc': 'Sync customer spend tiers with CRM accounts',
        'connected': false,
      },
      {
        'name': 'Slack Alerts',
        'desc': 'Daily digest of high-volume transactions',
        'connected': true,
      },
    ];

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Active Connectors & Webhooks',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          ...integrations.map(
            (item) => SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                item['name'] as String,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              subtitle: Text(
                item['desc'] as String,
                style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
              ),
              value: item['connected'] as bool,
              activeColor: const Color(0xFF2563EB),
              onChanged: (val) {},
            ),
          ),
        ],
      ),
    );
  }
}
