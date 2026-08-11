import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const VendorApp());
}

class VendorApp extends StatelessWidget {
  const VendorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amazevalley',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF3F5FA),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          primary: const Color(0xFF2563EB),
        ),
        useMaterial3: true,
      ),
      home: const DashboardShell(),
    );
  }
}

// ==========================================
// GLASSMORPHIC CONTAINER WIDGET
// ==========================================
class GlassCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;

  const GlassCard({
    super.key,
    required this.child,
    this.borderRadius = 20,
    this.padding,
    this.margin,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: padding ?? const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: backgroundColor ?? Colors.white.withOpacity(0.75),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: Colors.white.withOpacity(0.8),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF2563EB).withOpacity(0.04),
                  blurRadius: 20,
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
// DUMMY DATASET (50+ VENDORS)
// ==========================================
class VendorModel {
  final String name;
  final String domain;
  final String grade;
  final int rating;
  final int changePercent;
  final bool isPositive;
  final String lastAssessed;
  final String status;
  final String category;
  final String accessLevel;

  VendorModel({
    required this.name,
    required this.domain,
    required this.grade,
    required this.rating,
    required this.changePercent,
    required this.isPositive,
    required this.lastAssessed,
    required this.status,
    required this.category,
    required this.accessLevel,
  });
}

final List<VendorModel> dummyVendors = List.generate(52, (index) {
  final names = ['Basecamp', 'Framer', 'Figma', 'Sketch', 'Slack', 'Notion', 'GitHub', 'Atlassian', 'Airtable', 'Miro'];
  final name = '${names[index % names.length]} ${index > 9 ? "#${index + 1}" : ""}';
  final domain = '${names[index % names.length].toLowerCase().replaceAll(" ", "")}.com';
  final grades = ['A', 'B', 'C', 'D'];
  final grade = grades[index % grades.length];
  final rating = 50 + (index * 7) % 49;
  final isPos = index % 3 != 0;
  final statuses = ['Active', 'Pending', 'In Review'];
  final categories = ['Customer Data', 'Business Data', 'Sensitive Data', 'Internal Data'];
  final accessLevels = ['Admin access', 'Write access', 'Read access'];

  return VendorModel(
    name: name,
    domain: domain,
    grade: grade,
    rating: rating,
    changePercent: (index % 15) + 1,
    isPositive: isPos,
    lastAssessed: '${(index % 28) + 1} Feb 2026',
    status: statuses[index % statuses.length],
    category: categories[index % categories.length],
    accessLevel: accessLevels[index % accessLevels.length],
  );
});

// ==========================================
// MAIN RESPONSIVE DASHBOARD SHELL
// ==========================================
class DashboardShell extends StatefulWidget {
  const DashboardShell({super.key});

  @override
  State<DashboardShell> createState() => _DashboardShellState();
}

class _DashboardShellState extends State<DashboardShell> {
  int _selectedIndex = 2; // Default: Overview

  final List<String> _menuTitles = [
    'Home Overview',
    'Reports Studio',
    'Organization Overview',
    'Risk Profile Analysis',
    'Remediation Tasks',
    'Domains Directory',
    'Identity Breaches',
    'Security Profile',
  ];

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 950;

    return Scaffold(
      drawer: !isDesktop
          ? Drawer(
        backgroundColor: const Color(0xFFF3F5FA),
        child: _SidebarNavigation(
          selectedIndex: _selectedIndex,
          onSelected: (idx) {
            setState(() => _selectedIndex = idx);
            Navigator.pop(context);
          },
        ),
      )
          : null,
      body: Row(
        children: [
          if (isDesktop)
            SizedBox(
              width: 240,
              child: _SidebarNavigation(
                selectedIndex: _selectedIndex,
                onSelected: (idx) => setState(() => _selectedIndex = idx),
              ),
            ),
          Expanded(
            child: _buildMainBody(isDesktop),
          ),
        ],
      ),
    );
  }

  Widget _buildMainBody(bool isDesktop) {
    if (!isDesktop) {
      // Mobile & Tablet view using SliverAppBar
      return CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            backgroundColor: Colors.white.withOpacity(0.85),
            elevation: 0,
            title: Text(
              _menuTitles[_selectedIndex],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF1E293B)),
            ),
            actions: [
              IconButton(icon: const Icon(Icons.filter_list, size: 20), onPressed: () {}),
              IconButton(icon: const Icon(Icons.file_upload_outlined, size: 20), onPressed: () {}),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: _buildViewContent(_selectedIndex, isDesktop: false),
            ),
          ),
        ],
      );
    }

    // Web & Desktop layout
    return Column(
      children: [
        _TopHeaderDesktop(title: _menuTitles[_selectedIndex]),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: _buildViewContent(_selectedIndex, isDesktop: true),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildViewContent(int index, {required bool isDesktop}) {
    switch (index) {
      case 2:
        return _OrganizationOverviewContent(isDesktop: isDesktop);
      default:
        return _GenericModuleContent(title: _menuTitles[index]);
    }
  }
}

// ==========================================
// SIDEBAR NAVIGATION WIDGET
// ==========================================
class _SidebarNavigation extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const _SidebarNavigation({required this.selectedIndex, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF3F5FA),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              'Bradi.',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E293B),
                letterSpacing: -0.5,
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Main Menu Items
          _navTile(0, Icons.home_outlined, 'Home'),
          _navTile(1, Icons.insert_drive_file_outlined, 'Reports'),
          const SizedBox(height: 24),

          // Section Header
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              'ORGANIZATION',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black38, letterSpacing: 1.2),
            ),
          ),
          const SizedBox(height: 8),

          _navTile(2, Icons.pie_chart_outline_rounded, 'Overview'),
          _navTile(3, Icons.error_outline_rounded, 'Risk Profile'),
          _navTile(4, Icons.outlined_flag_rounded, 'Remediation'),
          _navTile(5, Icons.language_rounded, 'Domains'),
          _navTile(6, Icons.hub_outlined, 'Identity breaches'),
          _navTile(7, Icons.shield_outlined, 'Security profile'),
        ],
      ),
    );
  }

  Widget _navTile(int index, IconData icon, String label) {
    final bool isSelected = selectedIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          dense: true,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          tileColor: isSelected ? const Color(0xFF2563EB) : Colors.transparent,
          leading: Icon(icon, color: isSelected ? Colors.white : Colors.black54, size: 20),
          title: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? Colors.white : Colors.black87,
            ),
          ),
          onTap: () => onSelected(index),
        ),
      ),
    );
  }
}

// ==========================================
// TOP DESKTOP HEADER
// ==========================================
class _TopHeaderDesktop extends StatelessWidget {
  final String title;

  const _TopHeaderDesktop({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
          const Spacer(),
          _actionButton(Icons.tune, 'Filters'),
          const SizedBox(width: 8),
          _actionButton(Icons.tune, 'Customize'),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            onPressed: () {},
            icon: const Icon(Icons.upload_outlined, size: 16),
            label: const Text('Export', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(IconData icon, String label) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        side: BorderSide(color: Colors.grey.shade300),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: () {},
      icon: Icon(icon, size: 16),
      label: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }
}

// ==========================================
// ORGANIZATION OVERVIEW VIEW (IMAGE DESIGN)
// ==========================================
class _OrganizationOverviewContent extends StatelessWidget {
  final bool isDesktop;

  const _OrganizationOverviewContent({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row 1: Rating Bar Chart + Vendor Breakdown Donut
        if (isDesktop)
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: _AverageRatingChartCard()),
              SizedBox(width: 20),
              Expanded(flex: 2, child: _VendorBreakdownCard()),
            ],
          )
        else ...[
          const _AverageRatingChartCard(),
          const SizedBox(height: 16),
          const _VendorBreakdownCard(),
        ],

        const SizedBox(height: 24),

        // Row 2: Vendor Movements Table (50+ Items)
        _VendorMovementsTableCard(isDesktop: isDesktop),
      ],
    );
  }
}

// Rating Bar Chart Card
class _AverageRatingChartCard extends StatelessWidget {
  const _AverageRatingChartCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Average vendor rating', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
              TextButton(
                onPressed: () {},
                child: const Row(
                  children: [
                    Text('View Full Report', style: TextStyle(fontSize: 12, color: Color(0xFF2563EB), fontWeight: FontWeight.bold)),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward, size: 14, color: Color(0xFF2563EB)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(color: Color(0xFF93C5FD), shape: BoxShape.circle),
                child: const Text('A', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
              const SizedBox(width: 8),
              const Text('95', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_upward, size: 14, color: Colors.green),
              const Text('5%', style: TextStyle(fontSize: 12, color: Colors.green, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 20),

          // Bar chart representation
          const SizedBox(
            height: 120,
            child: _BarChartPainterWidget(),
          ),
        ],
      ),
    );
  }
}

class _BarChartPainterWidget extends StatelessWidget {
  const _BarChartPainterWidget();

  @override
  Widget build(BuildContext context) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final heights = [0.6, 0.7, 0.65, 0.45, 0.9, 0.4, 0.5, 0.6, 0.85, 0.7, 0.6, 0.8];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAlignmentColumn.bottom,
      children: List.generate(months.length, (idx) {
        final isSelected = idx == 4; // May selected
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 22,
              height: 80 * heights[idx],
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF2563EB) : const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(height: 8),
            Text(months[idx], style: const TextStyle(fontSize: 11, color: Colors.black45)),
          ],
        );
      }),
    );
  }
}

class CrossAlignmentColumn {
  static const CrossAxisAlignment bottom = CrossAxisAlignment.end;
}

// Vendor Breakdown Donut Card
class _VendorBreakdownCard extends StatelessWidget {
  const _VendorBreakdownCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      backgroundColor: const Color(0xFF2563EB),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Vendor breakdown', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 20),
          Row(
            children: [
              // Legend
              Expanded(
                child: Column(
                  children: [
                    _breakdownRow('A', '45%', '90 vendors'),
                    _breakdownRow('B', '64%', '65 vendors'),
                    _breakdownRow('C', '41%', '56 vendors'),
                    _breakdownRow('D', '35%', '24 vendors'),
                  ],
                ),
              ),

              // Donut Chart Placeholder
              SizedBox(
                width: 110,
                height: 110,
                child: CustomPaint(
                  painter: _DonutChartPainter(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _breakdownRow(String grade, String pct, String count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
            child: Center(
              child: Text(grade, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(width: 8),
          Text(pct, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(width: 6),
          Text(count, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 10)),
        ],
      ),
    );
  }
}

class _DonutChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = 22.0;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Segment A (Cyan Patterned)
    paint.color = const Color(0xFF60A5FA);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius - strokeWidth / 2), 0, 1.8, false, paint);

    // Segment B
    paint.color = const Color(0xFF1D4ED8);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius - strokeWidth / 2), 1.9, 2.0, false, paint);

    // Segment C
    paint.color = const Color(0xFF93C5FD);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius - strokeWidth / 2), 4.0, 1.2, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Vendor Movements Table Card (50+ Items)
// ==========================================
// VENDOR MOVEMENTS TABLE CARD (FIXED FOR MOBILE)
// ==========================================
class _VendorMovementsTableCard extends StatefulWidget {
  final bool isDesktop;

  const _VendorMovementsTableCard({super.key, required this.isDesktop});

  @override
  State<_VendorMovementsTableCard> createState() => _VendorMovementsTableCardState();
}

class _VendorMovementsTableCardState extends State<_VendorMovementsTableCard> {
  String _activeTab = 'Day';

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // -------------------------------------------------------------
          // FIX 1: Responsive Header Bar (Line 631 - Replaced Row with Wrap)
          // -------------------------------------------------------------
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: [
              const Text(
                'Vendor Movements',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  // Filter Toggle Chips (Day / Week / Month / Year)
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: ['Day', 'Week', 'Month', 'Year'].map((t) {
                        final isSel = _activeTab == t;
                        return GestureDetector(
                          onTap: () => setState(() => _activeTab = t),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: isSel ? Colors.white : Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              t,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                                color: isSel ? Colors.black87 : Colors.black45,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  // Add Vendor Action Button
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF2563EB),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.add, size: 16),
                    label: const Text('Add vendor', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // -------------------------------------------------------------
          // FIX 2: Horizontally Scrollable Data Table (Line 682-686)
          // -------------------------------------------------------------
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columnSpacing: widget.isDesktop ? 24 : 16, // Compact spacing
              // for mobile
              headingRowHeight: 40,
              dataRowMinHeight: 52,
              dataRowMaxHeight: 52,
              columns: const [
                DataColumn(label: Text('Vendor ⇅', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                DataColumn(label: Text('Rating ⇅', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                DataColumn(label: SizedBox(width: 110, child: Text('Last '
                    'Assessed ⇅',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)))),
                DataColumn(label: Text('Labels', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12))),
                // DataColumn(label: Text('Access', style: TextStyle(fontWeight:
                // FontWeight.bold, fontSize: 12))),
                // DataColumn(label: Text('Category', style: TextStyle(fontWeight:
                // FontWeight.bold, fontSize: 12))),
              ],
              rows: dummyVendors.map((vendor) {
                return DataRow(
                  cells: [
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(value: false, onChanged: (val){}),
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.blue.shade50,
                            child: Text(vendor.name[0], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(vendor.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                              Text(vendor.domain, style: const TextStyle(fontSize: 10, color: Colors.black38)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: vendor.grade == 'A'
                                  ? const Color(0xFF93C5FD)
                                  : vendor.grade == 'B'
                                  ? Colors.lightBlue.shade100
                                  : vendor.grade == 'C'
                                  ? Colors.amber.shade100
                                  : Colors.orange.shade200,
                              shape: BoxShape.circle,
                            ),
                            child: Text(vendor.grade, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
                          ),
                          const SizedBox(width: 6),
                          Text('${vendor.rating}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                          const SizedBox(width: 4),
                          Icon(
                            vendor.isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                            size: 10,
                            color: vendor.isPositive ? Colors.green : Colors.red,
                          ),
                          Text(
                            '${vendor.changePercent}%',
                            style: TextStyle(fontSize: 10, color: vendor.isPositive ? Colors.green : Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    DataCell(Text(vendor.lastAssessed, style: const TextStyle(fontSize: 11, color: Colors.black87))),
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: 60,child: _pillBadge(vendor.status,
                          Colors
                              .green.shade50, Colors.green)),
                          const SizedBox(width: 4),
                          SizedBox(width: 80, child: _pillBadge(vendor
                              .category, Colors
                              .blue.shade50, Colors.blue)),
                          const SizedBox(width: 4),
                          _pillBadge(vendor.accessLevel, Colors.purple.shade50, Colors.purple),
                        ],
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

  Widget _pillBadge(String label, Color bg, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
      child: Text(label, style: TextStyle(fontSize: 9, color: textColor, fontWeight: FontWeight.bold)),
    );
  }
}

// ==========================================
// GENERIC MODULE CONTENT (FOR OTHER MENU ITEMS)
// ==========================================
class _GenericModuleContent extends StatelessWidget {
  final String title;

  const _GenericModuleContent({required this.title});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Container(
        height: 400,
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shield_outlined, size: 64, color: Color(0xFF2563EB)),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
            const SizedBox(height: 8),
            const Text('Security & Risk Management Module Loaded', style: TextStyle(fontSize: 12, color: Colors.black45)),
          ],
        ),
      ),
    );
  }
}

