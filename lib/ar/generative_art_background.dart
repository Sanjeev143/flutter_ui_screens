import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const GenerativeArtBackGround());
}

class GenerativeArtBackGround extends StatelessWidget {
  const GenerativeArtBackGround({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Generative Shader SaaS',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF070A12),
        primaryColor: const Color(0xFF2563EB),
      ),
      home: const LandingPage(),
    );
  }
}

// ==========================================
// REUSABLE GLASSMORPHIC CONTAINER
// ==========================================
class GlassContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  const GlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 24,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: padding ?? const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: Colors.white.withOpacity(0.12),
              width: 1.2,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

// ==========================================
// MAIN LANDING PAGE
// ==========================================
class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  FragmentShader? _shader;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();

    _loadShader();
  }

  Future<void> _loadShader() async {
    try {
      final program =
      await FragmentProgram.fromAsset('shaders/generative_art.frag');
      setState(() {
        _shader = program.fragmentShader();
      });
    } catch (e) {
      debugPrint("Shader loading fallback: $e");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _shader?.dispose();
    super.dispose();
  }

  void _showLoginDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const GlassLoginModal(),
    );
  }

  void _showLiveDemoDialog() {
    showDialog(
      context: context,
      builder: (context) => GlassLiveDemoDialog(
        shader: _shader,
        controller: _controller,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. GENERATIVE SHADER BACKGROUND
          if (_shader != null)
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  size: Size.infinite,
                  painter: ShaderBackgroundPainter(
                    shader: _shader!,
                    time: _controller.value * 20.0,
                  ),
                );
              },
            )
          else
            Container(color: const Color(0xFF070A12)),

          // 2. HERO CONTENT OVERLAY
          SafeArea(
            child: Column(
              children: [
                _buildNavbar(),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: _buildHeroSection(),
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

  Widget _buildNavbar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              Icon(Icons.auto_awesome, color: Color(0xFF60A5FA), size: 26),
              SizedBox(width: 8),
              Text(
                'AMAZEVALLEY.AI',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.12),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Colors.white.withOpacity(0.2)),
              ),
            ),
            onPressed: _showLoginDialog,
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GlassContainer(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          borderRadius: 30,
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.bolt, color: Color(0xFF60A5FA), size: 16),
              SizedBox(width: 6),
              Text(
                'Next-Gen Shader Engine v2.0',
                style: TextStyle(
                  color: Color(0xFF60A5FA),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Generative Intelligence\nFor Enterprise Teams',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 42,
            height: 1.1,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Supercharge your SaaS workflow with real-time GPU-accelerated\nintelligence and procedural automation.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15, color: Colors.white70, height: 1.5),
        ),
        const SizedBox(height: 36),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2563EB),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: _showLoginDialog,
              child: const Text('Start Free Trial', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                side: BorderSide(color: Colors.white.withOpacity(0.3)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: _showLiveDemoDialog,
              child: const Text('Book Live Demo'),
            ),
          ],
        ),
      ],
    );
  }
}

// ==========================================
// 1. GLASSMORPHIC LOGIN MODAL SHEET
// ==========================================
class GlassLoginModal extends StatelessWidget {
  const GlassLoginModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: GlassContainer(
        borderRadius: 28,
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Welcome Back',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white54),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Text('Sign in to access your generative dashboard', style: TextStyle(fontSize: 12, color: Colors.white54)),
            const SizedBox(height: 24),
            _inputField(Icons.email_outlined, 'Work Email', false),
            const SizedBox(height: 16),
            _inputField(Icons.lock_outline, 'Password', true),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  padding: const EdgeInsets.only(top: 14, bottom: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Sign In to Dashboard', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField(IconData icon, String hint, bool isObscure) {
    return TextField(
      obscureText: isObscure,
      style: const TextStyle(color: Colors.white, fontSize: 13),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white54, size: 18),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white38, fontSize: 13),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF2563EB))),
      ),
    );
  }
}

// ==========================================
// 2. LIVE SHADER DEMO DIALOG
// ==========================================
class GlassLiveDemoDialog extends StatefulWidget {
  final FragmentShader? shader;
  final AnimationController controller;

  const GlassLiveDemoDialog({
    super.key,
    required this.shader,
    required this.controller,
  });

  @override
  State<GlassLiveDemoDialog> createState() => _GlassLiveDemoDialogState();
}

class _GlassLiveDemoDialogState extends State<GlassLiveDemoDialog> {
  double _speedMultiplier = 1.0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: GlassContainer(
        borderRadius: 24,
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: 420,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Live GPU Shader Canvas', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white54, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Live Interactive Shader Canvas Preview
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: widget.shader != null
                      ? AnimatedBuilder(
                    animation: widget.controller,
                    builder: (context, child) {
                      return CustomPaint(
                        painter: ShaderBackgroundPainter(
                          shader: widget.shader!,
                          time: widget.controller.value * 20.0 * _speedMultiplier,
                        ),
                      );
                    },
                  )
                      : Container(color: Colors.black26),
                ),
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Simulation Speed', style: TextStyle(fontSize: 12, color: Colors.white70)),
                  Text('${_speedMultiplier.toStringAsFixed(1)}x', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF60A5FA))),
                ],
              ),
              Slider(
                value: _speedMultiplier,
                min: 0.2,
                max: 3.0,
                activeColor: const Color(0xFF2563EB),
                onChanged: (val) => setState(() => _speedMultiplier = val),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// SHADER PAINTER
// ==========================================
class ShaderBackgroundPainter extends CustomPainter {
  final FragmentShader shader;
  final double time;

  ShaderBackgroundPainter({required this.shader, required this.time});

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setFloat(2, time);

    final paint = Paint()..shader = shader;
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant ShaderBackgroundPainter oldDelegate) {
    return oldDelegate.time != time;
  }
}