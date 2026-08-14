import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const PlantDoctorApp());
}

class PlantDoctorApp extends StatelessWidget {
  const PlantDoctorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PlantPulse & AI Plant Doctor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0C1D13),
        fontFamily: 'Inter',
      ),
      home: const ScreenOne(),
    );
  }
}

// =============================================================================
// REUSABLE BACKGROUND & GLASSMORPHIC HELPERS
// =============================================================================

class ForestBackground extends StatelessWidget {
  final Widget child;
  final bool darkMidnight;

  const ForestBackground({
    super.key,
    required this.child,
    this.darkMidnight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: darkMidnight
              ? [
            const Color(0xFF132219),
            const Color(0xFF0A140F),
            const Color(0xFF050A07),
          ]
              : [
            const Color(0xFF234B2E),
            const Color(0xFF132B1A),
            const Color(0xFF0A180E),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -80,
            left: -40,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF4C8754).withOpacity(0.22),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 90, sigmaY: 90),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            right: -60,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF2F633A).withOpacity(0.2),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),
          SafeArea(child: child),
        ],
      ),
    );
  }
}

class GlassBox extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final Color? backgroundColor;
  final Border? border;

  const GlassBox({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius = 24,
    this.backgroundColor,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white.withOpacity(0.07),
        borderRadius: BorderRadius.circular(borderRadius),
        border: border ??
            Border.all(
              color: Colors.white.withOpacity(0.12),
              width: 1.0,
            ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );
  }
}

class PrimaryWhiteButton extends StatelessWidget {
  final String text;
  final bool showSparkle;
  final IconData? prefixIcon;
  final VoidCallback onPressed;

  const PrimaryWhiteButton({
    super.key,
    required this.text,
    this.showSparkle = false,
    this.prefixIcon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF0F1E14),
          elevation: 4,
          shadowColor: Colors.black.withOpacity(0.25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefixIcon != null) ...[
              Icon(prefixIcon, size: 18, color: const Color(0xFF2E7D32)),
              const SizedBox(width: 8),
            ] else if (showSparkle) ...[
              const Icon(Icons.auto_awesome, size: 18, color: Color(0xFF0F1E14)),
              const SizedBox(width: 8),
            ],
            Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _circleIconButton({required IconData icon, required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: GlassBox(
      borderRadius: 50,
      padding: const EdgeInsets.all(10),
      child: Icon(icon, size: 16, color: Colors.white),
    ),
  );
}

Widget _glassPillButton(String text, {required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: GlassBox(
      borderRadius: 20,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.white.withOpacity(0.85),
        ),
      ),
    ),
  );
}

Widget _tagPill(String label, IconData icon, {bool active = false}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: active ? Colors.white : Colors.white.withOpacity(0.08),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: active ? Colors.white : Colors.white.withOpacity(0.15),
      ),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 13,
          color: active ? const Color(0xFF0F1E14) : const Color(0xFF8FD897),
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: active ? const Color(0xFF0F1E14) : Colors.white.withOpacity(0.85),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SCREEN 1: WELCOME SCREEN
// =============================================================================

class ScreenOne extends StatelessWidget {
  const ScreenOne({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ForestBackground(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: screenHeight -
                  MediaQuery.of(context).padding.top -
                  MediaQuery.of(context).padding.bottom,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 10),
                  // Monstera Pot
                  Center(
                    child: SizedBox(
                      width: 260,
                      height: 280,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 220,
                            height: 220,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF6EAF7B).withOpacity(0.2),
                            ),
                          ),
                          Positioned(
                            top: 15,
                            left: 20,
                            child: Transform.rotate(
                              angle: -0.38,
                              child: const Icon(
                                Icons.eco_rounded,
                                size: 105,
                                color: Color(0xFF438A4F),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            right: 25,
                            child: Transform.rotate(
                              angle: 0.42,
                              child: const Icon(
                                Icons.eco_rounded,
                                size: 95,
                                color: Color(0xFF86D892),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 60,
                            child: Transform.rotate(
                              angle: -0.1,
                              child: const Icon(
                                Icons.eco_rounded,
                                size: 115,
                                color: Color(0xFF5BA769),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 135,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFFFAF7EE),
                                        Color(0xFFE5DFC9),
                                        Color(0xFFCDC5AC),
                                      ],
                                    ),
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(16),
                                      bottom: Radius.circular(24),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.4),
                                        blurRadius: 18,
                                        offset: const Offset(0, 10),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Container(
                                  width: 120,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2A2825),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Column(
                    children: [
                      const Text(
                        "Welcome",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Scan plants, spot issues, and\nget instant care tips.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white.withOpacity(0.7),
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      PrimaryWhiteButton(
                        text: "Continue with Phone",
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (_) => const ScreenTwo(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.08),
                            side: BorderSide(
                              color: Colors.white.withOpacity(0.15),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.apple, color: Colors.white, size: 22),
                              SizedBox(width: 8),
                              Text(
                                "Continue with Apple",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text.rich(
                        TextSpan(
                          text: "By pressing on 'Continue with...' you agree to our\n",
                          children: [
                            TextSpan(
                              text: "Terms of service",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const TextSpan(text: " and "),
                            TextSpan(
                              text: "privacy policy",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white.withOpacity(0.5),
                          height: 1.3,
                        ),
                      ),
                    ],
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

// =============================================================================
// SCREEN 2: JOIN AI PLANT DOCTOR
// =============================================================================

class ScreenTwo extends StatelessWidget {
  const ScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ForestBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _circleIconButton(
                    icon: Icons.arrow_back_ios_new_rounded,
                    onTap: () => Navigator.pop(context),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 18,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                  _glassPillButton("Skip", onTap: () {}),
                ],
              ),
              const SizedBox(height: 24),
              Center(
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(
                    Icons.energy_savings_leaf_rounded,
                    size: 65,
                    color: Color(0xFF2E7D32),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Join AI Plant Doctor",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Create an account to unlock\nmore scans and features.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.65),
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 24),
              _glassInputField(hintText: "Name", icon: Icons.person_rounded),
              const SizedBox(height: 12),
              _glassInputField(hintText: "Email", icon: Icons.mail_rounded),
              const SizedBox(height: 12),
              _glassInputField(
                hintText: "Password",
                icon: Icons.lock_rounded,
                isPassword: true,
              ),
              const SizedBox(height: 24),
              PrimaryWhiteButton(
                text: "Continue",
                showSparkle: true,
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (_) => const ScreenThree()),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _glassInputField({
    required String hintText,
    required IconData icon,
    bool isPassword = false,
  }) {
    return GlassBox(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      borderRadius: 18,
      child: TextField(
        obscureText: isPassword,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          icon: Icon(icon, color: const Color(0xFF86BA8F), size: 20),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// SCREEN 3: DOCTOR INTRO
// =============================================================================

class ScreenThree extends StatelessWidget {
  const ScreenThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ForestBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _circleIconButton(
                    icon: Icons.arrow_back_ios_new_rounded,
                    onTap: () => Navigator.pop(context),
                  ),
                  _glassPillButton("Skip", onTap: () {}),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Welcome to AI",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white),
              ),
              const Text(
                "Plant Doctor",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Scan, diagnose, and care for your\nplants with confidence.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.65),
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _miniFeatureCard(
                      title: "Instant diagnosis",
                      subtitle: "Scan leaves",
                      icon: Icons.search_rounded,
                      isActive: false,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _miniFeatureCard(
                      title: "Smart reminders",
                      subtitle: "Watering fertilizing,",
                      icon: Icons.water_drop_rounded,
                      isActive: true,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _miniFeatureCard(
                      title: "Actionable plans",
                      subtitle: "Step treatments",
                      icon: Icons.task_alt_rounded,
                      isActive: false,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              PrimaryWhiteButton(
                text: "Continue",
                showSparkle: true,
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (_) => const ScreenFour()),
                  );
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _miniFeatureCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool isActive,
  }) {
    return Container(
      height: 135,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xFF388E3C).withOpacity(0.7)
            : Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isActive ? const Color(0xFF81C784) : Colors.white.withOpacity(0.12),
          width: isActive ? 1.5 : 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: TextStyle(fontSize: 10, color: Colors.white.withOpacity(0.65)),
              ),
            ],
          ),
          Center(
            child: Icon(icon, color: isActive ? Colors.white : const Color(0xFF8FD897), size: 22),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SCREEN 4: ADD PLANT & ASSESSMENT
// =============================================================================

class ScreenFour extends StatelessWidget {
  const ScreenFour({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ForestBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _circleIconButton(
                    icon: Icons.arrow_back_ios_new_rounded,
                    onTap: () => Navigator.pop(context),
                  ),
                  const Text(
                    "Add Plant",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                  _circleIconButton(icon: Icons.grid_view_rounded, onTap: () {}),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  _tagPill("Today", Icons.calendar_today_rounded, active: true),
                  const SizedBox(width: 8),
                  _tagPill("photos", Icons.photo_library_rounded),
                  const SizedBox(width: 8),
                  _tagPill("Info", Icons.info_outline_rounded),
                ],
              ),
              const SizedBox(height: 16),
              GlassBox(
                borderRadius: 24,
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Plant Assessment",
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Take a photo and let AI identify your plant and suggest care routines",
                      style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.65)),
                    ),
                    const SizedBox(height: 16),
                    PrimaryWhiteButton(
                      text: "Quick Health Check",
                      prefixIcon: Icons.search_rounded,
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (_) => const ScreenFive()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// SCREEN 5: CALATHEAS SCANNER
// =============================================================================

class ScreenFive extends StatelessWidget {
  const ScreenFive({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ForestBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _circleIconButton(
                    icon: Icons.arrow_back_ios_new_rounded,
                    onTap: () => Navigator.pop(context),
                  ),
                  _circleIconButton(icon: Icons.check_rounded, onTap: () {}),
                ],
              ),
              const Spacer(),
              PrimaryWhiteButton(
                text: "View Profile",
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (_) => const ScreenSix()),
                  );
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// SCREEN 6: DRAGON TREE PROFILE (TRIGGERS SCREEN 7 ON CAMERA TAP)
// =============================================================================

class ScreenSix extends StatelessWidget {
  const ScreenSix({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ForestBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _circleIconButton(
                    icon: Icons.arrow_back_ios_new_rounded,
                    onTap: () => Navigator.pop(context),
                  ),
                  const Text(
                    "Dragon Tree",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  _circleIconButton(icon: Icons.grid_view_rounded, onTap: () {}),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  _tagPill("Today", Icons.calendar_today_rounded, active: true),
                  const SizedBox(width: 8),
                  _tagPill("photos", Icons.photo_library_rounded),
                  const SizedBox(width: 8),
                  _tagPill("Info", Icons.info_outline_rounded),
                ],
              ),
              const SizedBox(height: 16),
              GlassBox(
                borderRadius: 24,
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Profile Picture",
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Icon(
                        Icons.filter_vintage_rounded,
                        size: 120,
                        color: const Color(0xFF8FD897).withOpacity(0.95),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              GlassBox(
                borderRadius: 24,
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Photos",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Tap the buttons below\nto add photos",
                      style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.65)),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        // TAP HERE TO NAVIGATE TO SCREEN 7 (PLANTPULSE)
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (_) => const ScreenSeven(),
                                ),
                              );
                            },
                            child: _actionButton(
                              label: "Take Photo",
                              icon: Icons.camera_alt_rounded,
                              isPrimary: false,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _actionButton(
                            label: "From Gallery",
                            icon: Icons.image_rounded,
                            isPrimary: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionButton({
    required String label,
    required IconData icon,
    required bool isPrimary,
  }) {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        color: isPrimary ? Colors.white : Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isPrimary ? Colors.white : Colors.white.withOpacity(0.15),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 16,
            color: isPrimary ? const Color(0xFF2E7D32) : const Color(0xFFA5E6AC),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: isPrimary ? const Color(0xFF0F1E14) : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SCREEN 7: PLANTPULSE WELCOME (SMART PLANT CARE)
// =============================================================================

// =============================================================================
// SCREEN 7: PLANTPULSE SEARCHABLE MULTI-PLANT DISCOVERY & SHOWCASE
// =============================================================================

class PlantItem {
  final String name;
  final String scientificName;
  final String category;
  final String watering;
  final String sunlight;
  final String temp;
  final IconData icon;
  final Color primaryAccent;
  final Color potColor1;
  final Color potColor2;

  PlantItem({
    required this.name,
    required this.scientificName,
    required this.category,
    required this.watering,
    required this.sunlight,
    required this.temp,
    required this.icon,
    required this.primaryAccent,
    required this.potColor1,
    required this.potColor2,
  });
}

class SlideActionButton extends StatefulWidget {
  final String label;
  final VoidCallback onSlideComplete;

  const SlideActionButton({
    super.key,
    required this.label,
    required this.onSlideComplete,
  });

  @override
  State<SlideActionButton> createState() => _SlideActionButtonState();
}

class _SlideActionButtonState extends State<SlideActionButton>
    with SingleTickerProviderStateMixin {
  double _dragPosition = 0.0;
  late AnimationController _resetController;
  late Animation<double> _resetAnimation;

  final double _buttonHeight = 60.0;
  final double _thumbSize = 48.0;

  @override
  void initState() {
    super.initState();
    _resetController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    )..addListener(() {
      setState(() {
        _dragPosition = _resetAnimation.value;
      });
    });
  }

  @override
  void dispose() {
    _resetController.dispose();
    super.dispose();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details, double maxDrag) {
    setState(() {
      _dragPosition = (_dragPosition + details.delta.dx).clamp(0.0, maxDrag);
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details, double maxDrag) {
    // If slid past 75% of the width, trigger action
    if (_dragPosition >= maxDrag * 0.75) {
      setState(() {
        _dragPosition = maxDrag;
      });
      widget.onSlideComplete();
      // Reset position slightly after transition
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          setState(() {
            _dragPosition = 0.0;
          });
        }
      });
    } else {
      // Snap back animation
      _resetAnimation = Tween<double>(
        begin: _dragPosition,
        end: 0.0,
      ).animate(
        CurvedAnimation(parent: _resetController, curve: Curves.easeOutCubic),
      );
      _resetController.forward(from: 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxDrag = constraints.maxWidth - _thumbSize - 12;

        return Container(
          height: _buttonHeight,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.09),
            borderRadius: BorderRadius.circular(35),
            border: Border.all(
              color: Colors.white.withOpacity(0.15),
              width: 1.2,
            ),
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              // Track Label & Arrows
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.only(left: 60.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.label,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white.withOpacity(
                            (1.0 - (_dragPosition / (maxDrag == 0 ? 1 : maxDrag))).clamp(0.2, 1.0),
                          ),
                          letterSpacing: -0.2,
                        ),
                      ),
                      Text(
                        ">>>",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: Colors.white.withOpacity(0.35),
                          letterSpacing: 2.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Draggable Circular Thumb
              Positioned(
                left: 6 + _dragPosition,
                child: GestureDetector(
                  onHorizontalDragUpdate: (details) =>
                      _onHorizontalDragUpdate(details, maxDrag),
                  onHorizontalDragEnd: (details) =>
                      _onHorizontalDragEnd(details, maxDrag),
                  child: Container(
                    width: _thumbSize,
                    height: _thumbSize,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Color(0xFF0C1D13),
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// =============================================================================
// SCREEN 7: PLANTPULSE SEARCHABLE WITH SLIDE-TO-NAVIGATE
// =============================================================================

class ScreenSeven extends StatefulWidget {
  const ScreenSeven({super.key});

  @override
  State<ScreenSeven> createState() => _ScreenSevenState();
}

class _ScreenSevenState extends State<ScreenSeven> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = "All";

  final List<String> _categories = [
    "All",
    "Indoor",
    "Outdoor",
    "Low Light",
    "Rare",
  ];

  final List<PlantItem> _allPlants = [
    PlantItem(
      name: "Parlor Palm",
      scientificName: "Chamaedorea elegans",
      category: "Indoor",
      watering: "70%",
      sunlight: "65%",
      temp: "18-24°C",
      icon: Icons.yard_rounded,
      primaryAccent: const Color(0xFF81C784),
      potColor1: const Color(0xFFC87D55),
      potColor2: const Color(0xFF8D4A2B),
    ),
    PlantItem(
      name: "Monstera Deliciosa",
      scientificName: "Swiss Cheese Plant",
      category: "Indoor",
      watering: "60%",
      sunlight: "80%",
      temp: "20-30°C",
      icon: Icons.eco_rounded,
      primaryAccent: const Color(0xFF69F0AE),
      potColor1: const Color(0xFFFAF7EE),
      potColor2: const Color(0xFFCDC5AC),
    ),
    PlantItem(
      name: "Calathea Orbifolia",
      scientificName: "Prayer Plant",
      category: "Low Light",
      watering: "85%",
      sunlight: "45%",
      temp: "18-26°C",
      icon: Icons.filter_vintage_rounded,
      primaryAccent: const Color(0xFFA5D6A7),
      potColor1: const Color(0xFF3E505B),
      potColor2: const Color(0xFF1E282D),
    ),
    PlantItem(
      name: "Dragon Tree",
      scientificName: "Dracaena marginata",
      category: "Indoor",
      watering: "50%",
      sunlight: "70%",
      temp: "16-24°C",
      icon: Icons.energy_savings_leaf_rounded,
      primaryAccent: const Color(0xFF4CAF50),
      potColor1: const Color(0xFFE5DFC9),
      potColor2: const Color(0xFF332F2A),
    ),
    PlantItem(
      name: "Coconut Palm",
      scientificName: "Cocos nucifera",
      category: "Outdoor",
      watering: "90%",
      sunlight: "95%",
      temp: "24-35°C",
      icon: Icons.park_rounded,
      primaryAccent: const Color(0xFF00E676),
      potColor1: const Color(0xFF8D4A2B),
      potColor2: const Color(0xFF5C321E),
    ),
  ];

  List<PlantItem> get _filteredPlants {
    return _allPlants.where((plant) {
      final matchesSearch = plant.name
          .toLowerCase()
          .contains(_searchController.text.toLowerCase()) ||
          plant.scientificName
              .toLowerCase()
              .contains(_searchController.text.toLowerCase());
      final matchesCategory = _selectedCategory == "All" ||
          plant.category.toLowerCase() == _selectedCategory.toLowerCase();
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredPlants;

    return Scaffold(
      body: ForestBackground(
        darkMidnight: true,
        child: Column(
          children: [
            // Top App Bar
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _circleIconButton(
                    icon: Icons.arrow_back_ios_new_rounded,
                    onTap: () => Navigator.pop(context),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.psychology_alt_rounded,
                        color: Color(0xFF8FD897),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "PlantPulse Discovery",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.white.withOpacity(0.95),
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                  _circleIconButton(
                    icon: Icons.grid_view_rounded,
                    onTap: () {},
                  ),
                ],
              ),
            ),

            // Scrollable Content
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                physics: const BouncingScrollPhysics(),
                children: [
                  Text(
                    "Welcome to",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.65),
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    "PlantPulse",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const Text(
                    "Explore & care for multiple plants",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFA5E6AC),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Search Bar
                  GlassBox(
                    borderRadius: 22,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 2),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search_rounded,
                          color: Colors.white.withOpacity(0.5),
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            onChanged: (_) => setState(() {}),
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: "Search plant name or species...",
                              hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.4),
                                fontSize: 13,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        if (_searchController.text.isNotEmpty)
                          GestureDetector(
                            onTap: () {
                              _searchController.clear();
                              setState(() {});
                            },
                            child: Icon(
                              Icons.close_rounded,
                              color: Colors.white.withOpacity(0.6),
                              size: 18,
                            ),
                          )
                        else
                          Icon(
                            Icons.tune_rounded,
                            color: Colors.white.withOpacity(0.5),
                            size: 18,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Category Filter Chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: _categories.map((cat) {
                        final isSelected = _selectedCategory == cat;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCategory = cat;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFF00C853)
                                  : Colors.white.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFF69F0AE)
                                    : Colors.white.withOpacity(0.12),
                              ),
                            ),
                            child: Text(
                              cat,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.8),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Carousel Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Featured Collection (${filtered.length})",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Swipe to view",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Plant Cards Carousel
                  SizedBox(
                    height: 255,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: filtered.length,
                      itemBuilder: (context, index) {
                        final plant = filtered[index];
                        return _buildPlantCard(plant);
                      },
                    ),
                  ),

                  const SizedBox(height: 22),

                  // --- SLIDE BUTTON THAT NAVIGATES TO SCREEN EIGHT ---
                  SlideActionButton(
                    label: "Slide to Explore & Scan",
                    onSlideComplete: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => const ScreenEight(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlantCard(PlantItem plant) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (_) => const ScreenEight()),
        );
      },
      child: Container(
        width: 195,
        margin: const EdgeInsets.only(right: 14),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF132B1A),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: plant.primaryAccent.withOpacity(0.35),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 18,
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
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    plant.category,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: plant.primaryAccent,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Color(0xFF00C853),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_outward_rounded,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 85,
                    height: 85,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: plant.primaryAccent.withOpacity(0.18),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        plant.icon,
                        size: 70,
                        color: plant.primaryAccent,
                      ),
                      Container(
                        width: 48,
                        height: 28,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [plant.potColor1, plant.potColor2],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Text(
              plant.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            Text(
              plant.scientificName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                color: Colors.white.withOpacity(0.55),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.water_drop_rounded,
                  size: 13,
                  color: Color(0xFF69F0AE),
                ),
                const SizedBox(width: 3),
                Text(
                  plant.watering,
                  style: const TextStyle(fontSize: 10, color: Colors.white70),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.wb_sunny_rounded,
                  size: 13,
                  color: Colors.amber,
                ),
                const SizedBox(width: 3),
                Text(
                  plant.sunlight,
                  style: const TextStyle(fontSize: 10, color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// SCREEN 8: PLANTPULSE CATALOG & METRICS DASHBOARD
// =============================================================================

class ScreenEight extends StatelessWidget {
  const ScreenEight({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ForestBackground(
        darkMidnight: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome to",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white.withOpacity(0.55),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.psychology_alt_rounded, color: Color(0xFF8FD897), size: 16),
                          const SizedBox(width: 6),
                          Text(
                            "PlantPulse",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Colors.white.withOpacity(0.95),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  _circleIconButton(icon: Icons.notifications_none_rounded, onTap: () {}),
                ],
              ),
              const SizedBox(height: 16),

              // Search Bar
              GlassBox(
                borderRadius: 20,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                child: Row(
                  children: [
                    Icon(Icons.search_rounded, color: Colors.white.withOpacity(0.4), size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search here..",
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.4),
                            fontSize: 13,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(Icons.tune_rounded, color: Colors.white.withOpacity(0.5), size: 18),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Filter Tabs
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00C853),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "All",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    _tagPill("Indoor", Icons.home_rounded),
                    const SizedBox(width: 8),
                    _tagPill("Outdoor", Icons.wb_sunny_rounded),
                    const SizedBox(width: 8),
                    _tagPill("Garden", Icons.park_rounded),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Card 1: Indoor - Parlor Palm Tree -> Screen 9
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (_) => const ScreenNine()),
                  );
                },
                child: _plantCatalogTile(
                  title: "Indoor",
                  subtitle: "Parlor Palm Tree",
                  onTapArrow: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (_) => const ScreenNine()),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),

              // Card 2: Outdoor - Coconut Tree
              _plantCatalogTile(
                title: "Outdoor",
                subtitle: "Coconut Tree",
                onTapArrow: () {},
              ),
              const SizedBox(height: 14),

              // Card 3: Garden - Green Blum Tree (Expanded Card with Diagnostics)
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFF132B1A),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: const Color(0xFF4C8754).withOpacity(0.3),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Garden",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "Green Blum Tree",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white.withOpacity(0.65),
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                      builder: (_) => const ScreenNine(),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF00C853),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.arrow_outward_rounded,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),

                          // Water Stat
                          Text(
                            "Water 70%",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.08),
                            ),
                            child: const Icon(
                              Icons.water_drop_outlined,
                              color: Color(0xFF81C784),
                              size: 16,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Light Stat
                          Text(
                            "Light 65%",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.08),
                            ),
                            child: const Icon(
                              Icons.wb_sunny_outlined,
                              color: Color(0xFFFFD54F),
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        right: -10,
                        bottom: -15,
                        child: Icon(
                          Icons.yard_rounded,
                          size: 140,
                          color: const Color(0xFF81C784).withOpacity(0.9),
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
    );
  }

  Widget _plantCatalogTile({
    required String title,
    required String subtitle,
    required VoidCallback onTapArrow,
  }) {
    return GlassBox(
      borderRadius: 20,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.white.withOpacity(0.55),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: onTapArrow,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFF00C853),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_outward_rounded,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SCREEN 9: FULLSCREEN AR CAMERA SCANNER VIEW
// =============================================================================

// =============================================================================
// SCREEN 9: FULLSCREEN AR CAMERA SCANNER VIEW (WITH CLICK NAVIGATION)
// =============================================================================

class ScreenNine extends StatelessWidget {
  const ScreenNine({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ForestBackground(
        darkMidnight: true,
        child: Stack(
          children: [
            // 1. Centered Palm Tree Subject
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.yard_rounded,
                      size: 240,
                      color: Color(0xFF69F0AE),
                    ),
                    Container(
                      width: 140,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xFFC87D55), Color(0xFF8D4A2B)],
                        ),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(8),
                          bottom: Radius.circular(26),
                        ),
                        border: Border.all(color: const Color(0xFF5C321E), width: 2),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 2. Futuristic AR Camera Reticle & Laser Line
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 380,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(44),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.65),
                        width: 2.0,
                      ),
                    ),
                  ),
                  // Horizontal Laser Target Line
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: Colors.white.withOpacity(0.85),
                  ),
                ],
              ),
            ),

            // 3. Top Navigation Back Button
            Positioned(
              top: 10,
              left: 20,
              child: _circleIconButton(
                icon: Icons.arrow_back_ios_new_rounded,
                onTap: () => Navigator.pop(context),
              ),
            ),

            // 4. Bottom Floating Glass Badge Info (CLICKABLE TO NAVIGATE)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  // Navigate to ScreenSix (Plant Profile & Photos)
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => const ScreenSeven(),
                    ),
                  );
                },
                child: GlassBox(
                  borderRadius: 30,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.12),
                        ),
                        child: const Icon(
                          Icons.yard_rounded,
                          color: Color(0xFF69F0AE),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Parlor Palm Tree",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "garden plant",
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white60,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.arrow_outward_rounded,
                          color: Color(0xFF0C1D13),
                          size: 16,
                        ),
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
}