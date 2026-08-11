import 'package:flutter/material.dart';

void main() {
  runApp(const EmedleyApp());
}

class EmedleyApp extends StatelessWidget {
  const EmedleyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emedley Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFE8EBE9),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF637D6B)),
        useMaterial3: true,
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
      body: SafeArea(
        child: Container(
          color: const Color(0xFFD3DCD6), // Outer light greenish frame
          padding: const EdgeInsets.all(12.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24.0),
            child: Container(
              color: const Color(0xFFF2F4F3),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. Sidebar Navigation
                  SidebarWidget(),

                  // Vertical Separator
                  VerticalDivider(width: 1, thickness: 1, color: Color(0xFFE2E7E4)),

                  // 2. Main Content Area
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TopHeaderWidget(),
                          SizedBox(height: 16),
                          BannerWidget(),
                          SizedBox(height: 16),
                          KpiGridWidget(),
                          SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 3, child: TeacherChartWidget()),
                              SizedBox(width: 16),
                              Expanded(flex: 1, child: SubjectTeachersWidget()),
                            ],
                          ),
                          SizedBox(height: 16),
                          TableSectionWidget(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 1. SIDEBAR NAVIGATION WIDGET (FIXED OVERFLOW)
// ==========================================
class SidebarWidget extends StatelessWidget {
  const SidebarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo & Collapse Icon
                    Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: const Color(0xFF6B806E),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.hexagon_outlined, color: Colors.white, size: 20),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Emedley',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2C3531)),
                        ),
                        const Spacer(),
                        const Icon(Icons.note_alt_outlined, color: Colors.grey, size: 20),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // Menu Options
                    _buildNavItem(Icons.grid_view_rounded, 'Dashboard', isSelected: true),
                    _buildNavItem(Icons.people_outline, 'Students profile'),
                    _buildNavItem(Icons.assignment_ind_outlined, 'Mentor info'),
                    _buildNavItem(Icons.account_balance_wallet_outlined, 'Financial'),
                    _buildNavItem(Icons.trending_up, 'Imporvement'),
                    _buildNavItem(Icons.workspace_premium_outlined, 'Course resources'),

                    // Replaced unbounded Spacer with flexible space
                    const SizedBox(height: 20),
                    const Expanded(child: SizedBox(height: 20)),

                    // Request Join Banner Card
                    Container(
                      // width: 160,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFB59D7B), Color(0xFF425C48)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(radius: 12, backgroundColor: Colors.white24),
                              const SizedBox(width: 0.0),
                              const CircleAvatar(radius: 12, backgroundColor: Colors.white54),
                              const SizedBox(width: 0.0),
                              const CircleAvatar(radius: 12, backgroundColor: Colors.white),
                              const SizedBox(width: 6.0),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.white30,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text('14+', style: TextStyle(color: Colors.white, fontSize: 10)),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Request for join teacher, need approval for access.',
                            style: TextStyle(color: Colors.white, fontSize: 11),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white24,
                                    foregroundColor: Colors.white,
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(vertical: 6),
                                  ),
                                  onPressed: () {},
                                  child: const Text('Decline', style: TextStyle(fontSize: 11)),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(vertical: 6),
                                  ),
                                  onPressed: () {},
                                  child: const Text('Accept', style: TextStyle
                                    (fontSize: 11)),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    _buildNavItem(Icons.settings_outlined, 'Settings'),
                    _buildNavItem(Icons.logout, 'Log out'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String title, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFFBECE4) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        leading: Icon(icon, color: isSelected ? const Color(0xFFD67B48) : Colors.grey[600], size: 20),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? const Color(0xFFD67B48) : const Color(0xFF4A5568),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 13,
          ),
        ),
        onTap: () {},
      ),
    );
  }
}

// ==========================================
// 2. TOP HEADER BAR WIDGET
// ==========================================
class TopHeaderWidget extends StatelessWidget {
  const TopHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Dashboard', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('04 August, 2026', style: TextStyle(color: Colors.grey,
                fontSize: 12)),
          ],
        ),
        const SizedBox(width: 40),

        // Search Bar
        Expanded(
          child: Container(
            height: 42,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Row(
              children: [
                Icon(Icons.search, color: Colors.grey, size: 18),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),

        _buildIconButton(Icons.mic_none_outlined),
        const SizedBox(width: 12),

        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: const Row(
            children: [
              Icon(Icons.wb_sunny_outlined, size: 18, color: Colors.black54),
              SizedBox(width: 8),
              Icon(Icons.nightlight_round_outlined, size: 18, color: Colors.grey),
            ],
          ),
        ),
        const SizedBox(width: 12),

        _buildIconButton(Icons.notifications_none),
        const SizedBox(width: 12),

        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: const Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=12'),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Amazevalley', style: TextStyle(fontWeight: FontWeight
                      .bold, fontSize: 12)),
                  Text('Flutter Dev', style: TextStyle(color: Colors.grey,
                      fontSize: 10)),
                ],
              ),
              SizedBox(width: 6),
              Icon(Icons.chevron_right, color: Colors.grey, size: 18),
            ],
          ),
        )
      ],
    );
  }

  static Widget _buildIconButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: Icon(icon, size: 18, color: Colors.black87),
    );
  }
}

// ==========================================
// 3. MAIN TOP BANNER
// ==========================================
class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFB3A078),
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFFC7B28B), Color(0xFF5D7A65)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Academic Year 2022-2023', style: TextStyle(color: Colors.white70, fontSize: 12)),
              const SizedBox(height: 6),
              const Text(
                'Overall Student Performance Dashboard Of ABC\nSchool for Class 10',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, height: 1.3),
              ),
              const SizedBox(height: 5),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
                onPressed: () {},
                child: const Text('Get Access', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const Icon(Icons.bar_chart_rounded, size: 100, color: Colors.white30),
        ],
      ),
    );
  }
}

// ==========================================
// 4. TOP KPI CARDS GRID
// ==========================================
class KpiGridWidget extends StatelessWidget {
  const KpiGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: _KpiCard(title: 'Total Student', value: '300', tagText: '+75%', tagColor: Colors.lightGreen, icon: Icons.school, iconColor: Colors.orangeAccent)),
        SizedBox(width: 12),
        Expanded(child: _KpiCard(title: 'Student absent & COPA', value: '15%', tagText: 'Retention Rate', tagColor: Colors.orange, icon: Icons.insert_chart, iconColor: Colors.teal)),
        SizedBox(width: 12),
        Expanded(child: _KpiCard(title: 'Attenance Rate', value: '15%', tagText: 'Attendance', tagColor: Colors.lightGreen, icon: Icons.battery_charging_full, iconColor: Colors.black)),
        SizedBox(width: 12),
        Expanded(child: _KpiCard(title: 'Teacher Saticfiction', value: '55%',
            tagText: 'Teacher', tagColor: Colors.lightGreen, icon: Icons.note_alt_outlined,
            iconColor: Colors.green)),
      ],
    );
  }
}

class _KpiCard extends StatelessWidget {
  final String title, value, tagText;
  final Color tagColor, iconColor;
  final IconData icon;

  const _KpiCard({
    required this.title,
    required this.value,
    required this.tagText,
    required this.tagColor,
    required this.iconColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(backgroundColor: iconColor.withOpacity(0.15), radius: 16, child: Icon(icon, color: iconColor, size: 16)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: tagColor.withOpacity(0.12), borderRadius: BorderRadius.circular(12)),
                child: Text(tagText, style: TextStyle(color: tagColor, fontSize: 10, fontWeight: FontWeight.bold)),
              )
            ],
          ),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 11)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// ==========================================
// 5. TEACHER CANDLE/BAR CHART SECTION
// ==========================================
class TeacherChartWidget extends StatelessWidget {
  const TeacherChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Teacher', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Container(
                decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.all(2),
                child: Row(
                  children: [
                    _filterChip('1H'),
                    _filterChip('4H'),
                    _filterChip('1D', isSelected: true),
                    _filterChip('1W'),
                    _filterChip('1M'),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 180,
            width: double.infinity,
            child: CustomPaint(painter: CandleChartPainter()),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String text, {bool isSelected = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF637D6B) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 11, color: isSelected ? Colors.white : Colors.black87, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class CandleChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintOrange = Paint()..color = const Color(0xFFE28B55)..strokeWidth = 2;
    final paintGreen = Paint()..color = const Color(0xFF4A7C59)..strokeWidth = 2;
    final gridPaint = Paint()..color = Colors.grey.shade300..strokeWidth = 0.5;

    canvas.drawLine(Offset(0, size.height * 0.3), Offset(size.width, size.height * 0.3), gridPaint);

    double spacing = size.width / 16;
    for (int i = 0; i < 16; i++) {
      double x = i * spacing + 12;
      bool isOrange = i % 2 == 0;
      Paint currentPaint = isOrange ? paintOrange : paintGreen;

      double topY = (i * 7 % 40) + 20;
      double bottomY = topY + 50;
      canvas.drawLine(Offset(x, topY), Offset(x, bottomY), currentPaint);

      canvas.drawRect(
        Rect.fromCenter(center: Offset(x, (topY + bottomY) / 2), width: 4, height: 20),
        currentPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ==========================================
// 6. SUBJECT WISE TEACHERS RIGHT SIDEBAR
// ==========================================
class SubjectTeachersWidget extends StatelessWidget {
  const SubjectTeachersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Subject wise Teachers', style: TextStyle(color: Colors.grey, fontSize: 12)),
              Icon(Icons.more_horiz, color: Colors.grey, size: 18),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Text('40', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: Colors.green.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
                child: const Text('↑ 47%', style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
              )
            ],
          ),
          const Text('Female 20%', style: TextStyle(color: Colors.grey, fontSize: 10)),
          const SizedBox(height: 16),
          _buildProgressBar('Academic', 0.6, '80', Colors.orangeAccent),
          _buildProgressBar('Performance', 0.47, '47%', const Color(0xFF4A7C59)),
          _buildProgressBar('Availability', 0.25, '60', const Color(0xFF4A7C59)),
          _buildProgressBar('To Do', 0.15, '60', Colors.black87),
        ],
      ),
    );
  }

  Widget _buildProgressBar(String label, double progress, String valueStr, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
              Text(valueStr, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            color: color,
            minHeight: 6,
            borderRadius: BorderRadius.circular(8),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 7. BOTTOM TABLE SECTION WIDGET
// ==========================================
class TableSectionWidget extends StatelessWidget {
  const TableSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Visualize Your Academic Success', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: const Color(0xFFFBECE4), borderRadius: BorderRadius.circular(16)),
                child: const Text('Annual Exam', style: TextStyle(color: Color(0xFFD67B48), fontSize: 11, fontWeight: FontWeight.bold)),
              )
            ],
          ),
          const SizedBox(height: 16),
          const Row(
            children: [
              Expanded(flex: 3, child: Text('Name', style: TextStyle(color: Colors.grey, fontSize: 12))),
              Expanded(flex: 2, child: Text('Students ID', style: TextStyle(color: Colors.grey, fontSize: 12))),
              Expanded(flex: 2, child: Text('Group', style: TextStyle(color: Colors.grey, fontSize: 12))),
              Expanded(flex: 2, child: Text('Mark-sheet', style: TextStyle(color: Colors.grey, fontSize: 12))),
              Expanded(flex: 2, child: Text('Status', style: TextStyle(color: Colors.grey, fontSize: 12))),
            ],
          ),
          const Divider(height: 24),
          const Row(
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    CircleAvatar(radius: 12, backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=33')),
                    SizedBox(width: 8),
                    Text('Antwan Graham', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              Expanded(flex: 2, child: Text('M-85454', style: TextStyle(fontSize: 12))),
              Expanded(flex: 2, child: Text('Science', style: TextStyle(fontSize: 12))),
              Expanded(flex: 2, child: Text('80/100', style: TextStyle(fontSize: 12))),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Chip(
                    label: Text('Full Profile', style: TextStyle(fontSize: 10, color: Color(0xFFD67B48))),
                    backgroundColor: Color(0xFFFBECE4),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          const Row(
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    CircleAvatar(radius: 12, backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=33')),
                    SizedBox(width: 8),
                    Text('Amazevalley', style: TextStyle(fontSize: 12,
                        fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              Expanded(flex: 2, child: Text('M-85455', style: TextStyle
                (fontSize: 12))),
              Expanded(flex: 2, child: Text('Science', style: TextStyle(fontSize: 12))),
              Expanded(flex: 2, child: Text('85/100', style: TextStyle
                (fontSize: 12))),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Chip(
                    label: Text('Full Profile', style: TextStyle(fontSize: 10, color: Color(0xFFD67B48))),
                    backgroundColor: Color(0xFFFBECE4),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          const Row(
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    CircleAvatar(radius: 12, backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=33')),
                    SizedBox(width: 8),
                    Text('Josh Rosh', style: TextStyle(fontSize: 12,
                        fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              Expanded(flex: 2, child: Text('M-85456', style: TextStyle
                (fontSize: 12))),
              Expanded(flex: 2, child: Text('Science', style: TextStyle(fontSize: 12))),
              Expanded(flex: 2, child: Text('90/100', style: TextStyle
                (fontSize: 12))),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Chip(
                    label: Text('Full Profile', style: TextStyle(fontSize: 10, color: Color(0xFFD67B48))),
                    backgroundColor: Color(0xFFFBECE4),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          const Row(
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    CircleAvatar(radius: 12, backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=33')),
                    SizedBox(width: 8),
                    Text('Raw Graham', style: TextStyle(fontSize: 12,
                        fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              Expanded(flex: 2, child: Text('M-85457', style: TextStyle
                (fontSize: 12))),
              Expanded(flex: 2, child: Text('Science', style: TextStyle(fontSize: 12))),
              Expanded(flex: 2, child: Text('95/100', style: TextStyle
                (fontSize: 12))),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Chip(
                    label: Text('Full Profile', style: TextStyle(fontSize: 10, color: Color(0xFFD67B48))),
                    backgroundColor: Color(0xFFFBECE4),
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          const Row(
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    CircleAvatar(radius: 12, backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=33')),
                    SizedBox(width: 8),
                    Text('Ravi Graham', style: TextStyle(fontSize: 12,
                        fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              Expanded(flex: 2, child: Text('M-85458', style: TextStyle
                (fontSize: 12))),
              Expanded(flex: 2, child: Text('Science', style: TextStyle(fontSize: 12))),
              Expanded(flex: 2, child: Text('95/100', style: TextStyle
                (fontSize: 12))),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Chip(
                    label: Text('Full Profile', style: TextStyle(fontSize: 10, color: Color(0xFFD67B48))),
                    backgroundColor: Color(0xFFFBECE4),
                    padding: EdgeInsets.zero,
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