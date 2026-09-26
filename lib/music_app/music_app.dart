import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amaze Music Player',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF09090C),
        primaryColor: const Color(0xFF03DAC6),
        colorScheme: const ColorScheme.dark(
          surface: Color(0xFF121216),
          primary: Color(0xFF03DAC6),
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
  final int durationSeconds;

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

class _MusicPlayerScreenState extends State<MusicPlayerScreen> with TickerProviderStateMixin {
  bool isPlaying = true;
  bool isMuted = false;
  double volumeLevel = 0.8;
  int currentPositionSeconds = 0;
  Timer? _playbackTimer;

  late AnimationController _vinylController;
  late AnimationController _equalizerController;

  final List<SongModel> playlist = [
    SongModel(
      title: 'Midnight Echoes',
      artist: 'Sufi Chill & Tabla Beats',
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
    SongModel(
      title: 'Celestial Harmony',
      artist: 'Harmonium & Piano Vibes',
      albumArt: 'https://images.unsplash.com/photo-1510915361894-db8b60106cb1?w=500&auto=format&fit=crop&q=60',
      durationSeconds: 310, // 5:10
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

    _equalizerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

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
            _nextSong();
          }
        });
      }
    });
  }

  void _nextSong() {
    setState(() {
      currentSongIndex = (currentSongIndex + 1) % playlist.length;
      currentPositionSeconds = 0;
    });
  }

  void _prevSong() {
    setState(() {
      currentSongIndex = (currentSongIndex - 1) < 0 ? playlist.length - 1 : currentSongIndex - 1;
      currentPositionSeconds = 0;
    });
  }

  @override
  void dispose() {
    _playbackTimer?.cancel();
    _vinylController.dispose();
    _equalizerController.dispose();
    super.dispose();
  }

  String _formatTime(int totalSeconds) {
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  // Bottom Sheet for Queue & Playlist Management
  void _showPlaylistBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF141418),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Container(
              padding: const EdgeInsets.all(24),
              height: 420,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Playback Queue',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close_rounded, color: Colors.white54),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: playlist.length,
                      itemBuilder: (context, index) {
                        final song = playlist[index];
                        final isSelected = index == currentSongIndex;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF03DAC6).withOpacity(0.15)
                                : Colors.white.withOpacity(0.03),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF03DAC6).withOpacity(0.5)
                                  : Colors.transparent,
                            ),
                          ),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(song.albumArt, width: 45, height: 45, fit: BoxFit.cover),
                            ),
                            title: Text(
                              song.title,
                              style: TextStyle(
                                color: isSelected ? const Color(0xFF03DAC6) : Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            subtitle: Text(
                              song.artist,
                              style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12),
                            ),
                            trailing: Text(
                              song.formattedDuration,
                              style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12),
                            ),
                            onTap: () {
                              setState(() {
                                currentSongIndex = index;
                                currentPositionSeconds = 0;
                              });
                              setModalState(() {});
                              Navigator.pop(context);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Volume Adjustment Dialog
  void _showVolumeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0.0),
          backgroundColor: const Color(0xFF181820),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Volume Control', style: TextStyle(color: Colors.white, fontSize: 16)),

              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.close, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
            ],),
          content: StatefulBuilder(
            builder: (context, setDialogState) {
              return SizedBox(
                height: 100.0,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        volumeLevel == 0 ? Icons.volume_off : Icons.volume_up,
                        color: const Color(0xFF03DAC6),
                      ),
                      onPressed: () {
                        setDialogState(() {
                          volumeLevel = volumeLevel == 0 ? 0.8 : 0;
                        });
                        setState(() {});
                      },
                    ),
                    Expanded(
                      child: Slider(
                        value: volumeLevel,
                        min: 0.0,
                        max: 1.0,
                        activeColor: const Color(0xFF03DAC6),
                        inactiveColor: Colors.white24,
                        onChanged: (val) {
                          setDialogState(() {
                            volumeLevel = val;
                          });
                          setState(() {});
                        },
                      ),
                    ),
                    Text('${(volumeLevel * 100).toInt()}%', style: const TextStyle(color: Colors.white54, fontSize: 12)),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentSong = playlist[currentSongIndex];

    return Scaffold(
      body: Stack(
        children: [
          // Background Glows
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

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  // Custom App Bar with Volume & Playlist Options
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
                            'Late Night Sufi & Chill',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => _showVolumeDialog(context),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.06),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white.withOpacity(0.1)),
                          ),
                          child: const Icon(Icons.volume_up_rounded, color: Color(0xFF03DAC6), size: 20),
                        ),
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

                  // Song Title & Animated Equalizer Waves
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
                            Row(
                              children: [
                                Text(
                                  currentSong.artist,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.5),
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                if (isPlaying)
                                  AnimatedBuilder(
                                    animation: _equalizerController,
                                    builder: (context, child) {
                                      return Row(
                                        children: List.generate(4, (index) {
                                          double height = 6 + (14 * ((index % 2 == 0 ? _equalizerController.value : (1 - _equalizerController.value))));
                                          return Container(
                                            margin: const EdgeInsets.symmetric(horizontal: 1.5),
                                            width: 3,
                                            height: height,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF03DAC6),
                                              borderRadius: BorderRadius.circular(2),
                                            ),
                                          );
                                        }),
                                      );
                                    },
                                  ),
                              ],
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

                  // Progress Bar (0 to duration, increments every second)
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

                  // Playback Controls
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
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isPlaying = !isPlaying;
                            if (isPlaying) {
                              _vinylController.repeat();
                              _equalizerController.repeat(reverse: true);
                            } else {
                              _vinylController.stop();
                              _equalizerController.stop();
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

                  // Bottom Glassmorphic Up-Next Queue Card (Tapping opens full playlist sheet)
                  GestureDetector(
                    onTap: () => _showPlaylistBottomSheet(context),
                    child: ClipRRect(
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
                                      'UP NEXT (${playlist.length} songs)',
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