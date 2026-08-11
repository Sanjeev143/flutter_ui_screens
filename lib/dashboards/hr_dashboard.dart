import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const HrDashboardApp());

class HrDashboardApp extends StatelessWidget {
  const HrDashboardApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Amazevalley",
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isDesktop = constraints.maxWidth > 1100;
            bool isTablet = constraints.maxWidth > 700 && constraints.maxWidth <= 1100;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main Content
                Expanded(
                  flex: isDesktop? 3 : 1,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _TopNav(),
                        const SizedBox(height: 20),
                        _Header(),
                        const SizedBox(height: 20),
                        isDesktop || isTablet
                            ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 1, child: _LeftColumn()),
                            const SizedBox(width: 20),
                            Expanded(flex: 2, child: _CenterColumn()),
                          ],
                        )
                            : Column(
                          children: [
                            _LeftColumn(),
                            const SizedBox(height: 20),
                            _CenterColumn(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Right Sidebar - hide on mobile
                if (isDesktop)
                  SizedBox(width: 360, child: _RightSidebar()),
                if (isTablet)
                  SizedBox(width: 300, child: _RightSidebar()),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TopNav extends StatefulWidget {
  @override
  State<_TopNav> createState() => _TopNavState();
}

class _TopNavState extends State<_TopNav> {
  int selected = 0;
  final tabs = ["Dashboard", "Calendar", "Projects", "Team", "Documents"];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const CircleAvatar(backgroundColor: Color(0xFF8FD19E), child: Icon(Icons.grid_4x4, color: Colors.white)),
          const SizedBox(width: 12),
          ...List.generate(tabs.length, (i) {
            bool isActive = selected == i;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: ChoiceChip(
                label: Text(tabs[i]),
                selected: isActive,
                onSelected: (_) => setState(() => selected = i),
                backgroundColor: Colors.white,
                selectedColor: const Color(0xFF8FD19E),
                labelStyle: TextStyle(color: isActive? Colors.white : Colors.black54),
                shape: StadiumBorder(side: BorderSide(color: Colors.grey.shade200)),
              ),
            );
          })
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text("Portal ", style: TextStyle(color: Colors.grey)),
            const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
            const Text(" Dashboard", style: TextStyle(color: Colors.grey)),
            const Spacer(),
            Wrap(spacing: 10, children: [
              OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.add), label: const Text("Add widget")),
              OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.calendar_today), label: const Text("18 - 22 November")),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8FD19E)),
                  onPressed: () {},
                  icon: const Icon(Icons.description),
                  label: const Text("Add report")),
            ])
          ],
        ),
        const SizedBox(height: 12),
        const Text("Good morning Amaze", style: TextStyle(fontSize: 28,
            fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class _LeftColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ProfileCard(),
        const SizedBox(height: 20),
        _AverageWorkTimeCard(),
      ],
    );
  }
}

class _ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.network(
                "https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400",
                height: 300, fit: BoxFit.cover, width: double.infinity),
          ),
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Chris Jonathan", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      Text("General manager", style: TextStyle(color: Colors.white70, fontSize: 12)),
                    ],
                  ),
                  const Spacer(),
                  CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.phone, color: Colors.black87, size: 18)),
                  const SizedBox(width: 8),
                  const CircleAvatar(backgroundColor: Colors.black, child: Icon(Icons.mail, color: Colors.white, size: 18)),
                ],
              ),
            ),
          ),
          Positioned(
            top: 160, left: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20)),
              child: const Text("4+ years experience ✨", style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          )
        ],
      ),
    );
  }
}

class _AverageWorkTimeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Average work time"),
          Row(children: [
            const Text("46 hours", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(width: 8),
            Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: const Color(0xFF8FD19E).withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
              child: const Text("+0.5%", style: TextStyle(color: Color(0xFF4CAF50))),
            )
          ]),
          const SizedBox(height: 20),
          SizedBox(height: 100, child: CustomPaint(painter: LineChartPainter())),
          const Text("Total work hours include extra hours", style: TextStyle(color: Colors.grey, fontSize: 12))
        ],
      ),
    );
  }
}

class _CenterColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [Expanded(child: _HoursCard()), const SizedBox(width: 20), Expanded(child: _TeamTypeCard())]),
        const SizedBox(height: 20),
        Row(children: [Expanded(child: _TotalEmployeeCard()), const SizedBox(width: 20), Expanded(child: _HiringStatsCard())]),
      ],
    );
  }
}

class _HoursCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const CircleAvatar(child: Icon(Icons.timer)),
            const Spacer(),
            Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: const Color(0xFF8FD19E), borderRadius: BorderRadius.circular(6)), child: const Text("+0.5%", style: TextStyle(color: Colors.white, fontSize: 12))),
          ]),
          const Text("46.5", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const Text("avg hours / weeks", style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          SizedBox(height: 60, child: CustomPaint(painter: DotChartPainter())),
          const Text("2 Hours 10 Hours", style: TextStyle(fontSize: 12, color: Colors.grey))
        ],
      ),
    );
  }
}

class _TeamTypeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFF4A7C8E), borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          Row(children: [
            const CircleAvatar(backgroundColor: Colors.white24, child: Icon(Icons.group, color: Colors.white)),
            const Spacer(),
            const Text("+2.6%", style: TextStyle(color: Colors.white)),
            const Icon(Icons.arrow_downward, color: Colors.white, size: 16)
          ]),
          const Text("151%", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
          const Text("Onsite team", style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Row(children: [
              const CircleAvatar(child: Icon(Icons.public)),
              const SizedBox(width: 10),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text("38%", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const Text("Remote team"),
              ]),
              const Spacer(),
              const Text("+2.6%", style: TextStyle(color: Colors.green))
            ]),
          )
        ],
      ),
    );
  }
}

class _TotalEmployeeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [const Text("Total employee"), const Spacer(), IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward))]),
          const Text("Track your team", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Center(child: Stack(alignment: Alignment.center, children: [
            SizedBox(height: 120, width: 120, child: CircularProgressIndicator(value: 0.7, strokeWidth: 15, color: const Color(0xFF8FD19E), backgroundColor: Colors.grey.shade200)),
            const Text("63", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          ])),
          const Center(child: Text("Total members")),
          const SizedBox(height: 20),
          _legend("Designer", "48 members", const Color(0xFF8FD19E)),
          _legend("Developer", "27 members", const Color(0xFF4A7C8E)),
          _legend("Project manager", "18 members", Colors.grey.shade300),
        ],
      ),
    );
  }

  Widget _legend(String title, String count, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        CircleAvatar(radius: 6, backgroundColor: color),
        const SizedBox(width: 8),
        Text(title),
        const Spacer(),
        Text(count, style: const TextStyle(fontWeight: FontWeight.bold))
      ]),
    );
  }
}

class _HiringStatsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Hiring statistics"),
          const Text("Talent recruitment", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(children: [
            const CircleAvatar(radius: 30, backgroundImage: NetworkImage("https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200")),
            const SizedBox(width: 8),
            const CircleAvatar(radius: 30, backgroundImage: NetworkImage("https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200")),
            const SizedBox(width: 8),
            Expanded(child: Container(
              height: 60,
              decoration: BoxDecoration(color: const Color(0xFF4A7C8E), borderRadius: BorderRadius.circular(16)),
              child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.video_call, color: Colors.white),
                Text("Join call", style: TextStyle(color: Colors.white, fontSize: 12))
              ]),
            ))
          ]),
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text("120 Talent"),
            const Text("80 Talent")
          ]),
          const SizedBox(height: 10),
          Row(children: List.generate(20, (i) => Expanded(child: Container(
            height: 40, margin: const EdgeInsets.symmetric(horizontal: 1),
            color: i < 12? const Color(0xFF8FD19E) : Colors.grey.shade200,
          )))),
          const SizedBox(height: 10),
          Row(children: [
            _legendDot("Matched", const Color(0xFF8FD19E)),
            const SizedBox(width: 20),
            _legendDot("Not match", Colors.grey.shade300),
          ])
        ],
      ),
    );
  }
  Widget _legendDot(String t, Color c) => Row(children: [CircleAvatar(radius: 4, backgroundColor: c), const SizedBox(width: 4), Text(t, style: const TextStyle(fontSize: 12))]);
}

class _RightSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF0F4F8),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(decoration: InputDecoration(
            hintText: "Search...",
            prefixIcon: const Icon(Icons.search),
            filled: true, fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
          )),
          const SizedBox(height: 20),
          const Text("Payout monthly"),
          const Text("Salaries and incentive", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          ..._payoutList(),
          const SizedBox(height: 20),
          _SalaryCard()
        ],
      ),
    );
  }

  List<Widget> _payoutList() {
    final data = [
      ["Amazevalley", "\$2,540.00", "Today", "Waiting", Colors.orange],
      ["Devon Lane", "\$2,540.00", "Today", "Done", Colors.green],
      ["Marvin McKinney", "\$2,540.00", "Yesterday", "Done", Colors.green],
      ["Devon Lane", "\$2,540.00", "Yesterday", "Done", Colors.green],
      ["Eleanor Pena", "\$2,540.00", "Yesterday", "Failed", Colors.red],
    ];
    return data.map((e) => ListTile(
      leading: const CircleAvatar(backgroundImage: NetworkImage("https://i.pravatar.cc/50")),
      title: Text(e[0].toString()),
      subtitle: Text("${e[1]} ${e[2]}"),
      trailing: Chip(label: Text(e[3].toString()), backgroundColor: (e[4] as Color)
          .withOpacity(0.1), labelStyle: TextStyle(color: Colors.greenAccent)),
    )).toList();
  }
}

class _SalaryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFF4A7C8E), borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          _salaryRow("Basic salary", "\$1,970", Colors.green.shade200),
          _salaryRow("Perform", "\$283", Colors.white),
          _salaryRow("Gift", "\$183", Colors.white24),
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text("Payment", style: TextStyle(color: Colors.white70)),
            const Text("97%", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold))
          ]),
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text("Take home pay", style: TextStyle(color: Colors.white70)),
            const Text("\$2,453.11", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold))
          ]),
        ],
      ),
    );
  }
  Widget _salaryRow(String t, String v, Color bg) => Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(t), Text(v, style: const TextStyle(fontWeight: FontWeight.bold))]),
  );
}

// Custom Painters
class LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFF4A7C8E)..strokeWidth = 2..style = PaintingStyle.stroke;
    final path = Path();
    path.moveTo(0, size.height*0.6);
    path.quadraticBezierTo(size.width*0.2, size.height*0.3, size.width*0.4, size.height*0.5);
    path.quadraticBezierTo(size.width*0.6, size.height*0.2, size.width, size.height*0.4);
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DotChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    for(int i=0; i<50; i++){
      final paint = Paint()..color = Colors.blue.withOpacity(0.3 + (i%5)*0.15);
      canvas.drawCircle(Offset(i*7.0, 30 + sin(i)*10), 3, paint);
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


//// All code generated by AI -  ---