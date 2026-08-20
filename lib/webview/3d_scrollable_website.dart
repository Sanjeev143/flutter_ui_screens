import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() {
  runApp(const AmazevalleyUniverseApp());
}

class AmazevalleyUniverseApp extends StatelessWidget {
  const AmazevalleyUniverseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazevalley - The Cosmic Valley',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF03050C),
        fontFamily: 'sans-serif',
      ),
      home: const UniverseContinuousScrollScreen(),
    );
  }
}

class UniverseContinuousScrollScreen extends StatefulWidget {
  const UniverseContinuousScrollScreen({super.key});

  @override
  State<UniverseContinuousScrollScreen> createState() =>
      _UniverseContinuousScrollScreenState();
}

class _UniverseContinuousScrollScreenState
    extends State<UniverseContinuousScrollScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _universeTimeController;
  late AnimationController _lightningController;

  double _scrollOffset = 0.0;
  String _activeTab = 'Home';
  bool _isAutoScrolling = false;
  final math.Random _random = math.Random();

  // Section Keys for Smooth Anchor Scrolling
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _universeKey = GlobalKey();
  final GlobalKey _constellationsKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();

  final List<String> _menuItems = [
    'Home',
    'Universe',
    'Constellations',
    'About Amazevalley',
  ];

  @override
  void initState() {
    super.initState();

    // 1. Continuous deep-space rotation & starfield drift
    _universeTimeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    // 2. Cosmic Lightning Flash Animation
    _lightningController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _triggerPeriodicLightning();

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    setState(() {
      _scrollOffset = _scrollController.offset;
      if (!_isAutoScrolling) {
        _updateActiveSectionOnScroll();
      }
    });
  }

  void _updateActiveSectionOnScroll() {
    if (!_scrollController.hasClients) return;

    // If reached bottom of page, activate the last section directly
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 60) {
      _activeTab = 'About Amazevalley';
      return;
    }

    double getOffsetY(GlobalKey key) {
      final context = key.currentContext;
      if (context == null) return double.infinity;
      final renderBox = context.findRenderObject() as RenderBox?;
      if (renderBox == null) return double.infinity;
      return renderBox.localToGlobal(Offset.zero).dy;
    }

    final aboutY = getOffsetY(_aboutKey);
    final constellationsY = getOffsetY(_constellationsKey);
    final universeY = getOffsetY(_universeKey);

    const threshold = 300.0;

    if (aboutY <= threshold) {
      _activeTab = 'About Amazevalley';
    } else if (constellationsY <= threshold) {
      _activeTab = 'Constellations';
    } else if (universeY <= threshold) {
      _activeTab = 'Universe';
    } else {
      _activeTab = 'Home';
    }
  }

  void _scrollToSection(String section) async {
    setState(() {
      _activeTab = section;
      _isAutoScrolling = true;
    });

    GlobalKey targetKey;
    switch (section) {
      case 'Home':
        targetKey = _homeKey;
        break;
      case 'Universe':
        targetKey = _universeKey;
        break;
      case 'Constellations':
        targetKey = _constellationsKey;
        break;
      case 'About Amazevalley':
        targetKey = _aboutKey;
        break;
      default:
        targetKey = _homeKey;
    }

    final context = targetKey.currentContext;
    if (context != null) {
      await Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
        alignment: 0.1, // Aligns near top accounting for navbar
      );
    }

    if (mounted) {
      setState(() {
        _isAutoScrolling = false;
      });
    }
  }

  void _triggerPeriodicLightning() async {
    while (mounted) {
      await Future.delayed(Duration(seconds: 3 + _random.nextInt(4)));
      if (mounted) {
        await _lightningController.forward(from: 0.0);
      }
    }
  }

  String _getActiveSection(double height) {
    if (_scrollOffset < height * 0.7) return 'Home';
    if (_scrollOffset < height * 1.8) return 'Universe';
    if (_scrollOffset < height * 2.8) return 'Constellations';
    return 'About Amazevalley';
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _universeTimeController.dispose();
    _lightningController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 850;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Background Gradient
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(0.0, -0.3),
                    radius: 1.5,
                    colors: [
                      Color(0xFF13092C),
                      Color(0xFF070B1E),
                      Color(0xFF020308),
                    ],
                  ),
                ),
              ),
            ),

            // 3D Starfield
            AnimatedBuilder(
              animation: _universeTimeController,
              builder: (context, _) {
                return CustomPaint(
                  size: Size(size.width, size.height),
                  painter: Starfield3DPainter(
                    time: _universeTimeController.value,
                    scrollOffset: _scrollOffset,
                  ),
                );
              },
            ),

            // Lightning Bolts
            AnimatedBuilder(
              animation: _lightningController,
              builder: (context, _) {
                if (_lightningController.value == 0.0 ||
                    _lightningController.value == 1.0) {
                  return const SizedBox.shrink();
                }
                return CustomPaint(
                  size: Size(size.width, size.height),
                  painter: CosmicLightningPainter(
                    progress: _lightningController.value,
                  ),
                );
              },
            ),

            // Single Continuous Scroll Body
            SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    key: _homeKey,
                    child: _buildHeroSection(size, isMobile),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    key: _universeKey,
                    child: _buildUniverseSection(size, isMobile),
                  ),
                  const SizedBox(height: 60),
                  Container(
                    key: _constellationsKey,
                    child: _buildConstellationsSection(isMobile),
                  ),
                  const SizedBox(height: 60),
                  Container(
                    key: _aboutKey,
                    child: _buildAboutSection(isMobile),
                  ),
                  _buildFooterSection(),
                ],
              ),
            ),

            // Fixed Top Navbar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _buildCosmicNavbar(isMobile, _activeTab),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // SECTION 1: HERO VIEW
  // -------------------------------------------------------------------------
  Widget _buildHeroSection(Size size, bool isMobile) {
    final double scrollFactor = (_scrollOffset * 0.002).clamp(-1.0, 1.0);

    return SizedBox(
      height: size.height,
      width: size.width,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: const Color(0xFF00F0FF).withOpacity(0.4),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00F0FF).withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.bolt, color: Color(0xFF00F0FF), size: 16),
                    SizedBox(width: 6),
                    Text(
                      "THE COSMIC REALM OF CREATION",
                      style: TextStyle(
                        fontSize: 12,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateX(-scrollFactor * 0.4),
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [
                      Colors.white,
                      Color(0xFF00F0FF),
                      Color(0xFFD946EF),
                      Color(0xFFFDE047),
                    ],
                  ).createShader(bounds),
                  child: Text(
                    "AMAZEVALLEY",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isMobile ? 44 : 84,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 6.0,
                      height: 1.1,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 650),
                child: Text(
                  "Where boundless imagination ignites the universe. Explore the limitless valley of technology, intelligence, and multidimensional experiences.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 15 : 18,
                    color: Colors.white.withOpacity(0.75),
                    height: 1.6,
                  ),
                ),
              ),
              const SizedBox(height: 36),
              ElevatedButton.icon(
                onPressed: () => _scrollToSection('Universe'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00F0FF),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 18,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 15,
                  shadowColor: const Color(0xFF00F0FF).withOpacity(0.6),
                ),
                icon: const Icon(Icons.rocket_launch_rounded, size: 20),
                label: const Text(
                  "ENTER THE VALLEY",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // SECTION 2: UNIVERSE DIMENSIONS
  // -------------------------------------------------------------------------
  Widget _buildUniverseSection(Size size, bool isMobile) {
    return Column(
      children: [
        Text(
          "THE UNIVERSE REALMS",
          style: TextStyle(
            fontSize: isMobile ? 26 : 38,
            fontWeight: FontWeight.w900,
            letterSpacing: 3.0,
            color: const Color(0xFF00F0FF),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Journey across multidimensional space matrices",
          style: TextStyle(color: Colors.white.withOpacity(0.7)),
        ),
        const SizedBox(height: 28),
        _build3DUniverseCard(
          index: 1,
          tag: "DIMENSION 01",
          title: "Quantum Core Matrix",
          description:
              "The neural heart of Amazevalley where compute clusters oscillate at terahertz frequencies, powering generative engines across the multiverse.",
          gradient: const [Color(0xFF00F0FF), Color(0xFF7000FF)],
          icon: Icons.hub_rounded,
          isMobile: isMobile,
        ),
        _build3DUniverseCard(
          index: 2,
          tag: "DIMENSION 02",
          title: "Plasma Nebula Stream",
          description:
              "High-energy plasma corridors facilitating instantaneous data routing and real-time interactive experiences without perceptual latency.",
          gradient: const [Color(0xFFFF007A), Color(0xFF7E22CE)],
          icon: Icons.flash_on_rounded,
          isMobile: isMobile,
        ),
        _build3DUniverseCard(
          index: 3,
          tag: "DIMENSION 03",
          title: "Event Horizon Zenith",
          description:
              "The edge of uncharted creative synthesis. Here, human ideas merge with autonomous agent intelligence to forge new realities.",
          gradient: const [Color(0xFF38BDF8), Color(0xFF3B82F6)],
          icon: Icons.all_inclusive_rounded,
          isMobile: isMobile,
        ),
      ],
    );
  }

  Widget _build3DUniverseCard({
    required int index,
    required String tag,
    required String title,
    required String description,
    required List<Color> gradient,
    required IconData icon,
    required bool isMobile,
  }) {
    final double targetOffset = index * 320.0;
    final double delta = (_scrollOffset - targetOffset) / 500.0;
    final double rotationY = (delta * 0.15).clamp(-0.25, 0.25);
    final double rotationX = (delta.abs() * 0.08).clamp(0.0, 0.2);

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: isMobile ? 16 : 80,
      ),
      constraints: const BoxConstraints(maxWidth: 850),
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.0012)
          ..rotateY(index.isEven ? -rotationY : rotationY)
          ..rotateX(rotationX),
        child: Container(
          padding: EdgeInsets.all(isMobile ? 22 : 36),
          decoration: BoxDecoration(
            color: const Color(0xFF0B1021).withOpacity(0.8),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: gradient.first.withOpacity(0.4),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: gradient.first.withOpacity(0.18),
                blurRadius: 35,
                spreadRadius: 2,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: gradient),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: isMobile ? 26 : 34,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tag,
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                        color: gradient.first,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: isMobile ? 22 : 28,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 15.5,
                        color: Colors.white.withOpacity(0.75),
                        height: 1.55,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------------------------------
  // SECTION 3: CONSTELLATIONS VIEW
  // -------------------------------------------------------------------------
  Widget _buildConstellationsSection(bool isMobile) {
    final constellations = [
      {
        'title': 'Orion Neural Engine',
        'badge': 'AI & SYNTHESIS',
        'desc':
            'Deep autonomous intelligence generating dynamic visual algorithms and adaptive soundscapes.',
        'color': const Color(0xFF00F0FF),
        'icon': Icons.psychology_rounded,
      },
      {
        'title': 'Cygnus Spatial Lattice',
        'badge': 'SPATIAL COMPUTE',
        'desc':
            '3D canvas projection architecture enabling multi-user holographic shared environments.',
        'color': const Color(0xFFD946EF),
        'icon': Icons.view_in_ar_rounded,
      },
      {
        'title': 'Vela Hyper-Stream',
        'badge': 'QUANTUM CLOUD',
        'desc':
            'Sub-millisecond global fabric delivering planetary compute synchronizations effortlessly.',
        'color': const Color(0xFF38BDF8),
        'icon': Icons.cloud_circle_rounded,
      },
      {
        'title': 'Phoenix Light Protocol',
        'badge': 'ZERO LATENCY',
        'desc':
            'Hardware-accelerated GLSL shader streams rendering 120 FPS visualizers simultaneously.',
        'color': const Color(0xFFF59E0B),
        'icon': Icons.bolt_rounded,
      },
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 64,
        vertical: 24,
      ),
      constraints: const BoxConstraints(maxWidth: 1100),
      child: Column(
        children: [
          Text(
            "THE CONSTELLATIONS",
            style: TextStyle(
              fontSize: isMobile ? 26 : 38,
              fontWeight: FontWeight.w900,
              letterSpacing: 3.0,
              color: const Color(0xFFD946EF),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Modular architecture nodes powering the Amazevalley ecosystem",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white.withOpacity(0.7)),
          ),
          const SizedBox(height: 36),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: constellations.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: isMobile ? 1.45 : 1.6,
            ),
            itemBuilder: (context, index) {
              final c = constellations[index];
              final color = c['color'] as Color;

              return Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF0B1021).withOpacity(0.75),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: color.withOpacity(0.35)),
                  boxShadow: [
                    BoxShadow(
                      color: color.withOpacity(0.12),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(c['icon'] as IconData, color: color, size: 28),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            c['badge'] as String,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      c['title'] as String,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      c['desc'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.7),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // SECTION 4: ABOUT AMAZEVALLEY VIEW
  // -------------------------------------------------------------------------
  Widget _buildAboutSection(bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 64,
        vertical: 24,
      ),
      constraints: const BoxConstraints(maxWidth: 850),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFF00F0FF), Color(0xFFD946EF)],
              ).createShader(bounds),
              child: Text(
                "ABOUT AMAZEVALLEY",
                style: TextStyle(
                  fontSize: isMobile ? 28 : 42,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.5,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 28),
          Container(
            padding: EdgeInsets.all(isMobile ? 22 : 36),
            decoration: BoxDecoration(
              color: const Color(0xFF0B1021).withOpacity(0.8),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.12)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "The Valley of Infinite Frontiers",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Amazevalley is envisioned as the cosmic cradle for tomorrow's technology pioneers. It is where advanced artificial intelligence, reactive shaders, and fluid spatial interfaces come together in harmony.",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white.withOpacity(0.8),
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 24),
                const Divider(color: Colors.white12),
                const SizedBox(height: 24),
                Row(
                  children: [
                    _buildMetric("99.99%", "Constellation Uptime"),
                    const SizedBox(width: 32),
                    _buildMetric("120 FPS", "Shader Precision"),
                    const SizedBox(width: 32),
                    _buildMetric("Infinite", "Valley Potential"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(String value, String label) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Color(0xFF00F0FF),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: Colors.white54),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // NAVBAR & FOOTER
  // -------------------------------------------------------------------------
  Widget _buildCosmicNavbar(bool isMobile, String activeSection) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF03050C).withOpacity(0.75),
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.08)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => _scrollToSection('Home'),
            borderRadius: BorderRadius.circular(12),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Color(0xFF00F0FF), Color(0xFFD946EF)],
                    ),
                  ),
                  child: const Icon(Icons.bolt, color: Colors.black, size: 20),
                ),
                const SizedBox(width: 10),
                const Text(
                  "Amazevalley",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          if (!isMobile)
            Row(
              children: _menuItems
                  .map((item) => _buildNavButton(item, activeSection == item))
                  .toList(),
            )
          else
            PopupMenuButton<String>(
              icon: const Icon(Icons.menu_rounded, color: Colors.white),
              color: const Color(0xFF0B1021),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.white.withOpacity(0.1)),
              ),
              onSelected: (item) => _scrollToSection(item),
              itemBuilder: (context) => _menuItems
                  .map(
                    (item) => PopupMenuItem(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(
                          color: activeSection == item
                              ? const Color(0xFF00F0FF)
                              : Colors.white,
                          fontWeight: activeSection == item
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildNavButton(String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: InkWell(
        onTap: () => _scrollToSection(label),
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF00F0FF).withOpacity(0.15)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF00F0FF).withOpacity(0.6)
                  : Colors.transparent,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? const Color(0xFF00F0FF) : Colors.white70,
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooterSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        children: [
          const Divider(color: Colors.white12),
          const SizedBox(height: 20),
          Text(
            "© 2026 Amazevalley. All Rights Reserved across Galaxies.",
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// CUSTOM PAINTER: 3D Animated Starfield & Nebula Dust
// ===========================================================================
class Starfield3DPainter extends CustomPainter {
  final double time;
  final double scrollOffset;

  Starfield3DPainter({required this.time, required this.scrollOffset});

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(42);
    const int totalStars = 200;

    for (int i = 0; i < totalStars; i++) {
      final double depth = (i % 3 + 1) * 0.5;
      final double baseX = (random.nextDouble() * size.width);
      final double baseY = (random.nextDouble() * size.height * 2.5);

      final double y =
          (baseY - (scrollOffset * depth * 0.4) + (time * 40 * depth)) %
          size.height;
      final double x =
          (baseX + math.sin(time * 2 * math.pi + i) * 4 * depth) % size.width;

      final double starSize = random.nextDouble() * 2.2 * depth + 0.5;
      final double alpha = (math.sin(time * 6.0 + i) * 0.35 + 0.65).clamp(
        0.1,
        1.0,
      );

      final paint = Paint()
        ..color =
            (i % 6 == 0
                    ? const Color(0xFF00F0FF)
                    : (i % 11 == 0 ? const Color(0xFFFF71D8) : Colors.white))
                .withOpacity(alpha);

      canvas.drawCircle(Offset(x, y), starSize, paint);
    }
  }

  @override
  bool shouldRepaint(covariant Starfield3DPainter oldDelegate) => true;
}

// ===========================================================================
// CUSTOM PAINTER: Celestial Forked Lightning Arc
// ===========================================================================
class CosmicLightningPainter extends CustomPainter {
  final double progress;

  CosmicLightningPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(1337);
    final double startX = size.width * 0.55;
    double currentX = startX;
    double currentY = 0;

    final path = Path();
    path.moveTo(currentX, currentY);

    while (currentY < size.height * 0.85) {
      currentY += random.nextDouble() * 35 + 15;
      currentX += (random.nextDouble() - 0.48) * 60;
      path.lineTo(currentX, currentY);
    }

    final double intensity = math.sin(progress * math.pi);

    final glowPaint = Paint()
      ..color = const Color(0xFF00F0FF).withOpacity(intensity * 0.45)
      ..strokeWidth = 14
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 22);

    canvas.drawPath(path, glowPaint);

    final midPaint = Paint()
      ..color = const Color(0xFFD946EF).withOpacity(intensity * 0.75)
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, midPaint);

    final corePaint = Paint()
      ..color = Colors.white.withOpacity(intensity)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, corePaint);
  }

  @override
  bool shouldRepaint(covariant CosmicLightningPainter oldDelegate) => true;
}
