import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(const BankingApp());
}

class BankingApp extends StatelessWidget {
  const BankingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Finance App',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const MainShellScreen(),
    );
  }
}

// ==========================================
// MAIN SHELL WITH BOTTOM NAVIGATION
// ==========================================
class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const CardScreen(),
    const AnalyticsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.credit_card), label: 'Cards'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), label: 'Analytics'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

// ==========================================
// 1. HOME SCREEN
// ==========================================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Welcome back,', style: TextStyle(color: Colors.grey, fontSize: 13)),
                      Text('Amazevalley', style: TextStyle(fontWeight:
                      FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.notifications_none_rounded),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Total Balance
          const Text('Total Balance', style: TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(height: 4),
          Row(
            children: const [
              Text('\$24,850.75', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              SizedBox(width: 8),
              Icon(Icons.remove_red_eye_outlined, color: Colors.grey, size: 20),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: const [
              Icon(Icons.arrow_upward, color: Colors.green, size: 14),
              Text('+12.5%', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
              Text(' from last month', style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 20),

          // VISA Card Widget
          _cardView('••••  ••••  ••••  4242'),
          const SizedBox(height: 20),

          // Quick Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildActionButton(context, Icons.arrow_upward, 'Send', () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SendMoneyScreen()));
              }),
              _buildActionButton(context, Icons.arrow_downward, 'Receive', () {}),
              _buildActionButton(context, Icons.receipt_long, 'Pay Bills', () {}),
              _buildActionButton(context, Icons.more_horiz, 'More', () {}),
            ],
          ),
          const SizedBox(height: 25),

          // Recent Transactions Section Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Recent Transactions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              GestureDetector(
                onTap: () {},
                child: const Text('See all', style: TextStyle(color: Colors.grey, fontSize: 13)),
              ),
            ],
          ),
          const SizedBox(height: 15),

          // Transactions List
          _buildTransactionItem(Icons.shopping_bag_outlined, 'Amazon Shopping', 'Today, 10:24 AM', '-\$120.50', isNegative: true),
          _buildTransactionItem(Icons.account_balance_wallet_outlined, 'Salary Received', 'May 23, 09:00 AM', '+\$4,250.00', isNegative: false),
          _buildTransactionItem(Icons.tv, 'Netflix Subscription', 'May 21, 08:40 PM', '-\$15.99', isNegative: true),
          _buildTransactionItem(Icons.music_note, 'Spotify Premium', 'May 20, 11:15 AM', '-\$9.99', isNegative: true),
        ],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: Colors.black, size: 22),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(IconData icon, String title, String subtitle, String amount, {required bool isNegative}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F0F2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 20),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: isNegative ? Colors.redAccent : Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}

// Card View

Widget _cardView(String cardNumber){
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(cardNumber, style: TextStyle(color: Colors.white, fontSize: 18, letterSpacing: 2)),
            Text('VISA', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20, fontStyle: FontStyle.italic)),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Card Holder', style: TextStyle(color: Colors.grey, fontSize: 10)),
                SizedBox(height: 2),
                Text('Amaze Valley', style: TextStyle(color: Colors
                    .white, fontWeight: FontWeight.bold, fontSize: 14)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Expires', style: TextStyle(color: Colors.grey, fontSize: 10)),
                SizedBox(height: 2),
                Text('07/16', style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold, fontSize: 14)),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

// ==========================================
// 2. ANALYTICS SCREEN
// ==========================================
class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Analytics', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
            ],
          ),
          const SizedBox(height: 15),

          // Segmented Control
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                Expanded(child: _buildSegmentButton('This Month', isSelected: true)),
                Expanded(child: _buildSegmentButton('Last Month', isSelected: false)),
                Expanded(child: _buildSegmentButton('This Year', isSelected: false)),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Spending Overview
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Spending Overview', style: TextStyle(color: Colors.grey, fontSize: 13)),
                  SizedBox(height: 4),
                  Text('\$2,745.60', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: const [
                    Text('In & Out', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    Icon(Icons.keyboard_arrow_down, size: 16),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Donut Chart
          SizedBox(
            height: 220,
            child: Stack(
              children: [
                PieChart(
                  PieChartData(
                    sectionsSpace: 4,
                    centerSpaceRadius: 65,
                    startDegreeOffset: -90,
                    sections: [
                      PieChartSectionData(color: const Color(0xFF9E86EC), value: 40, title: '40%', radius: 35, titleStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 11)),
                      PieChartSectionData(color: const Color(0xFF7CA6F8), value: 25, title: '25%', radius: 35, titleStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 11)),
                      PieChartSectionData(color: const Color(0xFFF1B761), value: 20, title: '20%', radius: 35, titleStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 11)),
                      PieChartSectionData(color: const Color(0xFF8CD8A5), value: 15, title: '15%', radius: 35, titleStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 11)),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Total', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      SizedBox(height: 2),
                      Text('\$2,745.60', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Analytics List Items
          _buildCategoryTile(const Color(0xFF9E86EC), 'Shopping', '40%', '-\$1,098.24'),
          _buildCategoryTile(const Color(0xFF7CA6F8), 'Bills & Utilities', '25%', '-\$686.40'),
          _buildCategoryTile(const Color(0xFFF1B761), 'Transport', '20%', '-\$549.12'),
          _buildCategoryTile(const Color(0xFF8CD8A5), 'Entertainment', '15%', '-\$411.84'),
        ],
      ),
    );
  }

  Widget _buildSegmentButton(String text, {required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? Colors.black : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey,
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildCategoryTile(Color color, String category, String percentage, String amount) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F2).withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(radius: 5, backgroundColor: color),
          const SizedBox(width: 12),
          Text(category, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const Spacer(),
          Text(percentage, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(width: 20),
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(width: 4),
          const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}

// ==========================================
// 3. SEND MONEY SCREEN
// ==========================================
class SendMoneyScreen extends StatelessWidget {
  const SendMoneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Send Money', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              SizedBox(
                height: 550.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Input
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F0F2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Search contact or enter number',
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                          icon: Icon(Icons.search, color: Colors.grey),
                          suffixIcon: Icon(Icons.qr_code_scanner, color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Saved Contacts Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Saved Contacts', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        GestureDetector(
                          onTap: () {},
                          child: const Text('See all', style: TextStyle(color: Colors.grey, fontSize: 12)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // Contacts Horizontal Avatar Scroll
                    SizedBox(
                      height: 70,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          _buildContactAvatar('Darshna', 'https://i.pravatar.cc/150?img=5'),
                          _buildContactAvatar('Chetan', 'https://i.pravatar.cc/150?img=12'),
                          _buildContactAvatar('Rahul', 'https://i.pravatar.cc/150?img=13'),
                          _buildContactAvatar('Parth', 'https://i.pravatar.cc/150?img=14'),
                          _buildContactAvatar('Jignesh', 'https://i.pravatar.cc/150?img=15'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Amount Input Section
                    const Center(child: Text('Enter Amount', style: TextStyle(color: Colors.grey, fontSize: 13))),
                    const SizedBox(height: 10),
                    const Center(
                      child: Text(
                        '\$350.00',
                        style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Payment Note Box
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F0F2),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          icon: Icon(Icons.link, color: Colors.grey),
                          hintText: 'Dinner payment',
                          hintStyle: TextStyle(color: Colors.black87, fontSize: 13),
                          suffixIcon: Icon(Icons.close, color: Colors.grey, size: 18),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const Spacer(),

                    // Payment Method Selector
                    const Text('Payment Method', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Amaze Valley', style: TextStyle(fontWeight:
                              FontWeight.bold, fontSize: 13)),
                              SizedBox(height: 2),
                              Text('VISA  •••• 4242', style: TextStyle(color: Colors.grey, fontSize: 12)),
                            ],
                          ),
                          const Spacer(),
                          const Text('\$24,850.75', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          const SizedBox(width: 4),
                          const Icon(Icons.chevron_right, color: Colors.grey),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Submit Button
                    ElevatedButton(
                      onPressed: () {Navigator.pop(context);},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text('Review & Send', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            ],
          )

        ),
      ),
    );
  }

  Widget _buildContactAvatar(String name, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(right: 18.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundImage: NetworkImage(imageUrl),
          ),
          const SizedBox(height: 6),
          Text(name, style: const TextStyle(fontSize: 11, color: Colors.black87)),
        ],
      ),
    );
  }
}

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
      // Total Balance
          const Text('Total Balance', style: TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(height: 4),
          Row(
            children: const [
              Text('\$24,850.75', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              SizedBox(width: 8),
              Icon(Icons.remove_red_eye_outlined, color: Colors.grey, size: 20),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: const [
              Icon(Icons.arrow_upward, color: Colors.green, size: 14),
              Text('+12.5%', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
              Text(' from last month', style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 20),

          // VISA Card Widget
          _cardView('••••  ••••  ••••  4242'),
          const SizedBox(height: 20),
          _cardView('••••  ••••  ••••  7001'),
          const SizedBox(height: 20),
          _cardView('••••  ••••  ••••  8989'),
          const SizedBox(height: 20),
          _cardView('••••  ••••  ••••  5454'),
          const SizedBox(height: 20),
          _cardView('••••  ••••  ••••  2856'),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row (Back Button & Title)
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      // color: Color(0xFFF0F4EF),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                      color: Colors.white38,
                      onPressed: () {},
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40), // Spacer to balance header title
                ],
              ),
              const SizedBox(height: 24),

              // Profile Image with Plus Badge
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 110,
                      height: 110,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFE2F3C0), // Lime green avatar background
                        image: DecorationImage(
                          image: NetworkImage('https://i.pravatar.cc/300?img=11'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                          border: Border.all(color: const Color(0xFFF9FBF8), width: 2),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // User Info
              const Center(
                child: Column(
                  children: [
                    Text(
                      'Amaze Valley',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'amazevalley@gmail.com',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Edit Profile Button
              Center(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit_outlined, size: 16, color: Colors.black87),
                  label: const Text(
                    'Edit Profile',
                    style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.6),
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // "General" Section
              _buildSectionTitle('General'),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    _buildListTile(
                      icon: Icons.home_outlined,
                      title: 'My Home',
                      onTap: () {},
                    ),
                    _buildListTile(
                      icon: Icons.battery_charging_full_outlined,
                      title: 'Connected Devices',
                      onTap: () {},
                      showDivider: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // "Preferences" Section
              _buildSectionTitle('Preferences'),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    // Dark Mode Toggle Row
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Row(
                        children: [
                          const Icon(Icons.nightlight_outlined, color: Colors.black87, size: 22),
                          const SizedBox(width: 16),
                          const Text(
                            'Dark Mode',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Switch.adaptive(
                            value: _isDarkMode,
                            activeColor: Colors.black,
                            onChanged: (value) {
                              setState(() {
                                _isDarkMode = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    _buildListTile(
                      icon: Icons.notifications_none_rounded,
                      title: 'Notifications',
                      onTap: () {},
                    ),
                    _buildListTile(
                      icon: Icons.g_translate_outlined,
                      title: 'Language',
                      onTap: () {},
                      showDivider: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget for Section Titles
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black45,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  // Helper Widget for Standard List Tiles
  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: Icon(icon, color: Colors.black87, size: 22),
          title: Text(
            title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black87),
          ),
          onTap: onTap,
        ),
        if (showDivider)
          const Divider(
            height: 1,
            indent: 54,
            endIndent: 16,
            color: Color(0xFFEFEFEF),
          ),
      ],
    );
  }
}
