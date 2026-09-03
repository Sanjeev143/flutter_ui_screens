import 'package:flutter/material.dart';

void main() {
  runApp(const FintechTradingApp());
}

class FintechTradingApp extends StatelessWidget {
  const FintechTradingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amaze Trade Trading Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0B0E14),
        cardColor: const Color(0xFF131720),
        primaryColor: const Color(0xFF00C853),
        colorScheme: const ColorScheme.dark(
          surface: Color(0xFF131720),
          primary: Color(0xFF00C853),
          secondary: Color(0xFF1E232F),
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
  String selectedNetwork = 'Solana';

  void _onNetworkSelected(String networkName) {
    setState(() {
      selectedNetwork = networkName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: 260,
            child: LeftSidebar(
              selectedNetwork: selectedNetwork,
              onNetworkSelected: _onNetworkSelected,
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const TopNavbar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const HeaderSection(),
                        const SizedBox(height: 24),
                        const AccountHeaderSection(),
                        const SizedBox(height: 16),
                        const OverviewCardsRow(),
                        const SizedBox(height: 24),
                        const TradingObjectivesSection(),
                        const SizedBox(height: 24),
                        const TradingHistorySection(),
                      ],
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
}

// ==========================================
// 1. LEFT SIDEBAR
// ==========================================
class LeftSidebar extends StatelessWidget {
  final String selectedNetwork;
  final Function(String) onNetworkSelected;

  const LeftSidebar({
    super.key,
    required this.selectedNetwork,
    required this.onNetworkSelected,
  });

  @override
  Widget build(BuildContext context) {
    final networks = ['Solana', 'Base', 'Ethereum', 'BSC', 'TON', 'Avalanche', 'XRP'];

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0B0E14),
        border: Border(right: BorderSide(color: Color(0xFF1E232F), width: 1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const GftHomeOverviewScreen())),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: [Color(0xFF00C853), Color(0xFF00E676)]),
                    ),
                    child: const Center(
                      child: Text('A', style: TextStyle(fontWeight:
                      FontWeight.bold, color: Colors.black, fontSize: 18)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Amaze Trade', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1)),
                      Text('Trade like the Greatest', style: TextStyle(color: Colors.grey, fontSize: 10)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFF131720),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF1E232F)),
              ),
              child: TextField(
                style: const TextStyle(fontSize: 12),
                decoration: const InputDecoration(
                  hintText: 'Search token/contract/wallet',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 11),
                  prefixIcon: Icon(Icons.search, size: 16, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                ),
                onSubmitted: (value) => Navigator.push(context, MaterialPageRoute(builder: (_) => SearchResultScreen(query: value))),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
            child: Text('Dashboard', style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.w600)),
          ),
          _sidebarItem(context, Icons.grid_view, 'NEW PAIRS', isSelected: true, screen: const NewPairsViewScreen()),
          _sidebarItem(context, Icons.local_fire_department_outlined, 'MEME SCOPE', screen: const MemeScopeScreen()),
          _sidebarItem(context, Icons.pie_chart_outline, 'MY POSITIONS', hasArrow: true, screen: const MyPositionsScreen()),
          _sidebarItem(context, Icons.store_mall_directory_outlined, 'TRADING CENTERS', hasArrow: true, screen: const TradingCentersScreen()),
          _sidebarItem(context, Icons.people_outline, 'TRADERS', badge: '99+', screen: const TradersLeaderboardScreen()),
          const Divider(color: Color(0xFF1E232F), height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
            child: Text('Network', style: TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.w600)),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: networks.length,
              itemBuilder: (context, index) {
                final name = networks[index];
                final isSelected = selectedNetwork == name;
                return _networkItem(context, name, isSelected, () => onNetworkSelected(name));
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFF1E232F))),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Wachlist', style: TextStyle(color: Colors.grey, fontSize: 11)),
                    Icon(Icons.keyboard_arrow_up, size: 16, color: Colors.grey),
                  ],
                ),
                const SizedBox(height: 8),
                _watchlistToken(context, 'PI', '\$0.0545', '+24.1%', true),
                const SizedBox(height: 6),
                _watchlistToken(context, 'PWEASE', '\$0.0325', '+9.1%', true),
                const SizedBox(height: 6),
                _watchlistToken(context, 'KAIREN', '\$0.0028', '+0.1%', true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _sidebarItem(BuildContext context, IconData icon, String title, {bool isSelected = false, bool hasArrow = false, String? badge, required Widget screen}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF1E232F) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        dense: true,
        leading: Icon(icon, size: 18, color: isSelected ? const Color(0xFF00C853) : Colors.grey),
        title: Text(title, style: TextStyle(fontSize: 11, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, color: isSelected ? Colors.white : Colors.grey)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (badge != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: const Color(0xFF1E232F), borderRadius: BorderRadius.circular(10)),
                child: Text(badge, style: const TextStyle(fontSize: 9, color: Colors.grey)),
              ),
            if (hasArrow) const Icon(Icons.keyboard_arrow_right, size: 16, color: Colors.grey),
          ],
        ),
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => screen)),
      ),
    );
  }

  static Widget _networkItem(BuildContext context, String name, bool isSelected, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF1E232F) : Colors.transparent,
        borderRadius: BorderRadius.circular(6),
      ),
      child: ListTile(
        dense: true,
        leading: Container(
          width: 16, height: 16,
          decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.blueAccent),
        ),
        title: Text(name, style: TextStyle(fontSize: 11, color: isSelected ? Colors.white : Colors.grey)),
        trailing: isSelected ? const Icon(Icons.check, size: 14, color: Color(0xFF00C853)) : null,
        onTap: () {
          onTap();
          Navigator.push(context, MaterialPageRoute(builder: (_) => NetworkDetailScreen(networkName: name)));
        },
      ),
    );
  }

  static Widget _watchlistToken(BuildContext context, String symbol, String price, String change, bool isPositive) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TokenDetailScreen(symbol: symbol, price: price, change: change))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(radius: 8, backgroundColor: Colors.grey),
                const SizedBox(width: 8),
                Text(symbol, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(price, style: const TextStyle(fontSize: 11)),
                Text(change, style: TextStyle(fontSize: 9, color: isPositive ? const Color(0xFF00C853) : Colors.red)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 2. TOP NAVBAR
// ==========================================
class TopNavbar extends StatelessWidget {
  const TopNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: Color(0xFF0B0E14),
        border: Border(bottom: BorderSide(color: Color(0xFF1E232F), width: 1)),
      ),
      child: Row(
        children: [
          _navButton(context, Icons.notifications_none, 'Alerts', const NotificationsScreen(type: 'System Alerts')),
          const SizedBox(width: 12),
          InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TwitterTrackerScreen())),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF131720),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF00C853).withOpacity(0.5)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.bolt, size: 14, color: Color(0xFF00C853)),
                  SizedBox(width: 6),
                  Text('Twitter Tracker', style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          _navButton(context, Icons.notifications_active_outlined, 'Alerts', const NotificationsScreen(type: 'Triggered Price Alerts')),
          const SizedBox(width: 12),
          const Text('195.43', style: TextStyle(fontSize: 12, color: Colors.grey)),
          const Spacer(),
          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ConnectWalletScreen())),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Connect wallet', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 16),
          InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const UserProfileScreen())),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.deepPurple,
                  child: Text('DS', style: TextStyle(fontSize: 10, color: Colors.white)),
                ),
                const SizedBox(width: 8),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Delon Shax', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                    Text('Coolest Goat', style: TextStyle(fontSize: 9, color: Colors.grey)),
                  ],
                ),
                const SizedBox(width: 4),
                const Icon(Icons.keyboard_arrow_down, size: 14, color: Colors.grey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _navButton(BuildContext context, IconData icon, String label, Widget targetScreen) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => targetScreen)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF131720),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF1E232F)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: Colors.grey),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 3. HEADER & CONTROLS SECTION
// ==========================================
class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('NEW PAIRS', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                SizedBox(height: 4),
                Text('New token pairs in the last 24-hours updated in real-time.', style: TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
            Row(
              children: [
                _actionButton(context, Icons.filter_list, 'Filter', const FilterModalScreen()),
                const SizedBox(width: 8),
                _actionButton(context, Icons.unfold_more, 'Dexel', const DexelConfigScreen()),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF131720),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFF1E232F)),
              ),
              child: Row(
                children: [
                  Switch(value: false, onChanged: (v) => Navigator.push(context, MaterialPageRoute(builder: (_) => const QuickBuySettingsScreen())), activeColor: const Color(0xFF00C853), materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
                  const Text('Quick buy', style: TextStyle(fontSize: 11)),
                  const SizedBox(width: 8),
                  Container(padding: const EdgeInsets.all(4), decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF1E232F)), child: const Icon(Icons.bolt, size: 10, color: Color(0xFF00C853))),
                  const SizedBox(width: 6),
                  const Text('0.5', style: TextStyle(fontSize: 11)),
                ],
              ),
            ),
            const SizedBox(width: 12),
            InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PresetsManagerScreen())),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF131720),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF1E232F)),
                ),
                child: const Row(
                  children: [
                    Text('Presets', style: TextStyle(fontSize: 11, color: Colors.grey)),
                    SizedBox(width: 8),
                    Text('\$1   \$2   \$3', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF00C853))),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WalletSelectorScreen())),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF131720),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF1E232F)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.account_balance_wallet_outlined, size: 14, color: Colors.grey),
                    SizedBox(width: 8),
                    Text('Wallet 1', style: TextStyle(fontSize: 11)),
                    SizedBox(width: 12),
                    Icon(Icons.keyboard_arrow_down, size: 14, color: Colors.grey),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  static Widget _actionButton(BuildContext context, IconData icon, String label, Widget targetScreen) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => targetScreen)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF131720),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF1E232F)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: Colors.grey),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 4. ACCOUNT HEADER & TABS SECTION
// ==========================================
class AccountHeaderSection extends StatelessWidget {
  const AccountHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const CircleAvatar(radius: 12, backgroundColor: Colors.grey, child: Icon(Icons.person, size: 12, color: Colors.black)),
            const SizedBox(width: 8),
            const Text('Accouny 1 - 4229409', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(color: const Color(0xFF00C853).withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
              child: const Text('Active', style: TextStyle(fontSize: 9, color: Color(0xFF00C853), fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(color: const Color(0xFF1E232F), borderRadius: BorderRadius.circular(4)),
              child: const Text('Instant', style: TextStyle(fontSize: 9, color: Colors.grey)),
            ),
            const SizedBox(width: 24),
            InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AccountOverviewTabScreen())),
              child: const Text('Account Overview', style: TextStyle(fontSize: 11, color: Colors.grey)),
            ),
            const SizedBox(width: 16),
            InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TradingOverviewTabScreen())),
              child: const Text('Trading Overview', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white, decoration: TextDecoration.underline)),
            ),
          ],
        ),
        InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ViewCredentialsScreen())),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF131720),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF1E232F)),
            ),
            child: const Row(
              children: [
                Icon(Icons.lock_outline, size: 12, color: Colors.grey),
                SizedBox(width: 6),
                Text('View Credentials', style: TextStyle(fontSize: 11)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ==========================================
// 5. OVERVIEW CARDS (Profit/Loss & Balance)
// ==========================================
class OverviewCardsRow extends StatelessWidget {
  const OverviewCardsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfitLossAnalyticsScreen())),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF131720),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF1E232F)),
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
                          Text('Profit/Loss', style: TextStyle(fontSize: 11, color: Colors.grey)),
                          SizedBox(height: 4),
                          Text('\$7,216.47', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF00C853))),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00C853).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: const Color(0xFF00C853).withOpacity(0.4)),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.shield_outlined, size: 12, color: Color(0xFF00C853)),
                            SizedBox(width: 4),
                            Text('Low Risks', style: TextStyle(fontSize: 10, color: Color(0xFF00C853), fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Loss', style: TextStyle(fontSize: 10, color: Colors.grey)),
                          Text('23%', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text('Profit', style: TextStyle(fontSize: 10, color: Colors.grey)),
                          Row(
                            children: const [
                              Text('13.7%', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF00C853))),
                              Icon(Icons.arrow_downward, size: 10, color: Color(0xFF00C853)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0B0E14),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: CustomPaint(
                      size: const Size(double.infinity, 48),
                      painter: ProfitLossChartPainter(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _MiniDataPoint(label: 'Balance', value: '\$91,670.20'),
                      _MiniDataPoint(label: 'Equity', value: '\$91,670.20'),
                      _MiniDataPoint(label: 'Account Size', value: '\$100,000.00'),
                      _MiniDataPoint(label: 'Account Balance', value: '\$91,670.20'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 6,
          child: InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AccountBalanceHistoryScreen())),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF131720),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF1E232F)),
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
                          Text('Account Balance', style: TextStyle(fontSize: 11, color: Colors.grey)),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Text('\$91,670.20', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                              SizedBox(width: 8),
                              Text('+4.33(+4.38%)', style: TextStyle(fontSize: 11, color: Color(0xFF00C853))),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: ['1D', '1W', '1M', '3M', 'YTD', '1Y', '5Y', 'All'].map((t) => InkWell(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TimeframeDetailScreen(timeframe: t))),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: t == '1D' ? const Color(0xFF1E232F) : Colors.transparent,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(t, style: TextStyle(fontSize: 9, color: t == '1D' ? Colors.white : Colors.grey)),
                          ),
                        )).toList(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0B0E14),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: CustomPaint(
                      size: const Size(double.infinity, 120),
                      painter: AccountBalanceGraphPainter(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MiniDataPoint extends StatelessWidget {
  final String label;
  final String value;
  const _MiniDataPoint({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 9, color: Colors.grey)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

// ==========================================
// 6. TRADING OBJECTIVES METRICS ROW
// ==========================================
class TradingObjectivesSection extends StatelessWidget {
  const TradingObjectivesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Trading Objectives', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF131720),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF1E232F)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _ObjectiveCard(title: 'Trades', value: '68', change: '+5.2%', isPositive: true),
              _ObjectiveCard(title: 'Lots', value: '286', change: '+4.2%', isPositive: true),
              _ObjectiveCard(title: 'Average RRR', value: '0.00'),
              _ObjectiveCard(title: 'Win Rate', value: '65.39%'),
              _ObjectiveCard(title: 'Trading Days', value: '15', change: '+4.2%', isPositive: true),
              _ObjectiveCard(title: 'Live Profit Share', value: '80%'),
              _ObjectiveCard(title: 'Avg. Winning Trade', value: '\$458.06'),
              _ObjectiveCard(title: 'Avg. Losing Trade', value: '-\$1,021.05', isLoss: true),
            ],
          ),
        ),
      ],
    );
  }
}

class _ObjectiveCard extends StatelessWidget {
  final String title;
  final String value;
  final String? change;
  final bool isPositive;
  final bool isLoss;

  const _ObjectiveCard({
    required this.title,
    required this.value,
    this.change,
    this.isPositive = false,
    this.isLoss = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ObjectiveDetailScreen(metricName: title, metricValue: value))),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 10, color: Colors.grey)),
            const SizedBox(height: 6),
            Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: isLoss ? Colors.red : Colors.white)),
            if (change != null) ...[
              const SizedBox(height: 2),
              Text(change!, style: TextStyle(fontSize: 9, color: isPositive ? const Color(0xFF00C853) : Colors.red)),
            ]
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 7. TRADING HISTORY TABLE SECTION (25+ Items)
// ==========================================
class TradingHistorySection extends StatelessWidget {
  const TradingHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    // Generate 28 detailed trading history rows programmatically to exceed 25 items
    final List<Map<String, dynamic>> rawTrades = List.generate(28, (i) {
      final isBuy = i % 3 != 0;
      final isWin = i % 4 != 0;
      return {
        'ticket': '${210551700 + i}',
        'openTime': 'Feb ${i % 28 + 1}, 25 • 14:${i < 10 ? '0$i' : i}:15',
        'openPrice': (1.27500 + (i * 0.00045)).toStringAsFixed(5),
        'closeTime': 'Feb ${i % 28 + 1}, 25 • 15:${i < 10 ? '0$i' : i}:42',
        'close': (1.27800 + (i * 0.00032)).toStringAsFixed(5),
        'side': isBuy ? 'Buy' : 'Sell',
        'symbol': i % 2 == 0 ? 'GBP/USDx' : 'EUR/USDx',
        'volume': '${(0.02 + (i % 5) * 0.02).toStringAsFixed(2)}',
        'stopLoss': '0',
        'takeProfit': '0',
        'netProfit': isWin ? '\$${(i + 1) * 1254.30}' : '-\$${(i + 1) * 312.40}',
        'isProfit': isWin,
      };
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Trading History (28 items)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            SizedBox(
              width: 180,
              height: 30,
              child: TextField(
                style: const TextStyle(fontSize: 11),
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 10),
                  prefixIcon: const Icon(Icons.search, size: 14, color: Colors.grey),
                  filled: true,
                  fillColor: const Color(0xFF131720),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: Color(0xFF1E232F)),
                  ),
                ),
                onSubmitted: (value) => Navigator.push(context, MaterialPageRoute(builder: (_) => HistorySearchScreen(query: value))),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF131720),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF1E232F)),
          ),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(1.2),
              1: FlexColumnWidth(1.8),
              2: FlexColumnWidth(1.2),
              3: FlexColumnWidth(1.8),
              4: FlexColumnWidth(1.2),
              5: FlexColumnWidth(1.0),
              6: FlexColumnWidth(1.4),
              7: FlexColumnWidth(1.0),
              8: FlexColumnWidth(1.0),
              9: FlexColumnWidth(1.0),
              10: FlexColumnWidth(1.4),
            },
            children: [
              TableRow(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xFF1E232F))),
                ),
                children: [
                  _tableHeader('Ticket'),
                  _tableHeader('Open Time'),
                  _tableHeader('Open Price'),
                  _tableHeader('Close Time'),
                  _tableHeader('Close'),
                  _tableHeader('Side'),
                  _tableHeader('Symbol'),
                  _tableHeader('Volume'),
                  _tableHeader('Stop loss'),
                  _tableHeader('Take Profit'),
                  _tableHeader('Net Profit'),
                ],
              ),
              ...rawTrades.map((t) => _tableDataRow(
                context,
                t['ticket'],
                t['openTime'],
                t['openPrice'],
                t['closeTime'],
                t['close'],
                t['side'],
                t['symbol'],
                t['volume'],
                t['stopLoss'],
                t['takeProfit'],
                t['netProfit'],
                t['isProfit'],
              )),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _tableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Text(text, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
    );
  }

  static TableRow _tableDataRow(
      BuildContext context,
      String ticket,
      String openTime,
      String openPrice,
      String closeTime,
      String close,
      String side,
      String symbol,
      String volume,
      String stopLoss,
      String takeProfit,
      String netProfit,
      bool isProfit,
      ) {
    return TableRow(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF1E232F), width: 0.5)),
      ),
      children: [
        _clickableCell(context, ticket, TicketDetailScreen(ticketId: ticket, netProfit: netProfit)),
        _clickableCell(context, openTime, TicketDetailScreen(ticketId: ticket, netProfit: netProfit)),
        _clickableCell(context, openPrice, TicketDetailScreen(ticketId: ticket, netProfit: netProfit)),
        _clickableCell(context, closeTime, TicketDetailScreen(ticketId: ticket, netProfit: netProfit)),
        _clickableCell(context, close, TicketDetailScreen(ticketId: ticket, netProfit: netProfit)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TicketDetailScreen(ticketId: ticket, netProfit: netProfit))),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: side == 'Buy' ? const Color(0xFF00C853).withOpacity(0.15) : Colors.red.withOpacity(0.15),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(side, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: side == 'Buy' ? const Color(0xFF00C853) : Colors.red)),
            ),
          ),
        ),
        _clickableCell(context, symbol, TokenDetailScreen(symbol: symbol, price: openPrice, change: '+1.4%')),
        _clickableCell(context, volume, TicketDetailScreen(ticketId: ticket, netProfit: netProfit)),
        _clickableCell(context, stopLoss, TicketDetailScreen(ticketId: ticket, netProfit: netProfit)),
        _clickableCell(context, takeProfit, TicketDetailScreen(ticketId: ticket, netProfit: netProfit)),
        InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TicketDetailScreen(ticketId: ticket, netProfit: netProfit))),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Text(
              netProfit,
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: isProfit ? const Color(0xFF00C853) : Colors.red),
            ),
          ),
        ),
      ],
    );
  }

  static Widget _clickableCell(BuildContext context, String text, Widget targetScreen) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => targetScreen)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Text(text, style: const TextStyle(fontSize: 11, color: Colors.white70)),
      ),
    );
  }
}

// ==========================================
// 8. CUSTOM CHART PAINTERS
// ==========================================
class ProfitLossChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    final count = 24;
    final spacing = size.width / count;

    for (int i = 0; i < count; i++) {
      final isHighlighted = i >= 18;
      paint.color = isHighlighted
          ? const Color(0xFF00C853)
          : Colors.grey.withOpacity(0.25);

      final heightFactor = 0.3 + ((i * 7) % 60) / 100.0;
      final barHeight = size.height * (isHighlighted ? 0.9 : heightFactor);

      final x = i * spacing + spacing / 2;
      canvas.drawLine(
        Offset(x, size.height),
        Offset(x, size.height - barHeight),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class AccountBalanceGraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0xFF00C853)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final mutedLinePaint = Paint()
      ..color = Colors.amber.withOpacity(0.6)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF00C853).withOpacity(0.15),
          Colors.transparent,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final path = Path();
    final fillPath = Path();

    path.moveTo(0, size.height * 0.7);
    fillPath.moveTo(0, size.height);
    fillPath.lineTo(0, size.height * 0.7);

    final points = [
      Offset(0, size.height * 0.7),
      Offset(size.width * 0.15, size.height * 0.65),
      Offset(size.width * 0.3, size.height * 0.75),
      Offset(size.width * 0.45, size.height * 0.5),
      Offset(size.width * 0.55, size.height * 0.55),
      Offset(size.width * 0.65, size.height * 0.2),
      Offset(size.width * 0.75, size.height * 0.5),
      Offset(size.width * 0.85, size.height * 0.45),
      Offset(size.width, size.height * 0.4),
    ];

    for (int i = 0; i < points.length; i++) {
      if (i == 0) {
        path.moveTo(points[i].dx, points[i].dy);
      } else {
        path.lineTo(points[i].dx, points[i].dy);
        fillPath.lineTo(points[i].dx, points[i].dy);
      }
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, linePaint);

    final secondaryPath = Path()
      ..moveTo(size.width * 0.65, size.height * 0.2)
      ..lineTo(size.width * 0.72, size.height * 0.48)
      ..lineTo(size.width * 0.8, size.height * 0.35)
      ..lineTo(size.width * 0.9, size.height * 0.48)
      ..lineTo(size.width, size.height * 0.42);

    canvas.drawPath(secondaryPath, mutedLinePaint);

    final dashPaint = Paint()
      ..color = Colors.grey.withOpacity(0.4)
      ..strokeWidth = 1;

    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width * 0.65, startY),
        Offset(size.width * 0.65, startY + 4),
        dashPaint,
      );
      startY += 8;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ==========================================
// 9. INDIVIDUAL SCREENS & NAVIGATION
// ==========================================

class GftHomeOverviewScreen extends StatelessWidget {
  const GftHomeOverviewScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Amaze Trade Terminal Overview'), backgroundColor: const Color(0xFF131720)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            const Text('Global Liquidity & Ecosystem Status', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _metricCard('Total Volume 24h', '\$4.82B', '+12.4%', true)),
                const SizedBox(width: 16),
                Expanded(child: _metricCard('Active Traders', '142,890', '+5.1%', true)),
                const SizedBox(width: 16),
                Expanded(child: _metricCard('Gas Benchmark', '14 gwei', '-2.3%', false)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SearchResultScreen extends StatelessWidget {
  final String query;
  const SearchResultScreen({super.key, required this.query});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search: "$query"'), backgroundColor: const Color(0xFF131720)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            Text('Matching Results for "$query"', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ...List.generate(4, (index) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF131720), borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFF00C853).withOpacity(0.3))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${query.toUpperCase()}_TOKEN_${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  const Text('Verified', style: TextStyle(color: Color(0xFF00C853))),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class NewPairsViewScreen extends StatelessWidget {
  const NewPairsViewScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Token Pairs Stream'), backgroundColor: const Color(0xFF131720)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Live Token Pairs Discovered in the Last Hour', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: List.generate(6, (i) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: const Color(0xFF131720), borderRadius: BorderRadius.circular(8), border: Border.all(color: const Color(0xFF1E232F))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('PAIR_${i + 1}/SOL', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      const Text('+142.4%', style: TextStyle(color: Color(0xFF00C853), fontWeight: FontWeight.bold)),
                    ],
                  ),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MemeScopeScreen extends StatelessWidget {
  const MemeScopeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meme Scope Radar'), backgroundColor: const Color(0xFF131720)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Viral Meme Velocity Index', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 2.5,
                children: List.generate(4, (i) => Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: const Color(0xFF131720), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.amber.withOpacity(0.4))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('PEPE_AI_${i + 1}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      const SizedBox(height: 4),
                      const Text('Bonding Curve: 94.2%', style: TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                  ),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyPositionsScreen extends StatelessWidget {
  const MyPositionsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Active Leveraged Positions'), backgroundColor: const Color(0xFF131720)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Open Margin Positions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF131720), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF00C853))),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('GBP/USDx (Long 20x)', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('+\$1,420.50', style: TextStyle(color: Color(0xFF00C853), fontWeight: FontWeight.bold)),
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
}

class TradingCentersScreen extends StatelessWidget {
  const TradingCentersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Trading Centers Hub'), backgroundColor: const Color(0xFF131720)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: const [
            Text('Connected Liquidity Desks', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            ListTile(title: Text('Amaze Trade Prime Liquidity Desk'), subtitle: Text('Zero-slippage routing')),
            ListTile(title: Text('Raydium / Orca Aggregator'), subtitle: Text('Solana AMM pool routing')),
          ],
        ),
      ),
    );
  }
}

class TradersLeaderboardScreen extends StatelessWidget {
  const TradersLeaderboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Traders Leaderboard'), backgroundColor: const Color(0xFF131720)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Top Monthly ROI Traders', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: List.generate(5, (i) => ListTile(
                  leading: CircleAvatar(child: Text('#${i + 1}')),
                  title: const Text('EliteTrader_Alpha'),
                  trailing: const Text('+428.4% ROI', style: TextStyle(color: Color(0xFF00C853), fontWeight: FontWeight.bold)),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NetworkDetailScreen extends StatelessWidget {
  final String networkName;
  const NetworkDetailScreen({super.key, required this.networkName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Network Node: $networkName'), backgroundColor: const Color(0xFF131720)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('$networkName RPC Node Telemetry', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _metricCard('Block Height', '241,892,104', 'Synced', true)),
                const SizedBox(width: 16),
                Expanded(child: _metricCard('Avg Latency', '12ms', 'Optimal', true)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TokenDetailScreen extends StatelessWidget {
  final String symbol;
  final String price;
  final String change;
  const TokenDetailScreen({super.key, required this.symbol, required this.price, required this.change});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Token: $symbol'), backgroundColor: const Color(0xFF131720)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$symbol / USD', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(price, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF00C853))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  final String type;
  const NotificationsScreen({super.key, required this.type});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text(type), backgroundColor: const Color(0xFF131720)), body: const Padding(padding: EdgeInsets.all(24.0), child: Text('System alert logs and price triggers.')));
}

class TwitterTrackerScreen extends StatelessWidget {
  const TwitterTrackerScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Twitter Social Tracker'), backgroundColor: const Color(0xFF131720)), body: const Padding(padding: EdgeInsets.all(24.0), child: Text('Real-Time Crypto Sentiment Stream.')));
}

class ConnectWalletScreen extends StatelessWidget {
  const ConnectWalletScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Connect Web3 Wallet'), backgroundColor: const Color(0xFF131720)), body: const Padding(padding: EdgeInsets.all(24.0), child: Text('Secure wallet connection suite.')));
}

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('User Profile & Security'), backgroundColor: const Color(0xFF131720)), body: const Padding(padding: EdgeInsets.all(24.0), child: Text('Manage API keys and security settings.')));
}

class FilterModalScreen extends StatelessWidget {
  const FilterModalScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Token Filter Matrix'), backgroundColor: const Color(0xFF131720)), body: const Padding(padding: EdgeInsets.all(24.0), child: Text('Configure min liquidity and volume thresholds.')));
}

class DexelConfigScreen extends StatelessWidget {
  const DexelConfigScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Dexel Provider Settings'), backgroundColor: const Color(0xFF131720)), body: const Padding(padding: EdgeInsets.all(24.0), child: Text('Select primary DEX liquidity aggregator endpoints.')));
}

class QuickBuySettingsScreen extends StatelessWidget {
  const QuickBuySettingsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Quick Buy Configuration'), backgroundColor: const Color(0xFF131720)), body: const Padding(padding: EdgeInsets.all(24.0), child: Text('Set default gas priority fees and 1-click execution parameters.')));
}

class PresetsManagerScreen extends StatelessWidget {
  const PresetsManagerScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Trade Presets Manager'), backgroundColor: const Color(0xFF131720)), body: const Padding(padding: EdgeInsets.all(24.0), child: Text('Edit quick allocation buttons.')));
}

class WalletSelectorScreen extends StatelessWidget {
  const WalletSelectorScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Wallet Selector'), backgroundColor: const Color(0xFF131720)), body: const Padding(padding: EdgeInsets.all(24.0), child: Text('Switch between operational sub-accounts and wallets.')));
}

class AccountOverviewTabScreen extends StatelessWidget {
  const AccountOverviewTabScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Account Overview Macro'), backgroundColor: const Color(0xFF131720)), body: const Padding(padding: EdgeInsets.all(24.0), child: Text('Consolidated macro financial statement.')));
}

class TradingOverviewTabScreen extends StatelessWidget {
  const TradingOverviewTabScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Trading Overview Ledger'), backgroundColor: const Color(0xFF131720)), body: const Padding(padding: EdgeInsets.all(24.0), child: Text('Detailed execution records and performance indicators.')));
}

class ViewCredentialsScreen extends StatelessWidget {
  const ViewCredentialsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Platform Credentials'), backgroundColor: const Color(0xFF131720)), body: const Padding(padding: EdgeInsets.all(24.0), child: Text('Encrypted access keys and server connection IP.')));
}

class ProfitLossAnalyticsScreen extends StatelessWidget {
  const ProfitLossAnalyticsScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Profit / Loss Deep Dive'), backgroundColor: const Color(0xFF131720)), body: const Padding(padding: EdgeInsets.all(24.0), child: Text('Granular analysis of winning vs losing streaks.')));
}

class AccountBalanceHistoryScreen extends StatelessWidget {
  const AccountBalanceHistoryScreen({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('Account Balance History'), backgroundColor: const Color(0xFF131720)), body: const Padding(padding: EdgeInsets.all(24.0), child: Text('Full historical equity curve progression.')));
}

class TimeframeDetailScreen extends StatelessWidget {
  final String timeframe;
  const TimeframeDetailScreen({super.key, required this.timeframe});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text('Timeframe: $timeframe'), backgroundColor: const Color(0xFF131720)), body: Padding(padding: const EdgeInsets.all(24.0), child: Text('Filtered balance performance graph for $timeframe interval.')));
}

class ObjectiveDetailScreen extends StatelessWidget {
  final String metricName;
  final String metricValue;
  const ObjectiveDetailScreen({super.key, required this.metricName, required this.metricValue});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text('Objective: $metricName'), backgroundColor: const Color(0xFF131720)), body: Padding(padding: const EdgeInsets.all(24.0), child: Text('Target criteria and compliance progress for $metricName ($metricValue).')));
}

class HistorySearchScreen extends StatelessWidget {
  final String query;
  const HistorySearchScreen({super.key, required this.query});
  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: Text('History Search: $query'), backgroundColor: const Color(0xFF131720)), body: Padding(padding: const EdgeInsets.all(24.0), child: Text('Filtered historical transaction records matching query "$query".')));
}

class TicketDetailScreen extends StatelessWidget {
  final String ticketId;
  final String netProfit;
  const TicketDetailScreen({super.key, required this.ticketId, required this.netProfit});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ticket Inspection: #$ticketId'), backgroundColor: const Color(0xFF131720)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: const Color(0xFF131720), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFF1E232F))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Ticket ID: #$ticketId', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text('Net Profit Result: $netProfit', style: const TextStyle(fontSize: 14, color: Color(0xFF00C853), fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _metricCard(String title, String val, String subtitle, bool isPos) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: const Color(0xFF131720), borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFF1E232F))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        const SizedBox(height: 6),
        Text(val, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(subtitle, style: TextStyle(fontSize: 10, color: isPos ? const Color(0xFF00C853) : Colors.red)),
      ],
    ),
  );
}