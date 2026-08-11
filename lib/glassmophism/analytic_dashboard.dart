import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const ChannelAnalyticsApp());
}

class ChannelAnalyticsApp extends StatelessWidget {
  const ChannelAnalyticsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Channel Analytics',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1E1E24),
        colorScheme: const ColorScheme.dark(
          surface: Color(0xFF2A2A32),
          primary: Color(0xFFE28A3B),
        ),
      ),
      home: const AnalyticsDashboardScreen(),
    );
  }
}

class AnalyticsDashboardScreen extends StatelessWidget {
  const AnalyticsDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1D22),
      body: SafeArea(
        child: Container(
          color: const Color(0xFF18171B),
          padding: const EdgeInsets.all(12.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28.0),
            child: Container(
              color: const Color(0xFF25242A),
              child: const Row(
                children: [
                  // 1. Left Narrow Navigation Rail
                  SidebarRailWidget(),

                  // 2. Main Dashboard Content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TopAppBarWidget(),
                          SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 3, child: MainHeroBannerWidget()),
                              SizedBox(width: 20),
                              Expanded(flex: 2, child: RightSideStatsWidget()),
                            ],
                          ),
                          SizedBox(height: 24),
                          TopVideosSectionWidget(),
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
// 1. LEFT NAVIGATION RAIL
// ==========================================
class SidebarRailWidget extends StatelessWidget {
  const SidebarRailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      color: const Color(0xFF1C1B20),
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          // App Logo
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.grid_view_rounded, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 30),

          // Nav Icons Stack
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                _buildRailIcon(Icons.bar_chart_rounded, isSelected: true),
                _buildRailIcon(Icons.subtitles_outlined),
                _buildRailIcon(Icons.show_chart_rounded),
                _buildRailIcon(Icons.account_balance_wallet_outlined),
                _buildRailIcon(Icons.explore_outlined),
                _buildRailIcon(Icons.shopping_bag_outlined),
              ],
            ),
          ),

          const Spacer(),

          // Bottom Utility Icons
          Stack(
            children: [
              _buildRailIcon(Icons.notifications_none_rounded),
              Positioned(
                right: 12,
                top: 8,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Colors.orangeAccent,
                    shape: BoxShape.circle,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          _buildRailIcon(Icons.settings_outlined),
        ],
      ),
    );
  }

  Widget _buildRailIcon(IconData icon, {bool isSelected = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Icon(
        icon,
        color: isSelected ? Colors.white : Colors.white38,
        size: 20,
      ),
    );
  }
}

// ==========================================
// 2. TOP APP BAR
// ==========================================
class TopAppBarWidget extends StatelessWidget {
  const TopAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Channel Analytics',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        Row(
          children: [
            _buildGlassIconButton(Icons.mail_outline),
            const SizedBox(width: 12),
            _buildGlassIconButton(Icons.search),
            const SizedBox(width: 12),
            const CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=60'),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildGlassIconButton(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white70, size: 18),
    );
  }
}

// ==========================================
// 3. MAIN HERO BANNER WITH GLASSMORPHISM METRICS
// ==========================================
class MainHeroBannerWidget extends StatelessWidget {
  const MainHeroBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [Color(0xFF383332), Color(0xFFC76228)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Background Hero Image Placeholder / Cutout
          Positioned(
            right: 40,
            bottom: 0,
            top: 0,
            child: Image.network(
              'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80&w=600',
              fit: BoxFit.cover,
            ),
          ),

          // Main Callout Text
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Popular Solution',
                  style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Optimize\nYour Metrics',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                  ),
                  onPressed: () {},
                  child: const Text('Start Now', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),

          // Glassmorphic Floating Metrics Bar
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildMetricItem('76k', 'Users', Colors.blueAccent),
                      _buildMetricItem('1.5m', 'Clicks', Colors.pinkAccent),
                      _buildMetricItem('\$3,6k', 'Sales', Colors.greenAccent),
                      _buildMetricItem('47', 'Items', Colors.orangeAccent),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.chevron_right, color: Colors.white, size: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMetricItem(String value, String label, Color dotColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            Container(width: 6, height: 6, decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle)),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(color: Colors.white70, fontSize: 11)),
          ],
        )
      ],
    );
  }
}

// ==========================================
// 4. RIGHT SIDE STATS & SALES PANELS
// ==========================================
class RightSideStatsWidget extends StatelessWidget {
  const RightSideStatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Active Users Line Chart Card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.04),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Text('Active Users right now', style: TextStyle(color: Colors.white70, fontSize: 13)),
                  SizedBox(width: 6),
                  Text('💡', style: TextStyle(fontSize: 12)),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 120,
                width: double.infinity,
                child: CustomPaint(painter: DualLineChartPainter()),
              ),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Oct', style: TextStyle(color: Colors.white38, fontSize: 11)),
                  Text('Mar', style: TextStyle(color: Colors.white38, fontSize: 11)),
                  Text('Jul', style: TextStyle(color: Colors.white38, fontSize: 11)),
                  Text('Aug', style: TextStyle(color: Colors.white38, fontSize: 11)),
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Latest Sales & Backpack Card Row
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Latest Sales', style: TextStyle(color: Colors.white70, fontSize: 13)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.show_chart, color: Colors.greenAccent, size: 16),
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(10)),
                          child: const Text('^ 6%', style: TextStyle(color: Colors.white, fontSize: 10)),
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text('\$ 586', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 4),
                    const Text('Your total earnings', style: TextStyle(color: Colors.white38, fontSize: 11)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                height: 140,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.black26,
                        ),
                        child: const Center(
                          child: Icon(Icons.backpack_outlined, size: 50, color: Colors.white60),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text('Synthetics backpack', style: TextStyle(color: Colors.white54, fontSize: 10)),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

// Custom Painter for Dual Sparkline Curves
class DualLineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = Colors.lightGreenAccent
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final paint2 = Paint()
      ..color = Colors.amberAccent
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    final path1 = Path();
    path1.moveTo(0, size.height * 0.7);
    path1.quadraticBezierTo(size.width * 0.25, size.height * 0.2, size.width * 0.5, size.height * 0.6);
    path1.quadraticBezierTo(size.width * 0.75, size.height * 0.1, size.width, size.height * 0.7);

    final path2 = Path();
    path2.moveTo(0, size.height * 0.8);
    path2.quadraticBezierTo(size.width * 0.3, size.height * 0.5, size.width * 0.6, size.height * 0.7);
    path2.quadraticBezierTo(size.width * 0.85, size.height * 0.2, size.width, size.height * 0.6);

    canvas.drawPath(path1, paint1);
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ==========================================
// 5. TOP VIDEOS SECTION TABLE
// ==========================================
class TopVideosSectionWidget extends StatelessWidget {
  const TopVideosSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Your top videos in this period',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.06),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                children: [
                  Text('Popularity', style: TextStyle(color: Colors.white70, fontSize: 12)),
                  SizedBox(width: 6),
                  Icon(Icons.keyboard_arrow_down, color: Colors.white70, size: 16),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 16),

        // Header Labels
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(flex: 4, child: Text('Video', style: TextStyle(color: Colors.white38, fontSize: 12))),
              Expanded(flex: 2, child: Text('Views', style: TextStyle(color: Colors.white38, fontSize: 12))),
              Expanded(flex: 3, child: Text('Average view duration', style: TextStyle(color: Colors.white38, fontSize: 12))),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // Video Items
        _buildVideoRow(
          'Build An Amazing Back\nWorkout',
          '16.3k views',
          '13:21 ( 17.54% )',
          'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&q=80&w=300',
        ),
        const SizedBox(height: 10),
        _buildVideoRow(
          'How to Train the Muscles\nat Home',
          '16.3k views',
          '17:34 ( 38.54% )',
          'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?auto=format&fit=crop&q=80&w=300',
        ),
        const SizedBox(height: 10),
        _buildVideoRow(
          'Build An Amazing Back\nWorkout',
          '16.3k views',
          '13:21 ( 17.54% )',
          'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&q=80&w=300',
        ),
        const SizedBox(height: 10),
        _buildVideoRow(
          'How to Train the Muscles\nat Home',
          '16.3k views',
          '17:34 ( 38.54% )',
          'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?auto=format&fit=crop&q=80&w=300',
        ),
        const SizedBox(height: 10),
        _buildVideoRow(
          'Build An Amazing Back\nWorkout',
          '16.3k views',
          '13:21 ( 17.54% )',
          'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&q=80&w=300',
        ),
        const SizedBox(height: 10),
        _buildVideoRow(
          'How to Train the Muscles\nat Home',
          '16.3k views',
          '17:34 ( 38.54% )',
          'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?auto=format&fit=crop&q=80&w=300',
        ),
        const SizedBox(height: 10),
        _buildVideoRow(
          'Build An Amazing Back\nWorkout',
          '16.3k views',
          '13:21 ( 17.54% )',
          'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&q=80&w=300',
        ),
        const SizedBox(height: 10),
        _buildVideoRow(
          'How to Train the Muscles\nat Home',
          '16.3k views',
          '17:34 ( 38.54% )',
          'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?auto=format&fit=crop&q=80&w=300',
        ),
        const SizedBox(height: 10),
        _buildVideoRow(
          'Build An Amazing Back\nWorkout',
          '16.3k views',
          '13:21 ( 17.54% )',
          'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&q=80&w=300',
        ),
        const SizedBox(height: 10),
        _buildVideoRow(
          'How to Train the Muscles\nat Home',
          '16.3k views',
          '17:34 ( 38.54% )',
          'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?auto=format&fit=crop&q=80&w=300',
        ),
        const SizedBox(height: 10),
        _buildVideoRow(
          'Build An Amazing Back\nWorkout',
          '16.3k views',
          '13:21 ( 17.54% )',
          'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?auto=format&fit=crop&q=80&w=300',
        ),
        const SizedBox(height: 10),
        _buildVideoRow(
          'How to Train the Muscles\nat Home',
          '16.3k views',
          '17:34 ( 38.54% )',
          'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?auto=format&fit=crop&q=80&w=300',
        ),
      ],
    );
  }

  Widget _buildVideoRow(String title, String views, String duration, String imageUrl) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          // Video Thumbnail
          Expanded(
            flex: 4,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(imageUrl, width: 70, height: 48, fit: BoxFit.cover),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                    const Row(
                      children: [
                        Icon(Icons.play_circle_fill, color: Colors.white38, size: 12),
                        SizedBox(width: 4),
                        Text('Sport Series', style: TextStyle(color: Colors.white38, fontSize: 10)),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),

          // Views
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.amberAccent, shape: BoxShape.circle)),
                const SizedBox(width: 6),
                Text(views, style: const TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),

          // Duration
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.greenAccent, shape: BoxShape.circle)),
                const SizedBox(width: 6),
                Text(duration, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                const Spacer(),
                const Icon(Icons.stacked_line_chart, color: Colors.amberAccent, size: 18),
                const SizedBox(width: 12),
                const Icon(Icons.more_horiz, color: Colors.white38, size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }
}