import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const SoundWaveApp());
}

class SoundWaveApp extends StatelessWidget {
  const SoundWaveApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SoundWave Glassmorphism',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F0826),
      ),
      home: const MainNavigationWrapper(),
    );
  }
}

// =========================================================================
// MAIN NAVIGATION WRAPPER WITH FLOATING GLASS NAVBAR
// =========================================================================
class MainNavigationWrapper extends StatefulWidget {
  const MainNavigationWrapper({super.key});

  @override
  State<MainNavigationWrapper> createState() => _MainNavigationWrapperState();
}

class _MainNavigationWrapperState extends State<MainNavigationWrapper> {
  int _currentIndex = 0;

  final List<Widget> _screens = [];

  @override
  void initState() {
    super.initState();
    _screens.addAll([
      HomeScreen(onSongTap: _openNowPlaying), //1
      ExploreScreen(onSongTap: _openNowPlaying), //2
      LibraryScreen(onSongTap: _openNowPlaying), //3
      SearchScreen(onSongTap: _openNowPlaying),//4
      const PlaceholderScreen(title: 'Profile'),//5
    ]);
  }

  void _openNowPlaying() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
        const NowPlayingScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic)),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Dynamic Background with Moving Mesh Orbs
          // const DynamicSpaceBackground(),
          const SoftPastelBackground(),

          // Active Screen
          IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),

          // Floating Glassmorphic Bottom Navigation Bar
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: CustomGlassBottomNavBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

// =========================================================================
// 1. HOME SCREEN (GLASSMORPHISM ENHANCED)
// =========================================================================
class HomeScreen extends StatelessWidget {
  final VoidCallback onSongTap;

  const HomeScreen({super.key, required this.onSongTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Glass App Header Bar
            Row(
              children: [
                _buildGlassIconButton(Icons.grid_view_rounded),
                const SizedBox(width: 12),
                const Icon(Icons.waves, color: Color(0xFFE879F9), size: 28),
                const SizedBox(width: 8),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Amazevalley',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    Text('Feel the music, live the moment.',
                        style: TextStyle(color: Colors.white54, fontSize: 10)),
                  ],
                ),
                const Spacer(),
                _buildGlassIconButton(Icons.notifications_outlined, badge: true),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFE879F9), width: 1.5),
                  ),
                  child: const CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=33'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Hero Glass Banner
            GlassContainer(
              height: 170,
              padding: const EdgeInsets.all(20),
              borderRadius: 28,
              blurSigma: 24.0,
              gradientColors: [
                const Color(0xFFC084FC).withOpacity(0.35),
                const Color(0xFF3B82F6).withOpacity(0.15),
              ],
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Good Vibes Only',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                height: 1.1)),
                        const SizedBox(height: 8),
                        Text('Curated playlist for\nyour best moments.',
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 11)),
                        const SizedBox(height: 6),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.9),
                            foregroundColor: const Color(0xFF5B21B6),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 8),
                          ),
                          onPressed: onSongTap,
                          icon: const Icon(Icons.play_arrow_rounded, size: 18),
                          label: const Text('Play Now',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12)),
                        )
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1508700115892-45ecd05ae2ad?w=300&auto=format&fit=crop&q=80',
                      width: 120,
                      height: 130,
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 24),

            _buildSectionHeader('Recently Played'),
            const SizedBox(height: 12),
            SizedBox(
              height: 140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildPlaylistCard('Chill Mix', '20 Songs',
                      'https://images.unsplash.com/photo-1518609878373-06d740f60d8b?w=300'),
                  _buildPlaylistCard('Lo-Fi Beats', '15 Songs',
                      'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=300'),
                  _buildPlaylistCard('Top Hits', '30 Songs',
                      'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=300'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            _buildSectionHeader('Recommended for you'),
            const SizedBox(height: 12),
            _buildSongListTile('Sunset Drive', 'Arijit Singh',
                'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=300', onSongTap),
            _buildSongListTile('Night Changes', 'One Direction',
                'https://images.unsplash.com/photo-1493225457124-a3eb161ffa5f?w=300', onSongTap),
            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        const Text('See all',
            style: TextStyle(color: Colors.white54, fontSize: 12)),
      ],
    );
  }

  Widget _buildPlaylistCard(String title, String count, String imgUrl) {
    return Container(
      width: 110,
      margin: const EdgeInsets.only(right: 12),
      child: GlassContainer(
        borderRadius: 20,
        padding: const EdgeInsets.all(8),
        blurSigma: 18.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(imgUrl, fit: BoxFit.cover, width: double.infinity),
              ),
            ),
            const SizedBox(height: 6),
            Text(title,
                maxLines: 1,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12)),
            Text(count,
                style: const TextStyle(color: Colors.white54, fontSize: 10)),
          ],
        ),
      ),
    );
  }

  Widget _buildSongListTile(
      String title, String artist, String imgUrl, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: GlassContainer(
        borderRadius: 18,
        padding: const EdgeInsets.all(10),
        blurSigma: 16.0,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(imgUrl, width: 46, height: 46, fit: BoxFit.cover),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                  Text(artist,
                      style: const TextStyle(color: Colors.white54, fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.favorite_border, color: Colors.white54, size: 20),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: onTap,
              child: GlassContainer(
                borderRadius: 20,
                padding: const EdgeInsets.all(8),
                child: const Icon(Icons.play_arrow_rounded,
                    color: Colors.white, size: 18),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// =========================================================================
// 2. NOW PLAYING SCREEN (GLASSMORPHISM ENHANCED)
// =========================================================================
class NowPlayingScreen extends StatelessWidget {
  const NowPlayingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const DynamicSpaceBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildGlassIconButton(Icons.keyboard_arrow_down_rounded,
                          onTap: () => Navigator.of(context).pop()),
                      const Text('Now Playing',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      _buildGlassIconButton(Icons.more_vert_rounded),
                    ],
                  ),
                  const Spacer(),

                  // Album Art Glass Card
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                            20,
                                (index) => Container(
                              width: 3,
                              height: (index % 5 + 1) * 25.0,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE879F9).withOpacity(0.4),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )),
                      ),
                      GlassContainer(
                        height: 280,
                        width: 280,
                        borderRadius: 32,
                        padding: const EdgeInsets.all(12),
                        blurSigma: 24.0,
                        gradientColors: [
                          const Color(0xFFE879F9).withOpacity(0.35),
                          const Color(0xFF3B82F6).withOpacity(0.15),
                        ],
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: Image.network(
                                'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500',
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 12,
                              right: 12,
                              child: _buildGlassIconButton(Icons.favorite_border),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Dreams Tonight',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(height: 4),
                          Text('Arijit Singh',
                              style: TextStyle(
                                  color: Colors.white54, fontSize: 14)),
                        ],
                      ),
                      GlassContainer(
                        borderRadius: 8,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        child: const Text('HD',
                            style: TextStyle(
                                color: Color(0xFFE879F9),
                                fontSize: 10,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),

                  SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 3,
                      thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 6),
                      activeTrackColor: const Color(0xFFE879F9),
                      inactiveTrackColor: Colors.white24,
                      thumbColor: Colors.white,
                    ),
                    child: Slider(
                      value: 0.45,
                      onChanged: (v) {},
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('1:42',
                            style:
                            TextStyle(color: Colors.white54, fontSize: 11)),
                        Text('3:56',
                            style:
                            TextStyle(color: Colors.white54, fontSize: 11)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(Icons.shuffle_rounded,
                          color: Colors.white54, size: 22),
                      const Icon(Icons.skip_previous_rounded,
                          color: Colors.white, size: 32),
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(colors: [
                            Color(0xFFE879F9),
                            Color(0xFFA855F7),
                          ]),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFE879F9).withOpacity(0.4),
                              blurRadius: 20,
                              spreadRadius: 2,
                            )
                          ],
                        ),
                        child: const Icon(Icons.pause_rounded,
                            color: Colors.white, size: 32),
                      ),
                      const Icon(Icons.skip_next_rounded,
                          color: Colors.white, size: 32),
                      const Icon(Icons.repeat_rounded,
                          color: Colors.white54, size: 22),
                    ],
                  ),
                  const SizedBox(height: 24),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.share_outlined,
                          color: Colors.white54, size: 20),
                      Icon(Icons.favorite, color: Colors.pinkAccent, size: 20),
                      Icon(Icons.download_outlined,
                          color: Colors.white54, size: 20),
                      Icon(Icons.queue_music_rounded,
                          color: Colors.white54, size: 20),
                    ],
                  ),
                  const Spacer(),

                  GlassContainer(
                    borderRadius: 20,
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                              'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=100',
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover),
                        ),
                        const SizedBox(width: 12),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Up Next: Maan Meri Jaan',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12)),
                            Text('King',
                                style: TextStyle(
                                    color: Colors.white54, fontSize: 10)),
                          ],
                        ),
                        const Spacer(),
                        const Icon(Icons.equalizer,
                            color: Color(0xFFE879F9), size: 20),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// =========================================================================
// 3. EXPLORE SCREEN (GLASSMORPHISM ENHANCED)
// =========================================================================
class ExploreScreen extends StatelessWidget {
  final VoidCallback onSongTap;

  const ExploreScreen({super.key, required this.onSongTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Explore',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold)),
                    Text('Discover new music everyday',
                        style: TextStyle(color: Colors.white54, fontSize: 12)),
                  ],
                ),
                _buildGlassIconButton(Icons.search),
              ],
            ),
            const SizedBox(height: 20),

            SizedBox(
              height: 70,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildGenreChip('Pop', Icons.music_note, isSelected: true),
                  _buildGenreChip('Lo-Fi', Icons.album_outlined),
                  _buildGenreChip('Rock', Icons.graphic_eq),
                  _buildGenreChip('Hip Hop', Icons.podcasts),
                  _buildGenreChip('Classical', Icons.piano),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Trending Now',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                const Text('See all',
                    style: TextStyle(color: Colors.white54, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 12),
            _buildTrendingRow('Blinding Lights', 'The Weeknd',
                'https://images.unsplash.com/photo-1501386761578-eac5c94b800a?w=300', onSongTap),
            _buildTrendingRow('Peaches', 'Justin Bieber',
                'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=300', onSongTap),
            _buildTrendingRow('Kesariya', 'Arijit Singh',
                'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=300', onSongTap),
            const SizedBox(height: 24),

            const Text('Made for you',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                    child: _buildCategoryCard(
                        'Workout\nBeats',
                        '25 Songs',
                        'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=300',
                        onSongTap)),
                const SizedBox(width: 10),
                Expanded(
                    child: _buildCategoryCard(
                        'Focus\nMode',
                        '30 Songs',
                        'https://images.unsplash.com/photo-1518609878373-06d740f60d8b?w=300',
                        onSongTap)),
                const SizedBox(width: 10),
                Expanded(
                    child: _buildCategoryCard(
                        'Sleep\nSounds',
                        '18 Songs',
                        'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=300',
                        onSongTap)),
              ],
            ),
            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }

  Widget _buildGenreChip(String label, IconData icon, {bool isSelected = false}) {
    return Container(
      width: 65,
      margin: const EdgeInsets.only(right: 10),
      child: GlassContainer(
        borderRadius: 18,
        padding: const EdgeInsets.symmetric(vertical: 8),
        blurSigma: 18.0,
        gradientColors: isSelected
            ? [const Color(0xFFE879F9).withOpacity(0.5), const Color(0xFF9333EA).withOpacity(0.3)]
            : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(height: 4),
            Text(label,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendingRow(
      String title, String artist, String imgUrl, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: GlassContainer(
        borderRadius: 18,
        padding: const EdgeInsets.all(10),
        blurSigma: 16.0,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(imgUrl, width: 44, height: 44, fit: BoxFit.cover),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)),
                  Text(artist,
                      style: const TextStyle(color: Colors.white54, fontSize: 11)),
                ],
              ),
            ),
            const Icon(Icons.equalizer, color: Color(0xFFE879F9), size: 18),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: onTap,
              child: GlassContainer(
                borderRadius: 20,
                padding: const EdgeInsets.all(6),
                child: const Icon(Icons.play_arrow_rounded,
                    color: Colors.white, size: 20),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
      String title, String count, String imgUrl, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        height: 150,
        borderRadius: 20,
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(imgUrl,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              left: 8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                          height: 1.1)),
                  const SizedBox(height: 2),
                  Text(count,
                      style: const TextStyle(
                          color: Colors.white54, fontSize: 9)),
                ],
              ),
            ),
            const Positioned(
              bottom: 8,
              right: 8,
              child: CircleAvatar(
                radius: 10,
                backgroundColor: Colors.white24,
                child: Icon(Icons.play_arrow_rounded,
                    color: Colors.white, size: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title,
          style: const TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
    );
  }
}

// =========================================================================
// REUSABLE GLASSMORPHIC CORE BUILDERS
// =========================================================================

/// Ambient Animated Background with Vibrant Glowing Orbs
class DynamicSpaceBackground extends StatelessWidget {
  const DynamicSpaceBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0C0721),
      child: Stack(
        children: [
          // Top-Right Magenta/Pink Orb
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0xFFE879F9), Colors.transparent],
                ),
              ),
            ),
          ),
          // Center-Left Deep Violet Orb
          Positioned(
            top: 250,
            left: -80,
            child: Container(
              width: 320,
              height: 320,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0xFFA855F7), Colors.transparent],
                ),
              ),
            ),
          ),
          // Bottom-Right Cyan/Blue Orb
          Positioned(
            bottom: -50,
            right: -50,
            child: Container(
              width: 280,
              height: 280,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0xFF3B82F6), Colors.transparent],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Frosted Glassmorphism Container with Dynamic Blur & Specular Borders
class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final List<Color>? gradientColors;
  final double blurSigma;

  const GlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius = 20,
    this.padding = EdgeInsets.zero,
    this.gradientColors,
    this.blurSigma = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: Colors.white.withOpacity(0.22),
              width: 1.2,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradientColors ??
                  [
                    Colors.white.withOpacity(0.15),
                    Colors.white.withOpacity(0.03),
                  ],
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

Widget _buildGlassIconButton(IconData icon,
    {VoidCallback? onTap, bool badge = false}) {
  return GestureDetector(
    onTap: onTap,
    child: Stack(
      children: [
        GlassContainer(
          borderRadius: 20,
          padding: const EdgeInsets.all(10),
          blurSigma: 16.0,
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        if (badge)
          Positioned(
            right: 10,
            top: 10,
            child: Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                  color: Color(0xFFE879F9), shape: BoxShape.circle),
            ),
          )
      ],
    ),
  );
}

/// Floating Glassmorphic Bottom Navigation Bar
class CustomGlassBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomGlassBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      borderRadius: 30,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      blurSigma: 24.0,
      gradientColors: [
        Colors.white.withOpacity(0.18),
        Colors.white.withOpacity(0.06),
      ],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, Icons.home_rounded, 'Home'),
          _buildNavItem(1, Icons.explore_rounded, 'Explore'),
          _buildNavItem(2, Icons.my_library_music_rounded, 'Library'),
          _buildNavItem(3, Icons.search_rounded, 'Search'),
          _buildNavItem(4, Icons.person_rounded, 'Profile'),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final bool isSelected = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFE879F9).withOpacity(0.35)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 1.0,
          )
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon,
                color: isSelected ? Colors.white : Colors.white54, size: 20),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white54,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'dart:ui';
// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(const LibraryApp());
// }

class LibraryScreen extends StatefulWidget {
  final VoidCallback onSongTap;

  const LibraryScreen({super.key, required this.onSongTap});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  int _selectedCategoryIndex = 0;
  int _currentNavIndex = 2; // Default to "Library"

  final List<String> _categories = ['Playlists', 'Songs', 'Albums', 'Artists'];

  final List<Map<String, String>> _playlists = [
    {
      'title': 'Favorites',
      'count': '128 Songs',
      'image': 'https://images.unsplash.com/photo-1518609878373-06d740f60d8b?w=300',
    },
    {
      'title': 'Workout Hits',
      'count': '56 Songs',
      'image': 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=300',
    },
    {
      'title': 'Chill Vibes',
      'count': '80 Songs',
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=300',
    },
    {
      'title': 'Road Trip',
      'count': '42 Songs',
      'image': 'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=300',
    },
    {
      'title': 'Happy Mood',
      'count': '75 Songs',
      'image': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=300',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Soft Pastel Lavender Ambient Background
          const SoftPastelBackground(),

          // 2. Main Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  // Top App Bar
                  _buildHeader(),
                  const SizedBox(height: 20),

                  // Filter Categories Bar
                  _buildCategoryBar(),
                  const SizedBox(height: 20),

                  // Scrollable Content
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          // "Create New Playlist" Action Card
                          _buildCreatePlaylistCard(),
                          const SizedBox(height: 16),

                          // Playlist Items
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _playlists.length,
                            itemBuilder: (context, index) {
                              final item = _playlists[index];
                              return _buildPlaylistItem(
                                title: item['title']!,
                                count: item['count']!,
                                imageUrl: item['image']!,
                              );
                            },
                          ),
                          const SizedBox(height: 90), // Spacing for floating nav
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 3. Floating Bottom Navigation Bar
          // Positioned(
          //   left: 20,
          //   right: 20,
          //   bottom: 20,
          //   child: CustomGlassBottomNav(
          //     currentIndex: _currentNavIndex,
          //     onTap: (index) {
          //       setState(() {
          //         _currentNavIndex = index;
          //       });
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }

  // Header Title + Search & Add Icons
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'My Library',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),
        Row(
          children: [
            _buildGlassIconButton(Icons.search_rounded),
            const SizedBox(width: 12),
            _buildGlassIconButton(Icons.add_rounded),
          ],
        )
      ],
    );
  }

  // Category Selector Pills
  Widget _buildCategoryBar() {
    return GlassContainer(
      borderRadius: 24,
      padding: const EdgeInsets.all(4),
      child: Row(
        children: List.generate(_categories.length, (index) {
          final isSelected = _selectedCategoryIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCategoryIndex = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: isSelected
                      ? const Color(0xFF8B73E6).withOpacity(0.7)
                      : Colors.transparent,
                  boxShadow: isSelected
                      ? [
                    BoxShadow(
                      color: const Color(0xFF8B73E6).withOpacity(0.3),
                      blurRadius: 10,
                      spreadRadius: 1,
                    )
                  ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    _categories[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                      fontWeight:
                      isSelected ? FontWeight.bold : FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // Create New Playlist Card
  Widget _buildCreatePlaylistCard() {
    return GlassContainer(
      borderRadius: 20,
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.add_rounded, color: Colors.white, size: 26),
          ),
          const SizedBox(width: 16),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create New Playlist',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Build your own collection',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 12,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // Playlist Tile Item
  Widget _buildPlaylistItem({
    required String title,
    required String count,
    required String imageUrl,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: GlassContainer(
        borderRadius: 20,
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                imageUrl,
                width: 54,
                height: 54,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 14),

            // Title & Track Count
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    count,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            // Action Buttons (Play & More)
            _buildGlassPlayButton(),
            const SizedBox(width: 8),
            const Icon(Icons.more_horiz_rounded, color: Colors.white60, size: 22),
            const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }

  // Play Button
  Widget _buildGlassPlayButton() {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: const Color(0xFF9E86EC).withOpacity(0.5),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.0),
      ),
      child: const Icon(
        Icons.play_arrow_rounded,
        color: Colors.white,
        size: 22,
      ),
    );
  }

  // Glass Top Icon Button
  Widget _buildGlassIconButton(IconData icon) {
    return GlassContainer(
      borderRadius: 16,
      padding: const EdgeInsets.all(10),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }
}

class SearchScreen extends StatefulWidget {
  final VoidCallback onSongTap;

  const SearchScreen({super.key, required this.onSongTap});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<Map<String, String>> _playlists = [
    {
      'title': 'Favorites',
      'count': '128 Songs',
      'image': 'https://images.unsplash.com/photo-1518609878373-06d740f60d8b?w=300',
    },
    {
      'title': 'Workout Hits',
      'count': '56 Songs',
      'image': 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=300',
    },
    {
      'title': 'Chill Vibes',
      'count': '80 Songs',
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=300',
    },
    {
      'title': 'Road Trip',
      'count': '42 Songs',
      'image': 'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=300',
    },
    {
      'title': 'Happy Mood',
      'count': '75 Songs',
      'image': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=300',
    },
    {
      'title': 'Favorites',
      'count': '128 Songs',
      'image': 'https://images.unsplash.com/photo-1518609878373-06d740f60d8b?w=300',
    },
    {
      'title': 'Workout Hits',
      'count': '56 Songs',
      'image': 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=300',
    },
    {
      'title': 'Chill Vibes',
      'count': '80 Songs',
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=300',
    },
    {
      'title': 'Road Trip',
      'count': '42 Songs',
      'image': 'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=300',
    },
    {
      'title': 'Happy Mood',
      'count': '75 Songs',
      'image': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=300',
    },
    {
      'title': 'Favorites',
      'count': '128 Songs',
      'image': 'https://images.unsplash.com/photo-1518609878373-06d740f60d8b?w=300',
    },
    {
      'title': 'Workout Hits',
      'count': '56 Songs',
      'image': 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=300',
    },
    {
      'title': 'Chill Vibes',
      'count': '80 Songs',
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=300',
    },
    {
      'title': 'Road Trip',
      'count': '42 Songs',
      'image': 'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=300',
    },
    {
      'title': 'Happy Mood',
      'count': '75 Songs',
      'image': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=300',
    },
    {
      'title': 'Favorites',
      'count': '128 Songs',
      'image': 'https://images.unsplash.com/photo-1518609878373-06d740f60d8b?w=300',
    },
    {
      'title': 'Workout Hits',
      'count': '56 Songs',
      'image': 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=300',
    },
    {
      'title': 'Chill Vibes',
      'count': '80 Songs',
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=300',
    },
    {
      'title': 'Road Trip',
      'count': '42 Songs',
      'image': 'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=300',
    },
    {
      'title': 'Happy Mood',
      'count': '75 Songs',
      'image': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=300',
    },
    {
      'title': 'Favorites',
      'count': '128 Songs',
      'image': 'https://images.unsplash.com/photo-1518609878373-06d740f60d8b?w=300',
    },
    {
      'title': 'Workout Hits',
      'count': '56 Songs',
      'image': 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=300',
    },
    {
      'title': 'Chill Vibes',
      'count': '80 Songs',
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=300',
    },
    {
      'title': 'Road Trip',
      'count': '42 Songs',
      'image': 'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=300',
    },
    {
      'title': 'Happy Mood',
      'count': '75 Songs',
      'image': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=300',
    },
    {
      'title': 'Favorites',
      'count': '128 Songs',
      'image': 'https://images.unsplash.com/photo-1518609878373-06d740f60d8b?w=300',
    },
    {
      'title': 'Workout Hits',
      'count': '56 Songs',
      'image': 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=300',
    },
    {
      'title': 'Chill Vibes',
      'count': '80 Songs',
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=300',
    },
    {
      'title': 'Road Trip',
      'count': '42 Songs',
      'image': 'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=300',
    },
    {
      'title': 'Happy Mood',
      'count': '75 Songs',
      'image': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=300',
    },
    {
      'title': 'Favorites',
      'count': '128 Songs',
      'image': 'https://images.unsplash.com/photo-1518609878373-06d740f60d8b?w=300',
    },
    {
      'title': 'Workout Hits',
      'count': '56 Songs',
      'image': 'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=300',
    },
    {
      'title': 'Chill Vibes',
      'count': '80 Songs',
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=300',
    },
    {
      'title': 'Road Trip',
      'count': '42 Songs',
      'image': 'https://images.unsplash.com/photo-1469854523086-cc02fe5d8800?w=300',
    },
    {
      'title': 'Happy Mood',
      'count': '75 Songs',
      'image': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=300',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Soft Pastel Lavender Ambient Background
          const SoftPastelBackground(),

          // 2. Main Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  // Top App Bar
                  _buildHeader(),
                  const SizedBox(height: 20),
                  // Scrollable Content
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          // "Create New Playlist" Action Card
                          // Playlist Items
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _playlists.length,
                            itemBuilder: (context, index) {
                              final item = _playlists[index];
                              return _buildPlaylistItem(
                                title: item['title']!,
                                count: item['count']!,
                                imageUrl: item['image']!,
                              );
                            },
                          ),
                          const SizedBox(height: 90), // Spacing for floating nav
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

  // Header Title + Search & Add Icons
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'My Library',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),
        Row(
          children: [
            _buildGlassIconButton(Icons.search_rounded),
            const SizedBox(width: 12),
            _buildGlassIconButton(Icons.add_rounded),
          ],
        )
      ],
    );
  }

  // Play Button
  Widget _buildGlassPlayButton() {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: const Color(0xFF9E86EC).withOpacity(0.5),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.0),
      ),
      child: const Icon(
        Icons.play_arrow_rounded,
        color: Colors.white,
        size: 22,
      ),
    );
  }

  // Playlist Tile Item
  Widget _buildPlaylistItem({
    required String title,
    required String count,
    required String imageUrl,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: GlassContainer(
        borderRadius: 20,
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                imageUrl,
                width: 54,
                height: 54,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 14),

            // Title & Track Count
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    count,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            // Action Buttons (Play & More)
            _buildGlassPlayButton(),
            const SizedBox(width: 8),
            const Icon(Icons.more_horiz_rounded, color: Colors.white60, size: 22),
            const SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}


// ==========================================
// REUSABLE GLASS CONTAINER & BACKGROUND
// ==========================================

class SoftPastelBackground extends StatelessWidget {
  const SoftPastelBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF9186E2), // Base Pastel Violet
      child: Stack(
        children: [
          // Top Left Bright Violet Glow
          Positioned(
            top: -40,
            left: -40,
            child: Container(
              width: 320,
              height: 320,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0xFFB1A7FF), Colors.transparent],
                ),
              ),
            ),
          ),
          // Center Right Soft Magenta Glow
          Positioned(
            top: 280,
            right: -60,
            child: Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0xFFC792EA), Colors.transparent],
                ),
              ),
            ),
          ),
          // Bottom Left Deep Purple
          Positioned(
            bottom: -60,
            left: -60,
            child: Container(
              width: 340,
              height: 340,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0xFF6B58C1), Colors.transparent],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Reusable Glassmorphism Container Widget
// class GlassContainer extends StatelessWidget {
//   final Widget child;
//   final double borderRadius;
//   final EdgeInsetsGeometry padding;
//
//   const GlassContainer({
//     super.key,
//     required this.child,
//     this.borderRadius = 20,
//     this.padding = EdgeInsets.zero,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(borderRadius),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0),
//         child: Container(
//           padding: padding,
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.15),
//             borderRadius: BorderRadius.circular(borderRadius),
//             border: Border.all(
//               color: Colors.white.withOpacity(0.25),
//               width: 1.0,
//             ),
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Colors.white.withOpacity(0.25),
//                 Colors.white.withOpacity(0.08),
//               ],
//             ),
//           ),
//           child: child,
//         ),
//       ),
//     );
//   }
// }
//
// // Custom Glass Bottom Navigation Bar
// class CustomGlassBottomNav extends StatelessWidget {
//   final int currentIndex;
//   final Function(int) onTap;
//
//   const CustomGlassBottomNav({
//     super.key,
//     required this.currentIndex,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GlassContainer(
//       borderRadius: 30,
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _buildNavItem(0, Icons.home_outlined, 'Home'),
//           _buildNavItem(1, Icons.search_rounded, 'Explore'),
//           _buildNavItem(2, Icons.music_note_rounded, 'Library'),
//           _buildNavItem(3, Icons.workspace_premium_outlined, 'Premium'),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildNavItem(int index, IconData icon, String label) {
//     final isSelected = currentIndex == index;
//     return GestureDetector(
//       onTap: () => onTap(index),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             if (isSelected)
//               Container(
//                 padding: const EdgeInsets.all(6),
//                 decoration: const BoxDecoration(
//                   color: Color(0xFF8B73E6),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Icon(icon, color: Colors.white, size: 20),
//               )
//             else
//               Icon(icon, color: Colors.white60, size: 22),
//             const SizedBox(height: 2),
//             Text(
//               label,
//               style: TextStyle(
//                 color: isSelected ? Colors.white : Colors.white60,
//                 fontSize: 11,
//                 fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


///Do like and subscribe...