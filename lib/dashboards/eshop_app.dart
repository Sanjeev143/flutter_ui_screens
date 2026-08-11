import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const EShopApp());
}

class EShopApp extends StatelessWidget {
  const EShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'e\$hop - Valley Admin Dashboard',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF10141D),
        primaryColor: const Color(0xFF3B82F6),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF3B82F6),
          surface: Color(0xFF181F2A),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

// ==========================================
// 1. GLASSMORPHIC CONTAINER HELPER
// ==========================================
class GlassContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const GlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 16,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: const Color(0xFF1E293B).withOpacity(0.55),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: Colors.white.withOpacity(0.08),
                width: 1.2,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 2. LOGIN SCREEN
// ==========================================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'amazevalley@gmail.com');
  final _passwordController = TextEditingController(text: 'password123');
  bool _isLoading = false;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() => _isLoading = false);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardMainScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF3B82F6),
                boxShadow: [
                  BoxShadow(color: Color(0xFF3B82F6), blurRadius: 150, spreadRadius: 50),
                ],
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: GlassContainer(
                borderRadius: 24,
                padding: const EdgeInsets.all(32),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.shopping_bag_outlined, color: Color(0xFF3B82F6), size: 32),
                            const SizedBox(width: 10),
                            RichText(
                              text: const TextSpan(
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(text: 'e', style: TextStyle(color: Colors.white)),
                                  TextSpan(text: '\$hop Valley', style:
                                  TextStyle(color: Color(0xFF3B82F6))),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        const Text('Sign In', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        const Text('Access your e\$hop admin portal', style: TextStyle(color: Colors.white54, fontSize: 13)),
                        const SizedBox(height: 24),
                        const Text('Email Address', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _emailController,
                          decoration: _inputDecoration('Enter email', Icons.email_outlined),
                          validator: (val) => val == null || !val.contains('@') ? 'Enter a valid email' : null,
                        ),
                        const SizedBox(height: 16),
                        const Text('Password', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: _inputDecoration('Enter password', Icons.lock_outline),
                          validator: (val) => val == null || val.length < 6 ? 'Password too short' : null,
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3B82F6),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: _isLoading ? null : _login,
                            child: _isLoading
                                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                                : const Text('Sign In to Portal', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                          ),
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

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, size: 20, color: Colors.white54),
      filled: true,
      fillColor: Colors.white.withOpacity(0.05),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF3B82F6))),
    );
  }
}

// ==========================================
// 3. MAIN DASHBOARD SHELL
// ==========================================
class DashboardMainScreen extends StatefulWidget {
  const DashboardMainScreen({super.key});

  @override
  State<DashboardMainScreen> createState() => _DashboardMainScreenState();
}

class _DashboardMainScreenState extends State<DashboardMainScreen> {
  int _selectedNavIndex = 0;

  final List<String> _pageTitles = [
    'Market Analytics',
    'E-commerce',
    'Products Info',
    'Customer Info',
    'Apps Directory',
    'Layouts',
    'Authentication',
    'Products Directory',
    'Widgets Studio',
    'Forms System',
    'Tables Overview',
    'Charts Studio',
    'Icons Set',
    'Maps Navigation',
    'Share Center',
  ];

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 1100;

    return Scaffold(
      drawer: !isDesktop
          ? Drawer(
        child: _Sidebar(
          selectedIndex: _selectedNavIndex,
          onSelected: (index) {
            setState(() => _selectedNavIndex = index);
            Navigator.pop(context);
          },
        ),
      )
          : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isDesktop)
            SizedBox(
              width: 240,
              child: _Sidebar(
                selectedIndex: _selectedNavIndex,
                onSelected: (index) => setState(() => _selectedNavIndex = index),
              ),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TopHeader(isDesktop: isDesktop),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _buildPage(_selectedNavIndex),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const _MarketAnalyticsView();
      case 1:
        return const _EcommerceView();
      case 2:
        return const _ProductsInfoView();
      case 3:
        return const _CustomerInfoView();
      case 7:
        return const _ProductsView();
      case 8:
        return const _WidgetsView();
      case 9:
        return const _FormsView();
      case 10:
        return const _TablesView();
      case 11:
        return const _ChartsView();
      case 13:
        return const _MapsView();
      default:
        return _GenericView(title: _pageTitles[index]);
    }
  }
}

// ==========================================
// 4. SIDEBAR NAVIGATION
// ==========================================
class _Sidebar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const _Sidebar({required this.selectedIndex, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF141A23),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          Row(
            children: [
              const Icon(Icons.shopping_bag_outlined, color: Color(0xFF3B82F6), size: 28),
              const SizedBox(width: 8),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(text: 'e', style: TextStyle(color: Colors.white)),
                    TextSpan(text: '\$hop', style: TextStyle(color: Color(0xFF3B82F6))),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('MENU', style: TextStyle(fontSize: 10, color: Colors.white38, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _navItem(0, Icons.grid_view_rounded, 'Dashboards'),
          _subNavItem(0, 'Market Analytics'),
          _subNavItem(1, 'E-commerce'),
          _subNavItem(2, 'Products info'),
          _subNavItem(3, 'Customer info'),
          _navItem(4, Icons.grid_view_outlined, 'Apps'),
          _navItem(5, Icons.layers_outlined, 'Layouts'),
          const SizedBox(height: 16),
          const Text('PAGES', style: TextStyle(fontSize: 10, color: Colors.white38, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          _navItem(6, Icons.person_outline, 'Authentication'),
          _navItem(7, Icons.inventory_2_outlined, 'Products'),
          _navItem(8, Icons.widgets_outlined, 'Widgets'),
          _navItem(9, Icons.insert_drive_file_outlined, 'Forms'),
          _navItem(10, Icons.table_chart_outlined, 'Tables'),
          _navItem(11, Icons.bar_chart_outlined, 'Charts'),
          _navItem(12, Icons.interests_outlined, 'Icons'),
          _navItem(13, Icons.location_on_outlined, 'Maps'),
          _navItem(14, Icons.share_outlined, 'Share'),
          const Divider(color: Colors.white10, height: 32),
          ListTile(
            dense: true,
            leading: const Icon(Icons.logout, color: Colors.redAccent, size: 20),
            title: const Text('Logout', style: TextStyle(color: Colors.redAccent, fontSize: 13)),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
            },
          ),
        ],
      ),
    );
  }

  Widget _navItem(int index, IconData icon, String label) {
    final bool isSelected = selectedIndex == index;
    return ListTile(
      dense: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      tileColor: isSelected ? const Color(0xFF1E293B) : null,
      leading: Icon(icon, color: isSelected ? const Color(0xFF3B82F6) : Colors.white54, size: 18),
      title: Text(label, style: TextStyle(fontSize: 13, color: isSelected ? Colors.white : Colors.white70, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
      onTap: () => onSelected(index),
    );
  }

  Widget _subNavItem(int index, String label) {
    final bool isSelected = selectedIndex == index;
    return Padding(
      padding: const EdgeInsets.only(left: 32.0, top: 2, bottom: 2),
      child: ListTile(
        dense: true,
        visualDensity: VisualDensity.compact,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        title: Text('—  $label', style: TextStyle(fontSize: 12, color: isSelected ? const Color(0xFF3B82F6) : Colors.white38)),
        onTap: () => onSelected(index),
      ),
    );
  }
}

// ==========================================
// 5. TOP HEADER NAVBAR
// ==========================================
class _TopHeader extends StatelessWidget {
  final bool isDesktop;

  const _TopHeader({required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: const Color(0xFF141A23),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (!isDesktop)
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          IconButton(
            icon: const Icon(Icons.menu_open_rounded, size: 20, color: Colors.white54),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              height: 38,
              constraints: const BoxConstraints(maxWidth: 350),
              decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(8)),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(fontSize: 12, color: Colors.white38),
                  prefixIcon: Icon(Icons.search, size: 18, color: Colors.white38),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ),
          ),
          const Spacer(),
          // App Launcher
          IconButton(icon: const Icon(Icons.grid_view_outlined, size: 20, color: Colors.white70), onPressed: () {}),
          // Shopping Bag Badge (5)
          Stack(
            children: [
              IconButton(icon: const Icon(Icons.shopping_bag_outlined, size: 20, color: Colors.white70), onPressed: () {}),
              Positioned(
                right: 6,
                top: 6,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: const Color(0xFF3B82F6),
                  child: const Text('5', style: TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          // Notification Bell Badge (3)
          Stack(
            children: [
              IconButton(icon: const Icon(Icons.notifications_none, size: 20, color: Colors.white70), onPressed: () {}),
              Positioned(
                right: 6,
                top: 6,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.amber,
                  child: const Text('3', style: TextStyle(fontSize: 9, color: Colors.black, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          const SizedBox(width: 6),
          // Flag Country Dropdown
          Row(
            children: [
              const Text('🇺🇸', style: TextStyle(fontSize: 16)),
              const Icon(Icons.keyboard_arrow_down, size: 14, color: Colors.white54),
            ],
          ),
          const SizedBox(width: 12),
          const CircleAvatar(radius: 14, backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=12')),
          if (isDesktop) ...[
            const SizedBox(width: 8),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Amaze Valley', style: TextStyle(fontSize: 12, fontWeight:
                FontWeight.bold, color: Colors.white)),
                Text('Admin', style: TextStyle(fontSize: 10, color: Colors.white38)),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

// ==========================================
// 6. MARKET ANALYTICS VIEW
// ==========================================
class _MarketAnalyticsView extends StatelessWidget {
  const _MarketAnalyticsView();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting & Top Control Pills
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Good Day, Amaze! 👋', style: TextStyle(fontSize: 20,
                      fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text("Here's what's updating with your E-shop today", style: TextStyle(fontSize: 12, color: Colors.white38)),
                ],
              ),
              Wrap(
                spacing: 8,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(8)),
                    child: const Row(
                      children: [
                        Text('01 Oct, 2023 to 31 Oct, 2023', style: TextStyle(fontSize: 11, color: Colors.white70)),
                        SizedBox(width: 6),
                        Icon(Icons.calendar_today_outlined, size: 14, color: Color(0xFF3B82F6)),
                      ],
                    ),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF10B981)),
                    onPressed: () {},
                    icon: const Icon(Icons.add_circle_outline, size: 16, color: Colors.white),
                    label: const Text('Add Product', style: TextStyle(fontSize: 12, color: Colors.white)),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.show_chart, size: 18, color: Color(0xFF3B82F6)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),

          // 4 Main Stat Cards
          LayoutBuilder(
            builder: (context, constraints) {
              final double width = constraints.maxWidth;
              final int crossAxisCount = width > 1100 ? 4 : (width > 600 ? 2 : 1);
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 2.2,
                children: const [
                  _StatCard(title: 'TOTAL EARNING', value: '\$757.40k', badge: '↗ +21.67 %', isPositive: true, icon: Icons.attach_money, actionText: 'View net earnings'),
                  _StatCard(title: 'ORDERS', value: '42,378', badge: '↘ - 5.75 %', isPositive: false, icon: Icons.shopping_bag_outlined, actionText: 'View all orders'),
                  _StatCard(title: 'CUSTOMERS', value: '1,85,45M', badge: '↗ +32.01 %', isPositive: true, icon: Icons.person_outline, actionText: 'See details'),
                  _StatCard(title: 'MY BALANCE', value: '\$245.15k', badge: 'Withdraw', isPositive: true, icon: Icons.account_balance_wallet_outlined, actionText: 'Withdraw money'),
                ],
              );
            },
          ),
          const SizedBox(height: 20),

          // Revenue Chart + Sales By Locations
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: _RevenueStatusChartCard()),
              const SizedBox(width: 16),
              Expanded(flex: 2, child: _SalesByLocationCard()),
            ],
          ),
          const SizedBox(height: 20),

          // Bottom References Row
          const Row(
            children: [
              Expanded(child: _BottomRefCard(title: 'Sourcing Reference', buttonText: 'Viewport v')),
              SizedBox(width: 16),
              Expanded(child: _BottomRefCard(title: 'Current Purchase History', buttonText: 'Purchase Report')),
            ],
          ),
        ],
      ),
    );
  }
}

// Stat Card Widget
class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String badge;
  final bool isPositive;
  final IconData icon;
  final String actionText;

  const _StatCard({
    required this.title,
    required this.value,
    required this.badge,
    required this.isPositive,
    required this.icon,
    required this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 10, color: Colors.white54, fontWeight: FontWeight.bold)),
              Text(badge, style: TextStyle(fontSize: 11, color: isPositive ? Colors.greenAccent : Colors.redAccent, fontWeight: FontWeight.bold)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(8)),
                child: Icon(icon, size: 18, color: isPositive ? Colors.greenAccent : const Color(0xFF3B82F6)),
              ),
            ],
          ),
          Text(actionText, style: const TextStyle(fontSize: 11, color: Colors.white38, decoration: TextDecoration.underline)),
        ],
      ),
    );
  }
}

// Revenue Status Chart Card
class _RevenueStatusChartCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Revenue Status', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Row(
                children: ['ALL', '1W', '1M', '6M', '1Y'].map((label) {
                  final bool isSelected = label == 'ALL';
                  return Container(
                    margin: const EdgeInsets.only(left: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF3B82F6) : Colors.transparent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Sub-metrics Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _chartMetric('7,589', 'Orders'),
              _chartMetric('\$22.54k', 'Earning'),
              _chartMetric('\$1,200', 'Refunds'),
              _chartMetric('16.25%', 'Conversation Ratio', color: Colors.greenAccent),
            ],
          ),
          const SizedBox(height: 20),
          // Chart Canvas
          SizedBox(
            height: 220,
            child: Stack(
              children: [
                CustomPaint(
                  size: Size.infinite,
                  painter: _BarLineChartPainter(),
                ),
                // Tooltip Box Overlay
                Positioned(
                  left: 140,
                  top: 50,
                  child: GlassContainer(
                    padding: const EdgeInsets.all(8),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Date: 23/10/23', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Row(children: [CircleAvatar(radius: 3, backgroundColor: Color(0xFF3B82F6)), SizedBox(width: 4), Text('Order: 33 Sales', style: TextStyle(fontSize: 9))]),
                        Row(children: [CircleAvatar(radius: 3, backgroundColor: Colors.greenAccent), SizedBox(width: 4), Text('Sold: \$1300.34', style: TextStyle(fontSize: 9))]),
                        Row(children: [CircleAvatar(radius: 3, backgroundColor: Colors.orangeAccent), SizedBox(width: 4), Text('Refund: 6 Sales', style: TextStyle(fontSize: 9))]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(radius: 4, backgroundColor: Color(0xFF3B82F6)),
              SizedBox(width: 4),
              Text('Order', style: TextStyle(fontSize: 10, color: Colors.white54)),
              SizedBox(width: 16),
              CircleAvatar(radius: 4, backgroundColor: Colors.greenAccent),
              SizedBox(width: 4),
              Text('Sold', style: TextStyle(fontSize: 10, color: Colors.white54)),
              SizedBox(width: 16),
              CircleAvatar(radius: 4, backgroundColor: Colors.orangeAccent),
              SizedBox(width: 4),
              Text('Refund', style: TextStyle(fontSize: 10, color: Colors.white54)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chartMetric(String val, String label, {Color? color}) {
    return Column(
      children: [
        Text(val, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.white38)),
      ],
    );
  }
}

class _BarLineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final barPaint = Paint()..color = const Color(0xFF3B82F6).withOpacity(0.85);
    final greenLinePaint = Paint()
      ..color = Colors.greenAccent
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    final orangeLinePaint = Paint()
      ..color = Colors.orangeAccent.withOpacity(0.6)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final double barGap = size.width / 13;

    for (int i = 0; i < 12; i++) {
      double x = (i * barGap) + 30;
      double barHeight = (i % 4 == 0 ? 0.8 : (i % 3 == 0 ? 0.45 : 0.65)) * (size.height - 30);
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(x, (size.height - 30) - barHeight, 14, barHeight), const Radius.circular(3)),
        barPaint,
      );
    }

    // Green line graph
    Path greenPath = Path();
    greenPath.moveTo(30, size.height * 0.7);
    greenPath.lineTo(size.width * 0.25, size.height * 0.3);
    greenPath.lineTo(size.width * 0.5, size.height * 0.6);
    greenPath.lineTo(size.width * 0.75, size.height * 0.25);
    greenPath.lineTo(size.width - 30, size.height * 0.5);
    canvas.drawPath(greenPath, greenLinePaint);

    // Orange dashed line graph
    Path orangePath = Path();
    orangePath.moveTo(30, size.height * 0.85);
    orangePath.lineTo(size.width * 0.3, size.height * 0.7);
    orangePath.lineTo(size.width * 0.6, size.height * 0.8);
    orangePath.lineTo(size.width - 30, size.height * 0.65);
    canvas.drawPath(orangePath, orangeLinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Sales by Location Card
class _SalesByLocationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locations = [
      {'name': 'South America', 'val': 0.74},
      {'name': 'North America', 'val': 0.62},
      {'name': 'Europe', 'val': 0.86},
      {'name': 'Australia', 'val': 0.51},
      {'name': 'Asia', 'val': 0.72},
      {'name': 'Africa', 'val': 0.60},
    ];

    return GlassContainer(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Sales by Locations', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFF3B82F6), borderRadius: BorderRadius.circular(4)),
                child: const Text('Area Report', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // World Map Graphic
          Container(
            height: 110,
            decoration: BoxDecoration(
              color: const Color(0xFF0F172A),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(Icons.public, size: 70, color: Color(0xFF3B82F6)),
                  Icon(Icons.map_outlined, size: 90, color: Colors.white10),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...locations.map((loc) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(loc['name'] as String, style: const TextStyle(fontSize: 11, color: Colors.white70)),
                      Text('${((loc['val'] as double) * 100).toInt()}%', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  LinearProgressIndicator(
                    value: loc['val'] as double,
                    backgroundColor: Colors.white10,
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

// Bottom Reference Card
class _BottomRefCard extends StatelessWidget {
  final String title;
  final String buttonText;

  const _BottomRefCard({required this.title, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(color: const Color(0xFF3B82F6), borderRadius: BorderRadius.circular(6)),
            child: Text(buttonText, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 7. UNIQUE DUMMY VIEWS FOR ALL MENU ITEMS
// ==========================================

// E-commerce View
class _EcommerceView extends StatelessWidget {
  const _EcommerceView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GlassContainer(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('E-commerce Store Management', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 2.5),
                itemCount: 6,
                itemBuilder: (context, i) => GlassContainer(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const CircleAvatar(backgroundColor: Color(0xFF3B82F6), child: Icon(Icons.store, color: Colors.white)),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Category Store #${i + 1}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          Text('${(i + 1) * 120} Products Active', style: const TextStyle(fontSize: 11, color: Colors.white38)),
                        ],
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

// Products Info View
class _ProductsInfoView extends StatelessWidget {
  const _ProductsInfoView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GlassContainer(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Products Information Hub', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                itemCount: 5,
                separatorBuilder: (c, i) => const Divider(color: Colors.white10),
                itemBuilder: (c, i) => ListTile(
                  leading: const Icon(Icons.inventory_2_outlined, color: Color(0xFF3B82F6)),
                  title: Text('Product Item SKU-${1000 + i}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: const Text('Stock level: 450 units | Vendor: Apple Inc.', style: TextStyle(color: Colors.white38, fontSize: 11)),
                  trailing: const Text('\$299.00', style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Customer Info View
class _CustomerInfoView extends StatelessWidget {
  const _CustomerInfoView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GlassContainer(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Customer Directory Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.2),
                itemCount: 8,
                itemBuilder: (c, i) => GlassContainer(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=${i + 15}')),
                      const SizedBox(height: 8),
                      Text('Customer #${i + 1}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      const Text('Total Spent: \$1,240', style: TextStyle(fontSize: 10, color: Colors.greenAccent)),
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

// Products Catalog View
class _ProductsView extends StatelessWidget {
  const _ProductsView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GlassContainer(
        padding: const EdgeInsets.all(20),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_bag, size: 48, color: Color(0xFF3B82F6)),
              SizedBox(height: 12),
              Text('Products Catalog Module', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('Manage inventory stock, discounts, and SKUs', style: TextStyle(color: Colors.white38, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}

// Widgets View
class _WidgetsView extends StatelessWidget {
  const _WidgetsView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GlassContainer(
        padding: const EdgeInsets.all(20),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.widgets, size: 48, color: Colors.amber),
              SizedBox(height: 12),
              Text('UI Widgets Library', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('Glassmorphic cards, custom indicators & badges', style: TextStyle(color: Colors.white38, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}

// Forms View
class _FormsView extends StatelessWidget {
  const _FormsView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GlassContainer(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Form Input Controls', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(labelText: 'Product Name', border: OutlineInputBorder())),
            const SizedBox(height: 12),
            const TextField(decoration: InputDecoration(labelText: 'Price (\$)', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: () {}, child: const Text('Save Form Data')),
          ],
        ),
      ),
    );
  }
}

// Tables View
class _TablesView extends StatelessWidget {
  const _TablesView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GlassContainer(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: DataTable(
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Item Name')),
              DataColumn(label: Text('Price')),
              DataColumn(label: Text('Status')),
            ],
            rows: List.generate(
              6,
                  (i) => DataRow(cells: [
                DataCell(Text('SKU-00${i + 1}')),
                DataCell(Text('Product Item ${i + 1}')),
                DataCell(Text('\$${(i + 1) * 45}')),
                const DataCell(Text('In Stock', style: TextStyle(color: Colors.greenAccent))),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

// Charts View
class _ChartsView extends StatelessWidget {
  const _ChartsView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GlassContainer(
        padding: const EdgeInsets.all(20),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.bar_chart, size: 48, color: Colors.greenAccent),
              SizedBox(height: 12),
              Text('Advanced Charts Studio', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('Line graphs, bar charts, and area projections', style: TextStyle(color: Colors.white38, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}

// Maps View
class _MapsView extends StatelessWidget {
  const _MapsView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GlassContainer(
        padding: const EdgeInsets.all(20),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.map_outlined, size: 48, color: Color(0xFF3B82F6)),
              SizedBox(height: 12),
              Text('Global Operations Map', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text('Live location tracking for order deliveries', style: TextStyle(color: Colors.white38, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}

// Generic Screen Placeholder
class _GenericView extends StatelessWidget {
  final String title;

  const _GenericView({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GlassContainer(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.space_dashboard_outlined, size: 48, color: Color(0xFF3B82F6)),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Module View active & responsive', style: TextStyle(color: Colors.white38, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}