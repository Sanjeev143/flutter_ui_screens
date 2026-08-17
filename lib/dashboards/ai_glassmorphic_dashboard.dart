import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() {
  runApp(const PolicyPlatformApp());
}

class PolicyPlatformApp extends StatelessWidget {
  const PolicyPlatformApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Control AI - Policy Platform',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF071418),
        fontFamily: 'sans-serif',
      ),
      home: const PolicyDashboardScreen(),
    );
  }
}

class SubEntity {
  final String title;
  final String code;
  final String status;
  final Color color;

  const SubEntity({
    required this.title,
    required this.code,
    required this.status,
    required this.color,
  });
}

class PolicyDashboardScreen extends StatefulWidget {
  const PolicyDashboardScreen({super.key});

  @override
  State<PolicyDashboardScreen> createState() => _PolicyDashboardScreenState();
}

class _PolicyDashboardScreenState extends State<PolicyDashboardScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _branchAnimationController;
  late AnimationController _detailsSlideController;

  int? _selectedBranchIndex = 2;
  int? _selectedSubEntityIndex = 0;
  bool _showDetailsPanel = true;

  final List<Map<String, dynamic>> _branchCategories = [
    {'title': 'Services', 'count': '18', 'icon': Icons.account_balance_outlined},
    {'title': 'Entities', 'count': '3', 'icon': Icons.business_outlined},
    {'title': 'Related Federal Laws', 'count': '24', 'icon': Icons.gavel_outlined},
    {'title': 'KPIs', 'count': '32', 'icon': Icons.show_chart_rounded},
    {'title': 'Related Federal Laws', 'count': '12', 'icon': Icons.shield_outlined},
  ];

  final List<SubEntity> _subEntities = const [
    SubEntity(title: 'Bank of New York...', code: '(GAPS 25) • 960', status: 'ACTIVE', color: Color(0xFF10B981)),
    SubEntity(title: 'Federal Law No...', code: '(GAPS 12) • 42', status: 'REVIEW', color: Color(0xFFF59E0B)),
    SubEntity(title: 'Bank of New York...', code: '(GAPS 25) • 960', status: 'ACTIVE', color: Color(0xFF10B981)),
    SubEntity(title: 'Emirates Origin...', code: '(GAPS 12) • 28', status: 'ACTIVE', color: Color(0xFF10B981)),
    SubEntity(title: 'Bank of New York...', code: '(GAPS 14) • 820', status: 'ACTIVE', color: Color(0xFF10B981)),
    SubEntity(title: 'Capital One Emi...', code: '(GAPS 08) • 120', status: 'MODERATE', color: Color(0xFF38BDF8)),
    SubEntity(title: 'Bank of New York...', code: '(GAPS 25) • 960', status: 'ACTIVE', color: Color(0xFF10B981)),
    SubEntity(title: 'East West Emir...', code: '(GAPS 12) • 54', status: 'ACTIVE', color: Color(0xFF10B981)),
    SubEntity(title: 'Emirates Origin...', code: '(GAPS 12) • 28', status: 'ACTIVE', color: Color(0xFF10B981)),
    SubEntity(title: 'Capital One Emi...', code: '(GAPS 08) • 120', status: 'MODERATE', color: Color(0xFF38BDF8)),
    SubEntity(title: 'Bank of New York...', code: '(GAPS 25) • 960', status: 'ACTIVE', color: Color(0xFF10B981)),
    SubEntity(title: 'East West Emir...', code: '(GAPS 12) • 54', status: 'ACTIVE', color: Color(0xFF10B981)),
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _branchAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();

    _detailsSlideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 450),
    )..forward();
  }

  void _onSelectBranch(int index) {
    setState(() {
      _selectedBranchIndex = index;
      _selectedSubEntityIndex = null;
    });
    _branchAnimationController.forward(from: 0.0);
  }

  void _onSelectSubEntity(int index) {
    setState(() {
      _selectedSubEntityIndex = index;
      _showDetailsPanel = true;
    });
    _detailsSlideController.forward(from: 0.0);
  }

  void _closeDetailsPanel() async {
    await _detailsSlideController.reverse();
    if (mounted) {
      setState(() {
        _showDetailsPanel = false;
        _selectedSubEntityIndex = null;
      });
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _branchAnimationController.dispose();
    _detailsSlideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient Nebula
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(-0.4, 0.0),
                  radius: 1.3,
                  colors: [
                    Color(0xFF0F3238),
                    Color(0xFF081C22),
                    Color(0xFF040A0D),
                  ],
                ),
              ),
            ),
          ),

          // Bezier Curves Canvas
          AnimatedBuilder(
            animation: Listenable.merge([_branchAnimationController, _pulseController]),
            builder: (context, _) {
              return CustomPaint(
                size: Size(size.width, size.height),
                painter: NodeLinkBezierPainter(
                  size: size,
                  selectedBranchIndex: _selectedBranchIndex,
                  selectedSubEntityIndex: _selectedSubEntityIndex,
                  branchCount: _branchCategories.length,
                  subEntityCount: _subEntities.length,
                  animationProgress: _branchAnimationController.value,
                  pulseValue: _pulseController.value,
                ),
              );
            },
          ),

          // Interactive Nodes Stage
          Positioned.fill(
            child: Row(
              children: [
                SizedBox(
                  width: size.width * 0.28,
                  child: Center(child: _buildCentralLawOrb()),
                ),
                SizedBox(
                  width: 220,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_branchCategories.length, (index) {
                      final item = _branchCategories[index];
                      final isSelected = _selectedBranchIndex == index;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: _buildBranchCard(
                          title: item['title'],
                          count: item['count'],
                          icon: item['icon'],
                          isSelected: isSelected,
                          onTap: () => _onSelectBranch(index),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(width: 80),
                if (_selectedBranchIndex != null)
                  Expanded(
                    child: FadeTransition(
                      opacity: _branchAnimationController,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(vertical: 60),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(_subEntities.length, (index) {
                              final entity = _subEntities[index];
                              final isSelected = _selectedSubEntityIndex == index;
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: _buildSubEntityChip(
                                  entity: entity,
                                  isSelected: isSelected,
                                  onTap: () => _onSelectSubEntity(index),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Top App Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildTopBar(),
          ),

          // Sliding & Fading AI Details Panel
          if (_showDetailsPanel)
            Positioned(
              top: 70,
              right: 20,
              bottom: 20,
              width: 440,
              child: FadeTransition(
                opacity: CurvedAnimation(
                  parent: _detailsSlideController,
                  curve: Curves.easeInOut,
                ),
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.3, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _detailsSlideController,
                      curve: Curves.easeOutCubic,
                      reverseCurve: Curves.easeInCubic,
                    ),
                  ),
                  child: _buildAiDetailsPanel(),
                ),
              ),
            ),

          // Bottom AI Query Bar
          Positioned(
            bottom: 24,
            left: size.width * 0.32,
            child: _buildBottomAiQueryBar(),
          ),
        ],
      ),
    );
  }

  // --- (Central Law Orb, Branch Card, SubEntity Chip & AI Details Panel widgets continue unchanged with close handler) ---
  Widget _buildAiDetailsPanel() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF0D2329).withOpacity(0.85),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 30,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.favorite_border, color: Color(0xFF00F0FF), size: 16),
                const SizedBox(width: 6),
                const Text("Healthcare", style: TextStyle(fontSize: 12, color: Color(0xFF00F0FF), fontWeight: FontWeight.bold)),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close, size: 18, color: Colors.white60),
                  onPressed: _closeDetailsPanel,
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              "Federal Decree-Law No. (42) of 2022\nPromulgating the Civil Procedure Code",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white, height: 1.3),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text("Active", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF10B981))),
                ),
                const SizedBox(width: 10),
                const Text("Last updated: 01 Oct 2024", style: TextStyle(fontSize: 11, color: Colors.white38)),
                const Spacer(),
                const Text("Explore details >", style: TextStyle(fontSize: 11, color: Color(0xFF00F0FF), fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.04),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Sentiment Rate", style: TextStyle(fontSize: 12, color: Colors.white70)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF59E0B).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text("Moderate", style: TextStyle(fontSize: 10, color: Color(0xFFF59E0B), fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text("45%", style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: Colors.white)),
                      SizedBox(width: 8),
                      Text("▲ +4% vs last month", style: TextStyle(fontSize: 11, color: Color(0xFF10B981), fontWeight: FontWeight.w600)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildMetricTile("11", "Public Complaints\n& Recommendations")),
                const SizedBox(width: 10),
                Expanded(child: _buildMetricTile("2", "Related\nRegulations")),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: _buildMetricTile("18", "Services")),
                const SizedBox(width: 10),
                Expanded(child: _buildMetricTile("12", "Entities Involved")),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF00F0FF).withOpacity(0.06),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFF00F0FF).withOpacity(0.25)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    children: [
                      Icon(Icons.auto_awesome, size: 14, color: Color(0xFF00F0FF)),
                      SizedBox(width: 6),
                      Text("RI Analysis", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF00F0FF))),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text("Propose De-regulation", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white)),
                  SizedBox(height: 4),
                  Text(
                    "Multiple regulations were found to be out of date in the following domains.",
                    style: TextStyle(fontSize: 11.5, color: Colors.white60, height: 1.4),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMetricTile(String value, String label) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 11, color: Colors.white54, height: 1.3)),
        ],
      ),
    );
  }

  Widget _buildCentralLawOrb() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "Federal Decree-Law\nNo. 45 of 2021",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.5, color: Colors.white),
        ),
        const SizedBox(height: 24),
        AnimatedBuilder(
          animation: _pulseController,
          builder: (context, child) {
            final scale = 1.0 + (_pulseController.value * 0.08);
            return Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 140 * scale,
                  height: 140 * scale,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF8B5CF6).withOpacity(0.4),
                        const Color(0xFF06B6D4).withOpacity(0.1),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const RadialGradient(
                      center: Alignment(-0.3, -0.3),
                      colors: [Color(0xFFC084FC), Color(0xFF7C3AED), Color(0xFF3B0764)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF8B5CF6).withOpacity(0.6),
                        blurRadius: 28,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text("GAPS  ", style: TextStyle(fontSize: 11, color: Colors.white60, fontWeight: FontWeight.bold)),
              Text("12", style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBranchCard({
    required String title,
    required String count,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 210,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF12343C).withOpacity(0.95) : const Color(0xFF0B1F24).withOpacity(0.65),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFF00F0FF) : Colors.white.withOpacity(0.08),
            width: isSelected ? 1.8 : 1.0,
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: const Color(0xFF00F0FF).withOpacity(0.25),
              blurRadius: 18,
              spreadRadius: 1,
            )
          ]
              : [],
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: isSelected ? const Color(0xFF00F0FF) : Colors.white60),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(count, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: isSelected ? Colors.white : Colors.white70)),
                  Text(title, style: TextStyle(fontSize: 11, color: isSelected ? const Color(0xFF00F0FF) : Colors.white38, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubEntityChip({
    required SubEntity entity,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E3A42).withOpacity(0.9) : const Color(0xFF0D2329).withOpacity(0.6),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isSelected ? const Color(0xFF00F0FF) : Colors.white.withOpacity(0.06)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(entity.title, style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: Colors.white)),
            const SizedBox(width: 8),
            Text(entity.code, style: const TextStyle(fontSize: 10, color: Colors.white38)),
            const SizedBox(width: 8),
            Container(width: 7, height: 7, decoration: BoxDecoration(color: entity.color, shape: BoxShape.circle))
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF071418).withOpacity(0.8),
        border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.08))),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(color: Color(0xFF00F0FF), shape: BoxShape.circle),
            child: const Icon(Icons.grain, color: Colors.black, size: 16),
          ),
          const SizedBox(width: 10),
          const Text("Control AI  |  Policy Platform - Amazevalley", style:
          TextStyle(fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 0.5)),
          const Spacer(),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add, size: 16),
            label: const Text("New Simulation", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF12343C),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
          ),
          const SizedBox(width: 12),
          const Icon(Icons.search, size: 20, color: Colors.white70),
          const SizedBox(width: 12),
          const CircleAvatar(radius: 14, backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=33')),
        ],
      ),
    );
  }

  Widget _buildBottomAiQueryBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF0A2026),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFF00F0FF).withOpacity(0.4)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00F0FF).withOpacity(0.15),
            blurRadius: 20,
          )
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.auto_awesome, size: 16, color: Color(0xFF00F0FF)),
          const SizedBox(width: 10),
          const Text("Ask a question...", style: TextStyle(fontSize: 13, color: Colors.white60)),
          const SizedBox(width: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text("My agent  +3", style: TextStyle(fontSize: 11, color: Colors.white70)),
          ),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00F0FF),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            ),
            icon: const Icon(Icons.bolt, size: 14),
            label: const Text("RI Analysis", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}

// ===========================================================================
// CUSTOM PAINTER: Smooth Cubic Bezier Curves connecting Nodes to Branches
// ===========================================================================
class NodeLinkBezierPainter extends CustomPainter {
  final Size size;
  final int? selectedBranchIndex;
  final int? selectedSubEntityIndex;
  final int branchCount;
  final int subEntityCount;
  final double animationProgress;
  final double pulseValue;

  NodeLinkBezierPainter({
    required this.size,
    required this.selectedBranchIndex,
    required this.selectedSubEntityIndex,
    required this.branchCount,
    required this.subEntityCount,
    required this.animationProgress,
    required this.pulseValue,
  });

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final orbCenter = Offset(size.width * 0.14, size.height * 0.5);
    final middleBranchLeft = size.width * 0.28;
    final middleBranchRight = middleBranchLeft + 220;

    final branchSpacing = 68.0;
    final branchStartY = (size.height / 2) - ((branchCount * branchSpacing) / 2) + 24;

    // 1. Draw Links from Orb to Middle Branches
    for (int i = 0; i < branchCount; i++) {
      final targetY = branchStartY + (i * branchSpacing);
      final branchTarget = Offset(middleBranchLeft, targetY);

      final isSelected = selectedBranchIndex == i;
      final path = Path();
      path.moveTo(orbCenter.dx + 44, orbCenter.dy);

      // Smooth horizontal S-curve
      final control1 = Offset(orbCenter.dx + 120, orbCenter.dy);
      final control2 = Offset(middleBranchLeft - 60, targetY);
      path.cubicTo(control1.dx, control1.dy, control2.dx, control2.dy, branchTarget.dx, branchTarget.dy);

      final linkPaint = Paint()
        ..color = isSelected
            ? const Color(0xFF00F0FF).withOpacity(0.8)
            : const Color(0xFF00F0FF).withOpacity(0.18)
        ..strokeWidth = isSelected ? 2.2 : 1.0
        ..style = PaintingStyle.stroke;

      canvas.drawPath(path, linkPaint);

      // Glowing Node Pulse on Selected Branch
      if (isSelected) {
        final nodePaint = Paint()..color = const Color(0xFF00F0FF);
        canvas.drawCircle(branchTarget, 3.5, nodePaint);
      }
    }

    // 2. Draw Fanning Links from Selected Branch to Sub-Entities
    if (selectedBranchIndex != null) {
      final selectedBranchY = branchStartY + (selectedBranchIndex! * branchSpacing);
      final startPoint = Offset(middleBranchRight, selectedBranchY);

      final subEntityLeft = middleBranchRight + 80;
      final subEntitySpacing = 36.0;
      final subEntityStartY = (size.height / 2) - ((subEntityCount * subEntitySpacing) / 2) + 20;

      for (int j = 0; j < subEntityCount; j++) {
        final targetSubY = subEntityStartY + (j * subEntitySpacing);
        final endPoint = Offset(subEntityLeft, targetSubY);

        final isSubSelected = selectedSubEntityIndex == j;

        final fanPath = Path();
        fanPath.moveTo(startPoint.dx, startPoint.dy);

        final c1 = Offset(startPoint.dx + (subEntityLeft - startPoint.dx) * 0.5, startPoint.dy);
        final c2 = Offset(startPoint.dx + (subEntityLeft - startPoint.dx) * 0.5, targetSubY);
        fanPath.cubicTo(c1.dx, c1.dy, c2.dx, c2.dy, endPoint.dx, endPoint.dy);

        final fanPaint = Paint()
          ..color = isSubSelected
              ? const Color(0xFF00F0FF).withOpacity(animationProgress * 0.9)
              : const Color(0xFF00F0FF).withOpacity(animationProgress * 0.25)
          ..strokeWidth = isSubSelected ? 2.0 : 1.0
          ..style = PaintingStyle.stroke;

        canvas.drawPath(fanPath, fanPaint);

        // Animated Traveling Particle along the line
        final particleProgress = (pulseValue + (j * 0.1)) % 1.0;
        final particlePoint = _calculateCubicBezierPoint(startPoint, c1, c2, endPoint, particleProgress);
        final particlePaint = Paint()
          ..color = const Color(0xFF00F0FF).withOpacity(animationProgress * 0.85);
        canvas.drawCircle(particlePoint, isSubSelected ? 3.0 : 1.8, particlePaint);
      }
    }
  }

  Offset _calculateCubicBezierPoint(Offset p0, Offset p1, Offset p2, Offset p3, double t) {
    final u = 1 - t;
    final tt = t * t;
    final uu = u * u;
    final uuu = uu * u;
    final ttt = tt * t;

    double x = uuu * p0.dx + 3 * uu * t * p1.dx + 3 * u * tt * p2.dx + ttt * p3.dx;
    double y = uuu * p0.dy + 3 * uu * t * p1.dy + 3 * u * tt * p2.dy + ttt * p3.dy;
    return Offset(x, y);
  }

  @override
  bool shouldRepaint(covariant NodeLinkBezierPainter oldDelegate) => true;
}