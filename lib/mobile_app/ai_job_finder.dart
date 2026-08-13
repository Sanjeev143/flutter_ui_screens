import 'package:flutter/material.dart';

void main() {
  runApp(const AIJobFinderApp());
}

class AIJobFinderApp extends StatelessWidget {
  const AIJobFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Job Finder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFC7DCDB),
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const OnboardingScreen(),
        '/home': (context) => const MainNavigationHolder(),
        '/details': (context) => const JobDetailsScreen(),
        '/menu': (context) => const AppMenuScreen(),
      },
    );
  }
}

// ==========================================
// 25 REALISTIC AI & TECH JOB ITEMS
// ==========================================
final List<Map<String, String>> initialJobs = [
  {
    'company': 'Tesla',
    'title': 'Machine Learning Research Specialist',
    'salary': '\$450k',
    'location': 'California, USA',
    'type': 'Full-time',
    'workMode': 'Remote',
  },
  {
    'company': 'Google',
    'title': 'Senior AI Tech Product Lead',
    'salary': '\$380k',
    'location': 'Mountain View, CA',
    'type': 'Full-time',
    'workMode': 'Hybrid',
  },
  {
    'company': 'OpenAI',
    'title': 'NLP & Vision Research Scientist',
    'salary': '\$500k',
    'location': 'San Francisco, CA',
    'type': 'Full-time',
    'workMode': 'On-site',
  },
  {
    'company': 'Apple',
    'title': 'Computer Vision Engineer',
    'salary': '\$320k',
    'location': 'Cupertino, CA',
    'type': 'Full-time',
    'workMode': 'Hybrid',
  },
  {
    'company': 'Microsoft',
    'title': 'Generative AI Platform Architect',
    'salary': '\$340k',
    'location': 'Redmond, WA',
    'type': 'Full-time',
    'workMode': 'Remote',
  },
  {
    'company': 'Meta',
    'title': 'LLM Infrastructure Engineer',
    'salary': '\$410k',
    'location': 'Menlo Park, CA',
    'type': 'Full-time',
    'workMode': 'On-site',
  },
  {
    'company': 'NVIDIA',
    'title': 'Deep Learning Performance Engineer',
    'salary': '\$390k',
    'location': 'Santa Clara, CA',
    'type': 'Full-time',
    'workMode': 'Hybrid',
  },
  {
    'company': 'Amazon',
    'title': 'Applied AI Scientist - AWS',
    'salary': '\$310k',
    'location': 'Seattle, WA',
    'type': 'Full-time',
    'workMode': 'Hybrid',
  },
  {
    'company': 'Anthropic',
    'title': 'AI Safety & Ethics Researcher',
    'salary': '\$420k',
    'location': 'San Francisco, CA',
    'type': 'Full-time',
    'workMode': 'Remote',
  },
  {
    'company': 'Netflix',
    'title': 'Personalization ML Engineer',
    'salary': '\$480k',
    'location': 'Los Gatos, CA',
    'type': 'Full-time',
    'workMode': 'Remote',
  },
  {
    'company': 'Uber',
    'title': 'Autonomous Fleet AI Specialist',
    'salary': '\$290k',
    'location': 'San Francisco, CA',
    'type': 'Full-time',
    'workMode': 'Hybrid',
  },
  {
    'company': 'Adobe',
    'title': 'Creative Generative Models Engineer',
    'salary': '\$275k',
    'location': 'San Jose, CA',
    'type': 'Full-time',
    'workMode': 'Remote',
  },
  {
    'company': 'Spotify',
    'title': 'Audio ML Recommendation Lead',
    'salary': '\$260k',
    'location': 'New York, NY',
    'type': 'Full-time',
    'workMode': 'Remote',
  },
  {
    'company': 'Databricks',
    'title': 'Data & AI Systems Architect',
    'salary': '\$330k',
    'location': 'San Francisco, CA',
    'type': 'Full-time',
    'workMode': 'Hybrid',
  },
  {
    'company': 'Snowflake',
    'title': 'Cloud ML Pipeline Engineer',
    'salary': '\$295k',
    'location': 'Bozeman, MT',
    'type': 'Full-time',
    'workMode': 'Remote',
  },
  {
    'company': 'IBM AI',
    'title': 'Quantum & Neural Tech Researcher',
    'salary': '\$250k',
    'location': 'Armonk, NY',
    'type': 'Full-time',
    'workMode': 'Hybrid',
  },
  {
    'company': 'Palantir',
    'title': 'AI Operations Deployment Lead',
    'salary': '\$310k',
    'location': 'Denver, CO',
    'type': 'Full-time',
    'workMode': 'On-site',
  },
  {
    'company': 'Scale AI',
    'title': 'RLHF Fine-Tuning Specialist',
    'salary': '\$360k',
    'location': 'San Francisco, CA',
    'type': 'Full-time',
    'workMode': 'Remote',
  },
  {
    'company': 'Cohere',
    'title': 'Enterprise NLP Developer',
    'salary': '\$280k',
    'location': 'Toronto, Canada',
    'type': 'Full-time',
    'workMode': 'Remote',
  },
  {
    'company': 'Midjourney',
    'title': 'Diffusion Model Engineer',
    'salary': '\$430k',
    'location': 'San Francisco, CA',
    'type': 'Full-time',
    'workMode': 'Remote',
  },
  {
    'company': 'Roblox',
    'title': 'Generative 3D AI Engineer',
    'salary': '\$270k',
    'location': 'San Mateo, CA',
    'type': 'Full-time',
    'workMode': 'Hybrid',
  },
  {
    'company': 'Stripe',
    'title': 'Fraud Detection ML Lead',
    'salary': '\$325k',
    'location': 'San Francisco, CA',
    'type': 'Full-time',
    'workMode': 'Remote',
  },
  {
    'company': 'Salesforce',
    'title': 'Einstein AI Product Manager',
    'salary': '\$240k',
    'location': 'San Francisco, CA',
    'type': 'Full-time',
    'workMode': 'Hybrid',
  },
  {
    'company': 'DeepMind',
    'title': 'Reinforcement Learning Scientist',
    'salary': '\$470k',
    'location': 'London, UK',
    'type': 'Full-time',
    'workMode': 'Hybrid',
  },
  {
    'company': 'Hugging Face',
    'title': 'Open Source ML Ecosystem Engineer',
    'salary': '\$290k',
    'location': 'New York, NY',
    'type': 'Full-time',
    'workMode': 'Remote',
  },
];

// ==========================================
// ONBOARDING SCREEN
// ==========================================
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFBACECB),
              Color(0xFFA5C4BF),
              Color(0xFF88B0A8),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Smart',
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white30),
                      ),
                      child: const Icon(Icons.key_outlined, color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Career',
                      style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const Text(
                  'Starts Here',
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Icon(
                      Icons.smart_toy_rounded,
                      size: 200,
                      color: const Color(0xFF1F4E45).withOpacity(0.85),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 56,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white.withOpacity(0.4)),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 58,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFCBB26B), Color(0xFF275E54)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// MAIN NAVIGATION HOLDER (Controls Bottom Bar & Pages)
// ==========================================
class MainNavigationHolder extends StatefulWidget {
  const MainNavigationHolder({super.key});

  @override
  State<MainNavigationHolder> createState() => _MainNavigationHolderState();
}

class _MainNavigationHolderState extends State<MainNavigationHolder> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    CalendarScreen(),
    AppMenuScreen(), // Opens or directly shows Menu view
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFBACECB),
              Color(0xFFA5C4BF),
              Color(0xFF88B0A8),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Dynamic Body View
              Expanded(child: _pages[_currentIndex]),

              // Floating Glassmorphic Bottom Navigation Bar
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.35),
                  borderRadius: BorderRadius.circular(35),
                  border: Border.all(color: Colors.white.withOpacity(0.4)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _navItem(Icons.home, index: 0),
                    _navItem(Icons.calendar_today_outlined, index: 1),
                    _navItem(Icons.grid_view_rounded, index: 2),
                    _navItem(Icons.person_outline, index: 3),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, {required int index}) {
    final bool isActive = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: isActive
            ? const BoxDecoration(
          color: Color(0xFF275E54),
          shape: BoxShape.circle,
        )
            : null,
        child: Icon(
          icon,
          color: Colors.white,
          size: 22,
        ),
      ),
    );
  }
}

// ==========================================
// 1. HOME SCREEN
// ==========================================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> filteredJobs = List.from(initialJobs);
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterSearchResults(String query) {
    setState(() {
      if (query.trim().isEmpty) {
        filteredJobs = List.from(initialJobs);
      } else {
        final lowercaseQuery = query.toLowerCase();
        filteredJobs = initialJobs.where((job) {
          final title = job['title']?.toLowerCase() ?? '';
          final company = job['company']?.toLowerCase() ?? '';
          final location = job['location']?.toLowerCase() ?? '';
          final workMode = job['workMode']?.toLowerCase() ?? '';

          return title.contains(lowercaseQuery) ||
              company.contains(lowercaseQuery) ||
              location.contains(lowercaseQuery) ||
              workMode.contains(lowercaseQuery);
        }).toList();
      }
    });
  }

  Future<void> _refreshJobs() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) {
      _searchController.clear();
      setState(() {
        filteredJobs = List.from(initialJobs);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top Bar Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Builder(
                    builder: (context) => GestureDetector(
                      onTap: () => Scaffold.of(context).openDrawer(),
                      child: const CircleAvatar(
                        radius: 22,
                        backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white30),
                    ),
                    child: const Text(
                      'Marko',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: _refreshJobs,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white30),
                      ),
                      child: const Icon(Icons.refresh, color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white30),
                    ),
                    child: const Icon(Icons.notifications_outlined, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Title Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Let's Find\nYour Next Future.",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.2,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  '${filteredJobs.length} Jobs',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),

        // Search Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(26),
                    border: Border.all(color: Colors.white.withOpacity(0.4)),
                  ),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _filterSearchResults,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      hintText: 'Search here...',
                      hintStyle: const TextStyle(color: Colors.white70, fontSize: 15),
                      border: InputBorder.none,
                      icon: const Icon(Icons.search, color: Colors.white70),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          _filterSearchResults('');
                        },
                        child: const Icon(Icons.clear, color: Colors.white70, size: 20),
                      )
                          : null,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFCBB26B), Color(0xFF275E54)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.tune, color: Colors.white),
              ),
            ],
          ),
        ),

        // Search Results List View
        Expanded(
          child: RefreshIndicator(
            onRefresh: _refreshJobs,
            color: const Color(0xFF275E54),
            child: filteredJobs.isEmpty
                ? ListView(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off_rounded, size: 60, color: Colors.white70),
                      SizedBox(height: 12),
                      Text(
                        'No jobs match your search keyword!',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            )
                : ListView.builder(
              padding: const EdgeInsets.only(top: 8, bottom: 20),
              itemCount: filteredJobs.length,
              itemBuilder: (context, index) {
                final job = filteredJobs[index];
                return _buildJobListItem(job);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildJobListItem(Map<String, String> job) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.45),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.6)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.bolt, color: Colors.black87, size: 20),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job['company']!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          job['location']!,
                          style: const TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.bookmark_border_rounded, color: Colors.black54),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              job['title']!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildChip(job['workMode'] ?? 'Remote'),
                const SizedBox(width: 8),
                _buildChip(job['type'] ?? 'Full-time'),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: job['salary']!,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF275E54),
                        ),
                      ),
                      const TextSpan(
                        text: '/year',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/details',
                      arguments: job,
                    );
                  },
                  child: Container(
                    height: 44,
                    width: 44,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFCBB26B), Color(0xFF275E54)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.north_east, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black87),
      ),
    );
  }
}

// ==========================================
// 2. CALENDAR SCREEN (Schedules & Interviews)
// ==========================================
class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Schedule',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white30),
                ),
                child: const Icon(Icons.calendar_month, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Horizontal Date Selector Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.35),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _dateItem('Mon', '12', false),
                _dateItem('Tue', '13', false), // Selected Date
                _dateItem('Wed', '14', true),
                _dateItem('Thu', '15', false),
                _dateItem('Fri', '16', false),
              ],
            ),
          ),
          const SizedBox(height: 24),

          const Text(
            'Upcoming Interviews',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),

          Expanded(
            child: ListView(
              children: [
                _interviewCard(
                  company: 'Tesla',
                  title: 'Machine Learning Specialist',
                  time: '10:00 AM - 11:00 AM',
                  status: 'Confirmed',
                ),
                _interviewCard(
                  company: 'Google',
                  title: 'Senior AI Tech Lead',
                  time: '02:30 PM - 03:30 PM',
                  status: 'Pending',
                ),
                _interviewCard(
                  company: 'OpenAI',
                  title: 'NLP Research Scientist',
                  time: '05:00 PM - 06:00 PM',
                  status: 'Confirmed',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateItem(String day, String date, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: isSelected
          ? BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFCBB26B), Color(0xFF275E54)],
        ),
        borderRadius: BorderRadius.circular(20),
      )
          : null,
      child: Column(
        children: [
          Text(
            day,
            style: TextStyle(
              fontSize: 14,
              color: isSelected ? Colors.white : Colors.white70,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            date,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _interviewCard({
    required String company,
    required String title,
    required String time,
    required String status,
  }) {
    final bool isConfirmed = status == 'Confirmed';
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.45),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.video_camera_front, color: Color(0xFF275E54)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$company • $time',
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isConfirmed ? const Color(0xFF275E54) : const Color(0xFFCBB26B),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}

// ==========================================
// 3. PROFILE SCREEN
// ==========================================
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'My Profile',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white30),
                ),
                child: const Icon(Icons.settings, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // User Header Badge Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white.withOpacity(0.5)),
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Marko',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Senior AI Engineer & Researcher',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFCBB26B), Color(0xFF275E54)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Pro Member',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                )
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Stats Cards
          Row(
            children: [
              Expanded(
                child: _profileStatCard('Applied', '18 Jobs'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _profileStatCard('Interviews', '4 Active'),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Profile Menu Options
          _profileOptionTile(Icons.description_outlined, 'My Resume / Portfolio'),
          _profileOptionTile(Icons.bookmark_border_rounded, 'Saved Applications'),
          _profileOptionTile(Icons.notifications_outlined, 'Notification Preferences'),
          _profileOptionTile(Icons.security_outlined, 'Account Security'),
        ],
      ),
    );
  }

  static Widget _profileStatCard(String title, String count) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.35),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
          const SizedBox(height: 6),
          Text(
            count,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _profileOptionTile(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF275E54)),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black54),
        ],
      ),
    );
  }
}

// ==========================================
// 4. FULL MENU SCREEN
// ==========================================
class AppMenuScreen extends StatelessWidget {
  const AppMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'App Menu',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildMenuItem(
                  icon: Icons.search,
                  title: 'Find Jobs',
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.bookmark_outline,
                  title: 'Saved Jobs',
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.chat_bubble_outline,
                  title: 'AI Assistant',
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.analytics_outlined,
                  title: 'Analytics',
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.settings_outlined,
                  title: 'Settings',
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.person_outline,
                  title: 'Profile',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({required IconData icon, required String title, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.35),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white.withOpacity(0.5)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: const Color(0xFF275E54)),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 5. DRAWER MENU COMPONENT
// ==========================================
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF88B0A8),
      child: SafeArea(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.transparent),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'),
              ),
              accountName: Text(
                'Marko',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              accountEmail: Text('amazevalley@gmail.com'),
            ),
            ListTile(
              leading: const Icon(Icons.refresh, color: Colors.white),
              title: const Text('Refresh Job Feed', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            ListTile(
              leading: const Icon(Icons.work_outline, color: Colors.white),
              title: const Text('Applied Jobs', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.white),
              title: const Text('Settings', style: TextStyle(color: Colors.white)),
              onTap: () {},
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.white),
              title: const Text('Sign Out', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 6. JOB DETAILS SCREEN
// ==========================================
// ==========================================
// JOB DETAILS SCREEN (With Apply Success Pop-up)
// ==========================================
class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({super.key});

  // Function to show Success Dialog Pop-up
  void _showApplicationSuccessDialog(BuildContext context, String company) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents closing without pressing OK
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFFBACECB).withOpacity(0.95),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: Colors.white.withOpacity(0.6)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Success Checkmark Badge
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Color(0xFF275E54),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 20),

                const Text(
                  'Successfully Applied!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),

                Text(
                  'Your application for $company has been submitted successfully.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 24),

                // OK Button (Dismisses modal and returns to Job List)
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFCBB26B), Color(0xFF275E54)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(dialogContext); // Close Dialog
                      Navigator.pop(context);       // Navigate Back to Job List
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, String>?;

    final String company = args?['company'] ?? 'Tesla';
    final String title = args?['title'] ?? 'Machine Learning Research Specialist';
    final String salary = args?['salary'] ?? '\$450k';
    final String location = args?['location'] ?? 'California, USA';

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFBACECB),
              Color(0xFFA5C4BF),
              Color(0xFF88B0A8),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top Bar Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white30),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
                      ),
                    ),
                    const Text(
                      'Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white30),
                      ),
                      child: const Icon(Icons.notifications_outlined, color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.white.withOpacity(0.5)),
                        ),
                        child: Column(
                          children: [
                            const Icon(Icons.bolt, size: 40, color: Colors.black87),
                            const SizedBox(height: 12),
                            Text(
                              title,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              company,
                              style: const TextStyle(fontSize: 16, color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: _infoCard(
                              icon: Icons.work_outline,
                              title: salary,
                              subtitle: 'Salary yearly',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _infoCard(
                              icon: Icons.people_outline,
                              title: '3 Years',
                              subtitle: 'Experience',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildDetailChip('Remote'),
                          _buildDetailChip('Freelance'),
                          _buildDetailChip('Full-time'),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on_outlined, size: 16, color: Colors.black54),
                                    const SizedBox(width: 4),
                                    Text(
                                      location,
                                      style: const TextStyle(color: Colors.black54, fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.bookmark_border_rounded, color: Colors.black87, size: 28),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'As a member of the $company engineering team, you will drive research-focused AI development, solve complex technical challenges, and deploy novel machine learning models into high-availability systems.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black.withOpacity(0.6),
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),

              // Apply Now Button with Pop-up Trigger
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Container(
                  width: double.infinity,
                  height: 58,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      colors: [Color(0xFFCBB26B), Color(0xFF275E54)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () => _showApplicationSuccessDialog(context, company),
                    child: const Text(
                      'Apply Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _infoCard({required IconData icon, required String title, required String subtitle}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.black87, size: 22),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 11, color: Colors.black54),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  static Widget _buildDetailChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.5)),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87),
      ),
    );
  }
}































