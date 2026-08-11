import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

void main() => runApp(const CustomSalesApp());

class CustomSalesApp extends StatelessWidget {
  const CustomSalesApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0C0E12),
        textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
        cardColor: const Color(0xFF181A20),
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
  String selectedMenu = "Contacts";
  DateTime _focusedDay = DateTime(2023, 10);
  DateTime? _selectedDay = DateTime(2023, 10, 4);
  final DraggableScrollableController _funnelController = DraggableScrollableController();

  final menuItems = ["Book Summaries", "Founders", "Finance", "Contacts", "Growth", "Projects"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
          builder: (context, constraints) {
            bool isDesktop = constraints.maxWidth > 1100;
            return Row(
              children: [
                if(isDesktop) _buildSideMenu(),
                Expanded(
                  child: Column(
                    children: [
                      _buildTopNav(isDesktop),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildHeader(),
                              const SizedBox(height: 20),
                              isDesktop
                                  ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                Expanded(flex: 3, child: _buildLeftColumn()),
                                const SizedBox(width: 20),
                                Expanded(flex: 2, child: _buildRightColumn()),
                              ])
                                  : Column(children: [_buildLeftColumn(), const SizedBox(height: 20), _buildRightColumn()]),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
      ),
    );
  }

  Widget _buildSideMenu() {
    final icons = [Icons.search, Icons.star_border, Icons.send, Icons.layers_outlined, Icons.devices_other];
    return Container(
      width: 140,
      color: const Color(0xFF0C0E12),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(width: 32, height: 32, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: const Icon(Icons.circle, color: Colors.black, size: 16)),
            const SizedBox(width: 8),
            SizedBox(width:60, child: const Text("Custom Sales", style:
            TextStyle
              (fontWeight: FontWeight.w600))),
          ]),
          const SizedBox(height: 100),
          IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back_ios_new, size: 18)),
          const SizedBox(height: 20),
          ...icons.map((i) => IconButton(onPressed: (){}, icon: Icon(i, color: Colors.grey[600]))),
        ],
      ),
    );
  }

  Widget _buildTopNav(bool isDesktop) {
    return Container(
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          if(!isDesktop) IconButton(onPressed: (){}, icon: const Icon(Icons.menu)),

          // FIX 1: Wrap chips in Expanded + Horizontal Scroll
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: menuItems.map((e) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(e),
                    selected: selectedMenu == e,
                    onSelected: (_) => setState(() => selectedMenu = e),
                    backgroundColor: const Color(0xFF181A20),
                    selectedColor: Colors.white,
                    labelStyle: TextStyle(color: selectedMenu == e? Colors.black : Colors.grey[400]),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    labelPadding: const EdgeInsets.symmetric(horizontal: 12), // smaller padding
                  ),
                )).toList(),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // FIX 2: Wrap right icons in Row with MainAxisSize.min
          Row(
            mainAxisSize: MainAxisSize.min, // don't take full width
            children: [
              CircleAvatar(radius: 16, child: Icon(Icons.mail_outline, size: 16)),
              const SizedBox(width: 12),
              CircleAvatar(radius: 16, child: Icon(Icons.notifications_none, size: 16)),
              const SizedBox(width: 12),
              const CircleAvatar(backgroundImage: NetworkImage("https://i.pravatar.cc/40?img=1")),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Customer\nInformation", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
        const Spacer(),
        _statHeader("\$1,980,130", "Won from 76 Deals\nThis Month", "+11% week"),
        _statHeader("+89", "New Customer\nfor Week", "+11% week"),
        _statHeader("+31", "New Customer\nfor Week", "+11% week"),
      ],
    );
  }

  Widget _statHeader(String value, String label, String tag) {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: Row(
        children: [
          Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: const Color(0xFF181A20), borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.bar_chart, size: 20)),
          const SizedBox(width: 10),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            Text(label, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
          ]),
          const SizedBox(width: 8),
          Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: const Color(0xFF2A2A2F), borderRadius: BorderRadius.circular(20)),
              child: Text(tag, style: const TextStyle(fontSize: 10)))
        ],
      ),
    );
  }

  Widget _buildLeftColumn() {
    return Column(children: [
      _interactionHistory(),
      const SizedBox(height: 20),
      Row(children: [
        Expanded(child: _taskSchedule()),
        const SizedBox(width: 20),
        Expanded(child: _stageFunnel()),
      ])
    ]);
  }

  Widget _interactionHistory() {
    final cards = [
      {"date": "Oct 4", "title": "Royal Package\nOpportunity", "price": "11,250\$", "color": const Color(0xFFE8D8A3)},
      {"date": "Oct 4", "title": "Third Deal\nMost Useful", "price": "15,250\$", "color": const Color(0xFFC8E8C8)},
      {"date": "Oct 4", "title": "Absolute\nSuccess Deal", "price": "23,250\$", "color": const Color(0xFFE8C8C8)},
      {"date": "Oct 4", "title": "Royal Package\nOpportunity", "price": "42,250\$", "color": const Color(0xFFF0E8C8)},
      {"date": "Oct 4", "title": "Absolute\nBusiness Service", "price": "12,250\$", "color": const Color(0xFF22252D)},
      {"date": "Oct 4", "title": "Royal Package\nOpportunity", "price": "32,250\$", "color": const Color(0xFF22252D)},
    ];
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF181A20), borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Row(children: [const Text("Interaction History"), const Spacer(), _iconBtn(), _iconBtn()]),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.3),
            itemCount: cards.length,
            itemBuilder: (_, i) => _historyCard(cards[i]),
          )
        ],
      ),
    );
  }

  Widget _historyCard(Map card) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: card["color"] as Color, borderRadius: BorderRadius.circular(16)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [Text(card["date"] as String, style: const TextStyle(color: Colors.black87, fontSize: 12)), const Spacer(), _dotMenu(Colors.black54)]),
        const SizedBox(height: 8),
        Text(card["title"] as String, style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w600)),
        const Spacer(),
        Row(children: [
          Text(card["price"] as String, style: const TextStyle(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w700)),
          const Spacer(),
          // FIXED: No negative margin
          SizedBox(
            width: 40,
            height: 20,
            child: Stack(
                children: List.generate(3, (i) => Positioned(
                    left: i * 10.0,
                    child: Container(
                        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: card["color"] as Color, width: 2)),
                        child: CircleAvatar(radius: 9, backgroundImage: NetworkImage("https://i.pravatar.cc/20?img=${i+1}"))
                    )
                ))
            ),
          )
        ])
      ]),
    );
  }

  // 2. TASK SCHEDULE CALENDAR - Selectable
  Widget _taskSchedule() {
    return Container(
      height: 320,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF181A20), borderRadius: BorderRadius.circular(16)),
      child: Column(children: [
        Row(children: [const Text("Tasks Schedule"), const Spacer(), _iconBtn(), _iconBtn()]),
        const SizedBox(height: 4),
        Expanded(
          child: TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            rowHeight: 28.0, // Custom row/cell height
            daysOfWeekHeight: 24.0, // Custom weekday header height
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarFormat: CalendarFormat.month,
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: const TextStyle(fontSize: 12, fontWeight:
              FontWeight.w600),
              leftChevronIcon: const Icon(Icons.chevron_left, size: 12),
              rightChevronIcon: const Icon(Icons.chevron_right, size: 12),
            ),
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(color: const Color(0xFFE8D8A3),
                  shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(4)),
              selectedDecoration: BoxDecoration(color: const Color
                (0xFFC8E8C8), shape: BoxShape.rectangle, borderRadius:
              BorderRadius.circular(2)),
              defaultTextStyle: TextStyle(color: Colors.grey[400]),
              weekendTextStyle: TextStyle(color: Colors.grey[400]),
            ),

          ),
        ),
      ]),
    );
  }

  // 1. STAGE FUNNEL - Slideable Upward
  Widget _stageFunnel() {
    return Container(
      height: 320,
      decoration: BoxDecoration(color: const Color(0xFF181A20), borderRadius: BorderRadius.circular(16)),
      child: DraggableScrollableSheet(
        controller: _funnelController,
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 1.0,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(children: [const Text("Stage Funnel"), const Spacer(), _iconBtn(), _iconBtn()]),
                const SizedBox(height: 10),
                Row(children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text("\$350,500", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700)),
                    Text("Total in Pipeline", style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                  ]),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(color: const Color(0xFF22252D), borderRadius: BorderRadius.circular(20)),
                    child: Row(children: [
                      _toggleBtn("Weighted", true),
                      _toggleBtn("Total", false),
                    ]),
                  )
                ]),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    controller: scrollController, // makes it slideable
                    children: [
                      _funnelStage("Qualification", "92,350\$"),
                      _funnelStage("Proposal", "67,120\$"),
                      _funnelStage("Negotiation", "20,120\$"),
                      _funnelStage("Closed Won", "170,910\$"),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _funnelStage(String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFF22252D), borderRadius: BorderRadius.circular(12)),
      child: Row(children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: TextStyle(color: Colors.grey[400], fontSize: 12)),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        ]),
        const Spacer(),
        IconButton(onPressed: (){}, icon: const Icon(Icons.open_in_full, size: 16))
      ]),
    );
  }

  Widget _toggleBtn(String text, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: active? const Color(0xFF2A2A2F) : Colors.transparent, borderRadius: BorderRadius.circular(16)),
      child: Text(text, style: TextStyle(fontSize: 12, color: active? Colors.white : Colors.grey[500])),
    );
  }

  Widget _buildRightColumn() {
    return Column(children: [
      _profileCard(),
      const SizedBox(height: 20),
      _detailedInfo(),
    ]);
  }

  Widget _profileCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFF181A20), borderRadius: BorderRadius.circular(16)),
      child: Column(children: [
        Row(children: [_iconBtn(), _iconBtn(), const Spacer(), _iconBtn(), _iconBtn()]),
        const SizedBox(height: 10),
        CircleAvatar(radius: 40, backgroundImage: NetworkImage("https://img.magnific"
            ".com/premium-photo/memoji-happy-man-white-background-emoji_826801-6840.jpg")),
        const SizedBox(height: 12),
        const Text("Amazevalley", style: TextStyle(fontSize: 18, fontWeight:
        FontWeight.w700)),
        Text("CEO. Inc, Alabama Machinery\n& Supply", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
        const SizedBox(height: 16),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _circleIcon(Icons.edit), _circleIcon(Icons.mail_outline), _circleIcon(Icons.phone),
          _circleIcon(Icons.add), _circleIcon(Icons.calendar_today), _circleIcon(Icons.event)
        ])
      ]),
    );
  }

  Widget _detailedInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFF181A20), borderRadius: BorderRadius.circular(16)),
      child: Column(children: [
        Row(children: [const Text("Detailed Information"), const Spacer(), _iconBtn(), _iconBtn()]),
        const SizedBox(height: 16),
        _infoRow(Icons.person_outline, "First Name", "Amaze"),
        _infoRow(Icons.person_outline, "Last Name", "Valley"),
        _infoRow(Icons.mail_outline, "Email", "amazevalley@gmail.com"),
        _infoRow(Icons.phone_outlined, "Phone Number", "+91 120 222 333 0"),
        _infoRow(Icons.calendar_today_outlined, "Last Contacted", "October 3 at 2:20 pm"),
      ]),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(children: [
        Icon(icon, size: 18, color: Colors.grey[500]),
        const SizedBox(width: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: TextStyle(color: Colors.grey[500], fontSize: 12)),
          Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        ]),
        const Spacer(),
        _circleIcon(label == "Last Contacted"? Icons.arrow_outward : Icons.edit, size: 14)
      ]),
    );
  }

  Widget _iconBtn() => Container(margin: const EdgeInsets.only(left: 8), padding: const EdgeInsets.all(6), decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.grey[800]!)), child: Icon(Icons.animation, size: 16));
  Widget _dotMenu(Color c) => Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: c.withOpacity(0.3))), child: Icon(Icons.more_horiz, size: 14, color: c));
  Widget _circleIcon(IconData i, {double size = 18}) => Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFF22252D)), child: Icon(i, size: size));
}