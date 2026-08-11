import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const GameOfThronesApp());
}

// ==========================================
// ROYAL GOT THEME SETUP
// ==========================================
class GoTTheme {
  static const Color backgroundTop = Color(0xFF0F1015);
  static const Color backgroundBottom = Color(0xFF1B1D24);
  static const Color cardBackground = Color(0xFF22252F);
  static const Color goldAccent = Color(0xFFE5C158);
  static const Color darkGold = Color(0xFF9E7D20);
  static const Color crimson = Color(0xFF8B0000);
  static const Color textLight = Color(0xFFF0F0F0);
  static const Color textMuted = Color(0xFFA0A5B5);

  static ThemeData get themeData {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundTop,
      primaryColor: goldAccent,
      fontFamily: 'serif',
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: goldAccent,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
        ),
      ),
    );
  }

  static BoxDecoration get pageGradient {
    return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [backgroundTop, backgroundBottom],
      ),
    );
  }
}

// ==========================================
// MODELS
// ==========================================
class GotCharacter {
  final int id;
  final String firstName;
  final String lastName;
  final String fullName;
  final String title;
  final String family;
  final String imageUrl;

  GotCharacter({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.title,
    required this.family,
    required this.imageUrl,
  });

  factory GotCharacter.fromJson(Map<String, dynamic> json) {
    return GotCharacter(
      id: json['id'] ?? 0,
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      fullName: (json['fullName'] != null && json['fullName'].toString().isNotEmpty)
          ? json['fullName']
          : '${json['firstName']} ${json['lastName']}',
      title: (json['title'] != null && json['title'].toString().isNotEmpty)
          ? json['title']
          : 'Westeros Citizen',
      family: (json['family'] != null && json['family'].toString().isNotEmpty)
          ? json['family']
          : 'Unassigned House',
      imageUrl: json['imageUrl'] ?? '',
    );
  }
}

// ==========================================
// MAIN APP ENTRY
// ==========================================
class GameOfThronesApp extends StatelessWidget {
  const GameOfThronesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Game of Thrones Codex',
      theme: GoTTheme.themeData,
      home: const MainShell(),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    CharacterListScreen(),
    HousesOverviewScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: GoTTheme.pageGradient,
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: GoTTheme.darkGold, width: 0.5)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          backgroundColor: GoTTheme.backgroundBottom,
          selectedItemColor: GoTTheme.goldAccent,
          unselectedItemColor: GoTTheme.textMuted,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outline),
              activeIcon: Icon(Icons.people, color: GoTTheme.goldAccent),
              label: 'Characters',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shield_outlined),
              activeIcon: Icon(Icons.shield, color: GoTTheme.goldAccent),
              label: 'Great Houses',
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// SCREEN 1: ALL CHARACTERS (API FETCHED)
// ==========================================
class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  late Future<List<GotCharacter>> _charactersFuture;
  List<GotCharacter> _allCharacters = [];
  List<GotCharacter> _filteredCharacters = [];
  String _searchQuery = '';
  String _selectedFamily = 'All';

  @override
  void initState() {
    super.initState();
    _charactersFuture = fetchAllCharacters();
  }

  Future<List<GotCharacter>> fetchAllCharacters() async {
    try {
      final response = await http.get(Uri.parse('https://thronesapi.com/api/v2/Characters'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final list = data.map((json) => GotCharacter.fromJson(json)).toList();
        setState(() {
          _allCharacters = list;
          _filteredCharacters = list;
        });
        return list;
      } else {
        throw Exception('Failed to load characters');
      }
    } catch (e) {
      // Fallback local dataset if network is unreachable
      return _getFallbackCharacters();
    }
  }

  void _applyFilters() {
    setState(() {
      _filteredCharacters = _allCharacters.where((char) {
        final matchesSearch = char.fullName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            char.title.toLowerCase().contains(_searchQuery.toLowerCase());
        final matchesFamily = _selectedFamily == 'All' ||
            char.family.toLowerCase().contains(_selectedFamily.toLowerCase());
        return matchesSearch && matchesFamily;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final families = ['All', 'Stark', 'Targaryen', 'Lannister', 'Baratheon', 'Greyjoy'];

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('AMAZEVALLEY THRONE'),
      ),
      body: Column(
        children: [
          // Search Box with Glassmorphism border
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              onChanged: (val) {
                _searchQuery = val;
                _applyFilters();
              },
              style: const TextStyle(color: GoTTheme.textLight),
              decoration: InputDecoration(
                hintText: 'Search lord, queen, or knight...',
                hintStyle: const TextStyle(color: GoTTheme.textMuted, fontSize: 13),
                prefixIcon: const Icon(Icons.search, color: GoTTheme.goldAccent),
                filled: true,
                fillColor: GoTTheme.cardBackground.withOpacity(0.8),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: GoTTheme.darkGold.withOpacity(0.6)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: GoTTheme.goldAccent, width: 1.5),
                ),
              ),
            ),
          ),

          // House Filter Chips
          SizedBox(
            height: 42,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: families.length,
              itemBuilder: (context, index) {
                final family = families[index];
                final isSelected = _selectedFamily == family;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ChoiceChip(
                    label: Text(
                      family,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isSelected ? Colors.black : GoTTheme.textLight,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
                    selected: isSelected,
                    selectedColor: GoTTheme.goldAccent,
                    backgroundColor: GoTTheme.cardBackground,
                    onSelected: (selected) {
                      setState(() {
                        _selectedFamily = family;
                        _applyFilters();
                      });
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),

          // FutureBuilder Main Character Grid
          Expanded(
            child: FutureBuilder<List<GotCharacter>>(
              future: _charactersFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: GoTTheme.goldAccent),
                  );
                } else if (snapshot.hasError && _allCharacters.isEmpty) {
                  return const Center(
                    child: Text('Failed to load Westeros records.',
                        style: TextStyle(color: GoTTheme.textMuted)),
                  );
                }

                if (_filteredCharacters.isEmpty) {
                  return const Center(
                    child: Text('No character matches your query.',
                        style: TextStyle(color: GoTTheme.textMuted)),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.72,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: _filteredCharacters.length,
                  itemBuilder: (context, index) {
                    final character = _filteredCharacters[index];
                    return _buildCharacterCard(character);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCharacterCard(GotCharacter character) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CharacterDetailScreen(character: character),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: GoTTheme.cardBackground.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: GoTTheme.darkGold.withOpacity(0.4), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image Box
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.network(
                  character.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.black26,
                    child: const Icon(Icons.shield, color: GoTTheme.goldAccent, size: 40),
                  ),
                ),
              ),
            ),

            // Info Section with strict Text Overflow Protection
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.fullName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis, // Ellipsis handles overflow
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: GoTTheme.textLight,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    character.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis, // Ellipsis handles overflow
                    style: const TextStyle(
                      color: GoTTheme.goldAccent,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    character.family,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis, // Ellipsis handles overflow
                    style: const TextStyle(
                      color: GoTTheme.textMuted,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<GotCharacter> _getFallbackCharacters() {
    return [
      GotCharacter(id: 1, firstName: 'Daenerys', lastName: 'Targaryen', fullName: 'Daenerys Targaryen', title: 'Mother of Dragons', family: 'Targaryen', imageUrl: 'https://thronesapi.com/assets/images/daenerys.jpg'),
      GotCharacter(id: 2, firstName: 'Samwell', lastName: 'Tarly', fullName: 'Samwell Tarly', title: 'Maester of the Night\'s Watch', family: 'Tarly', imageUrl: 'https://thronesapi.com/assets/images/samwell.jpg'),
      GotCharacter(id: 3, firstName: 'Jon', lastName: 'Snow', fullName: 'Jon Snow', title: 'King in the North', family: 'Stark', imageUrl: 'https://thronesapi.com/assets/images/jon-snow.jpg'),
      GotCharacter(id: 4, firstName: 'Arya', lastName: 'Stark', fullName: 'Arya Stark', title: 'No One', family: 'Stark', imageUrl: 'https://thronesapi.com/assets/images/arya-stark.jpg'),
    ];
  }
}

// ==========================================
// SCREEN 2: CHARACTER DETAIL SCREEN
// ==========================================
class CharacterDetailScreen extends StatelessWidget {
  final GotCharacter character;

  const CharacterDetailScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: GoTTheme.pageGradient,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 360.0,
              pinned: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: GoTTheme.goldAccent),
                onPressed: () => Navigator.pop(context),
              ),
              flexibleSpace: FlexibleSpaceBar(
                title: LayoutBuilder(
                  builder: (context, constraints) {
                    return Text(
                      character.fullName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis, // Ellipsis handles overflow
                      style: const TextStyle(
                        color: GoTTheme.goldAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        shadows: [Shadow(color: Colors.black, blurRadius: 8)],
                      ),
                    );
                  },
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      character.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.black,
                        child: const Icon(Icons.person, size: 80, color: GoTTheme.goldAccent),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            GoTTheme.backgroundTop.withOpacity(0.7),
                            GoTTheme.backgroundTop,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title Pill
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: GoTTheme.cardBackground,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: GoTTheme.darkGold),
                        ),
                        child: Text(
                          character.title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: GoTTheme.goldAccent,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Information Table Cards
                    _buildInfoRow('House / Allegiance', character.family),
                    _buildInfoRow('First Name', character.firstName),
                    _buildInfoRow('Last Name', character.lastName),
                    _buildInfoRow('Character ID', '#${character.id}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: GoTTheme.cardBackground.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: GoTTheme.darkGold.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: GoTTheme.textMuted, fontSize: 13),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value.isEmpty ? 'N/A' : value,
              textAlign: TextAlign.end,
              maxLines: 1,
              overflow: TextOverflow.ellipsis, // Ellipsis handles overflow
              style: const TextStyle(
                color: GoTTheme.textLight,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// SCREEN 3: HOUSES OVERVIEW
// ==========================================
class HousesOverviewScreen extends StatelessWidget {
  const HousesOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final houses = [
      {'name': 'House Stark', 'sigil': '🐺 Direwolf', 'motto': 'Winter is Coming', 'seat': 'Winterfell'},
      {'name': 'House Targaryen', 'sigil': '🐉 Dragon', 'motto': 'Fire and Blood', 'seat': 'Dragonstone'},
      {'name': 'House Lannister', 'sigil': '🦁 Lion', 'motto': 'Hear Me Roar!', 'seat': 'Casterly Rock'},
      {'name': 'House Baratheon', 'sigil': '🦌 Stag', 'motto': 'Ours is the Fury', 'seat': 'Storm\'s End'},
      {'name': 'House Greyjoy', 'sigil': '🦑 Kraken', 'motto': 'We Do Not Sow', 'seat': 'Pyke'},
      {'name': 'House Martell', 'sigil': '☀️ Sun & Spear', 'motto': 'Unbowed, Unbent, Unbroken', 'seat': 'Sunspear'},
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('GREAT HOUSES'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: houses.length,
        itemBuilder: (context, index) {
          final house = houses[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: GoTTheme.cardBackground.withOpacity(0.85),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: GoTTheme.darkGold.withOpacity(0.5)),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: GoTTheme.crimson.withOpacity(0.2),
                    shape: BoxShape.circle,
                    border: Border.all(color: GoTTheme.crimson),
                  ),
                  child: Center(
                    child: Text(
                      house['sigil']!.split(' ').first,
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        house['name']!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: GoTTheme.textLight,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        ' "${house['motto']}" ',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: GoTTheme.goldAccent,
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Seat: ${house['seat']}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: GoTTheme.textMuted,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}