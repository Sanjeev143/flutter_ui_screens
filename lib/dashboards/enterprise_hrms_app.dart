import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const TayaboApp());
}

class TayaboApp extends StatelessWidget {
  const TayaboApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amazevalley Enterprise HRMS',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF3F4F8),
        fontFamily: 'Roboto',
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF6C5CE7),
          surface: Colors.white,
        ),
      ),
      home: const TayaboDashboardScreen(),
    );
  }
}

class TayaboDashboardScreen extends StatefulWidget {
  const TayaboDashboardScreen({super.key});

  @override
  State<TayaboDashboardScreen> createState() => _TayaboDashboardScreenState();
}

class _TayaboDashboardScreenState extends State<TayaboDashboardScreen> {
  int _selectedNavIndex = 0;

  final List<String> _menuTitles = [
    'Dashboard',
    'Attendance Management',
    'Payroll Center',
    'Performance Statistics',
    'Employee Directory',
    'Recruitment (ATS)',
    'Meetings & Events',
    'Reports & Analytics',
    'Support & Help-desk',
  ];

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 1024;

    return Scaffold(
      drawer: !isDesktop ? Drawer(child: _buildSidebarContent()) : null,
      body: SafeArea(child: Row(
        children: [
          if (isDesktop) _buildSidebarContent(),
          Expanded(
            child: Column(
              children: [
                _buildTopAppBar(!isDesktop),
                Expanded(
                  child: IndexedStack(
                    index: _selectedNavIndex,
                    children: [
                      _DashboardView(
                        onNavigate: (idx) =>
                            setState(() => _selectedNavIndex = idx),
                      ),
                      const _AttendanceView(),
                      const _PayrollView(),
                      const _PerformanceView(),
                      const _EmployeesView(),
                      const _RecruitmentView(),
                      const _MeetingsView(),
                      const _ReportsView(),
                      const _SupportView(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),)

    );
  }

  // TOP APP BAR
  Widget _buildTopAppBar(bool isMobile) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: const Color(0xFFF3F4F8),
      child: Row(
        children: [
          if (isMobile)
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.black87),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _selectedNavIndex == 0
                      ? 'Hello Amaze Valley 👋'
                      : _menuTitles[_selectedNavIndex],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E1E2D),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                const Text(
                  "Here's what needs your attention",
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          if (!isMobile)
            Container(
              width: 200,
              height: 38,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(fontSize: 12, color: Colors.grey),
                  prefixIcon: Icon(Icons.search, size: 16, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(bottom: 12),
                ),
              ),
            ),
          const SizedBox(width: 8),
          _topIconButton(Icons.settings_outlined),
          const SizedBox(width: 6),
          _topIconButton(Icons.notifications_none, hasBadge: true),
        ],
      ),
    );
  }

  Widget _topIconButton(IconData icon, {bool hasBadge = false}) {
    return Stack(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Icon(icon, size: 18, color: Colors.black87),
        ),
        if (hasBadge)
          Positioned(
            right: 8,
            top: 6,
            child: Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }

  // SIDEBAR NAVIGATION CONTENT
  Widget _buildSidebarContent() {
    return Container(
      width: 240,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.widgets, color: Color(0xFF6C5CE7), size: 28),
              SizedBox(width: 10),
              Text(
                'HRMS',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E1E2D),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView(
              children: [
                _sidebarNavItem(0, Icons.grid_view_rounded, 'Dashboard'),
                _sidebarNavItem(1, Icons.person_outline, 'Attendance'),
                _sidebarNavItem(2, Icons.attach_money, 'Payroll'),
                _sidebarNavItem(3, Icons.speed, 'Performance'),
                _sidebarNavItem(4, Icons.people_outline, 'Employees'),
                _sidebarNavItem(5, Icons.work_outline, 'Recruitment'),
                _sidebarNavItem(
                  6,
                  Icons.calendar_today_outlined,
                  'Meetings & Events',
                ),
                _sidebarNavItem(
                  7,
                  Icons.bar_chart_outlined,
                  'Reports & Analytics',
                ),
              ],
            ),
          ),
          _sidebarNavItem(8, Icons.headset_mic_outlined, 'Support / Help-desk'),
          _sidebarNavItem(8, Icons.logout_rounded, 'Logout'),
          const SizedBox(height: 12),
          // User Card Profile
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF6C5CE7),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 14,
                      backgroundImage: NetworkImage(
                        'https://i.pravatar.cc/100?img=12',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Amaze Valley',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          'Admin',
                          style: TextStyle(color: Colors.white70, fontSize: 10),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.more_horiz,
                      color: Colors.white70,
                      size: 16,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.wb_sunny_outlined,
                                size: 12,
                                color: Color(0xFF6C5CE7),
                              ),
                              SizedBox(width: 4),
                              Text(
                                'Light',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF6C5CE7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.nightlight_round,
                              size: 12,
                              color: Colors.white70,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Dark',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white70,
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
          ),
        ],
      ),
    );
  }

  Widget _sidebarNavItem(int index, IconData icon, String label) {
    final bool isSelected = _selectedNavIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedNavIndex = index;
          });

          // Safe drawer auto-close logic for mobile screen drawer
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF6C5CE7) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: isSelected ? Colors.white : Colors.black54,
              ),
              const SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 1. DASHBOARD VIEW MODULE
// ==========================================
class _DashboardView extends StatelessWidget {
  final Function(int) onNavigate;

  const _DashboardView({required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // TOP ROW
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 1100) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: _buildAttendanceCard()),
                    const SizedBox(width: 16),
                    Expanded(flex: 3, child: _buildPayrollCard()),
                    const SizedBox(width: 16),
                    Expanded(flex: 4, child: _buildPerformanceChartCard()),
                  ],
                );
              }
              return Column(
                children: [
                  _buildAttendanceCard(),
                  const SizedBox(height: 16),
                  _buildPayrollCard(),
                  const SizedBox(height: 16),
                  _buildPerformanceChartCard(),
                ],
              );
            },
          ),

          const SizedBox(height: 16),

          // BOTTOM ROW
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 1100) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: _buildVacanciesCard()),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          _buildPerformanceTrackCard(),
                          const SizedBox(height: 16),
                          _buildEmploymentStatusCard(),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(flex: 3, child: _buildMeetingsCard()),
                  ],
                );
              }
              return Column(
                children: [
                  _buildVacanciesCard(),
                  const SizedBox(height: 16),
                  _buildPerformanceTrackCard(),
                  const SizedBox(height: 16),
                  _buildEmploymentStatusCard(),
                  const SizedBox(height: 16),
                  _buildMeetingsCard(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceCard() {
    return _cardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cardHeader('Attendance', 'Track real-time Attendance'),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _legendDot(const Color(0xFF6C5CE7), 'Present'),
                const SizedBox(width: 12),
                _legendDot(const Color(0xFFA3E635), 'Late'),
                const SizedBox(width: 12),
                _legendDot(const Color(0xFFFACC15), 'On Leave'),
                const SizedBox(width: 12),
                _legendDot(const Color(0xFFF87171), 'Absent'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 130,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CustomPaint(
                  size: const Size(200, 100),
                  painter: AttendanceGaugePainter(),
                ),
                const Positioned(
                  bottom: 8,
                  child: Text(
                    '405 (65%)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
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

  Widget _buildPayrollCard() {
    return _cardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cardHeader('Payroll', 'Track salary'),
          const SizedBox(height: 8),
          _payrollRow(
            'Steve Smith',
            'Id-23535',
            '\$6,000',
            'Pending',
            Colors.red.shade100,
            Colors.red.shade700,
            'https://i.pravatar.cc/100?img=33',
          ),
          _payrollRow(
            'Albert Flores',
            'Id-23536',
            '\$4,000',
            'Paid',
            Colors.green.shade100,
            Colors.green.shade700,
            'https://i.pravatar.cc/100?img=47',
          ),
          _payrollRow(
            'Leslie Alexander',
            'Id-23537',
            '\$2,000',
            'Pending',
            Colors.red.shade100,
            Colors.red.shade700,
            'https://i.pravatar.cc/100?img=11',
          ),
          _payrollRow(
            'Courtney Henry',
            'Id-23538',
            '\$8,000',
            'Pending',
            Colors.red.shade100,
            Colors.red.shade700,
            'https://i.pravatar.cc/100?img=68',
          ),
          _payrollRow(
            'Jenny Wilson',
            'Id-23539',
            '\$4,000',
            'Paid',
            Colors.green.shade100,
            Colors.green.shade700,
            'https://i.pravatar.cc/100?img=22',
          ),
        ],
      ),
    );
  }

  Widget _payrollRow(
    String name,
    String id,
    String salary,
    String status,
    Color bgColor,
    Color textColor,
    String img,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: [
          CircleAvatar(radius: 12, backgroundImage: NetworkImage(img)),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  id,
                  style: const TextStyle(fontSize: 9, color: Colors.grey),
                ),
              ],
            ),
          ),
          Text(
            salary,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceChartCard() {
    return _cardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Performance statistics',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: const [
                    Text(
                      'Last 7 Days',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down, size: 12),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _legendDot(const Color(0xFF4ADE80), 'Dev Team'),
                const SizedBox(width: 8),
                _legendDot(const Color(0xFF818CF8), 'Design Team'),
                const SizedBox(width: 8),
                _legendDot(const Color(0xFFFACC15), 'Marketing Team'),
                const SizedBox(width: 8),
                _legendDot(const Color(0xFFF87171), 'Management Team'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 160,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 20,
                ),
                titlesData: FlTitlesData(
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 28,
                      interval: 20,
                      getTitlesWidget: (val, meta) => Text(
                        '${val.toInt()}%',
                        style: const TextStyle(fontSize: 9, color: Colors.grey),
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (val, meta) {
                        const days = [
                          'SAT',
                          'SUN',
                          'MON',
                          'TUE',
                          'WED',
                          'THU',
                          'FRI',
                        ];
                        if (val.toInt() >= 0 && val.toInt() < days.length) {
                          return Text(
                            days[val.toInt()],
                            style: const TextStyle(
                              fontSize: 9,
                              color: Colors.grey,
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  _lineData([
                    const FlSpot(0, 30),
                    const FlSpot(1, 50),
                    const FlSpot(2, 70),
                    const FlSpot(3, 40),
                    const FlSpot(4, 75),
                    const FlSpot(5, 60),
                    const FlSpot(6, 65),
                  ], const Color(0xFF818CF8)),
                  _lineData([
                    const FlSpot(0, 45),
                    const FlSpot(1, 20),
                    const FlSpot(2, 40),
                    const FlSpot(3, 80),
                    const FlSpot(4, 60),
                    const FlSpot(5, 80),
                    const FlSpot(6, 40),
                  ], const Color(0xFF4ADE80)),
                  _lineData([
                    const FlSpot(0, 20),
                    const FlSpot(1, 40),
                    const FlSpot(2, 30),
                    const FlSpot(3, 60),
                    const FlSpot(4, 30),
                    const FlSpot(5, 50),
                    const FlSpot(6, 70),
                  ], const Color(0xFFFACC15)),
                  _lineData([
                    const FlSpot(0, 60),
                    const FlSpot(1, 30),
                    const FlSpot(2, 25),
                    const FlSpot(3, 50),
                    const FlSpot(4, 70),
                    const FlSpot(5, 40),
                    const FlSpot(6, 30),
                  ], const Color(0xFFF87171)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  LineChartBarData _lineData(List<FlSpot> spots, Color color) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: color,
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
    );
  }

  Widget _buildVacanciesCard() {
    return _cardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cardHeader('Current Vacancies', ''),
          const SizedBox(height: 8),
          _vacancyRow(
            'Frontend Developer',
            'Google - 2/3 Scheduled',
            const Color(0xFF818CF8),
          ),
          _vacancyRow(
            'Project Manager',
            'Amazon - 1/2 Scheduled',
            const Color(0xFFA3E635),
          ),
          _vacancyRow(
            'QA Analyst',
            'Netflix - 3/4 Scheduled',
            const Color(0xFFFACC15),
          ),
          _vacancyRow(
            'UI Designer',
            'Netflix - 3/4 Scheduled',
            const Color(0xFFF87171),
          ),
          _vacancyRow(
            'Mobile Developer',
            'Amazevalley - 2/4 Scheduled',
            const Color(0xFFF87171),
          ),
          _vacancyRow(
            'Frontend Developer',
            'Google - 2/3 Scheduled',
            const Color(0xFF818CF8),
          ),
          _vacancyRow(
            'Project Manager',
            'Amazon - 1/2 Scheduled',
            const Color(0xFFA3E635),
          ),
          _vacancyRow(
            'QA Analyst',
            'Netflix - 3/4 Scheduled',
            const Color(0xFFFACC15),
          ),
          _vacancyRow(
            'UI Designer',
            'Netflix - 3/4 Scheduled',
            const Color(0xFFF87171),
          ),
          _vacancyRow(
            'Mobile Developer',
            'Amazevalley - 2/4 Scheduled',
            const Color(0xFFF87171),
          ),
        ],
      ),
    );
  }

  Widget _vacancyRow(String title, String subtitle, Color iconBg) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: iconBg.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.business_center_outlined,
              color: iconBg,
              size: 16,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 9, color: Colors.grey),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey, size: 16),
        ],
      ),
    );
  }

  Widget _buildPerformanceTrackCard() {
    return _cardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Track employee performance',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 20,
              child: Row(
                children: [
                  Expanded(
                    flex: 42,
                    child: Container(color: const Color(0xFF4ADE80)),
                  ),
                  Expanded(
                    flex: 28,
                    child: Container(color: const Color(0xFF6C5CE7)),
                  ),
                  Expanded(
                    flex: 16,
                    child: Container(color: const Color(0xFFFACC15)),
                  ),
                  Expanded(
                    flex: 14,
                    child: Container(color: const Color(0xFFF87171)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _legendDotWithValue(
                  const Color(0xFF4ADE80),
                  '42%',
                  'Excellent',
                ),
                const SizedBox(width: 10),
                _legendDotWithValue(const Color(0xFF6C5CE7), '28%', 'Good'),
                const SizedBox(width: 10),
                _legendDotWithValue(const Color(0xFFFACC15), '16%', 'Fair'),
                const SizedBox(width: 10),
                _legendDotWithValue(const Color(0xFFF87171), '14%', 'Improved'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E2D),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: const [
                Icon(Icons.info_outline, color: Colors.white, size: 14),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Enroll in a time management workshop and implement a weekly check-in with a supervisor to track task progress.',
                    style: TextStyle(fontSize: 9, color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmploymentStatusCard() {
    return _cardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _cardHeader('Employment Status', ''),
          const SizedBox(height: 4),
          Row(
            children: const [
              Text(
                '820',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 6),
              Text(
                'Total\nEmployee',
                style: TextStyle(fontSize: 8, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 20,
              child: Row(
                children: [
                  Expanded(
                    flex: 48,
                    child: Container(color: const Color(0xFF4ADE80)),
                  ),
                  Expanded(
                    flex: 32,
                    child: Container(color: const Color(0xFF2563EB)),
                  ),
                  Expanded(
                    flex: 20,
                    child: Container(color: const Color(0xFFFACC15)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _legendDotWithValue(
                  const Color(0xFF4ADE80),
                  '48%',
                  'Permanent (460)',
                ),
                const SizedBox(width: 10),
                _legendDotWithValue(
                  const Color(0xFF2563EB),
                  '32%',
                  'Contract (220)',
                ),
                const SizedBox(width: 10),
                _legendDotWithValue(
                  const Color(0xFFFACC15),
                  '20%',
                  'Probation (140)',
                ),
              ],
            ),
          ),
          const Divider(height: 20),
          Row(
            children: [
              const Text(
                'Interviews',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              SizedBox(
                width: 90,
                height: 22,
                child: Stack(
                  children: const [
                    Positioned(
                      left: 0,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundImage: NetworkImage(
                          'https://i.pravatar.cc/100?img=1',
                        ),
                      ),
                    ),
                    Positioned(
                      left: 14,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundImage: NetworkImage(
                          'https://i.pravatar.cc/100?img=2',
                        ),
                      ),
                    ),
                    Positioned(
                      left: 28,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundImage: NetworkImage(
                          'https://i.pravatar.cc/100?img=3',
                        ),
                      ),
                    ),
                    Positioned(
                      left: 42,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundImage: NetworkImage(
                          'https://i.pravatar.cc/100?img=4',
                        ),
                      ),
                    ),
                    Positioned(
                      left: 56,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundImage: NetworkImage(
                          'https://i.pravatar.cc/100?img=5',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              const Text(
                '10 People',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMeetingsCard() {
    return _cardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Meetings/Events',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: const [
                    Text(
                      'Meetings',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down, size: 12),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          const Text(
            'Track important meetings',
            style: TextStyle(fontSize: 10, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          _meetingTile(
            'Meeting with Wade Warren',
            '8:00 - 8:45 AM (UTC)',
            'Marketing',
            'On Zoom Meeting',
          ),
          _meetingTile(
            'Meeting with Jane Cooper',
            '12:30 - 1:15 PM (UTC)',
            'Developer',
            'On Google Meet',
          ),
          _meetingTile(
            'Meeting with Courtney Henry',
            '3:00 - 4:45 PM (UTC)',
            'Designer',
            'On Google Meet',
          ),
          _meetingTile(
            'Meeting with Courtney Henry',
            '4:00 - 4:45 PM (UTC)',
            'Designer',
            'On Google Meet',
          ),
          _meetingTile(
            'Meeting with Courtney Henry',
            '5:00 - 5:45 PM (UTC)',
            'Designer',
            'On Google Meet',
          ),
          _meetingTile(
            'Meeting with Courtney Henry',
            '6:00 - 6:45 PM (UTC)',
            'Designer',
            'On Google Meet',
          ),
          _meetingTile(
            'Meeting with Courtney Henry',
            '7:00 - 7:45 PM (UTC)',
            'Designer',
            'On Google Meet',
          ),
          _meetingTile(
            'Meeting with Courtney Henry',
            '8:00 - 8:45 PM (UTC)',
            'Designer',
            'On Google Meet',
          ),
          _meetingTile(
            'Meeting with Courtney Henry',
            '9:00 - 9:45 PM (UTC)',
            'Designer',
            'On Google Meet',
          ),
        ],
      ),
    );
  }

  Widget _meetingTile(String title, String time, String tag, String platform) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  tag,
                  style: const TextStyle(fontSize: 8, color: Colors.black87),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(time, style: const TextStyle(fontSize: 9, color: Colors.grey)),
          const SizedBox(height: 6),
          Row(
            children: [
              SizedBox(
                width: 45,
                height: 18,
                child: Stack(
                  children: const [
                    Positioned(
                      left: 0,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundImage: NetworkImage(
                          'https://i.pravatar.cc/100?img=10',
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundImage: NetworkImage(
                          'https://i.pravatar.cc/100?img=11',
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: Color(0xFF6C5CE7),
                        child: Text(
                          '+5',
                          style: TextStyle(
                            fontSize: 6,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  platform,
                  style: const TextStyle(fontSize: 8, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF10B981),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () {},
                icon: const Icon(Icons.videocam_outlined, size: 10),
                label: const Text(
                  'Join Now',
                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _cardWrapper({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _cardHeader(String title, String subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E1E2D),
              ),
            ),
            if (subtitle.isNotEmpty)
              Text(
                subtitle,
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
          ],
        ),
        const Icon(Icons.more_horiz, color: Colors.grey, size: 16),
      ],
    );
  }

  Widget _legendDot(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(radius: 3, backgroundColor: color),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 9, color: Colors.black87)),
      ],
    );
  }

  Widget _legendDotWithValue(Color color, String value, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(radius: 3, backgroundColor: color),
        const SizedBox(width: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 2),
        Text(label, style: const TextStyle(fontSize: 9, color: Colors.grey)),
      ],
    );
  }
}

// ==========================================
// 2. ATTENDANCE VIEW MODULE (POPULATED)
// ==========================================
class _AttendanceView extends StatelessWidget {
  const _AttendanceView();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _metricChip('Present Today', '2,420', const Color(0xFF6C5CE7)),
              const SizedBox(width: 8),
              _metricChip('Late Arrival', '32', const Color(0xFFA3E635)),
              const SizedBox(width: 8),
              _metricChip('On Leave', '82', const Color(0xFFFACC15)),
              const SizedBox(width: 8),
              _metricChip('Absent', '45', const Color(0xFFF87171)),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Daily Real-Time Attendance Log',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                _attendanceTile(
                  'Sarah Jenkins',
                  'Engineering',
                  '08:58 AM',
                  '05:02 PM',
                  'On Time',
                  Colors.green,
                  'https://i.pravatar.cc/100?img=12',
                ),
                _attendanceTile(
                  'Marcus Vance',
                  'Product Design',
                  '09:22 AM',
                  '05:15 PM',
                  'Late Arrival',
                  Colors.amber,
                  'https://i.pravatar.cc/100?img=33',
                ),
                _attendanceTile(
                  'Priya Sharma',
                  'HR Operations',
                  '--:--',
                  '--:--',
                  'On Leave',
                  Colors.blue,
                  'https://i.pravatar.cc/100?img=47',
                ),
                _attendanceTile(
                  'David Chen',
                  'Operations',
                  '--:--',
                  '--:--',
                  'Absent',
                  Colors.red,
                  'https://i.pravatar.cc/100?img=11',
                ),
                _attendanceTile(
                  'Elena Rostova',
                  'Management',
                  '08:45 AM',
                  '05:00 PM',
                  'On Time',
                  Colors.green,
                  'https://i.pravatar.cc/100?img=5',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _metricChip(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(fontSize: 10, color: Colors.grey),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _attendanceTile(
    String name,
    String dept,
    String checkIn,
    String checkOut,
    String status,
    Color color,
    String img,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 14, backgroundImage: NetworkImage(img)),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    dept,
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          Text(
            'In: $checkIn',
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
          Text(
            'Out: $checkOut',
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 3. PAYROLL VIEW MODULE (POPULATED)
// ==========================================
class _PayrollView extends StatelessWidget {
  const _PayrollView();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Salary Processing Center',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6C5CE7),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Run Payroll',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                _payrollDetailRow(
                  'Steve Smith',
                  'EMP-23535',
                  '\$6,000',
                  'Basic: \$4,000 | Allowance: \$2,000',
                  'Pending',
                  Colors.red,
                  'https://i.pravatar.cc/100?img=33',
                ),
                _payrollDetailRow(
                  'Albert Flores',
                  'EMP-23536',
                  '\$4,000',
                  'Basic: \$3,000 | Allowance: \$1,000',
                  'Paid',
                  Colors.green,
                  'https://i.pravatar.cc/100?img=47',
                ),
                _payrollDetailRow(
                  'Leslie Alexander',
                  'EMP-23537',
                  '\$2,000',
                  'Basic: \$1,500 | Allowance: \$500',
                  'Pending',
                  Colors.red,
                  'https://i.pravatar.cc/100?img=11',
                ),
                _payrollDetailRow(
                  'Courtney Henry',
                  'EMP-23538',
                  '\$8,000',
                  'Basic: \$5,500 | Allowance: \$2,500',
                  'Pending',
                  Colors.red,
                  'https://i.pravatar.cc/100?img=68',
                ),
                _payrollDetailRow(
                  'Jenny Wilson',
                  'EMP-23539',
                  '\$4,000',
                  'Basic: \$3,000 | Allowance: \$1,000',
                  'Paid',
                  Colors.green,
                  'https://i.pravatar.cc/100?img=22',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _payrollDetailRow(
    String name,
    String id,
    String total,
    String breakdown,
    String status,
    Color color,
    String img,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(radius: 14, backgroundImage: NetworkImage(img)),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  breakdown,
                  style: const TextStyle(fontSize: 9, color: Colors.grey),
                ),
              ],
            ),
          ),
          Text(
            total,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 4. PERFORMANCE VIEW MODULE (POPULATED)
// ==========================================
class _PerformanceView extends StatelessWidget {
  const _PerformanceView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Team Goals & OKRs Progress',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _okrProgressRow('Dev Team - Flutter Suite Upgrade', 0.85, '85%'),
            _okrProgressRow(
              'Design System Migration to Figma Tokens',
              0.60,
              '60%',
            ),
            _okrProgressRow(
              'Marketing Q3 Product Campaign Launch',
              0.40,
              '40%',
            ),
            _okrProgressRow('Sales Target Pipeline Achievement', 0.92, '92%'),
          ],
        ),
      ),
    );
  }

  Widget _okrProgressRow(String title, double val, String percent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                percent,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6C5CE7),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: val,
            backgroundColor: Colors.grey.shade200,
            color: const Color(0xFF6C5CE7),
            minHeight: 6,
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 5. EMPLOYEES VIEW MODULE (POPULATED)
// ==========================================
class _EmployeesView extends StatelessWidget {
  const _EmployeesView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListView(
          children: const [
            Text(
              'Employee Master Directory',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/100?img=33',
                ),
              ),
              title: Text(
                'Steve Smith',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Senior Software Engineer - Tech Team',
                style: TextStyle(fontSize: 11),
              ),
              trailing: Text(
                'EMP-23535',
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ),
            Divider(),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/100?img=47',
                ),
              ),
              title: Text(
                'Albert Flores',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'UI/UX Designer - Product Team',
                style: TextStyle(fontSize: 11),
              ),
              trailing: Text(
                'EMP-23536',
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ),
            Divider(),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  'https://i.pravatar.cc/100?img=11',
                ),
              ),
              title: Text(
                'Leslie Alexander',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Project Manager - Operations',
                style: TextStyle(fontSize: 11),
              ),
              trailing: Text(
                'EMP-23537',
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 6. RECRUITMENT VIEW MODULE (POPULATED)
// ==========================================
class _RecruitmentView extends StatelessWidget {
  const _RecruitmentView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Active Hiring Pipelines',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _pipelineTile(
              'Frontend Developer',
              '8 Applicants',
              '3 Interviewing',
            ),
            _pipelineTile('Project Manager', '4 Applicants', '1 Offered'),
            _pipelineTile('QA Analyst', '12 Applicants', '4 Screening'),
            _pipelineTile('UI Designer', '6 Applicants', '2 Selected'),
          ],
        ),
      ),
    );
  }

  Widget _pipelineTile(String role, String applicants, String stage) {
    return ListTile(
      title: Text(
        role,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(applicants, style: const TextStyle(fontSize: 11)),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFF6C5CE7).withOpacity(0.15),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          stage,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6C5CE7),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 7. MEETINGS VIEW MODULE (POPULATED)
// ==========================================
class _MeetingsView extends StatelessWidget {
  const _MeetingsView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListView(
          children: const [
            Text(
              'Scheduled Syncs & Events',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            ListTile(
              leading: Icon(Icons.videocam, color: Color(0xFF10B981)),
              title: Text(
                'Meeting with Wade Warren',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '8:00 - 8:45 AM (UTC) | Marketing',
                style: TextStyle(fontSize: 10),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.videocam, color: Color(0xFF10B981)),
              title: Text(
                'Meeting with Jane Cooper',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '12:30 - 1:15 PM (UTC) | Developer',
                style: TextStyle(fontSize: 10),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.videocam, color: Color(0xFF10B981)),
              title: Text(
                'Meeting with Courtney Henry',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '3:00 - 4:45 PM (UTC) | Designer',
                style: TextStyle(fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 8. REPORTS VIEW MODULE (POPULATED)
// ==========================================
class _ReportsView extends StatelessWidget {
  const _ReportsView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Exportable Analytics & Reports',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _reportRow('Monthly Attendance Audit', 'PDF / Excel'),
            _reportRow('Q2 Payroll Statement', 'CSV'),
            _reportRow('Annual Attrition Analysis', 'PDF'),
            _reportRow('Department Diversity Report', 'Excel'),
          ],
        ),
      ),
    );
  }

  Widget _reportRow(String title, String type) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
      subtitle: Text('Format: $type', style: const TextStyle(fontSize: 10)),
      trailing: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6C5CE7),
        ),
        onPressed: () {},
        icon: const Icon(Icons.download, size: 12, color: Colors.white),
        label: const Text(
          'Export',
          style: TextStyle(fontSize: 10, color: Colors.white),
        ),
      ),
    );
  }
}

// ==========================================
// 9. SUPPORT VIEW MODULE (POPULATED)
// ==========================================
class _SupportView extends StatelessWidget {
  const _SupportView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'HR Ticketing System',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _ticketTile(
              '#TK-1024',
              'Tax Declaration Query',
              'In Progress',
              Colors.amber,
            ),
            _ticketTile(
              '#TK-1025',
              'Laptop Charger Replacement',
              'Open',
              Colors.blue,
            ),
            _ticketTile(
              '#TK-1021',
              'Leave Balance Regularization',
              'Resolved',
              Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _ticketTile(String id, String subject, String status, Color color) {
    return ListTile(
      title: Text(
        '$id: $subject',
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          status,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }
}

// ==========================================
// ATTENDANCE ARC GAUGE PAINTER
// ==========================================
class AttendanceGaugePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height);
    final double radius = size.width / 2 - 10;
    const double strokeWidth = 22.0;

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    paint.color = const Color(0xFF6C5CE7);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi,
      math.pi * 0.65,
      false,
      paint,
    );

    paint.color = const Color(0xFFA3E635);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi + math.pi * 0.66,
      math.pi * 0.15,
      false,
      paint,
    );

    paint.color = const Color(0xFFFACC15);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi + math.pi * 0.82,
      math.pi * 0.10,
      false,
      paint,
    );

    paint.color = const Color(0xFFF87171);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi + math.pi * 0.93,
      math.pi * 0.07,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
