import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AV HR Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF4F6F9),
        primaryColor: const Color(0xFF3B5BDB),
      ),
      home: const MainLayoutScreen(),
    );
  }
}

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _selectedIndex = 0;

  final List<String> _menuTitles = [
    'Dashboard',
    'Sourcing',
    'Library',
    'Outreach',
    'Interviews',
    'Software Engineer',
    'Product Designer',
    'Project Manager',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left Sidebar Navigation
          Container(
            width: 260,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(17.0),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF3B5BDB),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.bolt, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'AV HR',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),

                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                    children: [
                      _buildNavItem(0, Icons.dashboard_outlined, 'Dashboard'),
                      _buildNavItem(1, Icons.search, 'Sourcing'),
                      _buildNavItem(2, Icons.library_books_outlined, 'Library'),
                      _buildNavItem(3, Icons.send_outlined, 'Outreach'),
                      _buildNavItem(4, Icons.calendar_today_outlined, 'Interviews'),
                      const SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Collections',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(Icons.add, size: 16, color: Colors.grey),
                          ],
                        ),
                      ),
                      _buildNavItem(5, Icons.folder_outlined, 'Software Engineer'),
                      _buildNavItem(6, Icons.folder_outlined, 'Product Designer'),
                      _buildNavItem(7, Icons.folder_outlined, 'Project Manager'),
                    ],
                  ),
                ),

                Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F9FA),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Your Trial is active', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      const SizedBox(height: 4),
                      const Text('Enjoy 5 more days of access', style: TextStyle(color: Colors.grey, fontSize: 11)),
                      const SizedBox(height: 8),
                      Container(
                        height: 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          gradient: const LinearGradient(colors: [Colors.blue, Colors.purple, Colors.pink]),
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(height: 1),

                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.laptop_chromebook, size: 20, color: Colors.grey),
                        title: const Text('Knowledge Hub', style: TextStyle(fontSize: 13)),
                        dense: true,
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.person_add_outlined, size: 20, color: Colors.grey),
                        title: const Text('Invite Teams', style: TextStyle(fontSize: 13)),
                        dense: true,
                        onTap: () {},
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          // Main Content View Area
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 70,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Text(
                        _menuTitles[_selectedIndex],
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Container(
                        width: 250,
                        height: 38,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            prefixIcon: Icon(Icons.search, size: 18),
                            suffixText: '⌘K',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 8),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      IconButton(icon: const Icon(Icons.notifications_none), onPressed: () {}),
                      IconButton(icon: const Icon(Icons.chat_bubble_outline), onPressed: () {}),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3B5BDB),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.group_add, size: 18),
                        label: const Text('Invite Team'),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),

                Expanded(
                  child: _getSelectedScreen(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String title) {
    bool isSelected = _selectedIndex == index;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFEEF2FF) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: Icon(icon, color: isSelected ? const Color(0xFF3B5BDB) : Colors.grey.shade600, size: 20),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? const Color(0xFF3B5BDB) : Colors.grey.shade800,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 13,
          ),
        ),
        dense: true,
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  Widget _getSelectedScreen() {
    switch (_selectedIndex) {
      case 0:
        return const DashboardContentWidget();
      case 1:
        return const SourcingScreenWidget();
      case 2:
        return const LibraryScreenWidget();
      case 3:
        return const OutreachScreenWidget();
      case 4:
        return const InterviewsScreenWidget();
      case 5:
      case 6:
      case 7:
        return CollectionDetailScreenWidget(collectionName: _menuTitles[_selectedIndex]);
      default:
        return const Center(child: Text('Screen content unavailable'));
    }
  }
}

/// 1. Dashboard Screen Content (Restored fully with 3 rows)
class DashboardContentWidget extends StatelessWidget {
  const DashboardContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  height: 260,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Talent Pool Insight', style: TextStyle(color: Color(0xFF3B5BDB), fontWeight: FontWeight.bold)),
                      const Spacer(),
                      const Text('70%', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      const Text('Data Engineering is in high demand with only 30% supply.', style: TextStyle(fontSize: 13, color: Colors.grey)),
                      const Spacer(),
                      Container(
                        height: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          gradient: const LinearGradient(colors: [Colors.blue, Colors.pink, Colors.red]),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Low', style: TextStyle(fontSize: 10, color: Colors.grey)),
                          Text('High', style: TextStyle(fontSize: 10, color: Colors.grey)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 4,
                child: Container(
                  height: 260,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Profiles added', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Last month', style: TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                      const Text('21,230', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _buildBar(40),
                          _buildBar(30),
                          _buildBar(60),
                          _buildBar(100, isSelected: true),
                          _buildBar(50),
                          _buildBar(70),
                          _buildBar(45),
                          _buildBar(65),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 4,
                child: Container(
                  height: 260,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Curated Highlight', style: TextStyle(fontWeight: FontWeight.bold)),
                      const Text('Candidates matching technical parameter', style: TextStyle(color: Colors.grey, fontSize: 11)),
                      const SizedBox(height: 12),
                      _buildCandidateItem('Gabriella Tania', 'Senior ML Engineer', '+ 94%'),
                      const Divider(height: 12),
                      _buildCandidateItem('David Chen', 'Lead Data Scientist • Passive', '+ 92%'),
                      const Divider(height: 12),
                      _buildCandidateItem('Sarah Jenkins', 'Senior ML Engineer', '+ 91%'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  height: 240,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Schedule', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Today ▾', style: TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('09.00', style: TextStyle(color: Colors.grey, fontSize: 11)),
                          Text('10.00', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                          Text('11.00', style: TextStyle(color: Colors.grey, fontSize: 11)),
                          Text('12.00', style: TextStyle(color: Colors.grey, fontSize: 11)),
                          Text('13.00', style: TextStyle(color: Colors.grey, fontSize: 11)),
                          Text('14.00', style: TextStyle(color: Colors.grey, fontSize: 11)),
                          Text('15.00', style: TextStyle(color: Colors.grey, fontSize: 11)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: Stack(
                          children: [
                            Positioned(
                              left: 85,
                              top: 0,
                              bottom: 0,
                              child: Container(width: 1.5, color: Colors.black87),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                      decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(4)),
                                      child: const Text('Interview', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
                                    ),
                                    const SizedBox(width: 4),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(4)),
                                      child: const Text('Sr. Product Designer...', style: TextStyle(fontSize: 9, color: Colors.grey)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const SizedBox(width: 60),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                      decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(4)),
                                      child: const Text('Assessment', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
                                    ),
                                    const SizedBox(width: 4),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(4)),
                                      child: const Text('Software Engineer', style: TextStyle(fontSize: 9, color: Colors.grey)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const SizedBox(width: 100),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                      decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(4)),
                                      child: const Text('Screening', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.green)),
                                    ),
                                    const SizedBox(width: 4),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                                      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(4)),
                                      child: const Text('Lead Front...', style: TextStyle(fontSize: 9, color: Colors.grey)),
                                    ),
                                    const SizedBox(width: 12),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(4)),
                                      child: const Text('Break', style: TextStyle(fontSize: 9, color: Colors.grey)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 6,
                child: Container(
                  height: 240,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Critical Skill Gap', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('See All >', style: TextStyle(color: Color(0xFF3B5BDB), fontSize: 12)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _buildSkillGapRow('Machine Learning', 'Urgent', 'Sr. Roles Needed', Colors.red),
                      const Divider(height: 12),
                      _buildSkillGapRow('Cloud Architecture', 'Moderate', 'Lead Roles Needed', Colors.orange),
                      const Divider(height: 12),
                      _buildSkillGapRow('Product Design', 'Stable', 'Stable Capacity', Colors.green),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  height: 280,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Trending Skills', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 14),
                      _buildTrendingSkillBar('Generative AI', '34%', 0.8),
                      const SizedBox(height: 10),
                      _buildTrendingSkillBar('Rust', '28%', 0.65),
                      const SizedBox(height: 10),
                      _buildTrendingSkillBar('Cloud Security', '20%', 0.5),
                      const SizedBox(height: 10),
                      _buildTrendingSkillBar('Software Engineer', '12%', 0.3),
                      const SizedBox(height: 10),
                      _buildTrendingSkillBar('Data Analyst', '8%', 0.2),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 5,
                child: Container(
                  height: 280,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Candidates', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('👤 Candidates Saved', style: TextStyle(fontSize: 11, color: Colors.grey)),
                              Text('829', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('📊 Total Searches', style: TextStyle(fontSize: 11, color: Colors.grey)),
                              Text('1,728', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('🚀 Outreached', style: TextStyle(fontSize: 11, color: Colors.grey)),
                              Text('129', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        height: 110,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomPaint(
                              size: const Size(double.infinity, 90),
                              painter: ChartWavePainter(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Jan 1', style: TextStyle(fontSize: 9, color: Colors.grey)),
                          Text('Jan 5', style: TextStyle(fontSize: 9, color: Colors.grey)),
                          Text('Jan 10', style: TextStyle(fontSize: 9, color: Colors.grey)),
                          Text('Jan 15', style: TextStyle(fontSize: 9, color: Colors.grey)),
                          Text('Jan 20', style: TextStyle(fontSize: 9, color: Colors.grey)),
                          Text('Jan 25', style: TextStyle(fontSize: 9, color: Colors.grey)),
                          Text('Jan 31', style: TextStyle(fontSize: 9, color: Colors.grey)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 3,
                child: Container(
                  height: 280,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('AV HR Assistant', style: TextStyle(fontWeight: FontWeight.bold)),
                      const Spacer(),
                      Center(
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(colors: [Colors.blue, Colors.purple, Colors.pink]),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text('Add benchmark salary...', style: TextStyle(color: Colors.grey, fontSize: 12)),
                            Row(
                              children: [
                                Icon(Icons.mic, size: 16, color: Colors.grey),
                                SizedBox(width: 8),
                                CircleAvatar(
                                  radius: 12,
                                  backgroundColor: Color(0xFF3B5BDB),
                                  child: Icon(Icons.arrow_upward, size: 14, color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),

          /// WE HAVE 3 ROWS
        ],
      ),
    );
  }

  static Widget _buildBar(double height, {bool isSelected = false}) {
    return Container(
      width: 12,
      height: height,
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF3B5BDB) : Colors.blue.shade100,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  static Widget _buildCandidateItem(String name, String role, String match) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const CircleAvatar(radius: 14, backgroundColor: Colors.grey),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                Text(role, style: const TextStyle(color: Colors.grey, fontSize: 10)),
              ],
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(color: const Color(0xFFEEF2FF), borderRadius: BorderRadius.circular(4)),
          child: Text(match, style: const TextStyle(color: Color(0xFF3B5BDB), fontSize: 11, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  static Widget _buildSkillGapRow(String skill, String status, String memberType, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(skill, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            const Text('8 Members', style: TextStyle(color: Colors.grey, fontSize: 10)),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
          child: Text(status, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
        ),
        Text(memberType, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }

  static Widget _buildTrendingSkillBar(String skill, String percentage, double factor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(skill, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
            Text(percentage, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: factor,
          backgroundColor: Colors.grey.shade100,
          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF3B5BDB)),
          minHeight: 6,
          borderRadius: BorderRadius.circular(3),
        ),
      ],
    );
  }
}

/// 2. Sourcing Screen (15+ Items)
class SourcingScreenWidget extends StatelessWidget {
  const SourcingScreenWidget({super.key});

  final List<Map<String, String>> candidates = const [
    {'name': 'Alex Rivers', 'role': 'Flutter & Dart Specialist', 'location': 'San Francisco, CA', 'match': '98%'},
    {'name': 'Priya Sharma', 'role': 'Senior Full Stack Engineer', 'location': 'Bangalore, India', 'match': '95%'},
    {'name': 'Marcus Vance', 'role': 'Cloud Infrastructure Lead', 'location': 'Berlin, Germany', 'match': '91%'},
    {'name': 'Elena Rostova', 'role': 'UI/UX Design Director', 'location': 'London, UK', 'match': '89%'},
    {'name': 'Liam O’Connor', 'role': 'Backend Systems Architect', 'location': 'Dublin, Ireland', 'match': '94%'},
    {'name': 'Aiden Smith', 'role': 'DevOps & K8s Expert', 'location': 'Austin, TX', 'match': '90%'},
    {'name': 'Sofia Gomez', 'role': 'Mobile Cross-Platform Lead', 'location': 'Madrid, Spain', 'match': '96%'},
    {'name': 'Kenji Sato', 'role': 'AI/ML Research Scientist', 'location': 'Tokyo, Japan', 'match': '97%'},
    {'name': 'Chloe Bennett', 'role': 'Product Manager', 'location': 'New York, NY', 'match': '88%'},
    {'name': 'Lucas Moreau', 'role': 'Cybersecurity Analyst', 'location': 'Paris, France', 'match': '87%'},
    {'name': 'Ananya Iyer', 'role': 'Data Engineering Lead', 'location': 'Mumbai, India', 'match': '93%'},
    {'name': 'Hans Gruber', 'role': 'Embedded Systems Dev', 'location': 'Munich, Germany', 'match': '85%'},
    {'name': 'Fatima Al-Farsi', 'role': 'Frontend Architect', 'location': 'Dubai, UAE', 'match': '92%'},
    {'name': 'Gabriel Santos', 'role': 'Blockchain Developer', 'location': 'São Paulo, Brazil', 'match': '84%'},
    {'name': 'Zoe Zhao', 'role': 'QA Automation Lead', 'location': 'Singapore', 'match': '89%'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Global Candidate Sourcing Hub (15+ Profiles)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3B5BDB), foregroundColor: Colors.white),
                onPressed: () {},
                icon: const Icon(Icons.add, size: 16),
                label: const Text('New Sourcing Query'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: candidates.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final c = candidates[index];
                  return ListTile(
                    leading: const CircleAvatar(backgroundColor: Color(0xFFEEF2FF), child: Icon(Icons.person, color: Color(0xFF3B5BDB))),
                    title: Text(c['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${c['role']} • ${c['location']}'),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(6)),
                      child: Text('${c['match']} Match', style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
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

/// 3. Library Screen (15+ Items)
class LibraryScreenWidget extends StatelessWidget {
  const LibraryScreenWidget({super.key});

  final List<Map<String, String>> assessments = const [
    {'title': 'Flutter Architecture Exam', 'sub': 'Code evaluation suite for mobile devs', 'cat': 'Mobile'},
    {'title': 'UI/UX Design Task Set', 'sub': 'Figma benchmark test cases', 'cat': 'Design'},
    {'title': 'System Design Blueprint', 'sub': 'Scalable microservices technical questionnaire', 'cat': 'Architecture'},
    {'title': 'Behavioral Interview Guide', 'sub': 'Standardized culture-fit assessment guidelines', 'cat': 'HR'},
    {'title': 'Advanced Rust Coding Test', 'sub': 'Memory safety and concurrency challenge', 'cat': 'Backend'},
    {'title': 'Kubernetes Cluster Ops Test', 'sub': 'DevOps recovery & deployment simulation', 'cat': 'DevOps'},
    {'title': 'Machine Learning Math Quiz', 'sub': 'Linear algebra and optimization assessment', 'cat': 'AI/ML'},
    {'title': 'React Native vs Flutter Case Study', 'sub': 'Cross-platform comparison analysis', 'cat': 'Mobile'},
    {'title': 'Product Roadmap Prioritization', 'sub': 'RICE scoring scenario exercise', 'cat': 'Product'},
    {'title': 'Cybersecurity Threat Mitigation', 'sub': 'Penetration testing questionnaire', 'cat': 'Security'},
    {'title': 'Data Pipeline Optimization', 'sub': 'Apache Spark tuning problem set', 'cat': 'Data'},
    {'title': 'Agile Scrum Mastery Assessment', 'sub': 'Sprint planning and blocker resolution test', 'cat': 'Management'},
    {'title': 'GraphQL API Design Exercise', 'sub': 'Schema federation and query batching test', 'cat': 'Backend'},
    {'title': 'Cloud Cost Optimization Lab', 'sub': 'AWS/GCP resource rightsizing task', 'cat': 'Cloud'},
    {'title': 'Executive Leadership Alignment', 'sub': 'Director-level situational judgment test', 'cat': 'Leadership'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Templates & Candidate Assessments Library (15+ Items)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 2.2,
              ),
              itemCount: assessments.length,
              itemBuilder: (context, index) {
                final a = assessments[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.folder_shared, color: Color(0xFF3B5BDB), size: 24),
                          Chip(label: Text(a['cat']!, style: const TextStyle(fontSize: 10)), backgroundColor: Colors.grey.shade100),
                        ],
                      ),
                      Text(a['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      Text(a['sub']!, style: const TextStyle(color: Colors.grey, fontSize: 11)),
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

/// 4. Outreach Screen (15+ Items)
class OutreachScreenWidget extends StatelessWidget {
  const OutreachScreenWidget({super.key});

  final List<Map<String, String>> campaigns = const [
    {'title': 'Q3 Mobile Engineering Push', 'sent': '142', 'eng': '48%', 'status': 'Active'},
    {'title': 'Lead Data Scientist Direct Mailer', 'sent': '85', 'eng': '62%', 'status': 'Completed'},
    {'title': 'UI/UX Community Blast', 'sent': '210', 'eng': '35%', 'status': 'Paused'},
    {'title': 'DevOps Infrastructure Wave 1', 'sent': '95', 'eng': '55%', 'status': 'Active'},
    {'title': 'AI Researcher Invitation Campaign', 'sent': '60', 'eng': '71%', 'status': 'Active'},
    {'title': 'Full Stack Bootcamp Graduates', 'sent': '320', 'eng': '28%', 'status': 'Completed'},
    {'title': 'Cybersecurity Specialist Outreach', 'sent': '110', 'eng': '49%', 'status': 'Active'},
    {'title': 'Product Manager Talent Pool Blast', 'sent': '175', 'eng': '40%', 'status': 'Paused'},
    {'title': 'Embedded Engineers Europe', 'sent': '88', 'eng': '52%', 'status': 'Completed'},
    {'title': 'Blockchain Devs Global Sift', 'sent': '130', 'eng': '33%', 'status': 'Active'},
    {'title': 'QA Automation Engineers Push', 'sent': '150', 'eng': '45%', 'status': 'Completed'},
    {'title': 'Cloud Architects Executive Hunt', 'sent': '45', 'eng': '80%', 'status': 'Active'},
    {'title': 'Junior Flutter Developers Fest', 'sent': '500', 'eng': '22%', 'status': 'Completed'},
    {'title': 'Database Administrators Sweep', 'sent': '75', 'eng': '58%', 'status': 'Paused'},
    {'title': 'CTO / VP Engineering Outreach', 'sent': '30', 'eng': '85%', 'status': 'Active'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Active Candidate Outreach Campaigns (15+ Campaigns)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: campaigns.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final camp = campaigns[index];
                  return ListTile(
                    leading: const Icon(Icons.send_rounded, color: Color(0xFF3B5BDB)),
                    title: Text(camp['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${camp['sent']} Sent  •  ${camp['eng']} engagement rate'),
                    trailing: Chip(
                      label: Text(camp['status']!, style: const TextStyle(fontSize: 11)),
                      backgroundColor: camp['status'] == 'Active' ? Colors.blue.shade50 : Colors.grey.shade100,
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

/// 5. Interviews Screen (15+ Items)
class InterviewsScreenWidget extends StatelessWidget {
  const InterviewsScreenWidget({super.key});

  final List<Map<String, String>> interviews = const [
    {'name': 'Jordan Lee', 'role': 'Senior Flutter Developer', 'time': 'Today, 10:00 AM', 'status': 'Confirmed'},
    {'name': 'Samantha Wright', 'role': 'Product Design Lead', 'time': 'Today, 02:00 PM', 'status': 'Pending'},
    {'name': 'Liam O’Connor', 'role': 'Backend Systems Architect', 'time': 'Tomorrow, 11:30 AM', 'status': 'Confirmed'},
    {'name': 'Marcus Brody', 'role': 'DevOps Specialist', 'time': 'Tomorrow, 03:00 PM', 'status': 'Confirmed'},
    {'name': 'Aisha Patel', 'role': 'AI Research Engineer', 'time': 'Aug 22, 09:30 AM', 'status': 'Pending'},
    {'name': 'Carlos Santana', 'role': 'Full Stack Engineer', 'time': 'Aug 22, 01:00 PM', 'status': 'Confirmed'},
    {'name': 'Mei Lin', 'role': 'Data Analyst', 'time': 'Aug 23, 11:00 AM', 'status': 'Confirmed'},
    {'name': 'Oliver Queen', 'role': 'Security Consultant', 'time': 'Aug 23, 04:00 PM', 'status': 'Cancelled'},
    {'name': 'Diana Prince', 'role': 'Product Manager', 'time': 'Aug 24, 10:00 AM', 'status': 'Confirmed'},
    {'name': 'Barry Allen', 'role': 'Performance Engineer', 'time': 'Aug 24, 02:30 PM', 'status': 'Pending'},
    {'name': 'Arthur Curry', 'role': 'Cloud Infrastructure Dev', 'time': 'Aug 25, 11:30 AM', 'status': 'Confirmed'},
    {'name': 'Victor Stone', 'role': 'Embedded Software Architect', 'time': 'Aug 25, 03:30 PM', 'status': 'Confirmed'},
    {'name': 'Clark Kent', 'role': 'Senior Journalist / Content Lead', 'time': 'Aug 26, 09:00 AM', 'status': 'Confirmed'},
    {'name': 'Bruce Wayne', 'role': 'FinTech Security Director', 'time': 'Aug 26, 04:00 PM', 'status': 'Pending'},
    {'name': 'Hal Jordan', 'role': 'Simulator Graphics Engineer', 'time': 'Aug 27, 10:30 AM', 'status': 'Confirmed'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Upcoming & Completed Candidate Interviews (15+ Sessions)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: interviews.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final inv = interviews[index];
                  return ListTile(
                    leading: const CircleAvatar(backgroundColor: Color(0xFFEEF2FF), child: Icon(Icons.calendar_today, size: 16, color: Color(0xFF3B5BDB))),
                    title: Text(inv['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('${inv['role']} — ${inv['time']}'),
                    trailing: Text(
                      inv['status']!,
                      style: TextStyle(
                        color: inv['status'] == 'Confirmed' ? Colors.green : (inv['status'] == 'Pending' ? Colors.orange : Colors.red),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
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

/// 6. Collection Detail Screen (Software Engineer, Product Designer, Project Manager - 15+ Items)
class CollectionDetailScreenWidget extends StatelessWidget {
  final String collectionName;
  const CollectionDetailScreenWidget({super.key, required this.collectionName});

  List<Map<String, String>> getCollectionData() {
    return List.generate(16, (index) {
      return {
        'name': '$collectionName Candidate #${index + 1}',
        'sub': 'Specialist in advanced $collectionName workflows & tooling',
        'stage': index % 3 == 0 ? 'Shortlisted' : (index % 3 == 1 ? 'Contacted' : 'Interviewing'),
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    final members = getCollectionData();
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Collection: $collectionName (16 Shortlisted Profiles)', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          const Text('Saved candidate pipelines and active shortlisted profiles.', style: TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: members.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final m = members[index];
                  return ListTile(
                    leading: const CircleAvatar(backgroundColor: Colors.grey, radius: 16, child: Icon(Icons.person, size: 16, color: Colors.white)),
                    title: Text(m['name']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    subtitle: Text(m['sub']!, style: const TextStyle(fontSize: 11)),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: const Color(0xFFEEF2FF), borderRadius: BorderRadius.circular(6)),
                      child: Text(m['stage']!, style: const TextStyle(color: Color(0xFF3B5BDB), fontSize: 11, fontWeight: FontWeight.bold)),
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

/// Painter utility for the dual wave graph curves matching the Candidates analytics card
class ChartWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintBlue = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final paintOrange = Paint()
      ..color = Colors.orange
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final pathBlue = Path();
    pathBlue.moveTo(0, size.height * 0.6);
    pathBlue.quadraticBezierTo(size.width * 0.25, size.height * 0.1, size.width * 0.5, size.height * 0.5);
    pathBlue.quadraticBezierTo(size.width * 0.75, size.height * 0.9, size.width, size.height * 0.3);

    final pathOrange = Path();
    pathOrange.moveTo(0, size.height * 0.8);
    pathOrange.quadraticBezierTo(size.width * 0.3, size.height * 0.4, size.width * 0.6, size.height * 0.7);
    pathOrange.quadraticBezierTo(size.width * 0.8, size.height * 0.3, size.width, size.height * 0.5);

    canvas.drawPath(pathBlue, paintBlue);
    canvas.drawPath(pathOrange, paintOrange);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}