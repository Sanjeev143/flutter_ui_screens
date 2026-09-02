import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const RelatelDashboardApp());
}

class RelatelDashboardApp extends StatelessWidget {
  const RelatelDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Relatel Finance Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF070709),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF3B82F6),
          surface: Color(0xFF141418),
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _selectedRoute = 'Dashboard';
  bool _isTokenOverviewExpanded = true;
  String _selectedToken = 'BNB';
  int _selectedTabIdx = 4;
  bool _isDarkMode = true;

  // Settings States
  bool _realTimePriceAlerts = true;
  bool _biometricAuth = false;
  bool _emailDigest = true;
  bool _autoCompoundStaking = true;
  bool _developerMode = false;
  String _selectedCurrency = 'USD (\$ )';
  String _selectedNode = 'Binance Smart Chain (Mainnet)';

  final List<String> _tabs = [
    'Transfers',
    'Holders',
    'Info',
    'DEX Trades',
    'Contract',
    'Analytics',
    'Cards'
  ];

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 900;

    return Scaffold(
      appBar: isMobile
          ? AppBar(
        backgroundColor: const Color(0xFF0F0F13).withOpacity(0.8),
        title: Text(_selectedRoute, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        actions: [
          IconButton(
            icon: Icon(_isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: () => setState(() => _isDarkMode = !_isDarkMode),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => _showSnackbar(context, 'No new notifications'),
          ),
        ],
      )
          : null,
      drawer: isMobile ? Drawer(backgroundColor: const Color(0xFF0F0F13), child: _buildSidebar(context)) : null,
      body: Stack(
        children: [
          // Background ambient gradient lighting for glassmorphic depth
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue.withOpacity(0.12),
              ),
            ),
          ),
          Positioned(
            bottom: -150,
            right: -100,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.purple.withOpacity(0.08),
              ),
            ),
          ),
          Row(
            children: [
              if (!isMobile)
                SizedBox(
                  width: 260,
                  child: _buildSidebar(context),
                ),
              Expanded(
                child: Column(
                  children: [
                    if (!isMobile) _buildTopHeader(context),
                    Expanded(
                      child: _buildSelectedScreenContent(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedScreenContent() {
    switch (_selectedRoute) {
      case 'Dashboard':
      case 'Token Overview':
        return _buildMainDashboard();
      case 'My Wallet':
        return _buildWalletScreen();
      case 'Explore Tokens':
        return _buildExploreTokensScreen();
      case 'Watchlist':
        return _buildWatchlistScreen();
      case 'Transfers':
        return _buildGlobalTransfersScreen();
      case 'Holders':
        return _buildGlobalHoldersScreen();
      case 'Charts & Trends':
        return _buildChartsScreen();
      case 'Help Center':
        return _buildHelpScreen();
      case 'Settings':
        return _buildSettingsScreen();
      case 'Profile':
        return _buildProfileScreen();
      default:
        return _buildMainDashboard();
    }
  }

  // --- Glassmorphic Container Wrapper ---
  Widget _glassContainer({
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Gradient? gradient,
    BorderRadius? borderRadius,
  }) {
    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: padding ?? const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: gradient ??
                  LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.06),
                      Colors.white.withOpacity(0.02),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
              borderRadius: borderRadius ?? BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.12), width: 1),
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  // --- Sidebar & Navigation ---
  Widget _buildSidebar(BuildContext context) {
    return Container(
      color: const Color(0xFF0F0F13).withOpacity(0.7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.hub, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Relatel', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text('microdose.studio', style: TextStyle(color: Colors.grey, fontSize: 11)),
                  ],
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white10, height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: Text('Overview', style: TextStyle(color: Colors.grey, fontSize: 12)),
                ),
                _buildNavItem(Icons.dashboard_outlined, 'Dashboard'),
                _buildNavItem(Icons.account_balance_wallet_outlined, 'My Wallet'),
                _buildNavItem(Icons.explore_outlined, 'Explore Tokens'),
                _buildNavItem(Icons.star_border, 'Watchlist'),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: Text('Analytics', style: TextStyle(color: Colors.grey, fontSize: 12)),
                ),
                ExpansionTile(
                  initiallyExpanded: _isTokenOverviewExpanded,
                  onExpansionChanged: (val) => setState(() => _isTokenOverviewExpanded = val),
                  leading: const Icon(Icons.token, size: 20, color: Colors.white70),
                  title: const Text('Token Overview', style: TextStyle(fontSize: 14)),
                  trailing: Icon(_isTokenOverviewExpanded ? Icons.expand_less : Icons.expand_more, size: 18),
                  children: [
                    _buildSubNavItem('BNB', Colors.amber),
                    _buildSubNavItem('ETH', Colors.blueAccent),
                    _buildSubNavItem('USDC', Colors.cyan),
                  ],
                ),
                _buildNavItem(Icons.swap_horiz, 'Transfers'),
                _buildNavItem(Icons.group_outlined, 'Holders'),
                _buildNavItem(Icons.show_chart, 'Charts & Trends'),
                const Divider(color: Colors.white10, height: 24),
                _buildNavItem(Icons.help_outline, 'Help Center'),
                _buildNavItem(Icons.settings_outlined, 'Settings'),
                _buildNavItem(Icons.person_outline, 'Profile'),
              ],
            ),
          ),
          const Divider(color: Colors.white10, height: 1),
          _buildUserProfileCard(context),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String title) {
    final bool isSelected = _selectedRoute == title;
    return Material(
      color: Colors.transparent,
      child: ListTile(
        dense: true,
        leading: Icon(icon, size: 20, color: isSelected ? Colors.blue : Colors.white70),
        title: Text(title, style: TextStyle(color: isSelected ? Colors.white : Colors.white70, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        tileColor: isSelected ? Colors.white.withOpacity(0.08) : null,
        onTap: () {
          setState(() => _selectedRoute = title);
          if (Navigator.of(context).canPop() && MediaQuery.of(context).size.width < 900) {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }

  Widget _buildSubNavItem(String name, Color dotColor) {
    final bool isSelected = _selectedToken == name && _selectedRoute == 'Token Overview';
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedToken = name;
            _selectedRoute = 'Token Overview';
          });
          if (Navigator.of(context).canPop() && MediaQuery.of(context).size.width < 900) {
            Navigator.of(context).pop();
          }
        },
        child: Container(
          margin: const EdgeInsets.only(left: 16, bottom: 4),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white.withOpacity(0.08) : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Container(width: 8, height: 8, decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle)),
              const SizedBox(width: 12),
              Text(name, style: TextStyle(color: isSelected ? Colors.white : Colors.white70, fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfileCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100'),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ashley Curtin', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                Text('amazevalley@gmail.com', style: TextStyle(fontSize: 10,
                    color: Colors.grey), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout, size: 16, color: Colors.grey),
            onPressed: () => _showSnackbar(context, 'Logged out successfully'),
          ),
        ],
      ),
    );
  }

  Widget _buildTopHeader(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: const Color(0xFF0F0F13).withOpacity(0.5),
            border: const Border(bottom: BorderSide(color: Colors.white10)),
          ),
          child: Row(
            children: [
              Text(_selectedRoute, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Spacer(),
              Container(
                constraints: const BoxConstraints(maxWidth: 300),
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.white10),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Search transaction or token',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                    prefixIcon: Icon(Icons.search, color: Colors.grey, size: 16),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: Icon(_isDarkMode ? Icons.dark_mode : Icons.light_mode),
                onPressed: () => setState(() => _isDarkMode = !_isDarkMode),
              ),
              IconButton(
                icon: const Icon(Icons.chat_bubble_outline, size: 20),
                onPressed: () => _showSnackbar(context, 'Support chat opened'),
              ),
              IconButton(
                icon: const Icon(Icons.notifications_outlined, size: 20),
                onPressed: () => _showSnackbar(context, 'No new notifications'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Graph with Area Shading ---
  Widget _buildSparklineGraph(Color lineColor, List<double> points) {
    return SizedBox(
      height: 44,
      child: CustomPaint(
        painter: SparklinePainter(lineColor: lineColor, points: points),
        child: Container(),
      ),
    );
  }

  // ==========================================
  // 1. DASHBOARD SCREEN & TABS
  // ==========================================
  Widget _buildMainDashboard() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTokenHeaderRow(),
          const SizedBox(height: 20),
          _buildInfoCardsGrid(context),
          const SizedBox(height: 24),
          _buildTabBar(),
          const SizedBox(height: 16),
          _buildDashboardTabContent(),
        ],
      ),
    );
  }

  Widget _buildDashboardTabContent() {
    switch (_selectedTabIdx) {
      case 0:
        return _buildTabTransfersView();
      case 1:
        return _buildTabHoldersView();
      case 2:
        return _buildTabInfoView();
      case 3:
        return _buildTabDexTradesView();
      case 4:
        return _buildContractSection();
      case 5:
        return _buildTabAnalyticsView();
      case 6:
        return _buildTabCardsView();
      default:
        return _buildContractSection();
    }
  }

  Widget _buildTabTransfersView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Recent Token Transfers', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _transferRow('0x8f3c...21a4', '0x12d9...90ff', '2.5 BNB', '2 mins ago', Colors.green),
        _transferRow('0x4e2a...bb12', '0x77c1...33ee', '140 USDC', '15 mins ago', Colors.blue),
        _transferRow('0x991b...44ac', '0x34fa...00bb', '0.45 ETH', '1 hour ago', Colors.orange),
      ],
    );
  }

  Widget _buildTabHoldersView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Top Token Holders', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _holderRow('1', '0x71C...3A2', '142,500 BNB', 0.85, '24.8%'),
        _holderRow('2', '0x44B...1F9', '89,200 BNB', 0.55, '15.5%'),
        _holderRow('3', '0x90A...8C3', '45,100 BNB', 0.30, '7.8%'),
      ],
    );
  }

  Widget _buildTabInfoView() {
    return _glassContainer(
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Token Comprehensive Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          SizedBox(height: 12),
          Text('Official Website: https://binance.com', style: TextStyle(color: Colors.blue, fontSize: 13)),
          SizedBox(height: 8),
          Text('Decimals: 18', style: TextStyle(color: Colors.grey, fontSize: 13)),
          SizedBox(height: 8),
          Text('Smart Contract Audit: Certified Secure (CertiK)', style: TextStyle(color: Colors.green, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildTabDexTradesView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Decentralized Exchange (DEX) Trades', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        _dexTradeRow('PancakeSwap v3', 'BUY', '12.4 BNB', '\$3,820.00', Colors.green),
        _dexTradeRow('Uniswap v2', 'SELL', '5.1 BNB', '\$1,540.00', Colors.red),
      ],
    );
  }

  Widget _buildTabAnalyticsView() {
    return _glassContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Token Volume & Momentum Analytics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 16),
          SizedBox(
            height: 140,
            child: CustomPaint(
              painter: SparklinePainter(lineColor: Colors.blueAccent, points: [20, 35, 30, 50, 45, 65, 60, 85], showAreaShade: true),
              child: Container(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabCardsView() {
    return _glassContainer(
      gradient: LinearGradient(
        colors: [const Color(0xFF1E3A8A).withOpacity(0.4), const Color(0xFF0F172A).withOpacity(0.6)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      child: const Row(
        children: [
          Icon(Icons.credit_card, color: Colors.cyanAccent, size: 32),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Relatel Virtual Crypto Card', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                SizedBox(height: 4),
                Text('Spend your token holdings globally with 2% cashback.', style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // 2. MY WALLET SCREEN
  // ==========================================
  Widget _buildWalletScreen() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _glassContainer(
            gradient: LinearGradient(
              colors: [const Color(0xFF1E3A8A).withOpacity(0.35), const Color(0xFF0F172A).withOpacity(0.6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Portfolio Balance', style: TextStyle(color: Colors.grey, fontSize: 13)),
                        SizedBox(height: 8),
                        Text('\$48,920.45', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                      onPressed: () => _showSnackbar(context, 'Deposit gateway opened'),
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text('Deposit'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 60,
                  child: CustomPaint(
                    painter: SparklinePainter(lineColor: Colors.cyanAccent, points: [20, 25, 22, 30, 28, 35, 42, 40, 50], showAreaShade: true),
                    child: Container(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Text('Asset Allocation', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _walletAssetTile('Binance Coin', 'BNB', '142.5 BNB', '\$42,100.00', Colors.amber, [30, 32, 31, 35, 38, 42]),
          _walletAssetTile('Ethereum', 'ETH', '1.8 ETH', '\$4,820.00', Colors.blue, [10, 15, 12, 18, 16, 20]),
          _walletAssetTile('USD Coin', 'USDC', '2,000 USDC', '\$2,000.45', Colors.cyan, [50, 50, 50, 50, 50, 50]),
        ],
      ),
    );
  }

  // ==========================================
  // 3. EXPLORE TOKENS SCREEN
  // ==========================================
  Widget _buildExploreTokensScreen() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Explore Trending Tokens', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          LayoutBuilder(builder: (context, constraints) {
            int crossAxisCount = constraints.maxWidth > 800 ? 3 : 1;
            return GridView.count(
              crossAxisCount: crossAxisCount,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.7,
              children: [
                _tokenCard('Bitcoin', 'BTC', '\$64,200.00', '+3.4%', Colors.orange, [10, 15, 12, 22, 28, 35]),
                _tokenCard('Solana', 'SOL', '\$142.10', '+8.1%', Colors.purple, [20, 18, 25, 30, 29, 45]),
                _tokenCard('Cardano', 'ADA', '\$0.45', '-1.2%', Colors.blueAccent, [30, 28, 25, 22, 20, 18]),
                _tokenCard('Polkadot', 'DOT', '\$6.80', '+2.5%', Colors.pink, [12, 14, 15, 13, 16, 19]),
                _tokenCard('Ripple', 'XRP', '\$0.58', '+0.4%', Colors.blue, [22, 22, 23, 21, 24, 25]),
                _tokenCard('Avalanche', 'AVAX', '\$28.40', '+5.6%', Colors.red, [15, 20, 18, 25, 30, 38]),
              ],
            );
          }),
        ],
      ),
    );
  }

  // ==========================================
  // 4. WATCHLIST SCREEN
  // ==========================================
  Widget _buildWatchlistScreen() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Your Watchlist Assets', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _walletAssetTile('BNB Chain', 'BNB', 'Tracked', '\$325,123.00', Colors.amber, [10, 20, 15, 30, 25, 40]),
          _walletAssetTile('Ethereum', 'ETH', 'Tracked', '\$3,120.45', Colors.blue, [25, 22, 28, 26, 32, 30]),
        ],
      ),
    );
  }

  // ==========================================
  // 5. GLOBAL TRANSFERS SCREEN
  // ==========================================
  Widget _buildGlobalTransfersScreen() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Global Chain Transfers', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _transferRow('0x8f3c...21a4', '0x12d9...90ff', '2.5 BNB', '2 mins ago', Colors.green),
          _transferRow('0x4e2a...bb12', '0x77c1...33ee', '140 USDC', '15 mins ago', Colors.blue),
          _transferRow('0x991b...44ac', '0x34fa...00bb', '0.45 ETH', '1 hour ago', Colors.orange),
        ],
      ),
    );
  }

  // ==========================================
  // 6. GLOBAL HOLDERS SCREEN
  // ==========================================
  Widget _buildGlobalHoldersScreen() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Global Holders Leaderboard', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _holderRow('1', '0x71C...3A2', '142,500 BNB', 0.85, '24.8%'),
          _holderRow('2', '0x44B...1F9', '89,200 BNB', 0.55, '15.5%'),
          _holderRow('3', '0x90A...8C3', '45,100 BNB', 0.30, '7.8%'),
        ],
      ),
    );
  }

  // ==========================================
  // 7. CHARTS & TRENDS SCREEN
  // ==========================================
  Widget _buildChartsScreen() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Market Momentum & Trends', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _glassContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('24H Volume Spike Trend', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 8),
                const Text('Trading volume increased by 42% over the last 24 hours across active EVM chains.', style: TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 24),
                SizedBox(
                  height: 160,
                  child: CustomPaint(
                    painter: SparklinePainter(lineColor: Colors.blueAccent, points: [15, 30, 25, 45, 40, 60, 55, 75, 70, 95], showAreaShade: true),
                    child: Container(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // 8. HELP CENTER SCREEN
  // ==========================================
  Widget _buildHelpScreen() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Help Center & Knowledge Base', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          const Text('Find answers to common questions or reach out to our 24/7 technical support engineers.', style: TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 24),
          _glassContainer(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const TextField(
              decoration: InputDecoration(
                hintText: 'Search for guides, errors, transactions, or wallet setup...',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                icon: Icon(Icons.search, color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 28),
          const Text('Frequently Asked Questions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _faqItem('How do I verify a smart contract deployment?', 'Go to the contract overview tab, paste your Solidity compiler version, and click verify. Our node runner compares generated bytecode hash against on-chain transaction deployment hex.'),
          _faqItem('Are my private wallet keys stored on your servers?', 'No. Relatel operates on a non-custodial decentralized model. All signatures, keys, and recovery phrases are encrypted and stored exclusively in your local device hardware storage.'),
          _faqItem('What should I do if a blockchain transaction fails or gets stuck?', 'Stuck transactions usually result from low gas fees. You can use the "Speed Up" feature in your connected MetaMask or EVM wallet to rebroadcast the nonce with a higher gas limit.'),
        ],
      ),
    );
  }

  // ==========================================
  // 9. SETTINGS SCREEN
  // ==========================================
  Widget _buildSettingsScreen() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Preferences & Configuration', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          const Text('Manage your security, dashboard appearance, blockchain node endpoints, and notification preferences.', style: TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 24),
          _settingsSectionTitle('Appearance & Localization'),
          _glassContainer(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                Material(
                  color: Colors.transparent,
                  child: SwitchListTile(
                    title: const Text('Dark Mode Aesthetics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    subtitle: const Text('Use high-contrast dark theme optimized for OLED displays', style: TextStyle(color: Colors.grey, fontSize: 11)),
                    secondary: const Icon(Icons.dark_mode_outlined, color: Colors.blue),
                    value: _isDarkMode,
                    onChanged: (val) => setState(() => _isDarkMode = val),
                  ),
                ),
                const Divider(color: Colors.white10, height: 1),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.monetization_on_outlined, color: Colors.amber, size: 22),
                          SizedBox(width: 16),
                          // SizedBox(
                          //   height: 100.0,
                          //   width: kIsWeb ? double.infinity: 200.0,
                          //   child:
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Default Fiat Currency', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                Text('Display balances in local '
                                    'currency',overflow: TextOverflow.ellipsis, style: TextStyle
                                  (color: Colors.grey, fontSize: 11,)),
                              ],
                            ),
                          // ),
                        ],
                      ),
                      DropdownButton<String>(
                        value: _selectedCurrency,
                        dropdownColor: const Color(0xFF141418),
                        style: const TextStyle(fontSize: 13, color: Colors.white),
                        underline: const SizedBox(),
                        items: ['USD (\$ )', 'EUR (€ )', 'GBP (£ )', 'INR (₹ )'].map((String val) {
                          return DropdownMenuItem<String>(value: val, child: Text(val));
                        }).toList(),
                        onChanged: (val) => setState(() => _selectedCurrency = val!),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _settingsSectionTitle('Security & Authentication'),
          _glassContainer(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                Material(
                  color: Colors.transparent,
                  child: SwitchListTile(
                    title: const Text('Biometric Authentication', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    subtitle: const Text('Require fingerprint or Face ID for fund transfers', style: TextStyle(color: Colors.grey, fontSize: 11)),
                    secondary: const Icon(Icons.fingerprint, color: Colors.green),
                    value: _biometricAuth,
                    onChanged: (val) => setState(() => _biometricAuth = val),
                  ),
                ),
                const Divider(color: Colors.white10, height: 1),
                Material(
                  color: Colors.transparent,
                  child: ListTile(
                    title: const Text('Manage Recovery Seed Phrase', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    subtitle: const Text('View secret backup words or export private keys safely', style: TextStyle(color: Colors.grey, fontSize: 11)),
                    leading: const Icon(Icons.vpn_key_outlined, color: Colors.orange),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                    onTap: () => _showSnackbar(context, 'Seed phrase security verification triggered'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _settingsSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 4),
      child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
    );
  }

  // ==========================================
  // 10. PROFILE SCREEN (Fixed for Mobile & Web)
  // ==========================================
  Widget _buildProfileScreen() {
    final bool isWide = MediaQuery.of(context).size.width > 700;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _glassContainer(
            gradient: LinearGradient(
              colors: [const Color(0xFF1E3A8A).withOpacity(0.35), const Color(0xFF0F172A).withOpacity(0.6)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 42,
                  backgroundImage: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200'),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text('Ashley Curtin', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(12)),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.verified, size: 12, color: Colors.white),
                                SizedBox(width: 4),
                                Text('PRO', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Text('amazevalley@gmail.com', style: TextStyle
                        (color: Colors.grey, fontSize: 13)),
                      const SizedBox(height: 8),
                      const Text('Member since August 2025 • EVM Node Verified', style: TextStyle(color: Colors.cyanAccent, fontSize: 11)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Safe responsive layout for metric cards
          if (isWide)
            Row(
              children: [
                Expanded(child: _profileStatMetric('Security Trust Score', '98 / 100', 'Maximum Protection Enabled', Colors.green, Icons.security)),
                const SizedBox(width: 16),
                Expanded(child: _profileStatMetric('Connected Wallets', '3 Active', 'MetaMask, Trust, Ledger', Colors.blue, Icons.account_balance_wallet)),
                const SizedBox(width: 16),
                Expanded(child: _profileStatMetric('Lifetime Volume', '\$142,850.00', 'Across 342 transactions', Colors.amber, Icons.trending_up)),
              ],
            )
          else
            Column(
              children: [
                _profileStatMetric('Security Trust Score', '98 / 100', 'Maximum Protection Enabled', Colors.green, Icons.security),
                const SizedBox(height: 12),
                _profileStatMetric('Connected Wallets', '3 Active', 'MetaMask, Trust, Ledger', Colors.blue, Icons.account_balance_wallet),
                const SizedBox(height: 12),
                _profileStatMetric('Lifetime Volume', '\$142,850.00', 'Across 342 transactions', Colors.amber, Icons.trending_up),
              ],
            ),

          const SizedBox(height: 28),
          const Text('Connected Wallet Addresses', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _walletAddressTile('Primary EVM Wallet (MetaMask)', '0x489b21a...8902f1a', 'Main Net • BNB & ETH', Colors.amber),
          _walletAddressTile('Cold Storage Vault (Ledger Nano X)', '0x991f82c...3341b09', 'Hardware Secured', Colors.green),
          const SizedBox(height: 24),
          const Text('Account & Session Security', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _glassContainer(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                Material(
                  color: Colors.transparent,
                  child: ListTile(
                    title: const Text('Change Account Password', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    subtitle: const Text('Last changed 3 months ago', style: TextStyle(color: Colors.grey, fontSize: 11)),
                    leading: const Icon(Icons.lock_outline, color: Colors.blue),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                    onTap: () => _showSnackbar(context, 'Password reset email sent'),
                  ),
                ),
                const Divider(color: Colors.white10, height: 1),
                Material(
                  color: Colors.transparent,
                  child: ListTile(
                    title: const Text('Download Activity & Tax Report', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    subtitle: const Text('Export CSV statement for FY 2025-2026', style: TextStyle(color: Colors.grey, fontSize: 11)),
                    leading: const Icon(Icons.download, color: Colors.green),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                    onTap: () => _showSnackbar(context, 'Tax report downloaded successfully'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileStatMetric(String title, String value, String subtitle, Color color, IconData icon) {
    return _glassContainer(
      child: Row(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                const SizedBox(height: 2),
                Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 2),
                Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _walletAddressTile(String label, String address, String network, Color color) {
    return _glassContainer(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 2),
                Text(address, style: const TextStyle(fontFamily: 'monospace', color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(6)),
            child: Text(network, style: const TextStyle(fontSize: 11, color: Colors.grey)),
          ),
        ],
      ),
    );
  }

  // --- Sub-components & Helpers ---
  Widget _buildTokenHeaderRow() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(color: Colors.amber, shape: BoxShape.circle),
              child: const Text('₿', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12)),
            ),
            const SizedBox(width: 8),
            Text('$_selectedToken ( BNB )', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            const Icon(Icons.copy, size: 14, color: Colors.grey),
          ],
        ),
        Wrap(
          spacing: 8,
          children: [
            _buildTagChip('FAB-20'),
            _buildTagChip('Binance', icon: Icons.info_outline),
            _buildTagChip('Exchange'),
            _buildTagChip('# Mainnet Launched'),
          ],
        ),
      ],
    );
  }

  Widget _buildTagChip(String label, {IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[Icon(icon, size: 12, color: Colors.grey), const SizedBox(width: 4)],
          Text(label, style: const TextStyle(fontSize: 11, color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildInfoCardsGrid(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool isWide = constraints.maxWidth > 900;

      final List<Widget> cards = [
        _glassContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Text('View all info', style: TextStyle(color: Colors.grey, fontSize: 11)),
                ],
              ),
              const SizedBox(height: 16),
              _statItem('Max total supply', '573,765 BNB', 'Total minted', 'Capped by contract', Colors.amber),
              const Divider(color: Colors.white10, height: 24),
              _statItem('Holders', '325,123', '(+0,76%)', 'Active addresses', Colors.green),
              const Divider(color: Colors.white10, height: 24),
              _statItem('Total Transfers', '1,765,876', 'Genesis', 'Tracked transactions', Colors.blue),
            ],
          ),
        ),
        _glassContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Market', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Text('View all info', style: TextStyle(color: Colors.grey, fontSize: 11)),
                ],
              ),
              const SizedBox(height: 16),
              _statItem('Onchain', '\$765,877.98', 'Chain-Based', 'Circulating value', Colors.green),
              const Divider(color: Colors.white10, height: 24),
              _statItem('Price', '325,123', '(-0,76%)', 'Volatility trend', Colors.red),
              const Divider(color: Colors.white10, height: 24),
              _statItem('Circulating supply', '1,765,876', 'Liquid Supply', 'Active circulation', Colors.blue),
            ],
          ),
        ),
        _glassContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Other Info', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ],
              ),
              const SizedBox(height: 16),
              _statItem('Token contract', '0C65778B76...BfguhGuj7hu7', '18 Decimals', 'Verified contract ID', Colors.grey),
              const Divider(color: Colors.white10, height: 24),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF1E3A8A), Color(0xFF0F172A)]),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blueAccent.withOpacity(0.4)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.auto_awesome, color: Colors.cyanAccent, size: 24),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Liquid Staking', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          Text('Track staking rewards.', style: TextStyle(fontSize: 10, color: Colors.grey)),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        textStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () => _showSnackbar(context, 'Upgrade to PRO'),
                      child: const Text('PRO'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ];

      if (isWide) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: cards[0]),
            const SizedBox(width: 16),
            Expanded(child: cards[1]),
            const SizedBox(width: 16),
            Expanded(child: cards[2]),
          ],
        );
      } else {
        return Column(
          children: [
            cards[0],
            const SizedBox(height: 16),
            cards[1],
            const SizedBox(height: 16),
            cards[2],
          ],
        );
      }
    });
  }

  Widget _statItem(String label, String value, String subValue, String desc, Color indicatorColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 6, height: 6, decoration: BoxDecoration(color: indicatorColor, shape: BoxShape.circle)),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Text(subValue, style: TextStyle(color: indicatorColor, fontSize: 12)),
          ],
        ),
        const SizedBox(height: 2),
        Text(desc, style: const TextStyle(color: Colors.grey, fontSize: 11)),
      ],
    );
  }

  Widget _buildTabBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_tabs.length, (index) {
          final bool isSelected = _selectedTabIdx == index;
          return Padding(
            padding: const EdgeInsets.only(right: 24),
            child: InkWell(
              onTap: () => setState(() => _selectedTabIdx = index),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _tabs[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: 2,
                    width: 40,
                    color: isSelected ? Colors.blue : Colors.transparent,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildContractSection() {
    return _glassContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text('Code', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              SizedBox(width: 24),
              Text('Read Contract', style: TextStyle(color: Colors.grey, fontSize: 13)),
              SizedBox(width: 24),
              Text('Write Contract', style: TextStyle(color: Colors.grey, fontSize: 13)),
            ],
          ),
          const Divider(color: Colors.white10, height: 24),
          Row(
            children: [
              const Text('Contract Source Code Verified', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(4)),
                child: const Text('(Exact Match)', style: TextStyle(fontSize: 10, color: Colors.grey)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          LayoutBuilder(builder: (context, constraints) {
            bool isWide = constraints.maxWidth > 600;
            final List<Widget> details = [
              _contractDetailItem('Contract name', 'BNB'),
              _contractDetailItem('Compiler version', 'v0.8.54'),
              _contractDetailItem('Optimization', 'No (200 runs)'),
              _contractDetailItem('EVM Version', 'default'),
            ];

            if (isWide) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: details.map((d) => Expanded(child: d)).toList(),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: details.map((d) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: d,
                )).toList(),
              );
            }
          }),
        ],
      ),
    );
  }

  Widget _contractDetailItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.grey, fontSize: 11)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
      ],
    );
  }

  Widget _walletAssetTile(String name, String symbol, String amount, String fiat, Color color, List<double> graphPoints) {
    return _glassContainer(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(width: 12, height: 12, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(symbol, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ])),
          SizedBox(width: 100, child: _buildSparklineGraph(color, graphPoints)),
          const SizedBox(width: 16),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(fiat, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(amount, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ]),
        ],
      ),
    );
  }

  Widget _tokenCard(String name, String symbol, String price, String change, Color color, List<double> points) {
    bool isPositive = change.startsWith('+');
    return _glassContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: color.withOpacity(0.2), shape: BoxShape.circle), child: Text(symbol[0], style: TextStyle(color: color, fontWeight: FontWeight.bold))),
              const SizedBox(width: 10),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                Text(symbol, style: const TextStyle(color: Colors.grey, fontSize: 11)),
              ]),
              const Spacer(),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text(price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                Text(change, style: TextStyle(color: isPositive ? Colors.green : Colors.red, fontSize: 11)),
              ]),
            ],
          ),
          _buildSparklineGraph(color, points),
        ],
      ),
    );
  }

  Widget _transferRow(String from, String to, String amount, String time, Color indicatorColor) {
    return _glassContainer(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: indicatorColor.withOpacity(0.2), shape: BoxShape.circle), child: Icon(Icons.arrow_forward, size: 16, color: indicatorColor)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('From $from → To $to', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              LinearProgressIndicator(value: 0.68, backgroundColor: Colors.white10, color: indicatorColor),
              const SizedBox(height: 4),
              Text(time, style: const TextStyle(color: Colors.grey, fontSize: 10)),
            ]),
          ),
          const SizedBox(width: 16),
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _holderRow(String rank, String address, String balance, double percentageVal, String percentageStr) {
    return _glassContainer(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                CircleAvatar(radius: 12, backgroundColor: Colors.blue.withOpacity(0.2), child: Text(rank, style: const TextStyle(fontSize: 11, color: Colors.blue))),
                const SizedBox(width: 12),
                Text(address, style: const TextStyle(fontFamily: 'monospace', fontSize: 13, fontWeight: FontWeight.bold)),
              ]),
              Text(balance, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: LinearProgressIndicator(value: percentageVal, backgroundColor: Colors.white10, color: Colors.blueAccent)),
              const SizedBox(width: 12),
              Text(percentageStr, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dexTradeRow(String dex, String type, String amount, String fiat, Color color) {
    return _glassContainer(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(4)), child: Text(type, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold))),
            const SizedBox(width: 12),
            Text(dex, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          ]),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(fiat, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            Text(amount, style: const TextStyle(color: Colors.grey, fontSize: 11)),
          ]),
        ],
      ),
    );
  }

  Widget _faqItem(String q, String a) {
    return _glassContainer(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.help_outline, size: 16, color: Colors.blue),
              const SizedBox(width: 8),
              Expanded(child: Text(q, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
            ],
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Text(a, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

// --- Custom Painter with Line + Gradient Area Shade ---
class SparklinePainter extends CustomPainter {
  final Color lineColor;
  final List<double> points;
  final bool showAreaShade;

  SparklinePainter({
    required this.lineColor,
    required this.points,
    this.showAreaShade = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;

    double minVal = points.reduce((a, b) => a < b ? a : b);
    double maxVal = points.reduce((a, b) => a > b ? a : b);
    double range = maxVal - minVal;
    if (range == 0) range = 1;

    double dxStep = size.width / (points.length - 1);
    final path = Path();
    final fillPath = Path();

    for (int i = 0; i < points.length; i++) {
      double x = i * dxStep;
      double normalizedY = (points[i] - minVal) / range;
      double y = size.height - (normalizedY * (size.height - 8) + 4);

      if (i == 0) {
        path.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        path.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }

    if (showAreaShade) {
      fillPath.lineTo(size.width, size.height);
      fillPath.close();

      final fillPaint = Paint()
        ..shader = LinearGradient(
          colors: [lineColor.withOpacity(0.35), lineColor.withOpacity(0.0)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
        ..style = PaintingStyle.fill;

      canvas.drawPath(fillPath, fillPaint);
    }
    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawPath(path, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}