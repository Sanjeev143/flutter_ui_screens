import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const PayCommissionApp());
}

class PayCommissionApp extends StatelessWidget {
  const PayCommissionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '8th Pay Commission Portal',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0E17), // Deep Navy
        primaryColor: const Color(0xFFD4AF37), // Regal Gold
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFD4AF37),
          secondary: Color(0xFF00E5FF),
          surface: Color(0xFF121826),
        ),
      ),
      home: const MainPortalScreen(),
    );
  }
}

// ==========================================
// GLASSMORPHIC CONTAINER HELPER
// ==========================================
class GlassCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? borderColor;

  const GlassCard({
    super.key,
    required this.child,
    this.borderRadius = 16,
    this.padding,
    this.margin,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: Container(
            padding: padding ?? const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.06),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: borderColor ?? Colors.white.withOpacity(0.12),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

// ==========================================
// MAIN PORTAL DASHBOARD SHELL
// ==========================================
class MainPortalScreen extends StatefulWidget {
  const MainPortalScreen({super.key});

  @override
  State<MainPortalScreen> createState() => _MainPortalScreenState();
}

class _MainPortalScreenState extends State<MainPortalScreen> {
  int _selectedIndex = 0;

  final List<String> _menuTitles = [
    '8th Pay Calculator',
    'Pension Estimator',
    'Arrears Tracker',
    'Pay Matrix Table',
    'DA/HRA Revisions',
    'Service History',
    'Official Circulars',
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isDesktop = screenWidth >= 900;

    return Scaffold(
      drawer: !isDesktop
          ? Drawer(
        backgroundColor: const Color(0xFF0F172A),
        child: _Sidebar(
          selectedIndex: _selectedIndex,
          onSelected: (index) {
            setState(() => _selectedIndex = index);
            Navigator.pop(context); // Close mobile drawer
          },
        ),
      )
          : null,
      body: Stack(
        children: [
          // Background ambient glass light blobs
          Positioned(
            top: -40,
            left: -40,
            child: Container(
              width: 200,
              height: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFD4AF37),
                boxShadow: [
                  BoxShadow(color: Color(0xFFD4AF37), blurRadius: 150, spreadRadius: 30),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -40,
            child: Container(
              width: 220,
              height: 220,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF00E5FF),
                boxShadow: [
                  BoxShadow(color: Color(0xFF00E5FF), blurRadius: 160, spreadRadius: 40),
                ],
              ),
            ),
          ),

          // Main Responsive Layout Structure
          SafeArea(
            child: Row(
              children: [
                if (isDesktop)
                  SizedBox(
                    width: 250,
                    child: _Sidebar(
                      selectedIndex: _selectedIndex,
                      onSelected: (index) => setState(() => _selectedIndex = index),
                    ),
                  ),
                Expanded(
                  child: Column(
                    children: [
                      _TopHeader(title: _menuTitles[_selectedIndex], isDesktop: isDesktop),
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: _buildView(_selectedIndex),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildView(int index) {
    switch (index) {
      case 0:
        return const _SalaryCalculatorView();
      case 1:
        return const _PensionEstimatorView();
      case 2:
        return const _ArrearsTrackerView();
      case 3:
        return const _PayMatrixView();
      case 4:
        return const _DaHraRevisionsView();
      case 5:
        return const _ServiceHistoryView();
      case 6:
        return const _OfficialCircularsView();
      default:
        return const _SalaryCalculatorView();
    }
  }
}

// ==========================================
// SIDEBAR NAVIGATION
// ==========================================
class _Sidebar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const _Sidebar({required this.selectedIndex, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0A0E17).withOpacity(0.85),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFD4AF37),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.account_balance, color: Colors.black, size: 22),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('8th CPC PORTAL', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))),
                  Text('Govt. Employee Scheme', style: TextStyle(fontSize: 10, color: Colors.white54)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text('CORE SERVICES', style: TextStyle(fontSize: 10, color: Colors.white38, fontWeight: FontWeight.bold, letterSpacing: 1.1)),
          const SizedBox(height: 10),
          _navItem(0, Icons.calculate_outlined, 'Salary Calculator'),
          _navItem(1, Icons.elderly_outlined, 'Pension Estimator'),
          _navItem(2, Icons.history_toggle_off, 'Arrears Tracker'),
          _navItem(3, Icons.grid_on_outlined, 'Pay Matrix Table'),
          const SizedBox(height: 20),
          const Text('RESOURCES', style: TextStyle(fontSize: 10, color: Colors.white38, fontWeight: FontWeight.bold, letterSpacing: 1.1)),
          const SizedBox(height: 10),
          _navItem(4, Icons.trending_up, 'DA & HRA Rates'),
          _navItem(5, Icons.badge_outlined, 'Service Record'),
          _navItem(6, Icons.description_outlined, 'Circulars & Orders'),
        ],
      ),
    );
  }

  Widget _navItem(int index, IconData icon, String label) {
    final bool isSelected = selectedIndex == index;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: ListTile(
        dense: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tileColor: isSelected ? const Color(0xFFD4AF37).withOpacity(0.18) : Colors.transparent,
        leading: Icon(icon, color: isSelected ? const Color(0xFFD4AF37) : Colors.white54, size: 18),
        title: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isSelected ? const Color(0xFFD4AF37) : Colors.white70,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        onTap: () => onSelected(index),
      ),
    );
  }
}

// ==========================================
// TOP HEADER
// ==========================================
class _TopHeader extends StatelessWidget {
  final String title;
  final bool isDesktop;

  const _TopHeader({required this.title, required this.isDesktop});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          if (!isDesktop)
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          GlassCard(
            borderRadius: 10,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: const [
                Icon(Icons.stars, color: Color(0xFFD4AF37), size: 14),
                SizedBox(width: 4),
                Text('2.86x', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          const CircleAvatar(
            radius: 14,
            backgroundColor: Color(0xFFD4AF37),
            child: Icon(Icons.person, color: Colors.black, size: 16),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 1. MOBILE-RESPONSIVE SALARY CALCULATOR
// ==========================================
class _SalaryCalculatorView extends StatefulWidget {
  const _SalaryCalculatorView();

  @override
  State<_SalaryCalculatorView> createState() => _SalaryCalculatorViewState();
}

class _SalaryCalculatorViewState extends State<_SalaryCalculatorView> {
  double _7thPayBasic = 35400;
  double _fitmentFactor = 2.57;

  final List<String> _payLevels = [
    'Level 1 (GP 1800)',
    'Level 6 (GP 4200)',
    'Level 10 (GP 5400)',
    'Level 14 (GP 10000)'
  ];

  late String _selectedPayLevel;

  @override
  void initState() {
    super.initState();
    _selectedPayLevel = _payLevels[1];
  }

  double get _8thPayBasic => _7thPayBasic * _fitmentFactor;
  double get _estimatedDa => _8thPayBasic * 0.50;
  double get _estimatedHra => _8thPayBasic * 0.27;
  double get _grossSalary => _8thPayBasic + _estimatedDa + _estimatedHra;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 700;

        Widget inputCard = GlassCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Employee Pay Input', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))),
              const SizedBox(height: 14),

              // Dropdown
              const Text('Select 7th CPC Pay Level', style: TextStyle(fontSize: 11, color: Colors.white70)),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: _selectedPayLevel,
                isExpanded: true,
                dropdownColor: const Color(0xFF121826),
                style: const TextStyle(color: Colors.white, fontSize: 12),
                decoration: _inputDeco(),
                items: _payLevels.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, overflow: TextOverflow.ellipsis),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedPayLevel = newValue;
                      if (newValue.contains('Level 1')) _7thPayBasic = 18000;
                      if (newValue.contains('Level 6')) _7thPayBasic = 35400;
                      if (newValue.contains('Level 10')) _7thPayBasic = 56100;
                      if (newValue.contains('Level 14')) _7thPayBasic = 144200;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              // Slider
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('7th CPC Basic (₹)', style: TextStyle(fontSize: 11, color: Colors.white70)),
                  Text('₹${_7thPayBasic.toInt()}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF00E5FF))),
                ],
              ),
              Slider(
                value: _7thPayBasic,
                min: 18000,
                max: 250000,
                divisions: 100,
                activeColor: const Color(0xFFD4AF37),
                onChanged: (val) => setState(() => _7thPayBasic = val),
              ),
              const SizedBox(height: 12),

              // Choice Chips
              const Text('Proposed Fitment Multiplier', style: TextStyle(fontSize: 11, color: Colors.white70)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [2.57, 2.86, 3.00, 3.68].map((factor) {
                  final isSelected = _fitmentFactor == factor;
                  return ChoiceChip(
                    label: Text('${factor}x', style: const TextStyle(fontSize: 11)),
                    selected: isSelected,
                    selectedColor: const Color(0xFFD4AF37),
                    backgroundColor: Colors.white10,
                    labelStyle: TextStyle(color: isSelected ? Colors.black : Colors.white, fontWeight: FontWeight.bold),
                    onSelected: (selected) => setState(() => _fitmentFactor = factor),
                  );
                }).toList(),
              ),
            ],
          ),
        );

        Widget summaryCard = GlassCard(
          padding: const EdgeInsets.all(16),
          borderColor: const Color(0xFFD4AF37).withOpacity(0.4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Estimated 8th CPC Revision', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 4),
              Text('Selected: $_selectedPayLevel', style: const TextStyle(fontSize: 10, color: Color(0xFFD4AF37))),
              const SizedBox(height: 16),
              _salaryRow('Revised Basic Pay', '₹${_8thPayBasic.toInt()}', isHighlight: true),
              const Divider(color: Colors.white10, height: 20),
              _salaryRow('Dearness Allowance (DA 50%)', '₹${_estimatedDa.toInt()}'),
              _salaryRow('House Rent Allowance (HRA 27%)', '₹${_estimatedHra.toInt()}'),
              const Divider(color: Colors.white10, height: 20),
              _salaryRow('Estimated Gross Monthly', '₹${_grossSalary.toInt()}', isTotal: true),
            ],
          ),
        );

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: isMobile
              ? Column(
            children: [
              inputCard,
              const SizedBox(height: 16),
              summaryCard,
            ],
          )
              : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 3, child: inputCard),
              const SizedBox(width: 16),
              Expanded(flex: 2, child: summaryCard),
            ],
          ),
        );
      },
    );
  }

  InputDecoration _inputDeco() {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white.withOpacity(0.05),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFD4AF37))),
    );
  }

  Widget _salaryRow(String label, String value, {bool isHighlight = false, bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(label, style: TextStyle(fontSize: isTotal ? 12 : 11, color: isTotal ? Colors.white : Colors.white70, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal))),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 16 : (isHighlight ? 14 : 12),
              fontWeight: FontWeight.bold,
              color: isTotal ? const Color(0xFF00E5FF) : (isHighlight ? const Color(0xFFD4AF37) : Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 2. RESPONSIVE PENSION ESTIMATOR
// ==========================================
class _PensionEstimatorView extends StatelessWidget {
  const _PensionEstimatorView();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 600;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Pension & Commutation Estimator', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: isMobile ? 1 : 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: isMobile ? 2.5 : 1.6,
                children: [
                  _pensionCard('Basic Pension (50%)', '₹52,400 / mo', Icons.payments_outlined),
                  _pensionCard('Commuted Amount (40%)', '₹28,15,400', Icons.account_balance_wallet_outlined),
                  _pensionCard('Reduced Monthly Pension', '₹31,440 / mo', Icons.savings_outlined),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _pensionCard(String title, String val, IconData icon) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFFD4AF37), size: 24),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 11, color: Colors.white54)),
          const SizedBox(height: 4),
          Text(val, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
        ],
      ),
    );
  }
}

// ==========================================
// 3. RESPONSIVE ARREARS TRACKER
// ==========================================
class _ArrearsTrackerView extends StatelessWidget {
  const _ArrearsTrackerView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GlassCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Calculated Retrospective Arrears', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: 5,
                separatorBuilder: (c, i) => const Divider(color: Colors.white10),
                itemBuilder: (c, i) => ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  title: Text('Quarter #${i + 1} Arrear Installment', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  subtitle: const Text('Status: Pending Cabinet Approval', style: TextStyle(color: Colors.white38, fontSize: 10)),
                  trailing: Text('₹${(i + 1) * 34200}', style: const TextStyle(color: Color(0xFF00E5FF), fontWeight: FontWeight.bold, fontSize: 13)),
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
// 4. RESPONSIVE PAY MATRIX TABLE VIEW
// ==========================================
class _PayMatrixView extends StatelessWidget {
  const _PayMatrixView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GlassCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('8th Pay Commission Matrix Table', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  child: DataTable(
                    columnSpacing: 20,
                    columns: const [
                      DataColumn(label: Text('Index Level', style: TextStyle(fontSize: 11))),
                      DataColumn(label: Text('Level 1 (GP 1800)', style: TextStyle(fontSize: 11))),
                      DataColumn(label: Text('Level 6 (GP 4200)', style: TextStyle(fontSize: 11))),
                      DataColumn(label: Text('Level 10 (GP 5400)', style: TextStyle(fontSize: 11))),
                    ],
                    rows: List.generate(
                      8,
                          (i) => DataRow(cells: [
                        DataCell(Text('Cell Stage ${i + 1}', style: const TextStyle(fontSize: 11))),
                        DataCell(Text('₹${((i + 1) * 18000 * 2.57).toInt()}', style: const TextStyle(fontSize: 11))),
                        DataCell(Text('₹${((i + 1) * 35400 * 2.57).toInt()}', style: const TextStyle(fontSize: 11))),
                        DataCell(Text('₹${((i + 1) * 56100 * 2.57).toInt()}', style: const TextStyle(fontSize: 11))),
                      ]),
                    ),
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
// 5. RESPONSIVE DA & HRA REVISIONS VIEW
// ==========================================
class _DaHraRevisionsView extends StatelessWidget {
  const _DaHraRevisionsView();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 600;

        Widget card1 = GlassCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Current DA Rate', style: TextStyle(fontSize: 11, color: Colors.white54)),
              SizedBox(height: 6),
              Text('50.00%', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF00E5FF))),
              SizedBox(height: 2),
              Text('Effective from Jan 2026', style: TextStyle(fontSize: 9, color: Colors.white38)),
            ],
          ),
        );

        Widget card2 = GlassCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('HRA City Revision (X/Y/Z)', style: TextStyle(fontSize: 11, color: Colors.white54)),
              SizedBox(height: 6),
              Text('30% / 20% / 10%', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))),
              SizedBox(height: 2),
              Text('Merged with Basic at 50% DA Threshold', style: TextStyle(fontSize: 9, color: Colors.white38)),
            ],
          ),
        );

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              isMobile
                  ? Column(children: [card1, const SizedBox(height: 12), card2])
                  : Row(children: [Expanded(child: card1), const SizedBox(width: 12), Expanded(child: card2)]),
              const SizedBox(height: 16),
              Expanded(
                child: GlassCard(
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    children: const [
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(Icons.check_circle_outline, color: Color(0xFF00E5FF), size: 18),
                        title: Text('July 2026 Estimated DA Hike (+4%)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        subtitle: Text('Expected revised rate: 54%', style: TextStyle(fontSize: 10, color: Colors.white38)),
                      ),
                      Divider(color: Colors.white10),
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(Icons.check_circle_outline, color: Color(0xFF00E5FF), size: 18),
                        title: Text('January 2026 Approved DA Hike (+4%)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        subtitle: Text('Revised rate from 46% to 50%', style: TextStyle(fontSize: 10, color: Colors.white38)),
                      ),
                    ],
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

// ==========================================
// 6. SERVICE HISTORY VIEW
// ==========================================
class _ServiceHistoryView extends StatelessWidget {
  const _ServiceHistoryView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GlassCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 22,
                  backgroundColor: Color(0xFFD4AF37),
                  child: Icon(Icons.person, color: Colors.black, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Rajesh Kumar Sharma', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                      Text('Emp ID: GOI-884920 | Section Officer', style: TextStyle(fontSize: 10, color: Colors.white54)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Promotion Milestones', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.star, color: Color(0xFFD4AF37), size: 16),
                    title: Text('MACP 2nd Financial Upgradation', style: TextStyle(fontSize: 12)),
                    subtitle: Text('Granted Level 10 Pay Scale - Aug 2022', style: TextStyle(fontSize: 10, color: Colors.white38)),
                  ),
                  Divider(color: Colors.white10),
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.work, color: Colors.white54, size: 16),
                    title: Text('Initial Appointment as Assistant', style: TextStyle(fontSize: 12)),
                    subtitle: Text('Central Secretariat Service - Jan 2012', style: TextStyle(fontSize: 10, color: Colors.white38)),
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

// ==========================================
// 7. OFFICIAL CIRCULARS VIEW
// ==========================================
class _OfficialCircularsView extends StatelessWidget {
  const _OfficialCircularsView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GlassCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Ministry Notifications', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: 4,
                separatorBuilder: (c, i) => const Divider(color: Colors.white10),
                itemBuilder: (c, i) => ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.picture_as_pdf, color: Colors.redAccent, size: 20),
                  title: Text('Gazette Order No. 8-CPC/2026/0${i + 1}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  subtitle: const Text('Department of Expenditure', style: TextStyle(fontSize: 10, color: Colors.white38)),
                  trailing: const Icon(Icons.download, size: 18, color: Color(0xFF00E5FF)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}