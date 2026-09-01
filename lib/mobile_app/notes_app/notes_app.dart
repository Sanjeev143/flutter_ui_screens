import 'dart:ui' as ui;
import 'package:flutter/material.dart';

void main() {
  runApp(const EvernoteCloneApp());
}

class EvernoteCloneApp extends StatelessWidget {
  const EvernoteCloneApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Evernote UI Clone',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF3EDF7), // Soft neutral base
        fontFamily: 'SF Pro Display',
        primarySwatch: Colors.deepPurple,
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeTab(),
    NotesTab(),
    NotebooksTab(),
    TasksTab(),
    CalendarTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
      ),
      // ==========================================
      // LIQUID GLASS BOTTOM NAVIGATION BAR
      // ==========================================
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Colors.white.withOpacity(0.6),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(0, Icons.add, "Create"),
                  _buildNavItem(1, Icons.edit_note, "Notes"),
                  _buildNavItem(2, Icons.book_outlined, "Notebooks"),
                  _buildNavItem(3, Icons.task_alt, "Tasks"),
                  _buildNavItem(4, Icons.calendar_today, "Calendar"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 14 : 10,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF7F4FD5).withOpacity(0.85) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.white : Colors.deepPurple.shade900,
              size: 20,
            ),
            if (isSelected) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ==========================================
// REUSABLE GLASS CONTAINER WIDGET
// ==========================================
class GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;
  final VoidCallback? onTap;

  const GlassContainer({
    super.key,
    required this.child,
    this.padding,
    this.height,
    this.width,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
          child: Container(
            height: height,
            width: width,
            padding: padding ?? const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.55),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.8),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
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
// CREATE NOTE SCREEN
// ==========================================
class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({super.key});

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  String _selectedPriority = "High Priority";
  final String _selectedDate = "13 Jan 2025";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3EDF7),
      appBar: AppBar(
        title: const Text("Create New Note"),
        backgroundColor: const Color(0xFF7F4FD5),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text("Note Title", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 6),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: "e.g., Sketch One UIScreen..",
                filled: true,
                fillColor: Colors.white.withOpacity(0.6),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Description / Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 6),
            TextField(
              controller: _descController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Enter note details...",
                filled: true,
                fillColor: Colors.white.withOpacity(0.6),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 16),
            const Text("Priority Level", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              value: _selectedPriority,
              items: ["High Priority", "Productive", "Normal", "Urgent", "Creative"]
                  .map((priority) => DropdownMenuItem(value: priority, child: Text(priority)))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  _selectedPriority = val!;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.6),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7F4FD5),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                final title = _titleController.text.trim().isEmpty ? "Untitled Note" : _titleController.text.trim();
                final desc = _descController.text.trim().isEmpty ? "No description provided." : _descController.text.trim();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => NoteDetailScreen(
                      title: title,
                      description: desc,
                      priority: _selectedPriority,
                      date: _selectedDate,
                    ),
                  ),
                );
              },
              child: const Text("Save Note", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// NOTE DETAIL SCREEN
// ==========================================
class NoteDetailScreen extends StatelessWidget {
  final String title;
  final String description;
  final String priority;
  final String date;

  const NoteDetailScreen({
    super.key,
    required this.title,
    required this.description,
    required this.priority,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3EDF7),
      appBar: AppBar(
        title: const Text("Note Details"),
        backgroundColor: const Color(0xFF7F4FD5),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GlassContainer(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
              const SizedBox(height: 12),
              Text(description, style: const TextStyle(color: Colors.grey, fontSize: 15)),
              const SizedBox(height: 24),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(color: Colors.purple.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                    child: Text(date, style: const TextStyle(fontSize: 12, color: Colors.purple, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                    child: Text(priority, style: const TextStyle(fontSize: 12, color: Colors.red, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7F4FD5),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Back", style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// GENERIC DETAIL SCREEN
// ==========================================
class DetailScreen extends StatelessWidget {
  final String title;
  final String message;

  const DetailScreen({super.key, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3EDF7),
      appBar: AppBar(
        title: Text(title),
        backgroundColor: const Color(0xFF7F4FD5),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: GlassContainer(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.auto_awesome, size: 64, color: Color(0xFF7F4FD5)),
                const SizedBox(height: 16),
                Text(
                  message.isEmpty ? title : message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF7F4FD5)),
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Go Back", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 1. HOME SCREEN TAB
// ==========================================
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailScreen(title: "Profile", message: "Account Settings"))),
                    child: const CircleAvatar(backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12')),
                  ),
                  const SizedBox(width: 10),
                  const Text("Hi, J.Snow 👋", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailScreen(title: "Search", message: "Global Search"))),
                    child: const CircleAvatar(backgroundColor: Colors.white, radius: 18, child: Icon(Icons.search, size: 18, color: Colors.black)),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailScreen(title: "Notifications", message: "Alerts Center"))),
                    child: const CircleAvatar(backgroundColor: Colors.white, radius: 18, child: Icon(Icons.notifications_none, size: 18, color: Colors.black)),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          const Text("My Evernote", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const Text("Today January 17, 2025", style: TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GlassContainer(
                  height: 110,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateNoteScreen())),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      CircleAvatar(backgroundColor: Colors.deepPurple, radius: 14, child: Icon(Icons.add, color: Colors.white, size: 16)),
                      Text("Create\nNew Note", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GlassContainer(
                  height: 110,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailScreen(title: "New Task", message: "Task Creator"))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      CircleAvatar(backgroundColor: Colors.amber, radius: 14, child: Icon(Icons.add, color: Colors.white, size: 16)),
                      Text("Create\nNew Task", style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GlassContainer(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailScreen(title: "Profile Setup", message: "Setup Progress View"))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Complete Your", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("80% Done", style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold)),
                  ],
                ),
                const Text("Profile Setup", style: TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 10),
                LinearProgressIndicator(value: 0.8, backgroundColor: Colors.white.withOpacity(0.5), color: const Color(0xFF7F4FD5)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text("Actions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailScreen(title: "Notebook Action", message: ""))), child: const _ActionCard(icon: Icons.book, label: "Notebook", color: Color(0xFFFFEBEE))),
              GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailScreen(title: "Camera Action", message: ""))), child: const _ActionCard(icon: Icons.camera_alt, label: "Camera", color: Color(0xFFE8F5E9))),
              GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailScreen(title: "Audio Action", message: ""))), child: const _ActionCard(icon: Icons.mic, label: "Audio", color: Color(0xFFFFF3E0))),
              GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailScreen(title: "Event Action", message: ""))), child: const _ActionCard(icon: Icons.event, label: "Event", color: Color(0xFFE3F2FD))),
            ],
          ),
          const SizedBox(height: 20),
          // ==========================================
          // GRAPHICAL DATA VISUAL / ANALYTICS WIDGET
          // ==========================================
          GlassContainer(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailScreen(title: "Activity Analytics", message: "Detailed Weekly Productivity Insights"))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Weekly Activity Visual", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text("+12% vs last week", style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    _ChartBar(day: "Mon", height: 40, isSelected: false),
                    _ChartBar(day: "Tue", height: 65, isSelected: false),
                    _ChartBar(day: "Wed", height: 50, isSelected: false),
                    _ChartBar(day: "Thu", height: 90, isSelected: true),
                    _ChartBar(day: "Fri", height: 75, isSelected: false),
                    _ChartBar(day: "Sat", height: 30, isSelected: false),
                    _ChartBar(day: "Sun", height: 45, isSelected: false),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartBar extends StatelessWidget {
  final String day;
  final double height;
  final bool isSelected;

  const _ChartBar({required this.day, required this.height, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 12,
          height: height,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF7F4FD5) : Colors.deepPurple.shade100,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(height: 8),
        Text(day, style: TextStyle(fontSize: 10, color: Colors.grey[600], fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _ActionCard({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          CircleAvatar(backgroundColor: color.withOpacity(0.8), child: Icon(icon, color: Colors.black87, size: 18)),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

// ==========================================
// 2. NOTES SCREEN TAB
// ==========================================
class NotesTab extends StatelessWidget {
  const NotesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> dailyNotes = [
      {"title": "✨ Sketch One UIScreen..", "desc": "Four app project unfinished..", "date": "13 Jan 2025", "priority": "High Priority"},
      {"title": "🧠 Review yesterday's designs..", "desc": "There are many questions about layout structure.", "date": "11 Jan 2025", "priority": "Productive"},
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Browse", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Row(
              children: [
                GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailScreen(title: "Search Notes", message: ""))), child: const CircleAvatar(backgroundColor: Colors.white, radius: 18, child: Icon(Icons.search, size: 18, color: Colors.black))),
                const SizedBox(width: 8),
                GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailScreen(title: "Options", message: ""))), child: const CircleAvatar(backgroundColor: Colors.white, radius: 18, child: Icon(Icons.more_horiz, size: 18, color: Colors.black))),
              ],
            )
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailScreen(title: "Shortcut", message: ""))), child: const _BrowseChip(icon: Icons.star, label: "Shortcut", color: Color(0xFFEDE7F6))),
            GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailScreen(title: "Tags", message: ""))), child: const _BrowseChip(icon: Icons.label, label: "Tags", color: Color(0xFFE3F2FD))),
            GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailScreen(title: "Recent", message: ""))), child: const _BrowseChip(icon: Icons.access_time, label: "Recent", color: Color(0xFFFFFDE7))),
            GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailScreen(title: "Shared", message: ""))), child: const _BrowseChip(icon: Icons.group, label: "Shared", color: Color(0xFFFCE4EC))),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Daily Notes", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailScreen(title: "All Daily Notes", message: ""))), child: const Text("See All", style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold))),
          ],
        ),
        const SizedBox(height: 12),
        ...dailyNotes.map((note) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: GlassContainer(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => NoteDetailScreen(title: note["title"]!, description: note["desc"]!, priority: note["priority"]!, date: note["date"]!))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(note["title"]!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 6),
                Text(note["desc"]!, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: Colors.purple.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                      child: Text(note["date"]!, style: const TextStyle(fontSize: 10, color: Colors.purple)),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(color: Colors.red.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                      child: Text(note["priority"]!, style: const TextStyle(fontSize: 10, color: Colors.red)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )),
      ],
    );
  }
}

class _BrowseChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _BrowseChip({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(backgroundColor: color.withOpacity(0.7), radius: 24, child: Icon(icon, color: Colors.deepPurple, size: 18)),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

// ==========================================
// 3. NOTEBOOKS SCREEN TAB
// ==========================================
class NotebooksTab extends StatelessWidget {
  const NotebooksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Notebooks", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Row(
              children: [
                GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailScreen(title: "Search Notebooks", message: ""))), child: const CircleAvatar(backgroundColor: Colors.white, radius: 18, child: Icon(Icons.search, size: 18, color: Colors.black))),
                const SizedBox(width: 8),
                GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailScreen(title: "More Options", message: ""))), child: const CircleAvatar(backgroundColor: Colors.white, radius: 18, child: Icon(Icons.more_horiz, size: 18, color: Colors.black))),
              ],
            )
          ],
        ),
        const Text("Collect & folder it as library", style: TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 20),
        GlassContainer(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailScreen(title: "Daily Notebooks", message: ""))), child: _NotebookCard(title: "Daily Notebooks", count: "3 Notes", date: "January 10", color: Colors.blue[50]!, icon: Icons.calendar_month)),
        const SizedBox(height: 12),
        GlassContainer(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailScreen(title: "Work Notebook", message: ""))), child: _NotebookCard(title: "Work", count: "0 Notes", date: "No notes yet", color: Colors.purple[50]!, icon: Icons.work)),
      ],
    );
  }
}

class _NotebookCard extends StatelessWidget {
  final String title;
  final String count;
  final String date;
  final Color color;
  final IconData icon;

  const _NotebookCard({required this.title, required this.count, required this.date, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: color.withOpacity(0.8), borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: Colors.black87),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 4),
            Text("$count • $date", style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        )
      ],
    );
  }
}

// ==========================================
// 4. TASKS SCREEN TAB
// ==========================================
class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("My Tasks", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Row(
              children: [
                GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailScreen(title: "Search Tasks", message: ""))), child: const CircleAvatar(backgroundColor: Colors.white, radius: 18, child: Icon(Icons.search, size: 18, color: Colors.black))),
                const SizedBox(width: 8),
                GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailScreen(title: "Task Options", message: ""))), child: const CircleAvatar(backgroundColor: Colors.white, radius: 18, child: Icon(Icons.more_horiz, size: 18, color: Colors.black))),
              ],
            )
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: const [
            _TaskChip(icon: Icons.book, label: "Notebooks", isSelected: false),
            SizedBox(width: 8),
            _TaskChip(icon: Icons.task, label: "My Tasks", badge: "17", isSelected: true),
            SizedBox(width: 8),
            _TaskChip(icon: Icons.calendar_today, label: "Today", isSelected: false),
          ],
        ),
        const SizedBox(height: 18),
        const Text("Active Task", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 10),
        SizedBox(
          height: 115,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              GlassContainer(width: 180, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailScreen(title: "Breathe & Stretch", message: ""))), child: const _TaskCardContent(title: "40-min Breathe & Stretch", progress: 0.8)),
              const SizedBox(width: 10),
              GlassContainer(width: 180, onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailScreen(title: "Evening Walk", message: ""))), child: const _TaskCardContent(title: "20-min Evening Walk", progress: 0.92)),
            ],
          ),
        ),
      ],
    );
  }
}

class _TaskChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? badge;
  final bool isSelected;

  const _TaskChip({required this.icon, required this.label, this.badge, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.deepPurple),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          if (badge != null) ...[
            const SizedBox(width: 6),
            CircleAvatar(radius: 9, backgroundColor: Colors.deepPurple, child: Text(badge!, style: const TextStyle(color: Colors.white, fontSize: 9))),
          ]
        ],
      ),
    );
  }
}

class _TaskCardContent extends StatelessWidget {
  final String title;
  final double progress;
  const _TaskCardContent({required this.title, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), maxLines: 2, overflow: TextOverflow.ellipsis),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Progress", style: TextStyle(fontSize: 10, color: Colors.grey)),
                Text("${(progress * 100).toInt()}%", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 4),
            LinearProgressIndicator(value: progress, color: Colors.deepPurple, backgroundColor: Colors.white.withOpacity(0.5)),
          ],
        ),
      ],
    );
  }
}

// ==========================================
// 5. CALENDAR SCREEN TAB
// ==========================================
class CalendarTab extends StatefulWidget {
  const CalendarTab({super.key});

  @override
  State<CalendarTab> createState() => _CalendarTabState();
}

class _CalendarTabState extends State<CalendarTab> {
  int selectedDateIndex = 3;

  final List<Map<String, String>> calendarDates = [
    {"day": "T", "date": "15", "month": "January 15, 2025"},
    {"day": "W", "date": "16", "month": "January 16, 2025"},
    {"day": "T", "date": "17", "month": "January 17, 2025"},
    {"day": "F", "date": "17", "month": "January 17, 2025"},
    {"day": "S", "date": "18", "month": "January 18, 2025"},
    {"day": "S", "date": "19", "month": "January 19, 2025"},
    {"day": "M", "date": "20", "month": "January 20, 2025"},
  ];

  @override
  Widget build(BuildContext context) {
    String currentSelectedMonth = calendarDates[selectedDateIndex]["month"]!;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("My Calendar", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Row(
              children: [
                GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailScreen(title: "Calendar Picker", message: ""))), child: const CircleAvatar(backgroundColor: Colors.white, radius: 18, child: Icon(Icons.calendar_month, size: 18, color: Colors.black))),
                const SizedBox(width: 8),
                GestureDetector(onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailScreen(title: "Settings", message: ""))), child: const CircleAvatar(backgroundColor: Colors.white, radius: 18, child: Icon(Icons.more_horiz, size: 18, color: Colors.black))),
              ],
            )
          ],
        ),
        const SizedBox(height: 4),
        Text("January 17, 2025", style: TextStyle(color: Colors.grey[600], fontSize: 12, fontWeight: FontWeight.w500)),
        const SizedBox(height: 16),
        GlassContainer(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(calendarDates.length, (index) {
              bool isSelected = selectedDateIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedDateIndex = index;
                  });
                },
                child: Column(
                  children: [
                    Text(
                      calendarDates[index]["day"]!,
                      style: TextStyle(color: Colors.grey[600], fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    CircleAvatar(
                      backgroundColor: isSelected ? Colors.deepPurple.shade100 : Colors.transparent,
                      radius: 18,
                      child: Text(
                        calendarDates[index]["date"]!,
                        style: TextStyle(
                          color: isSelected ? Colors.deepPurple.shade900 : Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 24),
        GlassContainer(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(title: "Exercise Event", message: "Selected Date: $currentSelectedMonth"))),
          child: const _CalendarEventTileContent(
            time: "08:30 AM",
            title: "60min Push-up & Stretching Exercise..",
            duration: "08:30 AM - 9:30 AM",
            hasAvatars: true,
          ),
        ),
        const SizedBox(height: 16),
        GlassContainer(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailScreen(title: "Client Meeting", message: "Selected Date: $currentSelectedMonth"))),
          child: const _CalendarEventTileContent(
            time: "11:31 AM",
            title: "Schedule Client Meeting..",
            duration: "11:31 AM - 1:00 PM",
            hasAvatars: true,
          ),
        ),
      ],
    );
  }
}

class _CalendarEventTileContent extends StatelessWidget {
  final String time;
  final String title;
  final String duration;
  final bool hasAvatars;

  const _CalendarEventTileContent({
    required this.time,
    required this.title,
    required this.duration,
    required this.hasAvatars,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(time, style: const TextStyle(color: Colors.grey, fontSize: 11, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 4),
              Text(duration, style: const TextStyle(color: Colors.pink, fontSize: 11, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
        if (hasAvatars)
          SizedBox(
            width: 60,
            height: 24,
            child: Stack(
              children: const [
                Positioned(left: 0, child: CircleAvatar(radius: 10, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'))),
                Positioned(left: 12, child: CircleAvatar(radius: 10, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'))),
                Positioned(left: 24, child: CircleAvatar(radius: 10, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=13'))),
              ],
            ),
          )
      ],
    );
  }
}