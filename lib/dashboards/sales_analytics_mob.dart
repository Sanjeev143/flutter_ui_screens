import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const SalesApp());

class SalesApp extends StatelessWidget {
  const SalesApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8F8F8),
        textTheme: GoogleFonts.interTextTheme(),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const ProgressScreen(),
    const PlanScreen(), // 3rd tab
    const PlaceholderScreen(title: "Messages"),
    const PlaceholderScreen(title: "Settings"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {"icon": Icons.home, "label": "Dashboard"},
      {"icon": Icons.speed, "label": "Progress"},
      {"icon": Icons.bar_chart, "label": "Plan"},
      {"icon": Icons.chat_bubble_outline, "label": ""},
      {"icon": Icons.sync, "label": ""},
    ];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: const BoxDecoration(color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          bool isSelected = _currentIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _currentIndex = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected? Colors.black : Colors.transparent,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  Icon(items[index]["icon"] as IconData,
                      color: isSelected? Colors.white : Colors.grey[600]),
                  if (isSelected)...[
                    const SizedBox(width: 6),
                    Text(items[index]["label"] as String,
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600))
                  ]
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

// 1. DASHBOARD SCREEN
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              const Text("Dashboard", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
              const Spacer(),
              CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.notifications_none, color: Colors.black))
            ]),
            const SizedBox(height: 20),
            // Sales Target Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(colors: [Color(0xFFFF9A3D), Color(0xFFFFC371)]),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), shape: BoxShape.circle),
                    child: const Icon(Icons.speed, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  const Text("Sales target reached 65%", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 12),
                  Stack(
                    children: [
                      Container(height: 8, decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), borderRadius: BorderRadius.circular(10))),
                      Container(width: MediaQuery.of(context).size.width * 0.5, height: 8, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10))),
                      Positioned(right: 0, top: -10, child: Text("1,000/3,000", style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 12)))
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text("Product Summary", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12, mainAxisSpacing: 12,
              children: [
                _summaryCard(Icons.shopping_bag_outlined, "Orders", "21,142", "+4,00%", Colors.green),
                _summaryCard(Icons.remove_red_eye_outlined, "Product views", "56,342", "+3,00%", Colors.red),
                _summaryCard(Icons.credit_card, "New products", "11,142", "+1,32%", Colors.red),
                _summaryCard(Icons.verified_outlined, "Best seller", "10,000", "+2,01%", Colors.green),
              ],
            ),
            const SizedBox(height: 12),
            _summaryCard(Icons.attach_money, "Total profit", "\$456,2K", "+1,30%", Colors.green, fullWidth: true),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard(IconData icon, String title, String value, String change, Color changeColor, {bool fullWidth = false}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Icon(icon, size: 20),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: changeColor.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
            child: Text(change, style: TextStyle(color: changeColor, fontSize: 12, fontWeight: FontWeight.w600)),
          )
        ]),
        const SizedBox(height: 12),
        Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
      ]),
    );
  }
}

// 2. PROGRESS SCREEN - with Map
class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Progress", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),
            _segmentControl(["Daily", "Monthly", "Yearly"], 1),
            const SizedBox(height: 20),
            // Boost Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(colors: [Color(0xFFFF9A3D), Color(0xFFFFC371)]),
              ),
              child: Row(children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text("Boost Your Sales", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                  Text("Boost your sales performance", style: TextStyle(color: Colors.white.withOpacity(0.9))),
                  const SizedBox(height: 8),
                  Text("Learn tips ↗", style: TextStyle(color: Colors.white, decoration: TextDecoration.underline)),
                ])),
                const Icon(Icons.rocket_launch, size: 60, color: Colors.white)
              ]),
            ),
            const SizedBox(height: 20),
            const Text("Sales by countries", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(children: [
                // Fake Map with pins
                SizedBox(
                  height: 180,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(Icons.public, size: 200, color: Colors.grey[200]),
                      Positioned(top: 70, left: 140, child: _mapPin("India")),
                      Positioned(top: 60, right: 60, child: Container(width: 6, height: 6, decoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle))),
                      Positioned(bottom: 40, left: 40, child: Container(width: 6, height: 6, decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle))),
                    ],
                  ),
                ),
                _countryRow(Colors.blue, "India", "\$156.90", "15%"),
                _countryRow(Colors.orange, "United States", "\$271.96", "26%"),
                _countryRow(Colors.blue, "Indonesia", "\$209.20", "20%"),
                const SizedBox(height: 8),
                TextButton(onPressed: (){}, child: const Text("See all countries", style: TextStyle(color: Color(0xFFFF9A3D))))
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget _mapPin(String label) => Column(children: [
    Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
        child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 12))),
    Container(width: 2, height: 10, color: Colors.black)
  ]);

  Widget _countryRow(Color color, String country, String amount, String percent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text("$country • $amount"),
        const Spacer(),
        Text(percent, style: const TextStyle(fontWeight: FontWeight.w600))
      ]),
    );
  }
}

// 3. PLAN SCREEN - with Chart
class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Plan", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),
            _segmentControl(["Daily", "Monthly", "Yearly"], 1),
            const SizedBox(height: 20),
            // Total Profit Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Row(children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text("Total profit", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  const Text("\$456,2K", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700)),
                ]),
                const Spacer(),
                SizedBox(width: 80, height: 40, child: _miniBarChart())
              ]),
            ),
            const SizedBox(height: 20),
            const Text("Report", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: _reportCard(Icons.speed, "Product output", "113,112", "+1,12%", Colors.red)),
              const SizedBox(width: 12),
              Expanded(child: _reportCard(Icons.wallet, "Expenses", "42,342", "+0,32%", Colors.green)),
            ]),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text("Target Marketing", style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 20),
                SizedBox(height: 200, child: _lineChart())
              ]),
            )
          ],
        ),
      ),
    );
  }

  Widget _reportCard(IconData icon, String title, String value, String change, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [Icon(icon), const Spacer(), Text(change, style: TextStyle(color: color, fontSize: 12))]),
        const SizedBox(height: 12),
        Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 13)),
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
      ]),
    );
  }

  Widget _miniBarChart() => BarChart(BarChartData(
    barGroups: List.generate(5, (i) => BarChartGroupData(x: i, barRods: [BarChartRodData(fromY: 0, toY: (i+1)*2.0, color: const Color(0xFFFF9A3D), width: 8, borderRadius: BorderRadius.circular(4))])),
    gridData: FlGridData(show: false), borderData: FlBorderData(show: false), titlesData: FlTitlesData(show: false),
  ));

  Widget _lineChart() => LineChart(LineChartData(
    lineBarsData: [LineChartBarData(
      spots: [const FlSpot(0,400),const FlSpot(1,500),const FlSpot(2,450),const FlSpot(3,650),const FlSpot(4,600),const FlSpot(5,700),const FlSpot(6,800)],
      color: const Color(0xFFFF9A3D), barWidth: 2, dotData: FlDotData(show: true),
    )],
    gridData: FlGridData(show: false), borderData: FlBorderData(show: false),
    titlesData: FlTitlesData(bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, meta) {
      const months = ["Jan","Feb","Mar","Apr","May","Jun","Jul"];
      return Text(months[v.toInt()], style: TextStyle(color: Colors.grey[500], fontSize: 12));
    }))),
  ));
}

Widget _segmentControl(List<String> options, int selected) {
  return Container(
    padding: const EdgeInsets.all(4),
    decoration: BoxDecoration(color: const Color(0xFFEEEEEE), borderRadius: BorderRadius.circular(30)),
    child: Row(
      children: List.generate(options.length, (i) => Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(color: i == selected? Colors.white : Colors.transparent, borderRadius: BorderRadius.circular(30)),
          child: Center(child: Text(options[i], style: TextStyle(fontWeight: i == selected? FontWeight.w600 : FontWeight.normal))),
        ),
      )),
    ),
  );
}

class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700)));
  }
}