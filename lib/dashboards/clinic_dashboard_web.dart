import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // ^1.0.0
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const DoctorDashboardApp());

class DoctorDashboardApp extends StatelessWidget {
  const DoctorDashboardApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0B0B0E),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      ),
      home: const DoctorDashboard(),
    );
  }
}

class DoctorDashboard extends StatefulWidget {
  const DoctorDashboard({super.key});
  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  int selectedDay = 2; // Tue 24
  final days = [
    {"day": "Sun", "date": "22"},
    {"day": "Mon", "date": "23"},
    {"day": "Tue", "date": "24"},
    {"day": "Wed", "date": "25"},
    {"day": "Thu", "date": "26"},
    {"day": "Fri", "date": "27"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(
            child: Column(
              children: [
                _buildTopBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: LayoutBuilder(
                        builder: (context, c) {
                          bool wide = c.maxWidth > 1200;
                          return wide
                              ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(flex: 3, child: _buildLeftSection()),
                              const SizedBox(width: 20),
                              Expanded(flex: 2, child: _buildCenterBody()),
                              const SizedBox(width: 20),
                              Expanded(flex: 2, child: _buildRightSection()),
                            ],
                          )
                              : Column(children: [
                            _buildLeftSection(), const SizedBox(height: 20),
                            _buildCenterBody(), const SizedBox(height: 20),
                            _buildRightSection(),
                          ]);
                        }
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

  Widget _buildSidebar() {
    final icons = [
      Icons.home_rounded, Icons.group_outlined, Icons.calendar_today_outlined,
      Icons.videocam_outlined, Icons.chat_bubble_outline, Icons.auto_awesome_outlined,
      Icons.bar_chart,
    ];
    return Container(
      width: 80,
      color: const Color(0xFF111113),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.medical_services, color: Colors.black),
          ),
          const SizedBox(height: 30),
          ...icons.map((i) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Icon(i, color: Colors.grey[600], size: 24),
          )),
          const Spacer(),
          Icon(Icons.settings_outlined, color: Colors.grey[600]),
          const SizedBox(height: 20),
          const CircleAvatar(radius: 18, child: Icon(Icons.person)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 44,
              decoration: BoxDecoration(color: const Color(0xFF1A1A1E), borderRadius: BorderRadius.circular(12)),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search employees, payroll...",
                  prefixIcon: const Icon(Icons.search, size: 20),
                  suffix: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.circular(4)),
                    child: const Text("F #", style: TextStyle(fontSize: 12)),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          const Icon(Icons.notifications_outlined),
          const SizedBox(width: 20),
          Row(
            children: [
              const CircleAvatar(child: Icon(Icons.person, size: 18)), // no network image
              const SizedBox(width: 10),
              Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Amazevalley", style: TextStyle(fontWeight:
                  FontWeight.w600)),
                  Text("amazevalley@gmail.com", style: TextStyle(fontSize: 12,
                      color: Colors.grey[500])),
                ],
              ),
              const Icon(Icons.keyboard_arrow_down)
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLeftSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("WELCOME BACK, DR. WILL", style: TextStyle(color: const Color(0xFF9FE870), fontSize: 12)),
        const SizedBox(height: 8),
        const Text("You have 6\nconsultations today", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
        const SizedBox(height: 20),
        GridView.count(
          crossAxisCount: 2, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16, mainAxisSpacing: 16, childAspectRatio: 1.4,
          children: [
            _statCard("Total patients", "1,284", "+12% vs last week", Colors.blue, _miniBarChart(Colors.blue)),
            _statCard("Today's appointments", "06", "+12% vs last week", Colors.purple, _miniBarChart(Colors.purple)),
            _statCard("Pending follow-ups", "18", "+12% vs last week", const Color(0xFF9FE870), _miniDotChart()),
            _statCard("Revenue (mo)", "\$23.8k", "+12% vs last week", Colors.grey, _miniLineChart()),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: const Color(0xFF1A1A1E), borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                const Text("AI assistant", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(color: const Color(0xFF222227), borderRadius: BorderRadius.circular(8)),
                  child: const Row(children: [Icon(Icons.auto_awesome, size: 14), SizedBox(width: 4), Text("AI Insight", style: TextStyle(fontSize: 12))]),
                )
              ]),
              Text("Smart suggestions", style: TextStyle(color: Colors.grey[500], fontSize: 12)),
              const SizedBox(height: 12),
              _aiItem(Colors.blue, "5 follow-ups pending this week", "Send reminders to keep retention high."),
              _aiItem(Colors.red, "2 high-risk patients detected", "Cardiac markers trending upward for John C. Liam B."),
              _aiItem(Colors.amber, "Patient inactive for 14 days", "Sophia Garcia hasn't logged in since April 5."),
            ],
          ),
        )
      ],
    );
  }

  Widget _statCard(String title, String value, String sub, Color color, Widget chart) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF1A1A1E), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFF222227), borderRadius: BorderRadius.circular(8)), child: Icon(Icons.person, size: 18)), const SizedBox(width: 8), Expanded(child: Text(title, style: TextStyle(color: Colors.grey[400], fontSize: 12), overflow: TextOverflow.ellipsis))]),
          const Spacer(),
          Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const Spacer(),
            SizedBox(width: 60, height: 30, child: chart)
          ]),
          const SizedBox(height: 6),
          Text(sub, style: TextStyle(color: color, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _aiItem(Color color, String title, String sub) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFF222227), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(8)), child: Icon(Icons.warning_amber_rounded, color: color, size: 18)),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.w600)), Text(sub, style: TextStyle(color: Colors.grey[500], fontSize: 12))])),
        ],
      ),
    );
  }

  Widget _buildCenterBody() {
    return Column(
      children: [
        SingleChildScrollView( // for small screens
          scrollDirection: Axis.horizontal,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(color: const Color(0xFF1A1A1E), borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: [
                const Icon(Icons.chevron_left, size: 18),
                ...List.generate(days.length, (i) => GestureDetector(
                  onTap: () => setState(() => selectedDay = i),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: selectedDay == i? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(children: [
                      Text(days[i]["day"]!, style: TextStyle(color: selectedDay == i? Colors.black : Colors.grey[500], fontSize: 12)),
                      Text(days[i]["date"]!, style: TextStyle(color: selectedDay == i? Colors.black : Colors.white, fontWeight: FontWeight.w600)),
                    ]),
                  ),
                )),
                const Icon(Icons.chevron_right, size: 18),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.videocam),
          label: const Text("Start Consultation"),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF9FE870),
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          height: 400,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.person, size: 400, color: Colors.white.withOpacity(0.05)),
              Positioned(
                top: 200,
                child: Container(
                  width: 120, height: 100,
                  decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [BoxShadow(color: Colors.red.withOpacity(0.5), blurRadius: 40)]
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _buildRightSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("Today's schedule", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          Text("6 appointments planned", style: TextStyle(color: Colors.grey[500], fontSize: 12))
        ]), const Spacer(), _viewAllBtn()]),
        const SizedBox(height: 12),
        _scheduleCard("John Carter", "09:00 • VIDEO", "Dr. Sarah Chen", true),
        Row(children: [
          Expanded(child: _scheduleCard("Emma Wilson", "09:00 • VIDEO", "", true, small: true)),
          const SizedBox(width: 12),
          Expanded(child: _scheduleCard("Emma Wilson", "09:00 • VIDEO", "", true, small: true)),
        ]),
        const SizedBox(height: 20),
        Row(children: [Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("Recent Activities", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          Text("Last 24 hours", style: TextStyle(color: Colors.grey[500], fontSize: 12))
        ]), const Spacer(), _viewAllBtn()]),
        const SizedBox(height: 12),
        _activityItem(Icons.calendar_today, "New booking", "John Carter"),
        _activityItem(Icons.bar_chart, "Lab report uploaded", "Emma Wilson"),
        _activityItem(Icons.mail_outline, "New message", "Olivia Martinez"),
      ],
    );
  }

  Widget _scheduleCard(String name, String time, String doctor, bool completed, {bool small = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFF1A1A1E), borderRadius: BorderRadius.circular(16)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const CircleAvatar(radius: 16, child: Icon(Icons.person, size: 16)),
          const SizedBox(width: 8),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: const TextStyle(fontWeight: FontWeight.w600)), Text(time, style: TextStyle(color: Colors.grey[500], fontSize: 12))])),
          if(completed) Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: Colors.green.withOpacity(0.2), borderRadius: BorderRadius.circular(20)), child: const Text("Completed", style: TextStyle(color: Colors.green, fontSize: 10))),
        ]),
        if(doctor.isNotEmpty)...[
          const SizedBox(height: 8),
          Row(children: [Icon(Icons.person_outline, size: 14, color: Colors.grey[500]), const SizedBox(width: 4), Expanded(child: Text(doctor, style: TextStyle(color: Colors.grey[500], fontSize: 12))), const Icon(Icons.edit_outlined, size: 16)])
        ],
        if(small)...[
          const SizedBox(height: 8),
          Row(children: [const Icon(Icons.play_circle_outline, size: 18), const Spacer(), const Icon(Icons.more_vert, size: 18)])
        ]
      ]),
    );
  }

  Widget _activityItem(IconData icon, String title, String name) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFF1A1A1E), borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFF222227), borderRadius: BorderRadius.circular(8)), child: Icon(icon, size: 18)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: TextStyle(color: Colors.grey[400], fontSize: 12)), Text(name, style: const TextStyle(fontWeight: FontWeight.w600))])),
        Text("2 min ago", style: TextStyle(color: Colors.grey[500], fontSize: 11))
      ]),
    );
  }

  Widget _viewAllBtn() => Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: const Color(0xFF222227), borderRadius: BorderRadius.circular(8)), child: const Text("View all", style: TextStyle(fontSize: 12)));

  // CHARTS UPDATED FOR fl_chart 1.0.0
  Widget _miniBarChart(Color color) => BarChart(
      BarChartData(
        barGroups: List.generate(5, (i) => BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(fromY: 0, toY: (i+1)*2.0, color: color, width: 4, borderRadius: BorderRadius.circular(2)) // fromY added
            ]
        )),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(show: false),
      )
  );

  Widget _miniLineChart() => LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: [const FlSpot(0,1),const FlSpot(1,3),const FlSpot(2,2),const FlSpot(3,4),const FlSpot(4,3)],
            color: Colors.grey,
            dotData: FlDotData(show: false),
            barWidth: 2,
          )
        ],
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(show: false),
      )
  );

  Widget _miniDotChart() => CustomPaint(painter: _DotPainter());
}

class _DotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF9FE870);
    for(int i=0; i<5; i++) {
      canvas.drawCircle(Offset(i*12.0, size.height/2 + (i%2==0? -5:5)), 2, paint);
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}