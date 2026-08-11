import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const GlassmorphismLoginApp());
}

class GlassmorphismLoginApp extends StatelessWidget {
  const GlassmorphismLoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glassmorphism Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Roboto',
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _bgAnimationController;
  late Animation<double> _bgAnimation;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Continuous ambient background movement animation
    _bgAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);

    _bgAnimation = Tween<double>(begin: -30.0, end: 30.0).animate(
      CurvedAnimation(
        parent: _bgAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _bgAnimationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // 1. Deep Dark Base Background
          Container(
            color: const Color(0xFF0D0B1E),
          ),

          // 2. Animated Floating Gradient Orbs (Creates the Glassmorphism Contrast)
          AnimatedBuilder(
            animation: _bgAnimation,
            builder: (context, child) {
              return Stack(
                children: [
                  // Top-Left Glowing Violet Orb
                  Positioned(
                    top: size.height * 0.15 + _bgAnimation.value,
                    left: size.width * 0.1 - _bgAnimation.value,
                    child: Container(
                      width: 220,
                      height: 220,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Color(0xFFE040FB), // Bright Magenta
                            Color(0xFF7C4DFF), // Purple
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Bottom-Right Glowing Cyan Orb
                  Positioned(
                    bottom: size.height * 0.15 - _bgAnimation.value,
                    right: size.width * 0.1 + _bgAnimation.value,
                    child: Container(
                      width: 260,
                      height: 260,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            Color(0xFF00E5FF), // Cyan
                            Color(0xFF00B0FF), // Blue
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // 3. Main Frosted Glass Card Centered
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: BackdropFilter(
                  // Gaussian Blur Strength
                  filter: ImageFilter.blur(sigmaX: 18.0, sigmaY: 18.0),
                  child: Container(
                    width: size.width > 450 ? 400 : double.infinity,
                    padding: const EdgeInsets.all(32.0),
                    decoration: BoxDecoration(
                      // Translucent fill layer
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(30.0),
                      // Specular Highlight Border
                      border: Border.all(
                        color: Colors.white.withOpacity(0.25),
                        width: 1.5,
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.15),
                          Colors.white.withOpacity(0.05),
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header Title
                        const Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Sign in to access your account',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 36),

                        // Email Field
                        _buildGlassTextField(
                          controller: _emailController,
                          hintText: 'Email Address',
                          icon: Icons.email_outlined,
                        ),
                        const SizedBox(height: 20),

                        // Password Field
                        _buildGlassTextField(
                          controller: _passwordController,
                          hintText: 'Password',
                          icon: Icons.lock_outline,
                          isPassword: true,
                        ),
                        const SizedBox(height: 12),

                        // Forgot Password Link
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Animated Glass Action Button
                        _buildGlassButton(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Login successful! Redirecting...'),
                                backgroundColor: Color(0xFF7C4DFF),
                                duration: Duration(milliseconds: 800),
                              ),
                            );

                            // 2. Navigate to Dashboard Screen
                            Navigator.of(context).pushReplacement(
                              PageRouteBuilder(
                                pageBuilder: (context, animation, secondaryAnimation) =>
                                const DashboardScreen(),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                                transitionDuration: const Duration(milliseconds: 600),
                              ),
                            );
                          },
                          text: 'SIGN IN',
                        ),
                        const SizedBox(height: 24),

                        // Social Login Divider
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.white.withOpacity(0.2),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Text(
                                'Or continue with',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.white.withOpacity(0.2),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Social Buttons Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildSocialIconButton(Icons.g_mobiledata_rounded),
                            _buildSocialIconButton(Icons.apple_rounded),
                            _buildSocialIconButton(Icons.facebook_rounded),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  // Glassmorphic Input Builder
  Widget _buildGlassTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.15),
          width: 1.0,
        ),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: const TextStyle(color: Colors.white, fontSize: 15),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.white.withOpacity(0.7)),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.4),
            fontSize: 14,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  // Glowing Primary Action Button
  Widget _buildGlassButton({
    required VoidCallback onTap,
    required String text,
  }) {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFE040FB),
            Color(0xFF00E5FF),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE040FB).withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  // Social Icon Button Builder
  Widget _buildSocialIconButton(IconData icon) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1.0,
        ),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 26),
        onPressed: () {},
      ),
    );
  }



}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0B1E),
      body: Stack(
        children: [
          // Background Gradient Orbs for Glass Effect
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0xFFE040FB), Color(0xFF7C4DFF)],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: -80,
            child: Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [Color(0xFF00E5FF), Color(0xFF00B0FF)],
                ),
              ),
            ),
          ),

          // Main Scrollable Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. TOP HEADER BAR
                  _buildHeader(context),
                  const SizedBox(height: 24),

                  // 2. SEARCH BAR
                  _buildSearchBar(),
                  const SizedBox(height: 24),

                  // 3. MAIN BALANCE FEATURE CARD
                  _buildMainBalanceCard(size),
                  const SizedBox(height: 24),

                  // 4. KPI STATS CARDS (GRID)
                  const Text(
                    'Overview Stats',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildKpiGrid(),
                  const SizedBox(height: 28),

                  // 5. RECENT ACTIVITY LIST
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Recent Activity',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'See All',
                          style: TextStyle(color: Color(0xFF00E5FF)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildActivityList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 1. Header Widget
  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFE040FB), width: 2),
              ),
              child: const CircleAvatar(
                radius: 22,
                backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=33'),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back,',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12,
                  ),
                ),
                const Text(
                  'Alex Johnson 👋',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),

        // Notification & Logout Actions
        Row(
          children: [
            _buildGlassIconButton(
              icon: Icons.notifications_none_rounded,
              onTap: () {},
            ),
            const SizedBox(width: 8),
            _buildGlassIconButton(
              icon: Icons.logout_rounded,
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ],
    );
  }

  // 2. Search Bar Widget
  Widget _buildSearchBar() {
    return _buildGlassContainer(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      borderRadius: 16,
      child: const TextField(
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: Colors.white54),
          hintText: 'Search analytics, cards, tasks...',
          hintStyle: TextStyle(color: Colors.white38, fontSize: 14),
          border: InputBorder.none,
        ),
      ),
    );
  }

  // 3. Featured Balance Card
  Widget _buildMainBalanceCard(Size size) {
    return _buildGlassContainer(
      padding: const EdgeInsets.all(24),
      borderRadius: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Wallet Balance',
                style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF00E5FF).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '+14.8%',
                  style: TextStyle(
                    color: Color(0xFF00E5FF),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            '\$24,580.40',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildQuickActionButton(Icons.arrow_upward_rounded, 'Send'),
              _buildQuickActionButton(Icons.arrow_downward_rounded, 'Receive'),
              _buildQuickActionButton(Icons.add_rounded, 'Top Up'),
              _buildQuickActionButton(Icons.more_horiz_rounded, 'More'),
            ],
          ),
        ],
      ),
    );
  }

  // 4. KPI Grid Cards
  Widget _buildKpiGrid() {
    return Row(
      children: [
        Expanded(
          child: _buildKpiCard(
            title: 'Revenue',
            value: '\$8,420',
            icon: Icons.show_chart_rounded,
            iconColor: const Color(0xFFE040FB),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _buildKpiCard(
            title: 'Expenses',
            value: '\$2,150',
            icon: Icons.shopping_bag_outlined,
            iconColor: const Color(0xFF00E5FF),
          ),
        ),
      ],
    );
  }

  Widget _buildKpiCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
  }) {
    return _buildGlassContainer(
      padding: const EdgeInsets.all(16),
      borderRadius: 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: iconColor.withOpacity(0.2),
            radius: 18,
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(height: 16),
          Text(title, style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // 5. Activity List
  Widget _buildActivityList() {
    final List<Map<String, dynamic>> items = [
      {'title': 'Figma Subscription', 'date': 'Today, 2:30 PM', 'amount': '-\$15.00', 'icon': Icons.design_services_rounded, 'color': Colors.purpleAccent},
      {'title': 'Client Payment', 'date': 'Yesterday', 'amount': '+\$1,250.00', 'icon': Icons.attach_money_rounded, 'color': Colors.greenAccent},
      {'title': 'Apple Store Purchase', 'date': '02 Aug 2026', 'amount': '-\$299.00', 'icon': Icons.apple_rounded, 'color': Colors.cyanAccent},
    ];

    return Column(
      children: items.map((item) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: _buildGlassContainer(
            padding: const EdgeInsets.all(14),
            borderRadius: 16,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: (item['color'] as Color).withOpacity(0.2),
                  child: Icon(item['icon'], color: item['color'], size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['title'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14)),
                      const SizedBox(height: 2),
                      Text(item['date'], style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 11)),
                    ],
                  ),
                ),
                Text(
                  item['amount'],
                  style: TextStyle(
                    color: item['amount'].toString().startsWith('+') ? Colors.greenAccent : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // Reusable Glass Container Builder
  Widget _buildGlassContainer({
    required Widget child,
    required EdgeInsetsGeometry padding,
    required double borderRadius,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16.0, sigmaY: 16.0),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.07),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: Colors.white.withOpacity(0.18),
              width: 1.0,
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildGlassIconButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: _buildGlassContainer(
        padding: const EdgeInsets.all(10),
        borderRadius: 12,
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _buildQuickActionButton(IconData icon, String label) {
    return Column(
      children: [
        _buildGlassContainer(
          padding: const EdgeInsets.all(12),
          borderRadius: 14,
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        const SizedBox(height: 6),
        Text(label, style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 11)),
      ],
    );
  }
}