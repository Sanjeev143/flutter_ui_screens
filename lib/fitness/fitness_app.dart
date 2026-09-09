import 'dart:math' as math;
import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const FitnessApp());
}

class FitnessApp extends StatelessWidget {
  const FitnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amaze Valley Fitness',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: const Color(0xFFEFF2FB),
        primaryColor: const Color(0xFF4C7BF4),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4C7BF4),
          primary: const Color(0xFF4C7BF4),
        ),
      ),
      home: const MainNavHost(),
    );
  }
}

// ==========================================
// SMOOTH PAGE ROUTE TRANSITION
// ==========================================

class SmoothPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  SmoothPageRoute({required this.page})
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionDuration: const Duration(milliseconds: 360),
    reverseTransitionDuration: const Duration(milliseconds: 280),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      );

      return FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 0.08),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: child,
        ),
      );
    },
  );
}

// ==========================================
// IMAGE NETWORK HELPER WITH FALLBACK
// ==========================================

Widget buildNetworkImage(String url, {BoxFit fit = BoxFit.cover}) {
  return Image.network(
    url,
    fit: fit,
    loadingBuilder: (context, child, loadingProgress) {
      if (loadingProgress == null) return child;
      return Container(
        color: const Color(0xFFE2E7F3),
        child: const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4C7BF4)),
          ),
        ),
      );
    },
    errorBuilder: (context, error, stackTrace) => Container(
      color: const Color(0xFFD6DFEF),
      child: const Center(
        child: Icon(Icons.fitness_center_rounded, color: Color(0xFF4C7BF4), size: 32),
      ),
    ),
  );
}

// ==========================================
// REUSABLE GLASSPHORMIC CONTAINER (CLAMP SAFE)
// ==========================================

class GlassmorphicContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final double blur;
  final double opacity;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Widget child;
  final Gradient? gradient;
  final Border? border;

  const GlassmorphicContainer({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 28,
    this.blur = 18,
    this.opacity = 0.65,
    this.padding,
    this.margin,
    required this.child,
    this.gradient,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final safeBaseOpacity = opacity.clamp(0.0, 1.0);
    final safeHighlightOpacity = (opacity + 0.18).clamp(0.0, 1.0);

    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3F64D8).withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              gradient: gradient ??
                  LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(safeHighlightOpacity),
                      Colors.white.withOpacity(safeBaseOpacity),
                    ],
                  ),
              border: border ??
                  Border.all(
                    color: Colors.white.withOpacity(0.55),
                    width: 1.2,
                  ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

// ==========================================
// DATA MODEL FOR PROGRAMS & CAROUSEL
// ==========================================

class ProgramItem {
  final String id;
  final String title;
  final String category;
  final String level;
  final String duration;
  final String setsReps;
  final String coach;
  final String members;
  final String tagline;
  final String description;
  final String imageUrl;
  final List<Color> gradientColors;

  const ProgramItem({
    required this.id,
    required this.title,
    required this.category,
    required this.level,
    required this.duration,
    required this.setsReps,
    required this.coach,
    required this.members,
    required this.tagline,
    required this.description,
    required this.imageUrl,
    required this.gradientColors,
  });
}

final List<ProgramItem> demoPrograms = [
  const ProgramItem(
    id: 'prog_1',
    title: 'Thunder Boult 5X5',
    category: 'Pick A Program',
    level: 'Intermediate • 4 weeks',
    duration: '39m16s',
    setsReps: '5X5set',
    coach: 'Jhon Snow',
    members: '5.8k+',
    tagline: 'Get Set, Stay\nIgnite, Finish Proud.\nJoin The Flow.',
    description:
    'Unleash the power within with the Thunder Boult Program, a 4-week strength training journey designed to discipline through 5x5 technique.',
    imageUrl:
    'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?auto=format&fit=crop&w=1000&q=80',
    gradientColors: [Color(0xFF86ABF9), Color(0xFF3363D8)],
  ),
  const ProgramItem(
    id: 'prog_2',
    title: 'Core Shred & Power 3X3',
    category: 'Core Conditioning',
    level: 'Intermediate • 5 weeks',
    duration: '28m40s',
    setsReps: '3X3set',
    coach: 'Alex Vance',
    members: '4.2k+',
    tagline: 'Define Abs,\nStrengthen Core,\nBuild True Balance.',
    description:
    'Strengthen your core foundation and improve rotational stability through high-intensity dynamic abdominal complexes.',
    imageUrl:
    'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?auto=format&fit=crop&w=1000&q=80',
    gradientColors: [Color(0xFFD289F4), Color(0xFF7B4BE7)],
  ),
  const ProgramItem(
    id: 'prog_3',
    title: 'Explosive HIIT Fury',
    category: 'Endurance & Cardio',
    level: 'Advanced • 3 weeks',
    duration: '22m15s',
    setsReps: '4X12set',
    coach: 'Sarah Miller',
    members: '8.1k+',
    tagline: 'Burn Fast,\nElevate Stamina,\nConquer Your Limits.',
    description:
    'Max heart-rate intervals designed to burn maximum calories, boost aerobic threshold, and build rapid cardiovascular resilience.',
    imageUrl:
    'https://images.unsplash.com/photo-1601422407692-ec4eeec1d9b3?auto=format&fit=crop&w=1000&q=80',
    gradientColors: [Color(0xFFFF9E7D), Color(0xFFFF5252)],
  ),
  const ProgramItem(
    id: 'prog_4',
    title: 'Hypertrophy Max Pump',
    category: 'Muscle Volume',
    level: 'Advanced • 6 weeks',
    duration: '48m10s',
    setsReps: '4X8set',
    coach: 'Marcus Brody',
    members: '6.4k+',
    tagline: 'Target Arms,\nShoulders & Chest.\nDemand Pure Growth.',
    description:
    'Heavy compound movements isolated with superset finishers targeted specifically at upper torso muscle hypertrophy.',
    imageUrl:
    'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&w=1000&q=80',
    gradientColors: [Color(0xFF48CAE4), Color(0xFF0077B6)],
  ),
  const ProgramItem(
    id: 'prog_5',
    title: 'Mobility & Posture Zen',
    category: 'Recovery & Form',
    level: 'Beginner • 2 weeks',
    duration: '20m00s',
    setsReps: '3X10set',
    coach: 'Elena Rostova',
    members: '3.9k+',
    tagline: 'Unlock Tight Joints,\nDeepen Breath,\nMove Without Pain.',
    description:
    'Restorative kinetic mobility routines targeted at unlocking tight hips, decompression of the spine, and tendon recovery.',
    imageUrl:
    'https://images.unsplash.com/photo-1518611012118-696072aa579a?auto=format&fit=crop&w=1000&q=80',
    gradientColors: [Color(0xFF80ED99), Color(0xFF2D6A4F)],
  ),
];

// ==========================================
// NAVIGATION HOST & CONTROLLER
// ==========================================

class MainNavHost extends StatefulWidget {
  const MainNavHost({super.key});

  @override
  State<MainNavHost> createState() => _MainNavHostState();
}

class _MainNavHostState extends State<MainNavHost> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    DashboardScreen(),
    ProgramsScreen(),
    ClipsLibraryScreen(),
    WarmupListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF2FB),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -60,
              left: -40,
              child: Container(
                width: 220,
                height: 220,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFC7D7FD),
                ),
              ),
            ),
            Positioned(
              bottom: 120,
              right: -50,
              child: Container(
                width: 260,
                height: 260,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE2CEFD),
                ),
              ),
            ),
            IndexedStack(
              index: _currentIndex,
              children: _pages,
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 16,
              child: _buildFloatingGlassNav(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingGlassNav() {
    return GlassmorphicContainer(
      height: 68,
      borderRadius: 36,
      blur: 24,
      opacity: 0.72,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _navItem(0, 'GENERATOR', Icons.auto_awesome),
          _navItem(1, 'PROGRAMS', Icons.layers_outlined),
          _navItem(2, 'CLIPS', Icons.video_collection_outlined),
          _navItem(3, 'PROFILE', Icons.person_outline),
        ],
      ),
    );
  }

  Widget _navItem(int index, String label, IconData icon) {
    final bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: isSelected
            ? const EdgeInsets.symmetric(horizontal: 12, vertical: 6)
            : const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1D284B) : Colors.transparent,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: isSelected
                    ? const LinearGradient(
                  colors: [Color(0xFF6C92F6), Color(0xFFB17BF6)],
                )
                    : null,
              ),
              child: Icon(
                icon,
                size: 16,
                color: isSelected ? Colors.white : const Color(0xFF8C98B6),
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 5),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                  color: Colors.white,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 1. DASHBOARD / HOME SCREEN
// ==========================================

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PageController _carouselController = PageController(viewportFraction: 0.94);
  int _activeCardIndex = 0;

  @override
  void dispose() {
    _carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 110),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTopHeader(context),
          const SizedBox(height: 20),
          const Text(
            'Hello, Amaze Valley!',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF7582A0),
            ),
          ),
          const Text(
            'Ready to Workout',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: Color(0xFF17203A),
            ),
          ),
          const SizedBox(height: 18),
          _buildActivityStatCard(),
          const SizedBox(height: 16),
          _buildFilterChips(),
          const SizedBox(height: 22),
          _buildProgramCarousel(context),
          const SizedBox(height: 22),
          _buildDailyGoalProgressCard(),
          const SizedBox(height: 22),
          _buildQuickStatsGrid(),
          const SizedBox(height: 24),
          _buildRecommendedWorkoutsSection(context),
          const SizedBox(height: 24),
          _buildRecentActivitySection(context),
        ],
      ),
    );
  }

  Widget _buildTopHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFF537FF5), Color(0xFFB566F5)],
                ),
              ),
              child: const CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xFF1D284B),
                child: Text(
                  'AV',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Amaze Valley',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF17203A),
                  ),
                ),
                Text(
                  'amazevalley@gmail.com',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4C7BF4),
                  ),
                ),
              ],
            )
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  SmoothPageRoute(page: const AnalyticsScreen()),
                );
              },
              icon: const Icon(Icons.tune, color: Color(0xFF4C5874), size: 22),
            ),
            GlassmorphicContainer(
              borderRadius: 22,
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.notifications_none_rounded, size: 20),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildActivityStatCard() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        const Text(
          '20',
          style: TextStyle(
            fontSize: 54,
            fontWeight: FontWeight.w800,
            letterSpacing: -1,
            color: Color(0xFF131D36),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Min Upper',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A233D),
              ),
            ),
            Text(
              'Body Activities',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A233D),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildFilterChips() {
    final filters = ['Upper Body', 'Build Strength', 'Beginner', 'Fat Burn'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: filters.map((filter) {
          final bool isFirst = filter == 'Upper Body';
          return GlassmorphicContainer(
            borderRadius: 20,
            opacity: isFirst ? 0.85 : 0.45,
            gradient: isFirst
                ? const LinearGradient(
              colors: [Color(0xFFEDEFFF), Color(0xFFDBE2FD)],
            )
                : null,
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Text(
              filter,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isFirst ? const Color(0xFF3F64D8) : const Color(0xFF6B7A99),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildProgramCarousel(BuildContext context) {
    return SizedBox(
      height: 385,
      child: PageView.builder(
        controller: _carouselController,
        physics: const BouncingScrollPhysics(),
        itemCount: demoPrograms.length,
        onPageChanged: (idx) => setState(() => _activeCardIndex = idx),
        itemBuilder: (context, index) {
          final item = demoPrograms[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  SmoothPageRoute(page: ProgramDetailScreen(program: item)),
                );
              },
              child: GlassmorphicContainer(
                height: 380,
                borderRadius: 34,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: buildNetworkImage(item.imageUrl),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              item.gradientColors.first.withOpacity(0.72),
                              item.gradientColors.last.withOpacity(0.92),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    item.category,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 11,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: List.generate(
                                  demoPrograms.length,
                                      (dotIndex) => AnimatedContainer(
                                    duration: const Duration(milliseconds: 250),
                                    margin: const EdgeInsets.only(left: 4),
                                    width: _activeCardIndex == dotIndex ? 14 : 5,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      color: _activeCardIndex == dotIndex
                                          ? Colors.white
                                          : Colors.white38,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const Spacer(),
                          _buildSocialAvatars(item.members),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Text(
                                  item.tagline,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 21,
                                    fontWeight: FontWeight.w800,
                                    height: 1.25,
                                  ),
                                ),
                              ),
                              GlassmorphicContainer(
                                borderRadius: 24,
                                opacity: 0.25,
                                padding: const EdgeInsets.all(12),
                                child: const Icon(
                                  Icons.arrow_outward,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDailyGoalProgressCard() {
    return GlassmorphicContainer(
      padding: const EdgeInsets.all(20),
      borderRadius: 28,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6C92F6).withOpacity(0.18),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.track_changes_rounded,
                      color: Color(0xFF4C7BF4),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Daily Goal Target',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF141E34),
                        ),
                      ),
                      Text(
                        '3 of 4 workouts completed',
                        style: TextStyle(fontSize: 11, color: Color(0xFF7582A0)),
                      ),
                    ],
                  ),
                ],
              ),
              const Text(
                '75%',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF4C7BF4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: 0.75,
              minHeight: 8,
              backgroundColor: const Color(0xFFE2E7F6),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4C7BF4)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStatsGrid() {
    return Row(
      children: [
        Expanded(
          child: GlassmorphicContainer(
            padding: const EdgeInsets.all(16),
            borderRadius: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFECE5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.local_fire_department_rounded,
                    color: Color(0xFFFF6E40),
                    size: 20,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  '485 kcal',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF141E34),
                  ),
                ),
                const Text(
                  'Active Calories',
                  style: TextStyle(fontSize: 11, color: Color(0xFF8692AE)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: GlassmorphicContainer(
            padding: const EdgeInsets.all(16),
            borderRadius: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5F7ED),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.bolt_rounded,
                    color: Color(0xFF00C48C),
                    size: 20,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  '1,240 lb',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF141E34),
                  ),
                ),
                const Text(
                  'Total Volume',
                  style: TextStyle(fontSize: 11, color: Color(0xFF8692AE)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRecommendedWorkoutsSection(BuildContext context) {
    final routines = [
      {
        'title': 'Upper Body Pump',
        'duration': '25 min',
        'level': 'Intermediate',
        'image':
        'https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?auto=format&fit=crop&w=500&q=80',
        'gradient': [const Color(0xFF7AA5FB), const Color(0xFF4C7BF4)],
      },
      {
        'title': 'HIIT Explosive',
        'duration': '18 min',
        'level': 'Advanced',
        'image':
        'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&w=500&q=80',
        'gradient': [const Color(0xFFCE8EF4), const Color(0xFF7D5FF2)],
      },
      {
        'title': 'Core Stability 360',
        'duration': '15 min',
        'level': 'Beginner',
        'image':
        'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?auto=format&fit=crop&w=500&q=80',
        'gradient': [const Color(0xFF6EE2F5), const Color(0xFF3F95EA)],
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recommended For You',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0xFF141E34),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  SmoothPageRoute(page: const WarmupListScreen()),
                );
              },
              child: const Text(
                'View all',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF4C7BF4),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 165,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: routines.length,
            separatorBuilder: (_, __) => const SizedBox(width: 14),
            itemBuilder: (context, index) {
              final r = routines[index];
              final grads = r['gradient'] as List<Color>;
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    SmoothPageRoute(page: const ProgramDetailScreen()),
                  );
                },
                child: GlassmorphicContainer(
                  width: 200,
                  borderRadius: 24,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: buildNetworkImage(r['image'] as String),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                grads.first.withOpacity(0.6),
                                grads.last.withOpacity(0.88),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                r['level'] as String,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  r['title'] as String,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time_rounded,
                                      color: Colors.white70,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      r['duration'] as String,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivitySection(BuildContext context) {
    final activities = [
      {
        'title': 'Dumbbell Bicep Curl',
        'details': '4 Sets • 12 Reps',
        'cal': '95 kcal',
        'image':
        'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?auto=format&fit=crop&w=200&q=80',
      },
      {
        'title': 'Kettlebell Sumo Squat',
        'details': '3 Sets • 15 Reps',
        'cal': '120 kcal',
        'image':
        'https://images.unsplash.com/photo-1517963879433-6ad2b056d712?auto=format&fit=crop&w=200&q=80',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Activities',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: Color(0xFF141E34),
          ),
        ),
        const SizedBox(height: 14),
        ...activities.map(
              (act) => GlassmorphicContainer(
            borderRadius: 22,
            opacity: 0.65,
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: buildNetworkImage(act['image'] as String),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        act['title'] as String,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF141E34),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        act['details'] as String,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF8692AE),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  act['cal'] as String,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF4C7BF4),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialAvatars(String memberCount) {
    return Row(
      children: [
        SizedBox(
          width: 68,
          height: 28,
          child: Stack(
            children: List.generate(3, (i) {
              return Positioned(
                left: i * 18.0,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    color: [Colors.orange, Colors.teal, Colors.purple][i],
                  ),
                  child: Center(
                    child: Text(
                      ['A', 'V', 'K'][i],
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(width: 6),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              memberCount,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
            const Text(
              'Members',
              style: TextStyle(color: Colors.white70, fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }
}

// ==========================================
// 2. PROGRAMS SCREEN
// ==========================================

class ProgramsScreen extends StatelessWidget {
  const ProgramsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Programs',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF141E34),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Text(
                  'amazevalley@gmail.com',
                  style: TextStyle(fontSize: 10, color: Color(0xFF4C7BF4), fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Pre-planned workout paired with audio guidance\nand expert coaching.',
            style: TextStyle(
              fontSize: 13,
              height: 1.4,
              color: Color(0xFF76829D),
            ),
          ),
          const SizedBox(height: 20),
          _programGlassCard(
            context,
            program: demoPrograms[0],
          ),
          const SizedBox(height: 16),
          _programGlassCard(
            context,
            program: demoPrograms[1],
          ),
          const SizedBox(height: 16),
          _programGlassCard(
            context,
            program: demoPrograms[2],
          ),
        ],
      ),
    );
  }

  Widget _programGlassCard(
      BuildContext context, {
        required ProgramItem program,
      }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          SmoothPageRoute(page: ProgramDetailScreen(program: program)),
        );
      },
      child: GlassmorphicContainer(
        height: 290,
        borderRadius: 28,
        child: Stack(
          children: [
            Positioned.fill(
              child: buildNetworkImage(program.imageUrl),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      program.gradientColors.first.withOpacity(0.82),
                      program.gradientColors.last.withOpacity(0.92),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    program.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    program.level,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    program.setsReps,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.person, size: 14, color: Colors.blue),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            program.coach,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Text(
                            'Gym Coach',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 9,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Text(
                          program.tagline,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            height: 1.25,
                          ),
                        ),
                      ),
                      GlassmorphicContainer(
                        borderRadius: 22,
                        opacity: 0.25,
                        padding: const EdgeInsets.all(10),
                        child: const Icon(
                          Icons.arrow_outward,
                          size: 18,
                          color: Colors.white,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 3. CLIPS LIBRARY SCREEN
// ==========================================

class ClipsLibraryScreen extends StatelessWidget {
  const ClipsLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Clips Library',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF141E34),
                ),
              ),
              Icon(Icons.ios_share, size: 20, color: Color(0xFF43516E)),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Train Smart with Exercise Videos. Watch,\nLearn & Repeat Your Personal Guide to Every Move.',
            style: TextStyle(fontSize: 12, color: Color(0xFF7985A0)),
          ),
          const SizedBox(height: 20),
          _buildVideoGlassCard(context),
          const SizedBox(height: 16),
          _buildHorizontalGlassClipCard(
            title: 'Dumbbell Bicep Curl',
            reps: '4x4',
            duration: '2min',
            imageUrl:
            'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?auto=format&fit=crop&w=200&q=80',
          ),
          const SizedBox(height: 12),
          _buildHorizontalGlassClipCard(
            title: 'Barbell High Squats',
            reps: '3x10',
            duration: '4min',
            imageUrl:
            'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&w=200&q=80',
          ),
          const SizedBox(height: 12),
          _buildHorizontalGlassClipCard(
            title: 'Kettlebell Deadlift',
            reps: '4x12',
            duration: '5min',
            imageUrl:
            'https://images.unsplash.com/photo-1517963879433-6ad2b056d712?auto=format&fit=crop&w=200&q=80',
          ),
        ],
      ),
    );
  }

  Widget _buildVideoGlassCard(BuildContext context) {
    return GlassmorphicContainer(
      height: 310,
      borderRadius: 32,
      child: Stack(
        children: [
          Positioned.fill(
            child: buildNetworkImage(
              'https://images.unsplash.com/photo-1517963879433-6ad2b056d712?auto=format&fit=crop&w=1000&q=80',
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFCE8EF4).withOpacity(0.55),
                    const Color(0xFF7D5FF2).withOpacity(0.88),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  SmoothPageRoute(page: const WorkoutActiveScreen()),
                );
              },
              child: GlassmorphicContainer(
                width: 60,
                height: 60,
                borderRadius: 30,
                opacity: 0.3,
                child: const Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 38,
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Kettlebell Swing Masterclass',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: const [
                    Text(
                      '02:12 / 4:55',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    Spacer(),
                    Icon(Icons.volume_up_outlined, color: Colors.white70, size: 18),
                    SizedBox(width: 10),
                    Icon(Icons.fullscreen, color: Colors.white70, size: 20),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHorizontalGlassClipCard({
    required String title,
    required String reps,
    required String duration,
    required String imageUrl,
  }) {
    return GlassmorphicContainer(
      borderRadius: 24,
      opacity: 0.6,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: SizedBox(
              width: 74,
              height: 74,
              child: buildNetworkImage(imageUrl),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF141E34),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  reps,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8A95AF),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  duration,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4C7BF4),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// ==========================================
// 4. WARM-UP ACTIVITIES LIST SCREEN
// ==========================================

class WarmupListScreen extends StatelessWidget {
  const WarmupListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final activities = [
      {
        'title': 'Dumbbell Bicep Curl\nStrengthen Arms',
        'sub': '7×7',
        'time': '45s',
        'image':
        'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?auto=format&fit=crop&w=250&q=80',
      },
      {
        'title': 'High Knees:\nDynamic Warm-Up',
        'sub': '5×5',
        'time': '35s',
        'image':
        'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&w=250&q=80',
      },
      {
        'title': 'Rock Barbell\nSemi-Squat Exercise',
        'sub': '5×5',
        'time': '60s',
        'image':
        'https://images.unsplash.com/photo-1574680096145-d05b474e2155?auto=format&fit=crop&w=250&q=80',
      },
      {
        'title': 'Overhead Barbell\nLift Exercise',
        'sub': '5×5',
        'time': '30s',
        'image':
        'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?auto=format&fit=crop&w=250&q=80',
      },
    ];

    final canPop = Navigator.canPop(context);

    return Scaffold(
      backgroundColor: const Color(0xFFEFF2FB),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (canPop)
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Row(
                        children: const [
                          Icon(Icons.chevron_left, size: 24, color: Color(0xFF141E34)),
                          Text(
                            'Back',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF141E34),
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    const Text(
                      'Amaze Valley',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF141E34),
                      ),
                    ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        SmoothPageRoute(page: const WarmupIntroScreen()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF537FF5), Color(0xFFB566F5)],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF537FF5).withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: const Text(
                        'Start Workout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              const Text(
                'Basic Warm-up\nActivities',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF141E34),
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: activities.length,
                itemBuilder: (context, index) {
                  final act = activities[index];
                  return _buildActivityRow(context, act);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityRow(BuildContext context, Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          SmoothPageRoute(page: const WarmupIntroScreen()),
        );
      },
      child: GlassmorphicContainer(
        borderRadius: 24,
        opacity: 0.65,
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox(
                width: 78,
                height: 78,
                child: buildNetworkImage(item['image'] as String),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'] as String,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF141E34),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['sub'] as String,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF8692AE),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['time'] as String,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF6B67F2),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE2E7F3)),
              ),
              child: const Icon(
                Icons.arrow_outward,
                size: 16,
                color: Color(0xFF6A7796),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 5. PROGRAM DETAIL SCREEN
// ==========================================

class ProgramDetailScreen extends StatelessWidget {
  final ProgramItem? program;

  const ProgramDetailScreen({super.key, this.program});

  @override
  Widget build(BuildContext context) {
    final active = program ?? demoPrograms[0];

    return Scaffold(
      backgroundColor: const Color(0xFFEFF2FB),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      children: const [
                        Icon(Icons.chevron_left, size: 24),
                        Text(
                          'Back',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.ios_share, size: 20),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GlassmorphicContainer(
                      width: double.infinity,
                      height: 320,
                      borderRadius: 32,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: buildNetworkImage(active.imageUrl),
                          ),
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.45),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      active.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF141E34),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      active.level,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF8692AE),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      active.description,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.5,
                        color: Color(0xFF6B7897),
                      ),
                    ),
                    const SizedBox(height: 24),
                    GlassmorphicContainer(
                      borderRadius: 20,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _ProgramMetric(label: 'Duration', val: active.duration),
                          _ProgramMetric(label: 'Per Week', val: active.setsReps),
                          _ProgramMetric(label: 'Coach', val: active.coach),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          SmoothPageRoute(page: const WarmupIntroScreen()),
                        );
                      },
                      child: Container(
                        height: 56,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          gradient: LinearGradient(
                            colors: [
                              active.gradientColors.first,
                              active.gradientColors.last,
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: active.gradientColors.last.withOpacity(0.35),
                              blurRadius: 18,
                              offset: const Offset(0, 8),
                            )
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Join Program',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgramMetric extends StatelessWidget {
  final String label;
  final String val;

  const _ProgramMetric({required this.label, required this.val});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Color(0xFF8692AE)),
        ),
        const SizedBox(height: 4),
        Text(
          val,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Color(0xFF141E34),
          ),
        ),
      ],
    );
  }
}

// ==========================================
// 6. ANALYTICS SCREEN
// ==========================================

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  int _selectedFilter = 1;

  @override
  Widget build(BuildContext context) {
    final filters = ['All', 'Monthly', 'Yearly', 'Weekly'];

    return Scaffold(
      backgroundColor: const Color(0xFFEFF2FB),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      children: const [
                        Icon(Icons.chevron_left, size: 24),
                        Text(
                          'Back',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'amazevalley@gmail.com',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4C7BF4),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(filters.length, (index) {
                  final isSel = _selectedFilter == index;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFilter = index),
                    child: GlassmorphicContainer(
                      borderRadius: 20,
                      opacity: isSel ? 0.9 : 0.5,
                      gradient: isSel
                          ? const LinearGradient(
                        colors: [Color(0xFF2C3550), Color(0xFF1B2338)],
                      )
                          : null,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      child: Text(
                        filters[index],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isSel ? Colors.white : const Color(0xFF6B7A99),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),
              _buildBarChartCard(),
              const SizedBox(height: 20),
              _buildLineChartCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBarChartCard() {
    return GlassmorphicContainer(
      borderRadius: 28,
      opacity: 0.7,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Total Volume',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF8692AE),
                ),
              ),
              Icon(Icons.unfold_more, size: 18, color: Color(0xFF8692AE)),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            '432 lbs',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xFF141E34),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _barItem('Sat', 0.25, false),
                _barItem('Sun', 0.40, false),
                _barItem('Mon', 0.30, false),
                _barItem('Tue', 0.55, false),
                _barItem('Wed', 0.85, true, labelBadge: '432'),
                _barItem('Thu', 0.60, false),
                _barItem('Fri', 0.35, false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _barItem(String day, double heightFraction, bool isHighlighted,
      {String? labelBadge}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (labelBadge != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            margin: const EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF2B3A5E),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              labelBadge,
              style: const TextStyle(color: Colors.white, fontSize: 9),
            ),
          ),
        Container(
          width: 26,
          height: 110 * heightFraction,
          decoration: BoxDecoration(
            color: isHighlighted
                ? const Color(0xFF4C7BF4)
                : const Color(0xFFEEF2FD),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          day,
          style: TextStyle(
            fontSize: 11,
            color: isHighlighted
                ? const Color(0xFF4C7BF4)
                : const Color(0xFF8692AE),
            fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildLineChartCard() {
    return GlassmorphicContainer(
      borderRadius: 28,
      opacity: 0.7,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Total Workout',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF8692AE),
                ),
              ),
              Icon(Icons.unfold_more, size: 18, color: Color(0xFF8692AE)),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            '26/37',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xFF141E34),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 120,
            width: double.infinity,
            child: CustomPaint(painter: AnalyticTrendPainter()),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri']
                .map(
                  (d) => Text(
                d,
                style: const TextStyle(
                  fontSize: 11,
                  color: Color(0xFF8692AE),
                ),
              ),
            )
                .toList(),
          )
        ],
      ),
    );
  }
}

// ==========================================
// 7. WARM-UP INTRO SCREEN
// ==========================================

class WarmupIntroScreen extends StatelessWidget {
  const WarmupIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF2FB),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      children: const [
                        Icon(Icons.chevron_left, size: 24),
                        Text(
                          'Back',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GlassmorphicContainer(
                    borderRadius: 16,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    child: const Text(
                      '37+ Workout',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF5A6682),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GlassmorphicContainer(
                      width: double.infinity,
                      height: 380,
                      borderRadius: 36,
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: buildNetworkImage(
                              'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&w=1000&q=80',
                            ),
                          ),
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    const Color(0xFF547DF2).withOpacity(0.55),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Get Set, Ready for',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF7582A0),
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Warm-Up',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF141E34),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        SizedBox(
                          width: 68,
                          height: 28,
                          child: Stack(
                            children: List.generate(3, (i) {
                              return Positioned(
                                left: i * 18.0,
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                    color: [
                                      Colors.orange,
                                      Colors.teal,
                                      Colors.purple,
                                    ][i],
                                  ),
                                  child: Center(
                                    child: Text(
                                      ['A', 'V', 'K'][i],
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          '4.8k+',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF141E34),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          SmoothPageRoute(page: const WorkoutActiveScreen()),
                        );
                      },
                      child: Container(
                        height: 56,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF5584F6), Color(0xFFA566F5)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF7085F6).withOpacity(0.35),
                              blurRadius: 18,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'Start Workout',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 8. ACTIVE WORKOUT HUD SCREEN
// ==========================================

class WorkoutActiveScreen extends StatelessWidget {
  const WorkoutActiveScreen({super.key});

  void _showActivationSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.55),
      builder: (BuildContext dialogContext) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Center(
            child: GlassmorphicContainer(
              width: 320,
              borderRadius: 28,
              opacity: 0.8,
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF537FF5), Color(0xFF00C48C)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00C48C).withOpacity(0.35),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Success!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF141E34),
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Plan activated successfully!\nYour workout streak is now live.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.4,
                      color: Color(0xFF6B7897),
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 22),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(dialogContext).pop();
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: Container(
                      height: 48,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4C7BF4), Color(0xFF6B67F2)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF4C7BF4).withOpacity(0.35),
                            blurRadius: 14,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'OK',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFBAD6FA),
      body: Stack(
        children: [
          Positioned.fill(
            child: buildNetworkImage(
              'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?auto=format&fit=crop&w=1000&q=80',
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF17203A).withOpacity(0.35),
                    const Color(0xFF10192D).withOpacity(0.85),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(
                            Icons.chevron_left,
                            size: 28,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          'Amaze Valley Training',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                        ),
                        const Icon(
                          Icons.pause_circle_outline,
                          size: 26,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Dumbbell Bicep\nCurl Arms',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              '48%',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            const Text(
                              'Complete',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              width: 70,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.white30,
                                borderRadius: BorderRadius.circular(2),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 35,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF4C7BF4),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: SafeArea(
              top: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GlassmorphicContainer(
                    borderRadius: 32,
                    blur: 24,
                    opacity: 0.75,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 18,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Duration',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF7D8AA5),
                              ),
                            ),
                            Text(
                              '01:00',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF15223D),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CustomPaint(
                                size: const Size(80, 80),
                                painter: DashedArcPainter(),
                              ),
                              const Text(
                                '0:27',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF141E34),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
                            Text(
                              'Session',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFF7D8AA5),
                              ),
                            ),
                            Text(
                              '06/37+',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF15223D),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => _showActivationSuccessDialog(context),
                    child: GlassmorphicContainer(
                      width: double.infinity,
                      height: 52,
                      borderRadius: 26,
                      blur: 20,
                      opacity: 0.35,
                      gradient: LinearGradient(
                        colors: [
                          const Color(0xFF537FF5).withOpacity(0.9),
                          const Color(0xFFB566F5).withOpacity(0.85),
                        ],
                      ),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.6),
                        width: 1.5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.check_circle_outline_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Activate Plan',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// RADIAL ARC & TREND PAINTERS
// ==========================================

class DashedArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(4, 4, size.width - 8, size.height - 8);
    const totalTicks = 28;
    const sweepAngle = math.pi * 1.5;
    const startAngle = math.pi * 0.75;

    for (int i = 0; i < totalTicks; i++) {
      final angle = startAngle + (sweepAngle / totalTicks) * i;
      final isFilled = i < 18;

      final paint = Paint()
        ..color = isFilled ? const Color(0xFF4C7BF4) : const Color(0xFFD6DEEF)
        ..strokeWidth = 2.8
        ..strokeCap = StrokeCap.round;

      final p1 = Offset(
        size.width / 2 + (rect.width / 2) * math.cos(angle),
        size.height / 2 + (rect.height / 2) * math.sin(angle),
      );
      final p2 = Offset(
        size.width / 2 + (rect.width / 2 - 8) * math.cos(angle),
        size.height / 2 + (rect.height / 2 - 8) * math.sin(angle),
      );

      canvas.drawLine(p1, p2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class AnalyticTrendPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0xFFBDD4FC)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()
      ..color = const Color(0xFF4C7BF4)
      ..style = PaintingStyle.fill;

    final path = Path();
    final points = [
      Offset(0, size.height * 0.7),
      Offset(size.width * 0.16, size.height * 0.65),
      Offset(size.width * 0.33, size.height * 0.78),
      Offset(size.width * 0.50, size.height * 0.55),
      Offset(size.width * 0.66, size.height * 0.60),
      Offset(size.width * 0.83, size.height * 0.40),
      Offset(size.width, size.height * 0.50),
    ];

    path.moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }

    canvas.drawPath(path, linePaint);

    for (var pt in points) {
      canvas.drawCircle(pt, 4, dotPaint);
      canvas.drawCircle(
        pt,
        2,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill,
      );
    }

    final peak = points[5];
    final rect = Rect.fromCenter(
      center: Offset(peak.dx, peak.dy - 16),
      width: 58,
      height: 18,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(6)),
      Paint()..color = const Color(0xFFF3F5FA),
    );

    final textSpan = const TextSpan(
      text: '26 workout',
      style: TextStyle(
        color: Color(0xFF697695),
        fontSize: 8,
        fontWeight: FontWeight.w600,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(rect.left + 5, rect.top + 3),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}