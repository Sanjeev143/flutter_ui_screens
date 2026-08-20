import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;

void main() {
  runApp(const PastelAiApp());
}

class PastelAiApp extends StatelessWidget {
  const PastelAiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Assistant',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'sans-serif',
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF3EAEF),
      ),
      home: const OnboardingScreen(),
    );
  }
}

// ---------------------------------------------------------
// 1. ANIMATED LIQUID BACKGROUND WIDGET
// ---------------------------------------------------------
class AnimatedLiquidBackground extends StatefulWidget {
  final Widget child;
  const AnimatedLiquidBackground({super.key, required this.child});

  @override
  State<AnimatedLiquidBackground> createState() => _AnimatedLiquidBackgroundState();
}

class _AnimatedLiquidBackgroundState extends State<AnimatedLiquidBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 10))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double val = _controller.value;
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.lerp(const Color(0xFFFCE7F3), const Color(0xFFE9D5FF), val)!,
                Color.lerp(const Color(0xFFE9D5FF), const Color(0xFFFBCFE8), val)!,
                const Color(0xFFF3EAEF),
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: -80 + (val * 40),
                right: -50 + (math.sin(val * math.pi) * 30),
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [Colors.pinkAccent.withOpacity(0.35), Colors.purple.withOpacity(0.05)],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: -100 + (val * 50),
                left: -60 - (math.cos(val * math.pi) * 30),
                child: Container(
                  width: 350,
                  height: 350,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [Colors.deepPurpleAccent.withOpacity(0.3), Colors.pink.withOpacity(0.05)],
                    ),
                  ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: Container(color: Colors.transparent),
              ),
              widget.child,
            ],
          ),
        );
      },
    );
  }
}

// ---------------------------------------------------------
// 2. ONBOARDING SCREEN
// ---------------------------------------------------------
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedLiquidBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87)),
                const Spacer(flex: 3),
                const Text(
                  'ONE\nASSISTANT.\nMANY WAYS\nTO HELP\nAMAZEVALLEY',
                  style: TextStyle(fontSize: 38, fontWeight: FontWeight.w900, height: 1.1, color: Color(0xFF1F1E24), letterSpacing: -0.5),
                ),
                const Spacer(flex: 2),
                ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: Colors.white.withOpacity(0.9), width: 1.5),
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.black,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const MainNavigationShell()),
                          );
                        },
                        child: const Text('Get Started', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// 3. MAIN NAVIGATION SHELL
// ---------------------------------------------------------
class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardTab(),
    const ChatHubTab(),
    const FavoritesTab(),
    const ProfileTab(),
  ];

  void _openMicVisualizer() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AudioVisualizerModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedLiquidBackground(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(child: _screens[_currentIndex]),

              // Bottom Liquid Glass Bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(36),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.45),
                        borderRadius: BorderRadius.circular(36),
                        border: Border.all(color: Colors.white.withOpacity(0.8), width: 1.5),
                        boxShadow: [
                          BoxShadow(color: Colors.purple.withOpacity(0.08), blurRadius: 15, offset: const Offset(0, 8)),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            icon: Icon(Icons.home_filled, color: _currentIndex == 0 ? Colors.black : Colors.black45),
                            onPressed: () => setState(() => _currentIndex = 0),
                          ),
                          IconButton(
                            icon: Icon(Icons.chat_bubble_outline, color: _currentIndex == 1 ? Colors.black : Colors.black45),
                            onPressed: () => setState(() => _currentIndex = 1),
                          ),
                          IconButton(
                            icon: Icon(Icons.favorite_border, color: _currentIndex == 2 ? Colors.black : Colors.black45),
                            onPressed: () => setState(() => _currentIndex = 2),
                          ),
                          IconButton(
                            icon: Icon(Icons.person_outline, color: _currentIndex == 3 ? Colors.black : Colors.black45),
                            onPressed: () => setState(() => _currentIndex = 3),
                          ),
                          GestureDetector(
                            onTap: _openMicVisualizer,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                shape: BoxShape.circle,
                                boxShadow: [BoxShadow(color: Colors.pink.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4))],
                              ),
                              child: const Icon(Icons.mic_none_rounded, color: Colors.black87, size: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// 4. DASHBOARD TAB
// ---------------------------------------------------------
class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  void _navigateToChat(BuildContext context, String topic, List<Map<String, String>> initialMessages) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(topic: topic, messages: initialMessages)));
  }

  void _openFeatureMenu(BuildContext context, String featureName) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MenuOptionScreen(featureName: featureName)));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87)),
              Row(
                children: [
                  const CircleAvatar(radius: 18, backgroundImage: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80')),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Amaze Valley', style: TextStyle(fontWeight:
                      FontWeight
                          .bold, fontSize: 13, color: Colors.black87)),
                      Text('How can I help you today?', style: TextStyle(fontSize: 11, color: Colors.black54)),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.5), shape: BoxShape.circle),
                child: const Icon(Icons.notifications_none, size: 18, color: Colors.black87),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(color: Colors.white.withOpacity(0.7), width: 1.5),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Unlock Pro\nFeatures', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87, height: 1.1)),
                              SizedBox(height: 8),
                              Text('Work faster, smarter,\nand more efficiently\nwith full AI access.', style: TextStyle(fontSize: 12, color: Colors.black54, height: 1.3)),
                            ],
                          ),
                        ),
                        const Icon(Icons.diamond_rounded, color: Colors.purple, size: 64),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 115,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildLiquidFeatureCard('Translation', Icons.auto_awesome, () => _openFeatureMenu(context, 'Translation')),
                    const SizedBox(width: 12),
                    _buildLiquidFeatureCard('Coding', Icons.code, () => _openFeatureMenu(context, 'Coding')),
                    const SizedBox(width: 12),
                    _buildLiquidFeatureCard('Finding info', Icons.chat_bubble_outline, () => _openFeatureMenu(context, 'Finding info')),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                  Text('View all', style: TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () => _navigateToChat(context, 'Travel', [
                  {'sender': 'user', 'text': 'Hi, can you suggest a good weekend trip near the city?'},
                  {'sender': 'ai', 'text': 'Of course! Do you prefer nature, sightseeing, or relaxing places?'},
                ]),
                child: _buildLiquidHistoryCard(title: 'Travel', subtitle: 'Hi, can you suggest a good weekend trip...'),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () => _navigateToChat(context, 'Productivity', [
                  {'sender': 'user', 'text': 'Hi, can you help me organize my day?'},
                  {'sender': 'ai', 'text': 'I would love to! Let us schedule your high-priority tasks.'},
                ]),
                child: _buildLiquidHistoryCard(title: 'Productivity', subtitle: 'Hi, can you help me organize my day?...'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLiquidFeatureCard(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            width: 100,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.35),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: Colors.white.withOpacity(0.7), width: 1.2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.purple.withOpacity(0.1), borderRadius: BorderRadius.circular(14)),
                  child: Icon(icon, color: Colors.purple, size: 20),
                ),
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLiquidHistoryCard({required String title, required String subtitle}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.35),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: Colors.white.withOpacity(0.7), width: 1.2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
              const SizedBox(height: 6),
              Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.black54)),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// 5. CHAT HUB TAB (Active Chats - Clicking opens chat screen)
// ---------------------------------------------------------
class ChatHubTab extends StatelessWidget {
  const ChatHubTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> activeChats = [// total 3 chat convo
      {
        'title': 'Travel Planning',
        'subtitle': 'Last active: Today, 2:15 PM',
        'messages': [
          {'sender': 'user', 'text': 'Can you plan a 2-day weekend trip?'},
          {'sender': 'ai', 'text': 'Certainly! Are you looking for mountains or beach resorts?'},
          {'sender': 'user', 'text': 'A quiet mountain cabin would be wonderful.'},
          {'sender': 'ai', 'text': 'I found 3 luxury cabins with scenic mountain views.'},
          {'sender': 'user', 'text': 'Please check availability for next weekend.'},
          {'sender': 'ai', 'text': 'Cabin #2 is available! Shall I confirm the reservation?'},
        ]
      },
      {
        'title': 'Daily Productivity & Tasks',
        'subtitle': 'Last active: Yesterday',
        'messages': [
          {'sender': 'user', 'text': 'Hi, can you help me organize my day?'},
          {'sender': 'ai', 'text': 'I would love to! Let us schedule your high-priority tasks in the morning.'},
          {'sender': 'user', 'text': 'What about my 3:00 PM meeting?'},
          {'sender': 'ai', 'text': 'Your product presentation meeting is locked in with all stakeholders.'},
          {'sender': 'user', 'text': 'Please set a reminder 15 minutes prior.'},
          {'sender': 'ai', 'text': 'Reminder set successfully for 2:45 PM!'},
        ]
      },
      {
        'title': 'Code Architecture & Flutter',
        'subtitle': 'Last active: 3 days ago',
        'messages': [
          {'sender': 'user', 'text': 'How do I optimize state management in Flutter?'},
          {'sender': 'ai', 'text': 'Riverpod or Bloc are excellent choices depending on your scalability needs.'},
          {'sender': 'user', 'text': 'Let us use Riverpod with immutable state.'},
          {'sender': 'ai', 'text': 'Great choice! NotifierProvider works seamlessly for clean architecture.'},
          {'sender': 'user', 'text': 'Can you generate a sample provider class?'},
          {'sender': 'ai', 'text': 'Here is your clean Riverpod controller implementation code.'},
        ]
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Active Chats', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 4),
          const Text('Tap any active chat session to continue conversation', style: TextStyle(fontSize: 12, color: Colors.black54)),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: activeChats.length,
              itemBuilder: (context, index) {
                final chat = activeChats[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            topic: chat['title'],
                            messages: List<Map<String, String>>.from(chat['messages']),
                          ),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.35),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white.withOpacity(0.7)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(chat['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87)),
                                  const SizedBox(height: 4),
                                  Text(chat['subtitle']!, style: const TextStyle(fontSize: 11, color: Colors.black54)),
                                ],
                              ),
                              const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.black54),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// 6. FAVORITES TAB
// ---------------------------------------------------------
class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> favoriteChats = [
      {
        'title': 'Cappadocia Weekend Itinerary',
        'category': 'Travel',
        'date': 'Aug 18, 2026',
        'messages': [
          {'sender': 'user', 'text': 'Can you plan a 2-day weekend trip to Cappadocia?'},
          {'sender': 'ai', 'text': 'Absolutely! Cappadocia is famous for its unique rock formations and hot air balloons.'},
          {'sender': 'user', 'text': 'What is the best time for the balloon ride?'},
          {'sender': 'ai', 'text': 'Early morning right at sunrise offers the most breathtaking views.'},
          {'sender': 'user', 'text': 'Which cave hotel do you recommend?'},
          {'sender': 'ai', 'text': 'Museum Hotel or Argos in Cappadocia are top-tier luxury choices.'},
          {'sender': 'user', 'text': 'Great, please book the sunset ATV tour as well.'},
          {'sender': 'ai', 'text': 'All set! ATV tour confirmed for Saturday at 5:00 PM.'},
        ]
      },
      {
        'title': 'Flutter Glassmorphism Snippet',
        'category': 'Coding',
        'date': 'Aug 17, 2026',
        'messages': [
          {'sender': 'user', 'text': 'How do I create true glassmorphism in Flutter?'},
          {'sender': 'ai', 'text': 'You can combine BackdropFilter with ImageFilter.blur and a semi-transparent white container.'},
          {'sender': 'user', 'text': 'What about the border stroke?'},
          {'sender': 'ai', 'text': 'Use a subtle white border with opacity around 0.7 for the glowing glass edge effect.'},
          {'sender': 'user', 'text': 'Can I add shadows too?'},
          {'sender': 'ai', 'text': 'Yes, adding soft pastel drop shadows gives it a floating 3D depth.'},
          {'sender': 'user', 'text': 'Can you generate the code snippet?'},
          {'sender': 'ai', 'text': 'Here is the complete ClipRRect and BackdropFilter implementation!'},
        ]
      },
      {
        'title': 'Q3 Financial Portfolio Review',
        'category': 'Productivity',
        'date': 'Aug 15, 2026',
        'messages': [
          {'sender': 'user', 'text': 'Can we review my Q3 investment portfolio?'},
          {'sender': 'ai', 'text': 'Of course. Let us look at your asset allocation across tech and index funds.'},
          {'sender': 'user', 'text': 'How did tech stocks perform?'},
          {'sender': 'ai', 'text': 'Tech equities grew by 14.2% this quarter, outperforming average benchmarks.'},
          {'sender': 'user', 'text': 'Should I rebalance into bonds?'},
          {'sender': 'ai', 'text': 'Given current market volatility, shifting 10% into treasury bonds is advised.'},
          {'sender': 'user', 'text': 'Please generate the final report.'},
          {'sender': 'ai', 'text': 'Financial summary report compiled and saved to your profile.'},
        ]
      },
      {
        'title': 'French Translation Phrasebook',
        'category': 'Translation',
        'date': 'Aug 12, 2026',
        'messages': [
          {'sender': 'user', 'text': 'Translate "Where is the nearest cafe?" into French.'},
          {'sender': 'ai', 'text': '"Où est le café le plus proche?"'},
          {'sender': 'user', 'text': 'How do I say "Thank you very much"?'},
          {'sender': 'ai', 'text': '"Merci beaucoup!"'},
          {'sender': 'user', 'text': 'What about "I would like a croissant please"?'},
          {'sender': 'ai', 'text': '"Je voudrais un croissant, s\'il vous plaît."'},
          {'sender': 'user', 'text': 'Perfect, save these to my phrasebook.'},
          {'sender': 'ai', 'text': 'Saved successfully to your translation favorites!'},
        ]
      },
      {
        'title': 'Healthy Meal Prep Weekly Plan',
        'category': 'Health & Fitness',
        'date': 'Aug 10, 2026',
        'messages': [
          {'sender': 'user', 'text': 'Give me a high-protein meal prep plan for the week.'},
          {'sender': 'ai', 'text': 'Certainly! We can focus on grilled chicken, quinoa, and roasted vegetables.'},
          {'sender': 'user', 'text': 'What about breakfasts?'},
          {'sender': 'ai', 'text': 'Overnight oats with chia seeds and Greek yogurt work great.'},
          {'sender': 'user', 'text': 'Can you keep it under 2,000 calories daily?'},
          {'sender': 'ai', 'text': 'Yes, portion controls are optimized for 1,850 calories per day.'},
          {'sender': 'user', 'text': 'Please add grocery items to my shopping list.'},
          {'sender': 'ai', 'text': 'All ingredients added to your grocery assistant!'},
        ]
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Selected & Saved Chats', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 4),
          const Text('Tap any chat to open full conversation', style: TextStyle(fontSize: 12, color: Colors.black54)),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: favoriteChats.length,
              itemBuilder: (context, index) {
                final chat = favoriteChats[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            topic: chat['title'],
                            messages: List<Map<String, String>>.from(chat['messages']),
                          ),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.35),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white.withOpacity(0.7)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(color: Colors.pink.withOpacity(0.15), shape: BoxShape.circle),
                                child: const Icon(Icons.favorite, color: Colors.pinkAccent, size: 18),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(chat['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(chat['category']!, style: const TextStyle(fontSize: 11, color: Colors.purple, fontWeight: FontWeight.w600)),
                                        const Text(' • ', style: TextStyle(color: Colors.black45)),
                                        Text(chat['date']!, style: const TextStyle(fontSize: 11, color: Colors.black54)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.chevron_right, size: 16, color: Colors.black54),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// 7. PROFILE TAB
// ---------------------------------------------------------
class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: [
          const SizedBox(height: 10),
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=300&q=80'),
                ),
                const SizedBox(height: 12),
                const Text('Amazevalley', style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.bold, color: Colors.black87)),
                const Text('amazevalley@gmail.com', style: TextStyle(fontSize:
                12, color: Colors.black54)),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(color: Colors.purple.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
                  child: const Text('Pro Member Tier 2', style: TextStyle(fontSize: 11, color: Colors.purple, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('Usage Statistics', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 10),
          Row(
            children: [
              _statCard('Prompts Run', '1,284'),
              const SizedBox(width: 12),
              _statCard('Hours Saved', '48.5h'),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Preferences & Settings', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87)),
          const SizedBox(height: 10),
          _profileOptionTile(Icons.settings_outlined, 'App Customization'),
          const SizedBox(height: 10),
          _profileOptionTile(Icons.security_outlined, 'Security & FaceID'),
          const SizedBox(height: 10),
          _profileOptionTile(Icons.language_outlined, 'Language (English - US)'),
          const SizedBox(height: 10),
          _profileOptionTile(Icons.help_outline_rounded, 'Help & Support Center'),
        ],
      ),
    );
  }

  Widget _statCard(String title, String value) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.35),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white.withOpacity(0.7)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                const SizedBox(height: 4),
                Text(title, style: const TextStyle(fontSize: 11, color: Colors.black54)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _profileOptionTile(IconData icon, String title) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.35),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white.withOpacity(0.7)),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.purple, size: 20),
              const SizedBox(width: 14),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
              const Spacer(),
              const Icon(Icons.chevron_right, size: 16, color: Colors.black54),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// 8. MIC ICON - AUDIO VISUALIZER MODAL
// ---------------------------------------------------------
class AudioVisualizerModal extends StatefulWidget {
  const AudioVisualizerModal({super.key});

  @override
  State<AudioVisualizerModal> createState() => _AudioVisualizerModalState();
}

class _AudioVisualizerModalState extends State<AudioVisualizerModal> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 10))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.45,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
            border: Border.all(color: Colors.white.withOpacity(0.8), width: 1.5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Listening...', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.7), shape: BoxShape.circle),
                      child: const Icon(Icons.close, size: 18, color: Colors.black87),
                    ),
                  ),
                ],
              ),
              const Text('Speak now, Amazevalley is listening...', style:
              TextStyle(fontSize: 13, color: Colors.black54)),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(12, (index) {
                      double wave = math.sin((_controller.value * 2 * math.pi) + (index * 0.5)).abs();
                      double height = 20 + (wave * 60);
                      return Container(
                        width: 6,
                        height: height,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: Colors.purple.withOpacity(0.7 + (wave * 0.3)),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  );
                },
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.purple.withOpacity(0.2), blurRadius: 15, spreadRadius: 2)],
                ),
                child: const Icon(Icons.mic, color: Colors.purple, size: 28),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// 9. CHAT SCREEN & MENU SCREEN
// ---------------------------------------------------------
class ChatScreen extends StatefulWidget {
  final String topic;
  final List<Map<String, String>> messages;
  const ChatScreen({super.key, required this.topic, required this.messages});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late List<Map<String, String>> _currentMessages;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentMessages = List.from(widget.messages);
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _currentMessages.add({'sender': 'user', 'text': _controller.text});
      String userQuery = _controller.text;
      _controller.clear();
      Future.delayed(const Duration(milliseconds: 600), () {
        setState(() {
          _currentMessages.add({'sender': 'ai', 'text': 'I have processed your request regarding "$userQuery".'});
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedLiquidBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.5), shape: BoxShape.circle),
                        child: const Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.black87),
                      ),
                    ),
                    Text(widget.topic, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87)),
                    const Icon(Icons.bookmark_border, size: 18, color: Colors.black87),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _currentMessages.length,
                  itemBuilder: (context, index) {
                    final msg = _currentMessages[index];
                    final isUser = msg['sender'] == 'user';
                    return Align(
                      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                            decoration: BoxDecoration(
                              color: isUser ? Colors.white.withOpacity(0.7) : Colors.white.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white.withOpacity(0.7)),
                            ),
                            child: Text(msg['text']!, style: const TextStyle(color: Colors.black87, fontSize: 13, height: 1.3)),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.45),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: Colors.white.withOpacity(0.8), width: 1.5),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              onSubmitted: (_) => _sendMessage(),
                              decoration: const InputDecoration(hintText: 'Your message...', border: InputBorder.none),
                            ),
                          ),
                          GestureDetector(
                            onTap: _sendMessage,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(color: Colors.white.withOpacity(0.8), shape: BoxShape.circle),
                              child: const Icon(Icons.send, color: Colors.black87, size: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuOptionScreen extends StatelessWidget {
  final String featureName;
  const MenuOptionScreen({super.key, required this.featureName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedLiquidBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.5), shape: BoxShape.circle),
                    child: const Icon(Icons.arrow_back_ios_new, size: 16, color: Colors.black87),
                  ),
                ),
                const SizedBox(height: 20),
                Text('Advanced $featureName Hub', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
                const SizedBox(height: 10),
                const Text('Configure parameters and let Amazevalley AI assist '
                    'you.', style: TextStyle(color: Colors.black54)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// FOR FULL SOURCE CODE PLEASE CONTACT ON AMAZEVALLEY@GMAIL.COM....HAPPY
/// CODING!!!!