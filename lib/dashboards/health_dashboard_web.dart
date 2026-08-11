import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const VitalHealthApp());
}

class VitalHealthApp extends StatelessWidget {
  const VitalHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VitalHealth',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF7F8FA),
        textTheme: GoogleFonts.interTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6C5DD3)),
        useMaterial3: true,
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
  String selectedTab = "Today";
  String selectedMenu = "Doctor";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 240,
            color: Colors.white,
            child: Column(
              children: [
                _buildLogo(),
                Expanded(child: _buildSidebarMenu()),
              ],
            ),
          ),
          // Main Content
          Expanded(
            child: Column(
              children: [
                _buildTopBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildStatCards(),
                        const SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 3, child: _buildPatientChart()),
                            const SizedBox(width: 20),
                            Expanded(flex: 1, child: _buildCalendar()),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildPatientTable(),
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

  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFF6C5DD3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.health_and_safety, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 10),
          Text("VitalHealth", style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _buildSidebarMenu() {
    final menuItems = [
      {"icon": Icons.dashboard_outlined, "title": "Dashboard"},
      {"icon": Icons.person_outline, "title": "Your Account"},
      {"icon": Icons.medical_services_outlined, "title": "Doctor", "sub": ["Add Doctor", "Doctor list"]},
      {"icon": Icons.group_outlined, "title": "Patient"},
      {"icon": Icons.apartment_outlined, "title": "Departments"},
      {"icon": Icons.calendar_month_outlined, "title": "Schedule"},
      {"icon": Icons.event_note_outlined, "title": "Appointment"},
      {"icon": Icons.bar_chart_outlined, "title": "Report"},
      {"icon": Icons.people_alt_outlined, "title": "Human Resources"},
      {"icon": Icons.bed_outlined, "title": "Bed Manager"},
    ];

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      children: [
        _menuItem(Icons.dashboard_outlined, "Dashboard"),
        _menuItem(Icons.person_outline, "Your Account"),
        const Padding(padding: EdgeInsets.only(left: 12, top: 16, bottom: 8),
            child: Text("APPLICATIONS", style: TextStyle(fontSize: 11, color: Colors.grey))),
        _expandableMenu("Doctor", true, ["Add Doctor", "Doctor list"]),
        _menuItem(Icons.group_outlined, "Patient"),
        _menuItem(Icons.apartment_outlined, "Departments"),
        _menuItem(Icons.calendar_month_outlined, "Schedule"),
        _menuItem(Icons.event_note_outlined, "Appointment"),
        _menuItem(Icons.bar_chart_outlined, "Report"),
        _menuItem(Icons.people_alt_outlined, "Human Resources"),
        _menuItem(Icons.bed_outlined, "Bed Manager"),
        const Padding(padding: EdgeInsets.only(left: 12, top: 16, bottom: 8),
            child: Text("OTHERS", style: TextStyle(fontSize: 11, color: Colors.grey))),
        _menuItem(Icons.payment_outlined, "Payment"),
        _menuItem(Icons.mail_outline, "Mail"),
        _menuItem(Icons.widgets_outlined, "Widgets"),
        const SizedBox(height: 20),
        _menuItem(Icons.logout, "Log Out", color: Colors.red),
      ],
    );
  }

  Widget _menuItem(IconData icon, String title, {Color color = Colors.black87}) {
    bool isSelected = selectedMenu == title;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: isSelected? const Color(0xFFECE8FF) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, size: 20, color: isSelected? const Color(0xFF6C5DD3) : color),
        title: Text(title, style: TextStyle(color: isSelected? const Color(0xFF6C5DD3) : color, fontWeight: isSelected? FontWeight.w600 : FontWeight.w400)),
        onTap: () => setState(() => selectedMenu = title),
        dense: true,
      ),
    );
  }

  Widget _expandableMenu(String title, bool expanded, List<String> subItems) {
    return Column(
      children: [
        _menuItem(Icons.medical_services_outlined, title),
        if(expanded)
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Column(
              children: subItems.map((e) => ListTile(
                title: Text(e, style: const TextStyle(fontSize: 14)),
                dense: true,
                onTap: (){},
              )).toList(),
            ),
          )
      ],
    );
  }

  Widget _buildTopBar() {
    return Container(
      height: 70,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: const Color(0xFFF7F8FA),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          const SizedBox(width: 20),
          const Icon(Icons.wb_sunny_outlined),
          Switch(value: true, onChanged: (_) {}),
          const Icon(Icons.nightlight_round_outlined),
          const SizedBox(width: 20),
          Stack(children: [
            const Icon(Icons.notifications_outlined),
            Positioned(right: 0, child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle)))
          ]),
          const SizedBox(width: 20),
          const Icon(Icons.mail_outline),
          const SizedBox(width: 20),
          const Text("Amazevalley"),
          const SizedBox(width: 8),
          CircleAvatar(backgroundImage: NetworkImage("https://i.pravatar.cc/40?img=1")),
          const SizedBox(width: 10),
          const Icon(Icons.settings_outlined),
        ],
      ),
    );
  }

  Widget _buildStatCards() {
    return Row(
      children: [
        _statCard("Visitors", "4,592", "+15.9%", Icons.person, "Stay informed with real-time data"),
        _statCard("Doctors", "260", "+15.9%", Icons.medical_services, "Stay updated with essential details", bg: const Color(0xFFE8F4FF)),
        _statCard("Patient", "540", "+15.0%", Icons.group, "Keep track of patient information"),
        _statCard("Total Bed", "1205", "Available", Icons.bed, "110 Bed Private\n215 Bed General", isBed: true),
      ].map((w) => Expanded(child: Padding(padding: const EdgeInsets.only(right: 16), child: w))).toList(),
    );
  }

  Widget _statCard(String title, String value, String sub, IconData icon, String desc, {Color bg = Colors.white, bool isBed = false}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [Icon(icon, size: 20), const SizedBox(width: 8), Text(title), const Spacer(), const Icon(Icons.more_horiz)]),
          const SizedBox(height: 12),
          Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                child: Text(sub, style: const TextStyle(color: Colors.green, fontSize: 12)))
          ]),
          const SizedBox(height: 8),
          Text(desc, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildPatientChart() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Text("Patient Overview", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const Spacer(),
            _legend("On Time", Colors.teal),
            const SizedBox(width: 12),
            _legend("On Late", const Color(0xFFD1C5F0)),
          ]),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, _) => Text("${v.toInt()}am", style: const TextStyle(fontSize: 10)))),
                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, interval: 20)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: [FlSpot(10, 40), FlSpot(11, 60), FlSpot(12, 40), FlSpot(13, 60), FlSpot(14, 50), FlSpot(15, 65), FlSpot(16, 40)],
                    color: Colors.teal,
                    dotData: FlDotData(show: true),
                  ),
                  LineChartBarData(
                    spots: [FlSpot(10, 60), FlSpot(11, 40), FlSpot(12, 45), FlSpot(13, 35), FlSpot(14, 50), FlSpot(15, 70), FlSpot(16, 45)],
                    color: const Color(0xFFD1C5F0),
                    dotData: FlDotData(show: true),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _legend(String text, Color color) {
    return Row(children: [Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)), const SizedBox(width: 4), Text(text, style: const TextStyle(fontSize: 12))]);
  }

  Widget _buildCalendar() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          const Text("Calendar", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.chevron_left)),
            const Text("July 2026", style: TextStyle(fontWeight: FontWeight.w600)),
            IconButton(onPressed: (){}, icon: const Icon(Icons.chevron_right)),
          ]),
          const SizedBox(height: 10),
          Wrap(
            spacing: 4, runSpacing: 4,
            children: List.generate(35, (i) => Container(
              width: 32, height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: i == 6? const Color(0xFFECE8FF) : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text("${i-2 < 1? '' : i-2}", style: TextStyle(fontWeight: i==6?FontWeight.bold:FontWeight.normal)),
            )),
          ),
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            _legend("Appointment", Colors.orange),
            _legend("Meeting", Colors.red),
            _legend("Surgery", Colors.purple),
          ])
        ],
      ),
    );
  }

  Widget _buildPatientTable() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text("Patient Overview", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              Text("Lorem ipsum dolor sit amet consectetur", style: TextStyle(color: Colors.grey[600], fontSize: 12))
            ]),
            const Spacer(),
            ...["Today", "Weekly", "Monthly", "Yearly"].map((e) => Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: ChoiceChip(
                label: Text(e, style: TextStyle(fontSize: 12.0),),
                selected: selectedTab == e,
                onSelected: (_) => setState(() => selectedTab = e),
                selectedColor: const Color(0xFFECE8FF),
              ),
            ))
          ]),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text("No")),
                DataColumn(label: Text("Name")),
                DataColumn(label: Text("Age",style: TextStyle(fontSize: 14.0)
                ),),
                DataColumn(label: Text("Date of Birth")),
                DataColumn(label: Text("Status")),
                DataColumn(label: Text("Email address")),
                DataColumn(label: Text("Phone")),
                DataColumn(label: Text("Action")),
              ],
              rows: List.generate(4, (i) => DataRow(cells: [
                DataCell(Text("0${i+2}", style: TextStyle(fontSize: 12.0))),
                DataCell(Row(children: [
                  CircleAvatar(backgroundImage: NetworkImage("https://i.pravatar.cc/40?img=${i+2}")),
                  const SizedBox(width: 8),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Text("Nevaeh Simmons",style: TextStyle(fontSize: 12.0)), Text("Melati Room",
                          style: TextStyle(fontSize: 12, color: Colors.grey))])
                ])),
                const DataCell(Text("23",style: TextStyle(fontSize: 12.0))),
                const DataCell(Text("23 February 2023",style: TextStyle(fontSize: 12.0))),
                DataCell(Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                    child: const Row(children: [Icon(Icons.circle, size: 8,
                        color: Colors.green), SizedBox(width: 4), Text("Active",style: TextStyle(fontSize: 12.0))]))),
                const DataCell(Text("nevaeh@example.com",style: TextStyle(fontSize: 12.0))),
                const DataCell(Text("(316) 555-0116",style: TextStyle(fontSize: 12.0))),
                DataCell(Row(children: [IconButton(onPressed: (){}, icon: const Icon(Icons.edit_outlined, size: 18)), IconButton(onPressed: (){}, icon: const Icon(Icons.delete_outline, size: 18, color: Colors.red))])),
              ])),
            ),
          )
        ],
      ),
    );
  }
}