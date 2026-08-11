import 'package:flutter/material.dart';

void main() {
  runApp(const DiboRuwaApp());
}

class DiboRuwaApp extends StatelessWidget {
  const DiboRuwaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AMAZEVALLEY Admin Portal',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF4F6F8),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF007A53),
          primary: const Color(0xFF007A53),
        ),
        useMaterial3: true,
      ),
      // Starts at Login Screen
      home: const LoginScreen(),
    );
  }
}

// ==========================================
// 1. LOGIN SCREEN
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
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      // Simulate API network request delay
      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        setState(() => _isLoading = false);

        // Navigate to Dashboard & Remove Login from backstack
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (context, animation, secondaryAnimation) =>
            const DashboardScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F8),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 420),
            padding: const EdgeInsets.all(32.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo Badge
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF007A53),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.waves, color: Colors.white, size: 32),
                  ),
                  const SizedBox(height: 16),

                  // Brand Title
                  const Text(
                    'AMAZEVALLEY',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Color(0xFF007A53),
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),

                  const Text(
                    'Sign in to your admin dashboard',
                    style: TextStyle(fontSize: 13, color: Colors.black45),
                  ),
                  const SizedBox(height: 32),

                  // Email Field
                  CrossAxisAlignmentColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Email Address',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _emailController,
                        style: const TextStyle(fontSize: 13),
                        decoration: InputDecoration(
                          hintText: 'Enter your email',
                          hintStyle: const TextStyle(fontSize: 13, color: Colors.black38),
                          prefixIcon: const Icon(Icons.email_outlined, size: 20),
                          filled: true,
                          fillColor: const Color(0xFFF9FAFB),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Color(0xFF007A53), width: 1.5),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!value.contains('@')) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Password Field
                  CrossAxisAlignmentColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Password',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(fontSize: 11, color: Color(0xFF007A53), fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        style: const TextStyle(fontSize: 13),
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          hintStyle: const TextStyle(fontSize: 13, color: Colors.black38),
                          prefixIcon: const Icon(Icons.lock_outline, size: 20),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              size: 20,
                              color: Colors.black45,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF9FAFB),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Color(0xFF007A53), width: 1.5),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),

                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF007A53),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: _isLoading ? null : _handleLogin,
                      child: _isLoading
                          ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                          : const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
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

// Helper Widget for Clean Form Layout
class CrossAxisAlignmentColumn extends StatelessWidget {
  final CrossAxisAlignment crossAxisAlignment;
  final List<Widget> children;

  const CrossAxisAlignmentColumn({
    super.key,
    required this.crossAxisAlignment,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: children,
    );
  }
}

// ==========================================
// 2. MAIN DASHBOARD SCREEN
// ==========================================
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedNavIndex = 0;

  final List<String> _pageTitles = [
    'Overview',
    'Drivers Management',
    'Deliveries Track',
    'Pending Requests',
    'Transaction History',
    'Customer Directory',
    'Payment Gateways',
    'Create New Post',
    'Customer Reviews',
    'Analytics & Reports',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // 1. LEFT NAVIGATION SIDEBAR
          _Sidebar(
            selectedIndex: _selectedNavIndex,
            onDestinationSelected: (index) {
              setState(() => _selectedNavIndex = index);
            },
          ),

          // 2. MAIN CONTENT AREA (DYNAMIC BODY)
          Expanded(
            child: Column(
              children: [
                // Top Header / Navbar
                _TopHeader(title: _pageTitles[_selectedNavIndex]),

                // Dynamic Body View
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _buildSelectedPage(_selectedNavIndex),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedPage(int index) {
    switch (index) {
      case 0:
        return const _OverviewView();
      case 1:
        return const _DriversView();
      case 2:
        return const _DeliveriesView();
      case 3:
        return const _RequestsView();
      case 4:
        return const _TransactionsView();
      case 5:
        return const _CustomersView();
      case 6:
        return const _PaymentsView();
      case 8:
        return const _ReviewsView();
      case 9:
        return const _ReportsView();
      default:
        return _PlaceholderView(title: _pageTitles[index]);
    }
  }
}

// ==========================================
// 3. SIDEBAR WIDGET
// ==========================================
class _Sidebar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const _Sidebar({
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    final navItems = [
      {'icon': Icons.grid_view_rounded, 'label': 'Overview'},
      {'icon': Icons.people_outline, 'label': 'Drivers'},
      {'icon': Icons.local_shipping_outlined, 'label': 'Deliveries'},
      {'icon': Icons.assignment_outlined, 'label': 'Request'},
      {'icon': Icons.swap_horiz_outlined, 'label': 'Transactions'},
      {'icon': Icons.group_outlined, 'label': 'Customers'},
      {'icon': Icons.payment_outlined, 'label': 'Payments'},
      {'icon': Icons.post_add_outlined, 'label': 'Create post'},
      {'icon': Icons.rate_review_outlined, 'label': 'Reviews'},
      {'icon': Icons.bar_chart_outlined, 'label': 'Report'},
    ];

    return Container(
      width: 220,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF007A53),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.waves, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 8),
                const Text(
                  'DIBORUWA',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF007A53),
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: navItems.length,
              itemBuilder: (context, index) {
                final isSelected = selectedIndex == index;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: ListTile(
                    dense: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    tileColor: isSelected ? const Color(0xFFE8F5E9) : null,
                    leading: Icon(
                      navItems[index]['icon'] as IconData,
                      color: isSelected ? const Color(0xFF4CAF50) : Colors.black54,
                      size: 20,
                    ),
                    title: Text(
                      navItems[index]['label'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        color: isSelected ? const Color(0xFF4CAF50) : Colors.black87,
                      ),
                    ),
                    onTap: () => onDestinationSelected(index),
                  ),
                );
              },
            ),
          ),
          ListTile(
            dense: true,
            leading: const Icon(Icons.logout, color: Colors.black54, size: 20),
            title: const Text('Logout', style: TextStyle(fontSize: 13, color: Colors.black87)),
            onTap: () {
              // Return back to Login Screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 4. TOP HEADER
// ==========================================
class _TopHeader extends StatelessWidget {
  final String title;

  const _TopHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      color: Colors.white,
      child: Row(
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(width: 40),
          Expanded(
            child: Container(
              height: 42,
              constraints: const BoxConstraints(maxWidth: 450),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F6F8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Search here...',
                  hintStyle: TextStyle(fontSize: 13, color: Colors.black38),
                  prefixIcon: Icon(Icons.search, size: 20, color: Colors.black38),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined, color: Colors.black87),
            onPressed: () {},
          ),
          const SizedBox(width: 16),
          const Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=12'),
              ),
              SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Amaze Valley', style: TextStyle(fontSize: 12,
                      fontWeight: FontWeight.bold)),
                  Text('amazevalley@gmail.com', style: TextStyle(fontSize: 10,
                      color: Colors.black45)),
                ],
              ),
              SizedBox(width: 4),
              Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.black54),
            ],
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 5. OVERVIEW PAGE
// ==========================================
class _OverviewView extends StatelessWidget {
  const _OverviewView();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: _RevenueOverviewSection()),
              SizedBox(width: 20),
              Expanded(flex: 2, child: _NewDeliveriesCard()),
            ],
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              Expanded(
                child: _MetricCard(
                  title: 'Delivered Orders',
                  value: '10,350',
                  badgeText: '4% (30 days)',
                  isPositive: true,
                  lineColor: Color(0xFF4CAF50),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _MetricCard(
                  title: 'Store visitors',
                  value: '20,350',
                  badgeText: '4% (30 days)',
                  isPositive: false,
                  lineColor: Color(0xFFE57373),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _MetricCard(
                  title: 'Customers',
                  value: '10,350',
                  badgeText: '4% (30 days)',
                  isPositive: true,
                  lineColor: Color(0xFF4CAF50),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: _OnTransitSection()),
              SizedBox(width: 16),
              Expanded(flex: 2, child: _TopCustomersSection()),
              SizedBox(width: 16),
              Expanded(flex: 2, child: Column(children: [_ReviewsSection(),
                SizedBox(height: 10,),_ReviewsSection(),SizedBox(height: 10,)
                ,_ReviewsSection(),SizedBox(height: 10,),_ReviewsSection(),SizedBox(height: 10,),_ReviewsSection()],)),
            ],
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 6. DRIVERS PAGE
// ==========================================
class _DriversView extends StatelessWidget {
  const _DriversView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Active Drivers (24)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4CAF50)),
                onPressed: () {},
                icon: const Icon(Icons.add, color: Colors.white, size: 18),
                label: const Text('Add New Driver', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: ListView.separated(
                itemCount: 8,
                separatorBuilder: (context, index) => const Divider(height: 20, color: Color(0xFFF4F6F8)),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=${index + 10}'),
                    ),
                    title: Text('Driver #${1000 + index} - John Doe', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    subtitle: const Text('Vehicle: Toyota Corolla | Reg: ABJ-492-X', style: TextStyle(fontSize: 12, color: Colors.black45)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: index % 2 == 0 ? Colors.green.shade50 : Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            index % 2 == 0 ? 'On Trip' : 'Available',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: index % 2 == 0 ? Colors.green : Colors.orange,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(Icons.more_vert, size: 18, color: Colors.black45),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 7. DELIVERIES PAGE
// ==========================================
class _DeliveriesView extends StatelessWidget {
  const _DeliveriesView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('All Delivery Orders', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 2.2,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Order #DLV-${2000 + index}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                          const Icon(Icons.local_shipping_outlined, color: Color(0xFF4CAF50), size: 18),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text('Item: Chicken Salad x 2', style: TextStyle(fontSize: 12, color: Colors.black54)),
                      const Text('Destination: Umuahia Street, off polo', style: TextStyle(fontSize: 11, color: Colors.black38)),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('\$45.00', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF4CAF50))),
                          Text('Jul ${10 + index}, 2026', style: const TextStyle(fontSize: 10, color: Colors.black38)),
                        ],
                      ),
                    ],
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

// ==========================================
// 8. REQUESTS PAGE
// ==========================================
class _RequestsView extends StatelessWidget {
  const _RequestsView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Customer Service Requests', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: ListView.separated(
                itemCount: 6,
                separatorBuilder: (context, index) => const Divider(height: 20, color: Color(0xFFF4F6F8)),
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.orange.shade100,
                      child: const Icon(Icons.assignment_late_outlined, color: Colors.orange, size: 20),
                    ),
                    title: Text('Refund Request #${500 + index}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    subtitle: const Text('Issue: Delayed delivery order. Customer requested partial refund.', style: TextStyle(fontSize: 12, color: Colors.black54)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        OutlinedButton(onPressed: () {}, child: const Text('Reject', style: TextStyle(color: Colors.red, fontSize: 12))),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4CAF50)),
                          onPressed: () {},
                          child: const Text('Approve', style: TextStyle(color: Colors.white, fontSize: 12)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 9. TRANSACTIONS PAGE
// ==========================================
class _TransactionsView extends StatelessWidget {
  const _TransactionsView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Recent Payment Transactions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('Transaction ID', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Customer', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Date', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Amount', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: List.generate(
                    8,
                        (index) => DataRow(cells: [
                      DataCell(Text('TXN-884920${index + 1}')),
                      const DataCell(Text('Chiamaka Chikezie')),
                      DataCell(Text('Aug 0${index + 1}, 2026')),
                      DataCell(Text('\$${(index + 1) * 120}.00')),
                      DataCell(
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(4)),
                          child: const Text('Successful', style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ]),
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

// ==========================================
// 10. CUSTOMERS PAGE
// ==========================================
class _CustomersView extends StatelessWidget {
  const _CustomersView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1,
        ),
        itemCount: 8,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(radius: 28, backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=${index + 20}')),
                const SizedBox(height: 8),
                Text('Customer ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const Text('Ohafia, Abia State', style: TextStyle(fontSize: 10, color: Colors.black45)),
                const SizedBox(height: 10),
                const Text('Total Spent: \$4,200', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Color(0xFF4CAF50))),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ==========================================
// 11. PAYMENTS PAGE
// ==========================================
class _PaymentsView extends StatelessWidget {
  const _PaymentsView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: const Color(0xFF007A53), borderRadius: BorderRadius.circular(16)),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Total Payouts', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      SizedBox(height: 8),
                      Text('\$1,240,000.00', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Pending Bank Transfer', style: TextStyle(color: Colors.black45, fontSize: 12)),
                      SizedBox(height: 8),
                      Text('\$14,250.00', style: TextStyle(color: Colors.black87, fontSize: 24, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 12. REVIEWS PAGE
// ==========================================
class _ReviewsView extends StatelessWidget {
  const _ReviewsView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: ListView.separated(
        itemCount: 5,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(radius: 14, backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=${index + 30}')),
                    const SizedBox(width: 8),
                    Text('User ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    const Spacer(),
                    const Row(
                      children: [
                        Icon(Icons.star, size: 14, color: Colors.amber),
                        Icon(Icons.star, size: 14, color: Colors.amber),
                        Icon(Icons.star, size: 14, color: Colors.amber),
                        Icon(Icons.star, size: 14, color: Colors.amber),
                        Icon(Icons.star_half, size: 14, color: Colors.amber),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text('Great delivery service! The food arrived warm and well-packaged.', style: TextStyle(fontSize: 12)),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ==========================================
// 13. REPORTS PAGE
// ==========================================
class _ReportsView extends StatelessWidget {
  const _ReportsView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.bar_chart, size: 64, color: Color(0xFF4CAF50)),
              SizedBox(height: 16),
              Text('Annual Financial & Operational Report Generated', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('Click below to download CSV or PDF copy.', style: TextStyle(fontSize: 12, color: Colors.black45)),
            ],
          ),
        ),
      ),
    );
  }
}

// Generic Fallback View
class _PlaceholderView extends StatelessWidget {
  final String title;

  const _PlaceholderView({required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }
}

// ==========================================
// OVERVIEW HELPER COMPONENTS
// ==========================================
class _RevenueOverviewSection extends StatelessWidget {
  const _RevenueOverviewSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F6F8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.circle, size: 8, color: Color(0xFF4CAF50)),
                        SizedBox(width: 6),
                        Text('Revenue', style: TextStyle(fontSize: 12, color: Colors.black54)),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text('\$112,340,000,000', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F6F8),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.circle, size: 8, color: Colors.orange),
                        SizedBox(width: 6),
                        Text('Pending', style: TextStyle(fontSize: 12, color: Colors.black54)),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text('\$100', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Text('2025', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    SizedBox(width: 6),
                    Icon(Icons.keyboard_arrow_down, size: 16),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const SizedBox(
            height: 140,
            child: _CustomBarChart(),
          ),
        ],
      ),
    );
  }
}

class _CustomBarChart extends StatelessWidget {
  const _CustomBarChart();

  @override
  Widget build(BuildContext context) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final heights = [0.3, 0.6, 0.35, 0.75, 0.7, 0.45, 0.55, 0.3, 0.65, 0.8, 0.9, 0.85];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(months.length, (index) {
        final isSelected = index == 4;
        final isGreen = index % 2 != 0 || index > 8;

        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (isSelected)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                margin: const EdgeInsets.only(bottom: 4),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text('\$1.1k', style: TextStyle(color: Colors.white, fontSize: 10)),
              ),
            Container(
              width: 14,
              height: 90 * heights[index],
              decoration: BoxDecoration(
                color: isGreen ? const Color(0xFF4CAF50) : const Color(0xFFE0E0E0),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 8),
            Text(months[index], style: const TextStyle(fontSize: 11, color: Colors.black45)),
          ],
        );
      }),
    );
  }
}

class _NewDeliveriesCard extends StatelessWidget {
  const _NewDeliveriesCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Text('New Delivery', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  SizedBox(width: 6),
                  CircleAvatar(radius: 10, backgroundColor: Color(0xFFF4F6F8), child: Text('4', style: TextStyle(fontSize: 10, color: Colors.black87))),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: const Row(
                  children: [
                    Text('See More', style: TextStyle(fontSize: 12, color: Color(0xFF4CAF50))),
                    Icon(Icons.chevron_right, size: 16, color: Color(0xFF4CAF50)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const _DeliveryListItem(),
          const _DeliveryListItem(),
        ],
      ),
    );
  }
}

class _DeliveryListItem extends StatelessWidget {
  const _DeliveryListItem();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=100',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(width: 50, height: 50, color: Colors.green.shade100),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Chicken Salad', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    Text('2am - 8pm', style: TextStyle(fontSize: 10, color: Colors.black45)),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Text('Vendor: ', style: TextStyle(fontSize: 10, color: Colors.black45)),
                    Text('Amaze Valley', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                    SizedBox(width: 10),
                    Text('Owner: ', style: TextStyle(fontSize: 10, color: Colors.black45)),
                    Text('Amaze Valley', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 2),
                Text('Item ID: FGFFV5675', style: TextStyle(fontSize: 9, color: Colors.black38)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String badgeText;
  final bool isPositive;
  final Color lineColor;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.badgeText,
    required this.isPositive,
    required this.lineColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                title.contains('Delivered')
                    ? Icons.check_circle_outline
                    : title.contains('Store')
                    ? Icons.storefront
                    : Icons.people_outline,
                size: 18,
                color: isPositive ? const Color(0xFF4CAF50) : Colors.orange,
              ),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontSize: 12, color: Colors.black54)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(
                width: 60,
                height: 20,
                child: CustomPaint(
                  painter: _SparklinePainter(color: lineColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                size: 12,
                color: isPositive ? const Color(0xFF4CAF50) : Colors.red,
              ),
              const SizedBox(width: 4),
              Text(
                badgeText,
                style: TextStyle(
                  fontSize: 10,
                  color: isPositive ? const Color(0xFF4CAF50) : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  final Color color;

  _SparklinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.lineTo(size.width * 0.2, size.height * 0.3);
    path.lineTo(size.width * 0.4, size.height * 0.6);
    path.lineTo(size.width * 0.6, size.height * 0.2);
    path.lineTo(size.width * 0.8, size.height * 0.5);
    path.lineTo(size.width, size.height * 0.1);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _OnTransitSection extends StatelessWidget {
  const _OnTransitSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Text('On Transit', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  SizedBox(width: 6),
                  CircleAvatar(radius: 10, backgroundColor: Color(0xFFF4F6F8)
                      , child: Text('14', style: TextStyle(fontSize: 10, color: Colors.black87))),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: const Row(
                  children: [
                    Text('See More', style: TextStyle(fontSize: 12, color: Color(0xFF4CAF50))),
                    Icon(Icons.chevron_right, size: 16, color: Color(0xFF4CAF50)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const _TransitCard(),
          const _TransitCard(),
          const _TransitCard(),
          const _TransitCard(),
          const _TransitCard(),
          const _TransitCard(),
          const _TransitCard(),
          const _TransitCard(),
          const _TransitCard(),
          const _TransitCard(),
        ],
      ),
    );
  }
}

class _TransitCard extends StatelessWidget {
  const _TransitCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://images.unsplash.com/photo-1540555700478-4be289fbecef?w=100',
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(width: 50, height: 50, color: Colors.blue.shade100),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Amaze Valley', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    Text('2am - 8pm', style: TextStyle(fontSize: 10, color: Colors.black45)),
                  ],
                ),
                SizedBox(height: 2),
                Text('Item ID: FGFFV5675 | Owner: Amaze Valley', style: TextStyle(fontSize: 10, color: Colors.black45)),
                SizedBox(height: 2),
                Text('Location: 24 Umuahia Street, off polo.', style: TextStyle(fontSize: 10, color: Colors.black38)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TopCustomersSection extends StatelessWidget {
  const _TopCustomersSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Text('Top Customers', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              SizedBox(width: 6),
              CircleAvatar(radius: 10, backgroundColor: Color(0xFFF4F6F8),
                  child: Text('14', style: TextStyle(fontSize: 10, color: Colors.black87))),
            ],
          ),
          const SizedBox(height: 12),
          ...List.generate(14, (index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: const _CustomerTile(),
          )),
        ],
      ),
    );
  }
}

class _CustomerTile extends StatelessWidget {
  const _CustomerTile();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 14,
            backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=5'),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Chiamaka Chikezie', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                Text('Ohafia, Abia state', style: TextStyle(fontSize: 9, color: Colors.black38)),
              ],
            ),
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Revenue', style: TextStyle(fontSize: 9, color: Color(0xFF4CAF50))),
              Text('\$400,000,000', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReviewsSection extends StatelessWidget {
  const _ReviewsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Text('Reviews', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  SizedBox(width: 6),
                  CircleAvatar(radius: 10, backgroundColor: Color(0xFFF4F6F8), child: Text('4', style: TextStyle(fontSize: 10, color: Colors.black87))),
                ],
              ),
              TextButton(
                onPressed: () {},
                child: const Text('See More', style: TextStyle(fontSize: 12, color: Color(0xFF4CAF50))),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              CircleAvatar(radius: 14, backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=33')),
              SizedBox(width: 8),
              Text('Kelly James', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              Spacer(),
              Row(
                children: [
                  Icon(Icons.star, size: 12, color: Colors.amber),
                  Icon(Icons.star, size: 12, color: Colors.amber),
                  Icon(Icons.star, size: 12, color: Colors.amber),
                  Icon(Icons.star, size: 12, color: Colors.amber),
                  Icon(Icons.star_border, size: 12, color: Colors.amber),
                  SizedBox(width: 4),
                  Text('4.0', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text('2am - wed - July - 2025', style: TextStyle(fontSize: 9, color: Colors.black38)),
          const SizedBox(height: 8),
          const Text(
            'Your Meal is amazing, thank you for delivering on time, i really enjoyed your food.',
            style: TextStyle(fontSize: 11, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}