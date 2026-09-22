import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';

void main() {
  runApp(const MusicApp());
}

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NeonVibe Music Player',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF09090C),
        primaryColor: const Color(0xFF1DB954),
        colorScheme: const ColorScheme.dark(
          surface: Color(0xFF121216),
          primary: Color(0xFF1DB954),
          secondary: Color(0xFF2A2A35),
        ),
        fontFamily: 'sans-serif',
      ),
      home: const MusicPlayerScreen(),
    );
  }
}

class SongModel {
  final String title;
  final String artist;
  final String albumArt;
  final int durationSeconds; // Total duration in seconds

  SongModel({
    required this.title,
    required this.artist,
    required this.albumArt,
    required this.durationSeconds,
  });

  String get formattedDuration {
    final minutes = durationSeconds ~/ 60;
    final seconds = durationSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> with SingleTickerProviderStateMixin {
  bool isPlaying = true;
  int currentPositionSeconds = 0; // Starts at 0
  Timer? _playbackTimer;

  late AnimationController _vinylController;

  final List<SongModel> playlist = [
    SongModel(
      title: 'Midnight Echoes',
      artist: 'Sufi Chill',
      albumArt: 'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?w=500&auto=format&fit=crop&q=60',
      durationSeconds: 225, // 3:45
    ),
    SongModel(
      title: 'Neon Horizon',
      artist: 'Amaze Valley & Co',
      albumArt: 'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=500&auto=format&fit=crop&q=60',
      durationSeconds: 252, // 4:12
    ),
    SongModel(
      title: 'Sands of Time',
      artist: 'Ambient Wave',
      albumArt: 'https://images.unsplash.com/photo-1470225620780-dba8ba36b745?w=500&auto=format&fit=crop&q=60',
      durationSeconds: 178, // 2:58
    ),
  ];

  int currentSongIndex = 0;

  @override
  void initState() {
    super.initState();
    _vinylController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();

    _startPlaybackTimer();
  }

  void _startPlaybackTimer() {
    _playbackTimer?.cancel();
    _playbackTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isPlaying) {
        setState(() {
          final currentSong = playlist[currentSongIndex];
          if (currentPositionSeconds < currentSong.durationSeconds) {
            currentPositionSeconds++;
          } else {
            // Auto play next song when current track ends
            _nextSong();
          }
        });
      }
    });
  }

  void _nextSong() {
    setState(() {
      currentSongIndex = (currentSongIndex + 1) % playlist.length;
      currentPositionSeconds = 0; // Reset progress to 0 for new song
    });
  }

  void _prevSong() {
    setState(() {
      currentSongIndex = (currentSongIndex - 1) < 0 ? playlist.length - 1 : currentSongIndex - 1;
      currentPositionSeconds = 0; // Reset progress to 0 for previous song
    });
  }

  @override
  void dispose() {
    _playbackTimer?.cancel();
    _vinylController.dispose();
    super.dispose();
  }

  String _formatTime(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final currentSong = playlist[currentSongIndex];

    return Scaffold(
      body: Stack(
        children: [
          // Background Glowing Ambient Gradients (Dribbble Dark Glass Vibe)
          Positioned(
            top: -120,
            left: -80,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF6200EE).withOpacity(0.18),
              ),
            ),
          ),
          Positioned(
            bottom: -60,
            right: -60,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF03DAC6).withOpacity(0.12),
              ),
            ),
          ),

          // Main Scaffold Layout
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  // Custom App Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.06),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white.withOpacity(0.1)),
                        ),
                        child: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white, size: 22),
                      ),
                      Column(
                        children: [
                          Text(
                            'PLAYING FROM PLAYLIST',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.4),
                              fontSize: 10,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Late Night Vibes',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.06),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white.withOpacity(0.1)),
                        ),
                        child: const Icon(Icons.more_horiz_rounded, color: Colors.white, size: 20),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // Rotating Vinyl / Album Art Display
                  Center(
                    child: SizedBox(
                      width: 270,
                      height: 270,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Outer glowing ring
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF6200EE).withOpacity(0.3),
                                  blurRadius: 40,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                          ),
                          // Rotating Vinyl Disc Effect
                          RotationTransition(
                            turns: _vinylController,
                            child: Container(
                              width: 260,
                              height: 260,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFF141418),
                                border: Border.all(color: Colors.white.withOpacity(0.08), width: 8),
                                image: DecorationImage(
                                  image: NetworkImage(currentSong.albumArt),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.6),
                                    ],
                                    stops: const [0.4, 1.0],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Center vinyl spindle hole
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF09090C),
                              border: Border.all(color: Colors.white.withOpacity(0.2), width: 3),
                            ),
                            child: const Center(
                              child: CircleAvatar(
                                radius: 6,
                                backgroundColor: Color(0xFF03DAC6),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 36),

                  // Song Title & Artist Info + Favorite Icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              currentSong.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.5,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              currentSong.artist,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.06),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.favorite_rounded,
                          color: Color(0xFF03DAC6),
                          size: 22,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Dynamic Progress Bar Starting at 0 and Incrementing Every Second
                  Column(
                    children: [
                      SliderTheme(
                        data: SliderThemeData(
                          trackHeight: 4,
                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6),
                          activeTrackColor: const Color(0xFF03DAC6),
                          inactiveTrackColor: Colors.white.withOpacity(0.15),
                          thumbColor: Colors.white,
                          overlayColor: const Color(0xFF03DAC6).withOpacity(0.2),
                        ),
                        child: Slider(
                          value: currentPositionSeconds.toDouble(),
                          min: 0.0,
                          max: currentSong.durationSeconds.toDouble(),
                          onChanged: (value) {
                            setState(() {
                              currentPositionSeconds = value.toInt();
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _formatTime(currentPositionSeconds),
                              style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12),
                            ),
                            Text(
                              currentSong.formattedDuration,
                              style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Playback Controls (Shuffle, Prev, Play/Pause, Next, Loop)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.shuffle_rounded, color: Colors.white.withOpacity(0.4), size: 22),
                      ),
                      IconButton(
                        onPressed: _prevSong,
                        icon: const Icon(Icons.skip_previous_rounded, color: Colors.white, size: 36),
                      ),
                      // Glowing Play/Pause Button
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isPlaying = !isPlaying;
                            if (isPlaying) {
                              _vinylController.repeat();
                            } else {
                              _vinylController.stop();
                            }
                          });
                        },
                        child: Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [Color(0xFF03DAC6), Color(0xFF6200EE)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF03DAC6).withOpacity(0.4),
                                blurRadius: 20,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: Icon(
                            isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 38,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: _nextSong,
                        icon: const Icon(Icons.skip_next_rounded, color: Colors.white, size: 36),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.repeat_rounded, color: Colors.white.withOpacity(0.4), size: 22),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Bottom Glassmorphic Up-Next Queue Card
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF181820).withOpacity(0.75),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.white.withOpacity(0.08)),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                playlist[(currentSongIndex + 1) % playlist.length].albumArt,
                                width: 42,
                                height: 42,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'UP NEXT',
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.4),
                                      fontSize: 9,
                                      letterSpacing: 1.2,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    playlist[(currentSongIndex + 1) % playlist.length].title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.playlist_play_rounded,
                              color: Color(0xFF03DAC6),
                              size: 26,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}