import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF070913),
      ),
      home: const MorphingAiSplashScreen(),
    );
  }
}

// -------------------------------------------------------------
// AI-POWERED DYNAMIC MORPHING SPLASH SCREEN
// -------------------------------------------------------------
class MorphingAiSplashScreen extends StatefulWidget {
  const MorphingAiSplashScreen({super.key});

  @override
  State<MorphingAiSplashScreen> createState() => _MorphingAiSplashScreenState();
}

class _MorphingAiSplashScreenState extends State<MorphingAiSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _morphController;
  late AnimationController _pulseController;
  late AnimationController _revealController;

  String _dynamicGreeting = "Initializing Neural Core...";
  String _aiSubtitle = "Synthesizing dynamic session context...";
  bool _isReady = false;

  // Insert your Gemini API Key or pass via --dart-define=GEMINI_KEY=xxx
  final String _apiKey = const String.fromEnvironment(
    'GEMINI_KEY',
    defaultValue: 'YOUR_GEMINI_API_KEY_HERE',
  );

  @override
  void initState() {
    super.initState();

    // 1. Continuous Morphing Loop
    _morphController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    // 2. Ambient Breath & Pulse Loop
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    // 3. Reveal / Transition Controller
    _revealController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _generateAiStartupContext();
  }

  Future<void> _generateAiStartupContext() async {
    final hour = DateTime.now().hour;
    final timeContext = hour < 12
        ? "morning"
        : hour < 17
        ? "afternoon"
        : "evening";

    try {
      if (_apiKey.isEmpty || _apiKey == 'YOUR_GEMINI_API_KEY_HERE') {
        // Fallback for offline or local preview
        await Future.delayed(const Duration(seconds: 3));
        _updateAiState(
          greeting: "Good $timeContext, Creator",
          subtitle: "Harmonizing creative pathways & generative nodes.",
        );
        return;
      }

      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: _apiKey,
      );

      final prompt = 'Generate a 4-word futuristic morning/afternoon/evening '
          'greeting for the user during $timeContext, and a brief 8-word AI status subtitle. '
          'Return format: Greeting | Subtitle';

      final response = await model.generateContent([Content.text(prompt)]);
      final text = response.text?.trim() ?? "";

      if (text.contains('|')) {
        final parts = text.split('|');
        _updateAiState(
          greeting: parts[0].trim(),
          subtitle: parts[1].trim(),
        );
      } else {
        _updateAiState(
          greeting: "Welcome, Pioneer",
          subtitle: "All neural synthesis models primed and active.",
        );
      }
    } catch (_) {
      // Graceful fallback
      _updateAiState(
        greeting: "Welcome Back",
        subtitle: "Neural engine synchronized successfully.",
      );
    }
  }

  void _updateAiState({required String greeting, required String subtitle}) {
    if (!mounted) return;
    setState(() {
      _dynamicGreeting = greeting;
      _aiSubtitle = subtitle;
      _isReady = true;
    });
    _revealController.forward();
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 900),
        pageBuilder: (_, animation, __) => const MainDashboardScreen(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
            opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.95, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
              ),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _morphController.dispose();
    _pulseController.dispose();
    _revealController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          // Background dynamic radial glow
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(0, -0.2),
                  radius: 1.2,
                  colors: [
                    Color(0xFF1E103A),
                    Color(0xFF0B0D1A),
                    Color(0xFF04060C),
                  ],
                ),
              ),
            ),
          ),

          // Generative Morphing Fluid Blob Canvas
          AnimatedBuilder(
            animation: Listenable.merge([_morphController, _pulseController]),
            builder: (context, _) {
              return CustomPaint(
                size: Size(size.width, size.height),
                painter: GenerativeMorphPainter(
                  morphProgress: _morphController.value,
                  pulseProgress: _pulseController.value,
                  isReady: _isReady,
                ),
              );
            },
          ),

          // Foreground Content & Dynamic AI Greeting
          Positioned(
            bottom: size.height * 0.14,
            left: 32,
            right: 32,
            child: FadeTransition(
              opacity: _revealController,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.25),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: _revealController,
                    curve: Curves.easeOutCubic,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Color(0xFF00F0FF), Color(0xFFD946EF), Colors.white],
                      ).createShader(bounds),
                      child: Text(
                        _dynamicGreeting,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _aiSubtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.7),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: _navigateToHome,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6366F1),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 36,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 12,
                        shadowColor: const Color(0xFF6366F1).withOpacity(0.6),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Enter Space",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward_rounded, size: 18),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------
// MATHEMATICAL PARAMETRIC MORPHING PAINTER
// -------------------------------------------------------------
class GenerativeMorphPainter extends CustomPainter {
  final double morphProgress;
  final double pulseProgress;
  final bool isReady;

  GenerativeMorphPainter({
    required this.morphProgress,
    required this.pulseProgress,
    required this.isReady,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.42);
    final baseRadius = size.width * 0.28 + (pulseProgress * 14.0);
    const int totalPoints = 180;

    final path = Path();

    for (int i = 0; i <= totalPoints; i++) {
      final theta = (i / totalPoints) * 2 * math.pi;

      // Harmonic perturbation equations creating dynamic fluid contours
      final harmonic1 = math.sin(3 * theta + morphProgress * 2 * math.pi) * 16.0;
      final harmonic2 = math.cos(5 * theta - morphProgress * 4 * math.pi) * 10.0;
      final harmonic3 = math.sin(2 * theta + morphProgress * 2 * math.pi) * 8.0;

      final r = baseRadius + harmonic1 + harmonic2 + harmonic3;
      final x = center.dx + r * math.cos(theta);
      final y = center.dy + r * math.sin(theta);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    // 1. Ambient Background Glow Shader
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          (isReady ? const Color(0xFF00F0FF) : const Color(0xFF8B5CF6))
              .withOpacity(0.4),
          const Color(0xFFEC4899).withOpacity(0.2),
          Colors.transparent,
        ],
        stops: const [0.0, 0.6, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: baseRadius * 1.8))
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 45);

    canvas.drawCircle(center, baseRadius * 1.5, glowPaint);

    // 2. Core Morphing Fluid Body
    final fluidGradient = Paint()
      ..shader = SweepGradient(
        center: FractionalOffset.center,
        startAngle: 0.0,
        endAngle: math.pi * 2,
        transform: GradientRotation(morphProgress * 2 * math.pi),
        colors: isReady
            ? const [
          Color(0xFF06B6D4),
          Color(0xFF8B5CF6),
          Color(0xFFEC4899),
          Color(0xFF06B6D4),
        ]
            : const [
          Color(0xFF3B82F6),
          Color(0xFF6366F1),
          Color(0xFF8B5CF6),
          Color(0xFF3B82F6),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: baseRadius));

    canvas.drawPath(path, fluidGradient);

    // 3. Internal Specular Core Ring
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.white.withOpacity(0.35);

    canvas.drawCircle(center, baseRadius * 0.45 + (pulseProgress * 6), ringPaint);
  }

  @override
  bool shouldRepaint(covariant GenerativeMorphPainter oldDelegate) => true;
}

// -------------------------------------------------------------
// TARGET MAIN DASHBOARD SCREEN
// ------------------------------------------------------------- 
class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({super.key});

  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _gradientController;

  @override
  void initState() {
    super.initState();
    // Continuous loop driving the shifting gradient animation
    _gradientController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _gradientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF070913),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white70),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Neural Workspace",
          style: TextStyle(fontSize: 18, color: Colors.white70, letterSpacing: 1.0),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Ambient backdrop blur
          Positioned(
            top: -60,
            left: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF6366F1).withOpacity(0.2),
              ),
            ),
          ),
          Positioned(
            bottom: -80,
            right: -80,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFEC4899).withOpacity(0.18),
              ),
            ),
          ),

          // Main Content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated Gradient Headline
                  AnimatedBuilder(
                    animation: _gradientController,
                    builder: (context, _) {
                      return ShaderMask(
                        shaderCallback: (bounds) {
                          return LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: const [
                              Color(0xFF00F0FF), // Neon Cyan
                              Color(0xFF8B5CF6), // Violet
                              Color(0xFFEC4899), // Pink
                              Color(0xFFF59E0B), // Amber
                              Color(0xFF00F0FF), // Loop point
                            ],
                            transform: _GradientRotation(
                              _gradientController.value * 2 * math.pi,
                            ),
                          ).createShader(bounds);
                        },
                        child: const Text(
                          "Welcome to dashboard creators",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.8,
                            height: 1.2,
                            color: Colors.white, // Required for ShaderMask
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  // Subtitle
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.08),
                      ),
                    ),
                    child: Text(
                      "This is splash screen demo with Generative AI Powered Dynamic Morphing Splash Screen in Flutter",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.7),
                        height: 1.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Action Button to replay the dynamic splash screen
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/');
                    },
                    icon: const Icon(Icons.replay_rounded, size: 18),
                    label: const Text("Replay Morphing Splash"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF00F0FF),
                      side: BorderSide(
                        color: const Color(0xFF00F0FF).withOpacity(0.6),
                        width: 1.4,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
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

// -------------------------------------------------------------
// HELPER: Gradient Rotation Matrix
// -------------------------------------------------------------
class _GradientRotation extends GradientTransform {
  final double radians;
  const _GradientRotation(this.radians);

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    final double sin = math.sin(radians);
    final double cos = math.cos(radians);
    final Offset center = bounds.center;

    return Matrix4.identity()
      ..translate(center.dx, center.dy)
      ..multiply(
        Matrix4(
          cos, -sin, 0.0, 0.0,
          sin,  cos, 0.0, 0.0,
          0.0,  0.0, 1.0, 0.0,
          0.0,  0.0, 0.0, 1.0,
        ),
      )
      ..translate(-center.dx, -center.dy);
  }
}