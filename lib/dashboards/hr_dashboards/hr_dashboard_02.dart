import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const CrextioApp());
}

class CrextioApp extends StatelessWidget {
  const CrextioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazevalley Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'sans-serif',
      ),
      home: const MainShell(),
    );
  }
}

// MARK: - Global Brand Palette
class AppColors {
  static const darkSurface = Color(0xFF262628);
  static const yellowAccent = Color(0xFFFFD465);
  static const textDark = Color(0xFF1B1B1D);
  static const textMuted = Color(0xFF7E7E82);
  static const lineMuted = Color(0x33E5E5E0);
}

// MARK: - Reusable Glass Container
class GlassContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final double blur;
  final double opacity;
  final Color? color;
  final Border? border;

  const GlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 24,
    this.padding,
    this.blur = 16,
    this.opacity = 0.55,
    this.color,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: color ?? Colors.white.withOpacity(opacity),
            borderRadius: BorderRadius.circular(borderRadius),
            border: border ??
                Border.all(
                  color: Colors.white.withOpacity(0.65),
                  width: 1.2,
                ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _activeNavIndex = 0;
  final List<String> _navTabs = [
    'Dashboard',
    'People',
    'Hiring',
    'Devices',
    'Apps',
    'Salary',
    'Calendar',
    'Reviews',
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 1100;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background Canvas (Warm Aurora Glow Mesh without dark grey)
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFFFFDF5),
                      Color(0xFFFAF7EE),
                      Color(0xFFF7EEDB),
                      Color(0xFFF3DEC0),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: -80,
              left: -60,
              child: _glowSphere(320, const Color(0xFFFFE79A).withOpacity(0.4)),
            ),
            Positioned(
              bottom: -60,
              right: -50,
              child: _glowSphere(360, const Color(0xFFF5CAA0).withOpacity(0.4)),
            ),
            Positioned(
              top: size.height * 0.35,
              right: size.width * 0.15,
              child: _glowSphere(240, const Color(0xFFFFFFFF).withOpacity(0.6)),
            ),

            // Main Fixed-Bounds Shell
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GlassContainer(
                borderRadius: 28,
                blur: 24,
                opacity: 0.35,
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTopHeader(isDesktop),
                      const SizedBox(height: 10),
                      Expanded(
                        child: _renderSelectedTabContent(isDesktop),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _glowSphere(double diameter, Color color) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: 100,
            spreadRadius: 40,
          ),
        ],
      ),
    );
  }

  // MARK: - Tab Router
  Widget _renderSelectedTabContent(bool isDesktop) {
    switch (_activeNavIndex) {
      case 0:
        return _buildDashboardView(isDesktop);
      case 1:
        return PeopleView(isDesktop: isDesktop);
      case 2:
        return HiringView(isDesktop: isDesktop);
      case 3:
        return DevicesView(isDesktop: isDesktop);
      case 4:
        return AppsView(isDesktop: isDesktop);
      case 5:
        return SalaryView(isDesktop: isDesktop);
      case 6:
        return CalendarView(isDesktop: isDesktop);
      case 7:
        return ReviewsView(isDesktop: isDesktop);
      default:
        return _buildDashboardView(isDesktop);
    }
  }

  // MARK: - Header & Navigation
  Widget _buildTopHeader(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GlassContainer(
              borderRadius: 30,
              blur: 14,
              opacity: 0.5,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: const Text(
                'Amazevalley',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
            ),
            if (isDesktop) ...[
              const Spacer(),
              _buildNavTabRow(),
              const Spacer(),
            ],
            _buildActionPills(isDesktop),
          ],
        ),
        if (!isDesktop) ...[
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: _buildNavTabRow(),
          ),
        ],
      ],
    );
  }

  Widget _buildNavTabRow() {
    return GlassContainer(
      borderRadius: 32,
      blur: 16,
      opacity: 0.55,
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(_navTabs.length, (i) {
          final isSelected = _activeNavIndex == i;
          return GestureDetector(
            onTap: () => setState(() => _activeNavIndex = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.darkSurface : Colors.transparent,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(
                _navTabs[i],
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textDark,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildActionPills(bool isDesktop) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isDesktop)
          GlassContainer(
            borderRadius: 24,
            blur: 12,
            opacity: 0.55,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: const Row(
              children: [
                Icon(Icons.settings_outlined, size: 16, color: AppColors.textDark),
                SizedBox(width: 6),
                Text('Setting', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              ],
            ),
          )
        else
          _circleIcon(Icons.settings_outlined),
        const SizedBox(width: 6),
        _circleIcon(Icons.notifications_none_outlined),
        const SizedBox(width: 6),
        _circleIcon(Icons.person_outline),
      ],
    );
  }

  Widget _circleIcon(IconData icon) {
    return GlassContainer(
      borderRadius: 20,
      blur: 12,
      opacity: 0.55,
      child: SizedBox(
        width: 34,
        height: 34,
        child: Icon(icon, size: 16, color: AppColors.textDark),
      ),
    );
  }

  // MARK: - 0. Dashboard View
  Widget _buildDashboardView(bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeroMetricBar(isDesktop),
        const SizedBox(height: 12),
        Expanded(
          child: isDesktop
              ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 280,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: const [
                      ProfileCard(),
                      SizedBox(height: 12),
                      AccordionList(),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Expanded(child: ProgressCard()),
                        SizedBox(width: 12),
                        Expanded(child: TimeTrackerCard()),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Expanded(child: CalendarScheduleCard()),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              const SizedBox(
                width: 280,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: OnboardingSideCard(),
                ),
              ),
            ],
          )
              : SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: const [
                ProfileCard(),
                SizedBox(height: 12),
                ProgressCard(),
                SizedBox(height: 12),
                TimeTrackerCard(),
                SizedBox(height: 12),
                CalendarScheduleCard(),
                SizedBox(height: 12),
                OnboardingSideCard(),
                SizedBox(height: 12),
                AccordionList(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroMetricBar(bool isDesktop) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome in, NexaHR',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.5,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    _metricPill('Interviews', '15%', AppColors.darkSurface, Colors.white),
                    const SizedBox(width: 8),
                    _metricPill('Hired', '15%', AppColors.yellowAccent, AppColors.textDark),
                    const SizedBox(width: 8),
                    _stripedProgressPill('Project time', '60%'),
                    const SizedBox(width: 8),
                    _metricPill('Output', '10%', Colors.white.withOpacity(0.4), AppColors.textDark, outlined: true),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (isDesktop) ...[
          const SizedBox(width: 20),
          _statCounter(Icons.people_outline, '78', 'Employe'),
          const SizedBox(width: 28),
          _statCounter(Icons.person_add_alt, '56', 'Hirings'),
          const SizedBox(width: 28),
          _statCounter(Icons.laptop_mac_outlined, '203', 'Projects'),
        ],
      ],
    );
  }

  Widget _metricPill(String title, String val, Color bg, Color textColor, {bool outlined = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 11, color: AppColors.textMuted, fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        GlassContainer(
          borderRadius: 16,
          blur: 10,
          opacity: 0.7,
          color: bg,
          border: outlined ? Border.all(color: Colors.white.withOpacity(0.8), width: 1.2) : null,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Container(
            height: 30,
            alignment: Alignment.center,
            child: Text(val, style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 12)),
          ),
        ),
      ],
    );
  }

  Widget _stripedProgressPill(String title, String val) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 11, color: AppColors.textMuted, fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        GlassContainer(
          borderRadius: 16,
          blur: 12,
          opacity: 0.45,
          child: CustomPaint(
            painter: StripedPillPainter(),
            child: Container(
              height: 30,
              width: 170,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 14),
              child: Text(val, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textDark)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _statCounter(IconData icon, String count, String label) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.textDark),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(count, style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w400, height: 0.9, letterSpacing: -1)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
          ],
        ),
      ],
    );
  }
}

// MARK: - 1. People View
class PeopleView extends StatelessWidget {
  final bool isDesktop;
  const PeopleView({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    final employees = [
      {'name': 'Lora Piterson', 'role': 'UX/UI Lead', 'status': 'Active', 'email': 'lora@amazevalley.co', 'img': '11'},
      {'name': 'Daniel Warren', 'role': 'Tech Lead', 'status': 'In Meeting', 'email': 'daniel@amazevalley.co', 'img': '12'},
      {'name': 'Sophia Chen', 'role': 'Product Manager', 'status': 'Active', 'email': 'sophia@amazevalley.co', 'img': '32'},
      {'name': 'Lucas Miller', 'role': 'Senior Backend Dev', 'status': 'On Leave', 'email': 'lucas@amazevalley.co', 'img': '33'},
      {'name': 'Maya Lin', 'role': 'Motion Designer', 'status': 'Active', 'email': 'maya@amazevalley.co', 'img': '44'},
      {'name': 'Julian Voss', 'role': 'DevOps Lead', 'status': 'Active', 'email': 'julian@amazevalley.co', 'img': '53'},
      {'name': 'Elena Rostova', 'role': 'QA Architect', 'status': 'Active', 'email': 'elena@amazevalley.co', 'img': '49'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('People Directory', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textDark)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(color: AppColors.darkSurface, borderRadius: BorderRadius.circular(20)),
              child: const Row(
                children: [
                  Icon(Icons.add, color: Colors.white, size: 16),
                  SizedBox(width: 4),
                  Text('Add Member', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Expanded(
          child: GlassContainer(
            borderRadius: 24,
            blur: 16,
            opacity: 0.65,
            padding: const EdgeInsets.all(16),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: employees.length,
              separatorBuilder: (context, index) => Divider(color: Colors.white.withOpacity(0.5), height: 14),
              itemBuilder: (context, index) {
                final emp = employees[index];
                final isActive = emp['status'] == 'Active';
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      CircleAvatar(radius: 20, backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=${emp['img']}')),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(emp['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), overflow: TextOverflow.ellipsis),
                            Text(emp['role']!, style: const TextStyle(color: AppColors.textMuted, fontSize: 11), overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                      if (isDesktop)
                        Expanded(child: Text(emp['email']!, style: const TextStyle(color: AppColors.textMuted, fontSize: 12))),
                      GlassContainer(
                        borderRadius: 12,
                        blur: 8,
                        opacity: 0.7,
                        color: isActive ? AppColors.yellowAccent.withOpacity(0.8) : Colors.white.withOpacity(0.5),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        child: Text(emp['status']!, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.more_vert, size: 18, color: AppColors.textMuted),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

// MARK: - 2. Hiring View
class HiringView extends StatelessWidget {
  final bool isDesktop;
  const HiringView({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    final pipelines = [
      {'title': 'Sourced', 'count': '28', 'color': Colors.white.withOpacity(0.65)},
      {'title': 'Screening', 'count': '14', 'color': Colors.white.withOpacity(0.45)},
      {'title': 'Interviewing', 'count': '6', 'color': AppColors.yellowAccent.withOpacity(0.75)},
      {'title': 'Offered', 'count': '2', 'color': AppColors.darkSurface.withOpacity(0.85), 'isDark': true},
    ];

    Widget pipelineCards = Row(
      children: pipelines.map((p) {
        final isDark = p['isDark'] == true;
        return GlassContainer(
          borderRadius: 20,
          blur: 14,
          opacity: 0.65,
          color: p['color'] as Color,
          padding: const EdgeInsets.all(14),
          child: SizedBox(
            width: isDesktop ? null : 110,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p['title'] as String, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: isDark ? Colors.white70 : AppColors.textMuted)),
                const SizedBox(height: 6),
                Text(p['count'] as String, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isDark ? Colors.white : AppColors.textDark)),
              ],
            ),
          ),
        );
      }).map((e) => isDesktop ? Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: e)) : Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: e)).toList(),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Hiring Pipeline', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textDark)),
        const SizedBox(height: 12),
        isDesktop
            ? pipelineCards
            : SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: pipelineCards,
        ),
        const SizedBox(height: 12),
        Expanded(
          child: GlassContainer(
            borderRadius: 24,
            blur: 16,
            opacity: 0.65,
            padding: const EdgeInsets.all(16),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const Text('Open Positions & Live Applicants', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                _jobRow('Lead UI/UX Architect', 'Design Team • Fulltime', '12 Applicants'),
                Divider(color: Colors.white.withOpacity(0.5)),
                _jobRow('Senior Mobile Engineer (Flutter)', 'Engineering • Remote', '34 Applicants'),
                Divider(color: Colors.white.withOpacity(0.5)),
                _jobRow('Staff Growth Marketer', 'Marketing • Hybrid', '8 Applicants'),
                Divider(color: Colors.white.withOpacity(0.5)),
                _jobRow('Data Platform Specialist', 'Infrastructure • Remote', '19 Applicants'),
                Divider(color: Colors.white.withOpacity(0.5)),
                _jobRow('VP of Brand Strategy', 'Executive • Hybrid', '5 Applicants'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _jobRow(String title, String meta, String appCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), overflow: TextOverflow.ellipsis),
                const SizedBox(height: 3),
                Text(meta, style: const TextStyle(color: AppColors.textMuted, fontSize: 11), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          const SizedBox(width: 8),
          GlassContainer(
            borderRadius: 16,
            blur: 8,
            opacity: 0.7,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Text(appCount, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// MARK: - 3. Devices View
// MARK: - 3. Devices View
class DevicesView extends StatelessWidget {
  final bool isDesktop;
  const DevicesView({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    final devices = [
      {'name': 'MacBook Pro 16"', 'user': 'Lora Piterson', 'os': 'macOS Sonoma', 'icon': Icons.laptop_mac},
      {'name': 'iPad Pro 12.9"', 'user': 'Design Pool 03', 'os': 'iPadOS 17.5', 'icon': Icons.tablet_mac},
      {'name': 'Dell UltraSharp 32"', 'user': 'Station B-12', 'os': 'Peripheral', 'icon': Icons.desktop_windows},
      {'name': 'iPhone 15 Pro Testbed', 'user': 'QA Department', 'os': 'iOS 17.4', 'icon': Icons.phone_iphone},
      {'name': 'Mac Studio M2 Ultra', 'user': 'Render Farm 01', 'os': 'macOS Sonoma', 'icon': Icons.computer},
      {'name': 'Studio Display 5K', 'user': 'Station B-14', 'os': 'Hardware Monitor', 'icon': Icons.tv},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Hardware & Devices',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textDark),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: GlassContainer(
            borderRadius: 24,
            blur: 16,
            opacity: 0.65,
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isDesktop ? 3 : 1,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                // Adjusted ratio from 1.6/2.5 to 1.5/2.2 to give enough vertical clearance
                childAspectRatio: isDesktop ? 1.5 : 2.2,
              ),
              itemCount: devices.length,
              itemBuilder: (context, index) {
                final d = devices[index];
                return GlassContainer(
                  borderRadius: 20,
                  blur: 12,
                  opacity: 0.5,
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 17,
                            backgroundColor: AppColors.darkSurface,
                            child: Icon(d['icon'] as IconData, color: Colors.white, size: 17),
                          ),
                          const Icon(Icons.more_horiz, color: AppColors.textMuted),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        d['name'] as String,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        d['os'] as String,
                        style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const Spacer(),
                      GlassContainer(
                        borderRadius: 10,
                        blur: 6,
                        opacity: 0.7,
                        color: AppColors.yellowAccent.withOpacity(0.5),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: Text(
                          'Assigned: ${d['user']}',
                          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

// MARK: - 4. Apps View
class AppsView extends StatelessWidget {
  final bool isDesktop;
  const AppsView({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    final apps = [
      {'name': 'Figma Enterprise', 'seats': '42/50 seats', 'cost': '\$750/mo', 'icon': Icons.draw},
      {'name': 'Slack Business+', 'seats': '78/100 seats', 'cost': '\$980/mo', 'icon': Icons.forum},
      {'name': 'GitHub Enterprise', 'seats': '32/40 seats', 'cost': '\$640/mo', 'icon': Icons.code},
      {'name': 'Notion Workspace', 'seats': '75/75 seats', 'cost': '\$600/mo', 'icon': Icons.note_alt},
      {'name': 'AWS Cloud Services', 'seats': 'Unlimited', 'cost': '\$2,450/mo', 'icon': Icons.cloud_queue},
      {'name': 'Linear Issue Tracker', 'seats': '38/45 seats', 'cost': '\$380/mo', 'icon': Icons.check_circle_outline},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Connected Apps & Subscriptions', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textDark)),
        const SizedBox(height: 12),
        Expanded(
          child: GlassContainer(
            borderRadius: 24,
            blur: 16,
            opacity: 0.65,
            padding: const EdgeInsets.all(16),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: apps.length,
              separatorBuilder: (context, index) => Divider(color: Colors.white.withOpacity(0.5), height: 14),
              itemBuilder: (context, index) {
                final app = apps[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      GlassContainer(
                        borderRadius: 20,
                        blur: 8,
                        opacity: 0.7,
                        child: CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0.6),
                          child: Icon(app['icon'] as IconData, color: AppColors.textDark),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(app['name'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), overflow: TextOverflow.ellipsis),
                            Text(app['seats'] as String, style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
                          ],
                        ),
                      ),
                      Text(app['cost'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

// MARK: - 5. Salary View
class SalaryView extends StatelessWidget {
  final bool isDesktop;
  const SalaryView({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    Widget statTiles = Row(
      children: [
        GlassContainer(
          borderRadius: 24,
          blur: 14,
          opacity: 0.85,
          color: AppColors.darkSurface.withOpacity(0.85),
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: isDesktop ? null : 260,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Next Payroll Batch', style: TextStyle(color: Colors.white70, fontSize: 12)),
                SizedBox(height: 6),
                Text('\$148,250.00', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('Scheduled for Sep 30, 2026', style: TextStyle(color: AppColors.yellowAccent, fontSize: 11)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        GlassContainer(
          borderRadius: 24,
          blur: 14,
          opacity: 0.65,
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: isDesktop ? null : 260,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bonus & Benefits Disbursed', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                SizedBox(height: 6),
                Text('\$32,400.00', style: TextStyle(color: AppColors.textDark, fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text('YTD Total: \$180,900.00', style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
              ],
            ),
          ),
        ),
      ].map((e) => isDesktop ? Expanded(child: e) : e).toList(),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Compensation & Payroll', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textDark)),
        const SizedBox(height: 12),
        isDesktop
            ? statTiles
            : SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: statTiles,
        ),
        const SizedBox(height: 12),
        Expanded(
          child: GlassContainer(
            borderRadius: 24,
            blur: 16,
            opacity: 0.65,
            padding: const EdgeInsets.all(16),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                const Text('Recent Disbursals', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                const _SalaryRow('Engineering Dept (32 members)', 'Sep 15, 2026', '\$74,100.00'),
                Divider(color: Colors.white.withOpacity(0.5)),
                const _SalaryRow('Product & Design (18 members)', 'Sep 15, 2026', '\$42,800.00'),
                Divider(color: Colors.white.withOpacity(0.5)),
                const _SalaryRow('Marketing & Sales (14 members)', 'Sep 15, 2026', '\$21,500.00'),
                Divider(color: Colors.white.withOpacity(0.5)),
                const _SalaryRow('Operations & HR (14 members)', 'Sep 15, 2026', '\$9,850.00'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SalaryRow extends StatelessWidget {
  final String title;
  final String date;
  final String amount;
  const _SalaryRow(this.title, this.date, this.amount);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), overflow: TextOverflow.ellipsis),
                Text(date, style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppColors.textDark)),
        ],
      ),
    );
  }
}

// MARK: - 6. Calendar View
class CalendarView extends StatelessWidget {
  final bool isDesktop;
  const CalendarView({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('Company Calendar & Events', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textDark)),
        SizedBox(height: 12),
        Expanded(child: CalendarScheduleCard()),
      ],
    );
  }
}

// MARK: - 7. Reviews View
class ReviewsView extends StatelessWidget {
  final bool isDesktop;
  const ReviewsView({super.key, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    final reviews = [
      {'name': 'Lora Piterson', 'period': 'Q3 360 Review', 'score': '4.9 / 5.0', 'status': 'Completed'},
      {'name': 'Sophia Chen', 'period': 'Annual Performance', 'score': '4.8 / 5.0', 'status': 'Under Review'},
      {'name': 'Lucas Miller', 'period': 'Probation End Review', 'score': '4.6 / 5.0', 'status': 'Pending Signature'},
      {'name': 'Daniel Warren', 'period': 'Leadership Peer Review', 'score': '5.0 / 5.0', 'status': 'Completed'},
      {'name': 'Maya Lin', 'period': 'Mid-Year Design Alignment', 'score': '4.7 / 5.0', 'status': 'Completed'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Performance Reviews & Metrics', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textDark)),
        const SizedBox(height: 12),
        Expanded(
          child: GlassContainer(
            borderRadius: 24,
            blur: 16,
            opacity: 0.65,
            padding: const EdgeInsets.all(16),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: reviews.length,
              separatorBuilder: (context, index) => Divider(color: Colors.white.withOpacity(0.5), height: 14),
              itemBuilder: (context, index) {
                final r = reviews[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(r['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), overflow: TextOverflow.ellipsis),
                            Text(r['period']!, style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(r['score']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                          const SizedBox(width: 8),
                          GlassContainer(
                            borderRadius: 10,
                            blur: 8,
                            opacity: 0.8,
                            color: AppColors.yellowAccent,
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Text(r['status']!, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

// MARK: - Shared Glass Cards
class StripedPillPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rrect = RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(16));
    final bgPaint = Paint()..color = Colors.white.withOpacity(0.3);
    canvas.drawRRect(rrect, bgPaint);

    canvas.save();
    canvas.clipRRect(rrect);

    final linePaint = Paint()
      ..color = Colors.white.withOpacity(0.85)
      ..strokeWidth = 2.0;

    for (double x = -size.height; x < size.width + size.height; x += 7) {
      canvas.drawLine(Offset(x, size.height), Offset(x + size.height, 0), linePaint);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 310,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 16, offset: const Offset(0, 8)),
        ],
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=800&auto=format&fit=crop'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.75)],
                stops: const [0.55, 1.0],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Lora Piterson', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white)),
                    Text('UX/UI Designer', style: TextStyle(fontSize: 12, color: Colors.white70)),
                  ],
                ),
                GlassContainer(
                  borderRadius: 20,
                  blur: 10,
                  opacity: 0.25,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  child: const Text('\$1,200', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AccordionList extends StatelessWidget {
  const AccordionList({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: 24,
      blur: 16,
      opacity: 0.65,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          _rowItem('Pension contributions', Icons.keyboard_arrow_down),
          Divider(color: Colors.white.withOpacity(0.6), height: 16),
          Row(
            children: const [
              Text('Devices', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              Spacer(),
              Icon(Icons.keyboard_arrow_up, size: 18, color: AppColors.textMuted),
            ],
          ),
          const SizedBox(height: 8),
          GlassContainer(
            borderRadius: 16,
            blur: 10,
            opacity: 0.75,
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 34,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E293B),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.laptop_mac, color: Colors.white70, size: 20),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('MacBook Air', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
                      Text('Version M1', style: TextStyle(fontSize: 10, color: AppColors.textMuted)),
                    ],
                  ),
                ),
                const Icon(Icons.more_vert, size: 16, color: AppColors.textMuted),
              ],
            ),
          ),
          Divider(color: Colors.white.withOpacity(0.6), height: 16),
          _rowItem('Compensation Summary', Icons.keyboard_arrow_down),
          Divider(color: Colors.white.withOpacity(0.6), height: 16),
          _rowItem('Employee Benefits', Icons.keyboard_arrow_down),
        ],
      ),
    );
  }

  Widget _rowItem(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
          Icon(icon, size: 18, color: AppColors.textMuted),
        ],
      ),
    );
  }
}

class ProgressCard extends StatelessWidget {
  const ProgressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: 28,
      blur: 16,
      opacity: 0.65,
      padding: const EdgeInsets.all(18),
      child: SizedBox(
        height: 245,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Progress', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                _topRightArrow(),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: const [
                Text('6.1', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600)),
                Text(' h', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
                SizedBox(width: 8),
                Text('Work Time\nthis week', style: TextStyle(fontSize: 10, color: AppColors.textMuted, height: 1.1)),
              ],
            ),
            const Spacer(),
            SizedBox(
              height: 120,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: 0,
                    right: 52,
                    child: GlassContainer(
                      borderRadius: 10,
                      blur: 8,
                      opacity: 0.9,
                      color: AppColors.yellowAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      child: const Text('5h 23m', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _barCol('S', 0.25, false),
                      _barCol('M', 0.75, true),
                      _barCol('T', 0.55, true),
                      _barCol('W', 0.40, true),
                      _barCol('T', 0.85, true),
                      _barCol('F', 0.65, false, activeYellow: true),
                      _barCol('S', 0.25, false),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _barCol(String day, double pct, bool filled, {bool activeYellow = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 70 * pct,
          decoration: BoxDecoration(
            color: activeYellow
                ? AppColors.yellowAccent
                : (filled ? AppColors.darkSurface : Colors.white.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: filled || activeYellow ? AppColors.darkSurface : Colors.transparent,
          ),
        ),
        const SizedBox(height: 6),
        Text(day, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
      ],
    );
  }
}

class TimeTrackerCard extends StatelessWidget {
  const TimeTrackerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: 28,
      blur: 16,
      opacity: 0.65,
      padding: const EdgeInsets.all(18),
      child: SizedBox(
        height: 245,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Time tracker', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                _topRightArrow(),
              ],
            ),
            const Spacer(),
            CustomPaint(
              painter: TimeDialPainter(),
              child: const SizedBox(
                width: 130,
                height: 130,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('02:35', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600, letterSpacing: -0.5)),
                      Text('Work Time', style: TextStyle(fontSize: 10, color: AppColors.textMuted)),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                _controlBtn(Icons.play_arrow_outlined),
                const SizedBox(width: 8),
                _controlBtn(Icons.pause),
                const Spacer(),
                Container(
                  width: 38,
                  height: 38,
                  decoration: const BoxDecoration(
                    color: AppColors.darkSurface,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.alarm, color: Colors.white, size: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _controlBtn(IconData icon) {
    return GlassContainer(
      borderRadius: 20,
      blur: 8,
      opacity: 0.75,
      child: SizedBox(
        width: 36,
        height: 36,
        child: Icon(icon, size: 18, color: AppColors.textDark),
      ),
    );
  }
}

class TimeDialPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final tickPaint = Paint()
      ..color = AppColors.textMuted.withOpacity(0.7)
      ..strokeWidth = 1.2;

    for (int i = 0; i < 40; i++) {
      final angle = (i * 2 * math.pi / 40);
      final p1 = Offset(center.dx + (radius - 12) * math.cos(angle), center.dy + (radius - 12) * math.sin(angle));
      final p2 = Offset(center.dx + radius * math.cos(angle), center.dy + radius * math.sin(angle));
      canvas.drawLine(p1, p2, tickPaint);
    }

    final arcPaint = Paint()
      ..color = AppColors.yellowAccent
      ..strokeWidth = 9
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius + 2),
      -math.pi / 4,
      1.6 * math.pi / 2,
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CalendarScheduleCard extends StatelessWidget {
  const CalendarScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: 28,
      blur: 16,
      opacity: 0.65,
      padding: const EdgeInsets.all(18),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _monthNavBtn('August'),
                const Text('September 2026', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                _monthNavBtn('October'),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                const SizedBox(width: 54),
                Expanded(child: _dayHeader('Mon', '22')),
                Expanded(child: _dayHeader('Tue', '23')),
                Expanded(child: _dayHeader('Wed', '24')),
                Expanded(child: _dayHeader('Thu', '25')),
                Expanded(child: _dayHeader('Fri', '26')),
                Expanded(child: _dayHeader('Sat', '27')),
              ],
            ),
            const SizedBox(height: 10),
            _timeSlot('8:00 am', child: _eventBadge('Weekly Team Sync', 'Discuss progress on projects', true)),
            _timeSlot('9:00 am'),
            _timeSlot('10:00 am', child: _eventBadge('Onboarding Session', 'Introduction for new hires', false, leftOffset: 60)),
            _timeSlot('11:00 am'),
          ],
        ),
      ),
    );
  }

  Widget _monthNavBtn(String title) {
    return GlassContainer(
      borderRadius: 20,
      blur: 8,
      opacity: 0.75,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }

  Widget _dayHeader(String day, String num) {
    return Column(
      children: [
        Text(day, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
        const SizedBox(height: 4),
        Text(num, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _timeSlot(String time, {Widget? child}) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.45))),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 54,
            child: Text(time, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
          ),
          Expanded(child: child ?? const SizedBox()),
        ],
      ),
    );
  }

  Widget _eventBadge(String title, String desc, bool isDark, {double leftOffset = 0}) {
    return Padding(
      padding: EdgeInsets.only(left: leftOffset),
      child: GlassContainer(
        borderRadius: 10,
        blur: 10,
        opacity: isDark ? 0.85 : 0.7,
        color: isDark ? AppColors.darkSurface.withOpacity(0.85) : Colors.white.withOpacity(0.7),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          height: 34,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : AppColors.textDark,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      desc,
                      style: TextStyle(fontSize: 8, color: isDark ? Colors.white60 : AppColors.textMuted),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _stackedAvatars(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stackedAvatars() {
    return SizedBox(
      width: 36,
      height: 18,
      child: Stack(
        children: const [
          Positioned(left: 0, child: CircleAvatar(radius: 8, backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=11'))),
          Positioned(left: 9, child: CircleAvatar(radius: 8, backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=12'))),
          Positioned(left: 18, child: CircleAvatar(radius: 8, backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=13'))),
        ],
      ),
    );
  }
}

class OnboardingSideCard extends StatelessWidget {
  const OnboardingSideCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlassContainer(
          borderRadius: 28,
          blur: 16,
          opacity: 0.65,
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Onboarding', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  Text('18%', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w300)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  _statSegment('30%', 'Task', AppColors.yellowAccent, 2.5),
                  const SizedBox(width: 4),
                  _statSegment('25%', '', AppColors.darkSurface, 1.5),
                  const SizedBox(width: 4),
                  _statSegment('0%', '', const Color(0xFF8F939A), 0.8),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        GlassContainer(
          borderRadius: 28,
          blur: 18,
          opacity: 0.88,
          color: AppColors.darkSurface.withOpacity(0.85),
          border: Border.all(color: Colors.white.withOpacity(0.18), width: 1.2),
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Onboarding Task', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                  Text('2/8', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w300)),
                ],
              ),
              const SizedBox(height: 14),
              _taskRow(Icons.laptop_chromebook, 'Interview', 'Sep 13, 08:30', isDone: true),
              _taskRow(Icons.bolt, 'Team Meeting', 'Sep 13, 10:30', isDone: true),
              _taskRow(Icons.chat_bubble_outline, 'Project Update', 'Sep 13, 13:00', isDone: false),
              _taskRow(Icons.edit_outlined, 'Discuss Q3 Goals', 'Sep 13, 14:45', isDone: false),
              _taskRow(Icons.link, 'HR Policy Review', 'Sep 13, 16:30', isDone: false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statSegment(String pct, String title, Color color, double flexRatio) {
    return Expanded(
      flex: (flexRatio * 10).toInt(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(pct, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
          const SizedBox(height: 4),
          Container(
            height: 30,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 8),
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
            child: title.isNotEmpty ? Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)) : null,
          ),
        ],
      ),
    );
  }

  Widget _taskRow(IconData icon, String title, String subtitle, {required bool isDone}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: const Color(0xFF38383B),
            child: Icon(icon, color: Colors.white70, size: 14),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
              Text(subtitle, style: const TextStyle(color: Color(0xFF8A8A8E), fontSize: 10)),
            ],
          ),
          const Spacer(),
          isDone
              ? const Icon(Icons.check_circle, color: AppColors.yellowAccent, size: 18)
              : Container(
            width: 16,
            height: 16,
            decoration: const BoxDecoration(color: Color(0xFF38383B), shape: BoxShape.circle),
          ),
        ],
      ),
    );
  }
}

Widget _topRightArrow() {
  return GlassContainer(
    borderRadius: 14,
    blur: 6,
    opacity: 0.8,
    child: const SizedBox(
      width: 28,
      height: 28,
      child: Icon(Icons.arrow_outward, size: 14, color: AppColors.textDark),
    ),
  );
}