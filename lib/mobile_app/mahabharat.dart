import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const MahabharatApp());
}

// ==========================================
// LAVENDER & WHITE GLASS THEME SETUP
// ==========================================
class GlassTheme {
  static const Color darkBackground = Color(0xFF0D0B18);
  static const Color lavenderPrimary = Color(0xFFD8B4F8);
  static const Color lavenderSoft = Color(0xFFE8D5C4);
  static const Color whiteAccent = Color(0xFFFFFFFF);
  static const Color textMuted = Color(0xFFB8B3CE);

  static LinearGradient get lavenderWhiteGradient => const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFE6E6FA),
      Color(0xFFFFFFFF),
    ],
  );

  static LinearGradient get glassGradient => LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.white.withOpacity(0.18),
      Colors.white.withOpacity(0.05),
    ],
  );

  static ThemeData get themeData {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBackground,
      primaryColor: lavenderPrimary,
      fontFamily: 'serif',
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: whiteAccent,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
        ),
      ),
    );
  }
}

// ==========================================
// CHARACTER MODEL
// ==========================================
class MahabharatCharacter {
  final String id;
  final String name;
  final String roleTitle;
  final String actorName;
  final String side;
  final String imageUrl;
  final String quickSummary;
  final String fullStory;
  final List<String> keyWeapons;

  MahabharatCharacter({
    required this.id,
    required this.name,
    required this.roleTitle,
    required this.actorName,
    required this.imageUrl,
    required this.side,
    required this.quickSummary,
    required this.fullStory,
    required this.keyWeapons,
  });
}

// ==========================================
// DATASET
// ==========================================
final List<MahabharatCharacter> mahabharatCharacters = [
  MahabharatCharacter(
    id: '1',
    name: 'Lord Krishna',
    roleTitle: 'Supreme Guide & Charioteer',
    actorName: 'Nitish Bharadwaj',
    side: 'Divine Guide',
    imageUrl: 'http://googleusercontent.com/image_collection/image_retrieval/1170002879506706531_0',
    quickSummary: 'The 8th avatar of Vishnu who served as Arjuna’s spiritual guide and delivered the Bhagavad Gita.',
    fullStory: 'Lord Krishna guided the Pandavas through diplomacy and spiritual wisdom. On the battlefield of Kurukshetra, when Arjuna faltered, Krishna imparted the immortal teachings of the Bhagavad Gita.',
    keyWeapons: ['Sudarshana Chakra', 'Kaumodaki Mace', 'Panchajanya Conch'],
  ),
  MahabharatCharacter(
    id: '2',
    name: 'Arjuna',
    roleTitle: 'Master Archer & 3rd Pandava',
    actorName: 'Firoz Khan (Arjun)',
    side: 'Pandava',
    imageUrl: 'http://googleusercontent.com/image_collection/image_retrieval/16804005918780148132_0',
    quickSummary: 'Undisputed master of archery, bearer of the divine Gandiva bow, and favorite student of Drona.',
    fullStory: 'Arjuna, son of Indra and Kunti, won Draupadi in her Swayamvara. During the war, he turned the tide against the Kaurava army using divine astras granted by Lord Shiva.',
    keyWeapons: ['Gandiva Bow', 'Pashupatastra', 'Agneyastra'],
  ),
  MahabharatCharacter(
    id: '3',
    name: 'Karna',
    roleTitle: 'Suryaputra & Loyal Ally',
    actorName: 'Pankaj Dheer',
    side: 'Kaurava Ally',
    imageUrl: 'http://googleusercontent.com/image_collection/image_retrieval/8514763752445027831_0',
    quickSummary: 'Firstborn of Kunti and Surya, famous for his unmatched generosity and tragic loyalty to Duryodhana.',
    fullStory: 'Abandoned at birth, Karna faced lifelong rejection due to his presumed low caste. Raised by a charioteer, his archery skill and generosity made him one of the grandest figures of the epic.',
    keyWeapons: ['Vijaya Bow', 'Vasavi Shakti', 'Nagastra'],
  ),
  MahabharatCharacter(
    id: '4',
    name: 'Bheeshma Pitamah',
    roleTitle: 'Grand Sire of Kuru Clan',
    actorName: 'Mukesh Khanna',
    side: 'Kuru Realm',
    imageUrl: 'http://googleusercontent.com/image_collection/image_retrieval/3200642369054279768_0',
    quickSummary: 'Grandson of Ganga, bound by an unbreakable vow of celibacy and eternal service to the Hastinapur throne.',
    fullStory: 'Blessed with Ichha Mrityu (control over his time of death), Bheeshma commanded the Kaurava forces for 10 days before lying on a bed of arrows until Uttarayana.',
    keyWeapons: ['Praswapastra', 'Celestial Bow', 'Vayu Astra'],
  ),
  MahabharatCharacter(
    id: '5',
    name: 'Draupadi',
    roleTitle: 'Empress born of Fire',
    actorName: 'Roopa Ganguly',
    side: 'Pandava Queen',
    imageUrl: 'http://googleusercontent.com/image_collection/image_retrieval/11317890585596888819_0',
    quickSummary: 'Born from the sacred fire of King Drupada, her honor became the catalyst for the Kurukshetra war.',
    fullStory: 'Following her humiliation in the Kuru assembly, Draupadi vowed that her hair would remain unbound until bathed in the blood of Dushasana.',
    keyWeapons: ['Unyielding Will', 'Spiritual Devotion'],
  ),
  MahabharatCharacter(
    id: '6',
    name: 'Duryodhana',
    roleTitle: 'Crown Prince of Hastinapur',
    actorName: 'Puneet Issar',
    side: 'Kaurava Leader',
    imageUrl: 'http://googleusercontent.com/image_collection/image_retrieval/12830842868110835626_0',
    quickSummary: 'Eldest Kaurava whose jealousy and refusal to share the kingdom sparked the Great War.',
    fullStory: 'A formidable mace-wielder trained by Balarama, Duryodhana refused Lord Krishna’s peace proposal of five villages, forcing the conflict at Kurukshetra.',
    keyWeapons: ['Vajra-hard Mace', 'Gada Combat'],
  ),
  MahabharatCharacter(
    id: '7',
    name: 'Bhima',
    roleTitle: 'Vrikodara & 2nd Pandava',
    actorName: 'Praveen Kumar',
    side: 'Pandava',
    imageUrl: 'http://googleusercontent.com/image_collection/image_retrieval/8727198548689360799_0',
    quickSummary: 'Possessing the strength of ten thousand elephants, Bhima vowed to kill all one hundred Kaurava brothers.',
    fullStory: 'Known for his ferocious rage and massive physique, Bhima fulfilled his vows by killing Dushasana and breaking Duryodhana’s thigh on the 18th day.',
    keyWeapons: ['Heavy Iron Gada (Mace)', 'Unarmed Combat'],
  ),
  MahabharatCharacter(
    id: '8',
    name: 'Dronacharya',
    roleTitle: 'Royal Preceptor & Master Strategist',
    actorName: 'Surendra Pal',
    side: 'Kaurava Commander',
    imageUrl: 'http://googleusercontent.com/image_collection/image_retrieval/9920498732886258112_0',
    quickSummary: 'Royal teacher of divine weapons to both Pandava and Kaurava princes, a master of strategy.',
    fullStory: 'Born from Sage Bharadwaja, Drona was a master of celestial astras. Bound by his allegiance to Hastinapur, he commanded the Kaurava forces for five days.',
    keyWeapons: ['Celestial Bows', 'Chakravyuha Formation', 'Brahmastra'],
  ),
  MahabharatCharacter(
    id: '9',
    name: 'Abhimanyu',
    roleTitle: 'Master of Chakravyuha & Arjuna\'s Son',
    actorName: 'Mayur Verma',
    side: 'Pandava Warrior',
    imageUrl: 'http://googleusercontent.com/image_collection/image_retrieval/10928877217525565538_0',
    quickSummary: 'Arjuna’s son who learned to breach the Chakravyuha while inside his mother’s womb.',
    fullStory: 'On the 13th day, teenage Abhimanyu entered the deadly Chakravyuha formation, single-handedly fighting off major Kaurava maharathis before his valiant death.',
    keyWeapons: ['Bow & Arrow', 'Chariot Wheel'],
  ),
  MahabharatCharacter(
    id: '10',
    name: 'Yudhishthira',
    roleTitle: 'Dharmaraj & Eldest Pandava',
    actorName: 'Gajendra Chauhan',
    side: 'Pandava Leader',
    imageUrl: 'https://picsum.photos/seed/yudhishthira/600/800',
    quickSummary: 'Eldest Pandava born from Yama (Dharma), known for his absolute adherence to truth and righteousness.',
    fullStory: 'The rightful king of Hastinapur whose flaw in the game of dice led to exile. He ruled Hastinapur as the sole surviving patriarch following the war.',
    keyWeapons: ['Spear', 'Lance', 'Dharma Astra'],
  ),
];

// ==========================================
// MAIN APP ENTRY
// ==========================================
class MahabharatApp extends StatelessWidget {
  const MahabharatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mahabharat Liquid Glass',
      theme: GlassTheme.themeData,
      home: const CharacterListScreen(),
    );
  }
}

// ==========================================
// 1. CHARACTER LIST SCREEN
// ==========================================
class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _blobController;
  String _searchQuery = '';
  String _selectedFilter = 'All';

  @override
  void initState() {
    super.initState();
    _blobController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 7),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _blobController.dispose();
    super.dispose();
  }

  List<MahabharatCharacter> get _filteredList {
    return mahabharatCharacters.where((char) {
      final matchesSearch = char.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          char.roleTitle.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          char.actorName.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesFilter = _selectedFilter == 'All' ||
          char.side.toLowerCase().contains(_selectedFilter.toLowerCase());

      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filters = ['All', 'Pandava', 'Kaurava', 'Divine', 'Kuru'];

    return Scaffold(
      body: Stack(
        children: [
          // Background Blobs
          AnimatedBuilder(
            animation: _blobController,
            builder: (context, child) {
              return Stack(
                children: [
                  Positioned(
                    top: -40 + (30 * _blobController.value),
                    left: -30 + (20 * _blobController.value),
                    child: Container(
                      width: 280,
                      height: 280,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFB19FFB).withOpacity(0.45),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFB19FFB).withOpacity(0.5),
                            blurRadius: 120,
                            spreadRadius: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.35 - (40 * _blobController.value),
                    right: -50 + (25 * _blobController.value),
                    child: Container(
                      width: 260,
                      height: 260,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.3),
                            blurRadius: 100,
                            spreadRadius: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // Scroll View
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 160.0,
                floating: false,
                pinned: true,
                backgroundColor: Colors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: ShaderMask(
                    shaderCallback: (bounds) => GlassTheme.lavenderWhiteGradient.createShader(bounds),
                    child: const Text(
                      'AMAZEVALLEY \nMAHABHARAT CODEX',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),

              // Search & Filter Section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white.withOpacity(0.25)),
                            ),
                            child: TextField(
                              onChanged: (val) => setState(() => _searchQuery = val),
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                hintText: 'Search warrior, weapon, or actor...',
                                hintStyle: TextStyle(color: GlassTheme.textMuted, fontSize: 13),
                                prefixIcon: Icon(Icons.search, color: GlassTheme.lavenderPrimary),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 14),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Filter Chips List
                      SizedBox(
                        height: 38,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: filters.length,
                          itemBuilder: (context, index) {
                            final filter = filters[index];
                            final isSelected = _selectedFilter == filter;
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: GestureDetector(
                                onTap: () => setState(() => _selectedFilter = filter),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 200),
                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        gradient: isSelected ? GlassTheme.lavenderWhiteGradient : null,
                                        color: isSelected ? null : Colors.white.withOpacity(0.07),
                                        border: Border.all(
                                          color: isSelected ? Colors.white : Colors.white.withOpacity(0.2),
                                        ),
                                      ),
                                      child: Text(
                                        filter,
                                        style: TextStyle(
                                          color: isSelected ? Colors.black : Colors.white,
                                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Character Cards
              SliverPadding(
                padding: const EdgeInsets.all(16.0),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final character = _filteredList[index];
                      return _buildLiquidGlassCard(context, character);
                    },
                    childCount: _filteredList.length,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLiquidGlassCard(BuildContext context, MahabharatCharacter character) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: GlassTheme.glassGradient,
              border: Border.all(
                color: Colors.white.withOpacity(0.22),
                width: 1.5,
              ),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CharacterDetailScreen(character: character),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    Hero(
                      tag: 'character_image_${character.id}',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: SizedBox(
                          width: 85,
                          height: 105,
                          child: Image.network(
                            character.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: const Color(0xFF5A4880),
                              child: const Icon(Icons.shield, color: GlassTheme.lavenderPrimary, size: 36),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Fixed typo
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) => GlassTheme.lavenderWhiteGradient.createShader(bounds),
                            child: Text(
                              character.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            character.roleTitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              color: GlassTheme.lavenderPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Actor: ${character.actorName}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 11,
                              color: GlassTheme.textMuted,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: GlassTheme.lavenderPrimary.withOpacity(0.15),
                              border: Border.all(
                                color: GlassTheme.lavenderPrimary.withOpacity(0.4),
                              ),
                            ),
                            child: Text(
                              character.side,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: GlassTheme.lavenderPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios, color: GlassTheme.lavenderPrimary, size: 16),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 2. DETAIL SCREEN
// ==========================================
class CharacterDetailScreen extends StatelessWidget {
  final MahabharatCharacter character;

  const CharacterDetailScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 340.0,
            pinned: true,
            backgroundColor: Colors.transparent,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.black45,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: ShaderMask(
                shaderCallback: (bounds) => GlassTheme.lavenderWhiteGradient.createShader(bounds),
                child: Text(
                  character.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              background: Hero(
                tag: 'character_image_${character.id}',
                child: Image.network(
                  character.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color(0xFF322353),
                    child: const Icon(Icons.shield, size: 80, color: GlassTheme.lavenderPrimary),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Fixed typo
                children: [
                  Center(
                    child: Text(
                      '— ${character.roleTitle} —',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: GlassTheme.lavenderPrimary,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    character.fullStory,
                    style: const TextStyle(fontSize: 15, height: 1.6, color: Colors.white),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}