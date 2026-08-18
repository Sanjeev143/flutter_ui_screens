import 'package:flutter/material.dart';

void main() {
  runApp(const LuxoraApp());
}

class LuxoraApp extends StatelessWidget {
  const LuxoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Luxora',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'serif',
        scaffoldBackgroundColor: const Color(0xFFF9F6F0),
      ),
      home: const IntroScreen(),
    );
  }
}

// 1. Intro / Onboarding Screen
class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image (Resembling Luxury Resort Sunset)
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=1000&q=80',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Dark Gradient Overlay for Readability
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.85),
                ],
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  // Logo Monogram
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFD4AF37), width: 1.5),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.hotel, color: Color(0xFFD4AF37), size: 24),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'LUXORA',
                    style: TextStyle(
                      fontFamily: 'serif',
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 4,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  // Tagline & Description
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Luxury stays,\neffortlessly booked.',
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Handpicked hotels. Unforgettable journeys.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Get Started Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC59B27),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      },
                      child: const Text(
                        'Get Started',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Page Indicator Dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFFC59B27), shape: BoxShape.circle)),
                      const SizedBox(width: 6),
                      Container(width: 6, height: 6, decoration: BoxDecoration(color: Colors.white.withOpacity(0.4), shape: BoxShape.circle)),
                      const SizedBox(width: 6),
                      Container(width: 6, height: 6, decoration: BoxDecoration(color: Colors.white.withOpacity(0.4), shape: BoxShape.circle)),
                      const SizedBox(width: 6),
                      Container(width: 6, height: 6, decoration: BoxDecoration(color: Colors.white.withOpacity(0.4), shape: BoxShape.circle)),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 2. Login Screen
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF8F3),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Image Header with Back Button
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=1000&q=80',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 250,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, const Color(0xFFFBF8F3)],
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.8),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black87),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Form Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome back',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1F1F1F)),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Sign in to continue your journey',
                    style: TextStyle(fontSize: 14, color: Color(0xFF757575)),
                  ),
                  const SizedBox(height: 24),
                  // Email TextField
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Email address',
                      hintStyle: const TextStyle(color: Color(0xFF9E9E9E), fontSize: 14),
                      prefixIcon: const Icon(Icons.mail_outline, color: Color(0xFF9E9E9E)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Password TextField
                  TextField(
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: const TextStyle(color: Color(0xFF9E9E9E), fontSize: 14),
                      prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF9E9E9E)),
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: const Color(0xFF9E9E9E)),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Forgot password?', style: TextStyle(color: Color(0xFF8B6B23), fontSize: 13, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Sign In Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF382914),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeDashboardScreen()),
                        );
                      },
                      child: const Text('Sign In', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Divider
                  Row(
                    children: const [
                      Expanded(child: Divider(color: Color(0xFFE0E0E0))),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('or continue with', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 12)),
                      ),
                      Expanded(child: Divider(color: Color(0xFFE0E0E0))),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Social Login Buttons
                  _socialButton('Continue with Apple', Icons.apple, Colors.black),
                  const SizedBox(height: 12),
                  _socialButton('Continue with Google', Icons.g_mobiledata, Colors.red[700]!),
                  const SizedBox(height: 30),
                  // Footer link to Signup
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?", style: TextStyle(color: Color(0xFF757575), fontSize: 13)),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SignupScreen()),
                          );
                        },
                        child: const Text('Sign up', style: TextStyle(color: Color(0xFF8B6B23), fontWeight: FontWeight.bold, fontSize: 13)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _socialButton(String text, IconData icon, Color iconColor) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF333333))),
        ],
      ),
    );
  }
}

// 3. Create Account Screen
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscurePassword = true;
  bool _termsAgreed = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF8F3),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Image Header with Back Button
            Stack(
              children: [
                Container(
                  height: 220,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=1000&q=80',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 220,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, const Color(0xFFFBF8F3)],
                    ),
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.8),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black87),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Form Content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Create your\naccount',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1F1F1F), height: 1.2),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Start your journey to extraordinary stays',
                    style: TextStyle(fontSize: 14, color: Color(0xFF757575)),
                  ),
                  const SizedBox(height: 20),
                  // Full Name
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Full name',
                      hintStyle: const TextStyle(color: Color(0xFF9E9E9E), fontSize: 14),
                      prefixIcon: const Icon(Icons.person_outline, color: Color(0xFF9E9E9E)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Email
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Email address',
                      hintStyle: const TextStyle(color: Color(0xFF9E9E9E), fontSize: 14),
                      prefixIcon: const Icon(Icons.mail_outline, color: Color(0xFF9E9E9E)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Password
                  TextField(
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: const TextStyle(color: Color(0xFF9E9E9E), fontSize: 14),
                      prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF9E9E9E)),
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility, color: const Color(0xFF9E9E9E)),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Phone Number Input with Country Code
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 12),
                        const Icon(Icons.phone_outlined, color: Color(0xFF9E9E9E), size: 20),
                        const SizedBox(width: 8),
                        const Text('+62', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        const Icon(Icons.arrow_drop_down, color: Color(0xFF9E9E9E)),
                        Container(height: 24, width: 1, color: const Color(0xFFE0E0E0), margin: const EdgeInsets.symmetric(horizontal: 8)),
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Phone number',
                              hintStyle: TextStyle(color: Color(0xFF9E9E9E), fontSize: 14),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Terms Agreement Checkbox text
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                        width: 20,
                        child: Checkbox(
                          value: _termsAgreed,
                          activeColor: const Color(0xFF382914),
                          onChanged: (val) => setState(() => _termsAgreed = val ?? true),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: 'I agree to the ',
                            style: const TextStyle(fontSize: 11, color: Color(0xFF757575)),
                            children: [
                              TextSpan(text: 'Terms of Service', style: TextStyle(color: Colors.brown.shade800, decoration: TextDecoration.underline)),
                              const TextSpan(text: ' and '),
                              TextSpan(text: 'Privacy Policy', style: TextStyle(color: Colors.brown.shade800, decoration: TextDecoration.underline)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Create Account Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF382914),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      onPressed: () {},
                      child: const Text('Create Account', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Divider
                  Row(
                    children: const [
                      Expanded(child: Divider(color: Color(0xFFE0E0E0))),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text('or continue with', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 12)),
                      ),
                      Expanded(child: Divider(color: Color(0xFFE0E0E0))),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Social Login Buttons
                  _socialButton('Continue with Apple', Icons.apple, Colors.black),
                  const SizedBox(height: 10),
                  _socialButton('Continue with Google', Icons.g_mobiledata, Colors.red[700]!),
                  const SizedBox(height: 20),
                  // Footer Link to Sign In
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already have an account?', style: TextStyle(color: Color(0xFF757575), fontSize: 13)),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Sign in', style: TextStyle(color: Color(0xFF8B6B23), fontWeight: FontWeight.bold, fontSize: 13)),
                      ),
                    ],
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

  Widget _socialButton(String text, IconData icon, Color iconColor) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF333333))),
        ],
      ),
    );
  }
}

// 3. Home Dashboard Screen (Screen 1 from your new images)
// 3. Home Dashboard Screen with 25 Hotels List
class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF8F3),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80'),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: const Color(0xFFE5E5E5))),
                        child: const Icon(Icons.search, size: 20, color: Colors.black87),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: const Color(0xFFE5E5E5))),
                        child: const Icon(Icons.notifications_none, size: 20, color: Colors.black87),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Book Your\nPerfect Stay!',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1F1F1F), height: 1.2),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  _categoryTab('Hotels', Icons.hotel, true),
                  const SizedBox(width: 10),
                  _categoryTab('Flights', Icons.flight, false),
                  const SizedBox(width: 10),
                  _categoryTab('Rental', Icons.car_rental, false),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // ListView with 25 Hotels
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                itemCount: kLuxoraHotels.length,
                itemBuilder: (context, index) {
                  final hotel = kLuxoraHotels[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HotelDetailScreen(hotel: hotel)),
                        );
                      },
                      child: Container(
                        height: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(hotel.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.transparent, Colors.black.withOpacity(0.75)],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 16,
                              right: 16,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 16,
                                    backgroundColor: Colors.white.withOpacity(0.3),
                                    child: const Icon(Icons.share, color: Colors.white, size: 14),
                                  ),
                                  const SizedBox(width: 8),
                                  CircleAvatar(
                                    radius: 16,
                                    backgroundColor: Colors.white.withOpacity(0.3),
                                    child: const Icon(Icons.favorite_border, color: Colors.white, size: 14),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(hotel.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on, color: Colors.white70, size: 14),
                                      const SizedBox(width: 4),
                                      Text(hotel.location, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                                    ],
                                  ),
                                  const SizedBox(height: 14),
                                  Row(
                                    children: [
                                      _infoBadge('\$${hotel.price.toInt()}', Icons.attach_money),
                                      const SizedBox(width: 6),
                                      _infoBadge(hotel.rating.toString(), Icons.star, iconColor: Colors.amber),
                                      const SizedBox(width: 6),
                                      _infoBadge('${hotel.beds} bed', Icons.bed),
                                      const SizedBox(width: 6),
                                      _infoBadge('${hotel.guests} Guest', Icons.person_outline),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryTab(String title, IconData icon, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.black87 : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: isSelected ? Colors.white : Colors.black87),
          const SizedBox(width: 6),
          Text(title, style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: FontWeight.w600, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _infoBadge(String text, IconData icon, {Color? iconColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, size: 12, color: iconColor ?? Colors.white),
          const SizedBox(width: 4),
          Text(text, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class Hotel {
  final String name;
  final String location;
  final double price;
  final double rating;
  final int beds;
  final int guests;
  final String imageUrl;
  final String description;

  const Hotel({
    required this.name,
    required this.location,
    required this.price,
    required this.rating,
    required this.beds,
    required this.guests,
    required this.imageUrl,
    required this.description,
  });
}

// List of 25 Handpicked Luxury Hotels
final List<Hotel> kLuxoraHotels = List.generate(25, (index) {
  final names = [
    'Mandarin', 'Kimpton', 'Riverside Grand', 'The Ritz-Carlton', 'Amanpuri',
    'Capella', 'Four Seasons', 'Rosewood', 'St. Regis', 'Waldorf Astoria',
    'Six Senses', 'Banyan Tree', 'InterContinental', 'Shangri-La', 'Fairmont',
    'The Peninsula', 'Mandarin Oriental', 'Park Hyatt', 'Conrad', 'Sofitel',
    'JW Marriott', 'W Hotel', 'Raffles', 'Edition', 'Grand Hyatt'
  ];
  final locations = [
    'Bangkok, Thailand', 'Bali, Indonesia', 'Paris, France', 'Maldives', 'Kyoto, Japan',
    'Santorini, Greece', 'Phuket, Thailand', 'Dubai, UAE', 'Zurich, Switzerland', 'Maui, Hawaii'
  ];
  final images = [
    'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=1000&q=80',
    'https://images.unsplash.com/photo-1591088398332-8a7791972843?auto=format&fit=crop&w=1000&q=80',
    'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=1000&q=80',
    'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&w=1000&q=80',
    'https://images.unsplash.com/photo-1571896349842-33c89424de2d?auto=format&fit=crop&w=1000&q=80',
  ];

  return Hotel(
    name: names[index % names.length],
    location: locations[index % locations.length],
    price: 85.0 + (index * 15),
    rating: 4.5 + ((index % 5) * 0.1),
    beds: (index % 3) + 1,
    guests: (index % 4) + 2,
    imageUrl: images[index % images.length],
    description: '${names[index % names.length]} offers world-class luxury stays, breathtaking panoramic views, exquisite dining experiences, and an unmatched serene atmosphere for your ultimate getaway.',
  );
});

// 4. Hotel Details Screen
class HotelDetailScreen extends StatelessWidget {
  final Hotel hotel;
  const HotelDetailScreen({super.key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 380,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(hotel.imageUrl),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.8),
                              child: IconButton(
                                icon: const Icon(Icons.arrow_back, color: Colors.black87),
                                onPressed: () => Navigator.pop(context),
                              ),
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white.withOpacity(0.8),
                                  child: const Icon(Icons.ios_share, color: Colors.black87, size: 18),
                                ),
                                const SizedBox(width: 10),
                                CircleAvatar(
                                  backgroundColor: Colors.white.withOpacity(0.8),
                                  child: const Icon(Icons.tune, color: Colors.black87, size: 18),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      left: 24,
                      right: 24,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(hotel.name, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const CircleAvatar(radius: 12, backgroundImage: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=100&q=80')),
                              const SizedBox(width: 8),
                              Text('${hotel.rating} (${hotel.beds * 2}k+ reviews)', style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Popular Amenities', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1F1F1F))),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _amenityBadge('${hotel.beds} Beds', Icons.bed_outlined),
                          _amenityBadge('HDTV', Icons.tv_outlined),
                          _amenityBadge('Free WiFi', Icons.wifi),
                          _amenityBadge('Bathtub', Icons.bathtub_outlined),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Text('Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1F1F1F))),
                      const SizedBox(height: 8),
                      Text(
                        hotel.description,
                        style: const TextStyle(color: Color(0xFF757575), fontSize: 13, height: 1.5),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Color(0xFFE5E5E5))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\$${hotel.price.toInt()}/ night', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1F1F1F))),
                  SizedBox(
                    width: 180,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF382914),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      onPressed: () {},
                      child: const Text('Book Now', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
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

  Widget _amenityBadge(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.black87),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF333333))),
        ],
      ),
    );
  }
}