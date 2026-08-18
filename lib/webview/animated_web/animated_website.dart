import 'package:flutter/material.dart';
import 'dart:ui';

void main() {
  runApp(const WoodNestApp());
}

class Lodge {
  final String title;
  final String subtitle;
  final String price;
  final String guests;
  final String imageUrl;
  final String description;

  const Lodge({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.guests,
    required this.imageUrl,
    required this.description,
  });
}

// Separate Data Lists for Locations, Rooms, Experiences, About Us & Gallery
final List<Lodge> kLocationsData = [
  const Lodge(
    title: 'Evergreen Peak',
    subtitle: 'Misty Pine Forest',
    price: '\$359',
    guests: '2-6 guests',
    imageUrl: 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&w=1920&q=80',
    description: 'Immersed in deep ancient pine woods with year-round mountain fog and secluded trails.',
  ),
  const Lodge(
    title: 'Whispering Valley',
    subtitle: 'Highland Ridge',
    price: '\$420',
    guests: '2-4 guests',
    imageUrl: 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=1920&q=80',
    description: 'Perched on high elevation ridges overlooking endless valleys and dramatic sunset vistas.',
  ),
  const Lodge(
    title: 'Emerald Ridge',
    subtitle: 'Deep Forest Sanctuary',
    price: '\$395',
    guests: '2-5 guests',
    imageUrl: 'https://images.unsplash.com/photo-1518780664697-55e3ad937233?auto=format&fit=crop&w=1920&q=80',
    description: 'Surrounded by lush emerald canopies and private natural spring streams.',
  ),
  const Lodge(
    title: 'Shadow Creek',
    subtitle: 'Canyon Hideaway',
    price: '\$450',
    guests: '4-6 guests',
    imageUrl: 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1920&q=80',
    description: 'Tucked safely within private canyon walls, offering absolute serenity and stargazing decks.',
  ),
];

final List<Lodge> kRoomsData = [
  const Lodge(
    title: 'Silvermist Suite',
    subtitle: 'Lakeside Glass Cabin',
    price: '\$490',
    guests: '4-8 guests',
    imageUrl: 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1920&q=80',
    description: 'Direct waterfront access with private dock, Scandinavian sauna, and stone fireplace.',
  ),
  const Lodge(
    title: 'Nordic Timber',
    subtitle: 'Alpine Chalet',
    price: '\$380',
    guests: '2-5 guests',
    imageUrl: 'https://images.unsplash.com/photo-1518780664697-55e3ad937233?auto=format&fit=crop&w=1920&q=80',
    description: 'Traditional solid timber architecture combined with modern minimalist luxury interiors.',
  ),
  const Lodge(
    title: 'Starlight Loft',
    subtitle: 'Glass-Roof Observatory',
    price: '\$510',
    guests: '2-3 guests',
    imageUrl: 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=1920&q=80',
    description: 'Features an inclined glass ceiling directly above the bed for panoramic night sky viewing.',
  ),
  const Lodge(
    title: 'Pine Haven',
    subtitle: 'Classic Timber Cabin',
    price: '\$340',
    guests: '2-4 guests',
    imageUrl: 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&w=1920&q=80',
    description: 'Cozy, rustic aesthetic with modern amenities, wood-burning stove, and private hot tub.',
  ),
];

final List<Map<String, String>> kExperiencesData = [
  {
    'title': 'Guided Wilderness Trekking',
    'subtitle': 'Explore secret waterfalls and summit trails with local experts.',
    'image': 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=1000&q=80',
  },
  {
    'title': 'Aurora Stargazing Nights',
    'subtitle': 'Experience crystal clear night skies away from light pollution.',
    'image': 'https://images.unsplash.com/photo-1519681393784-d120267933ba?auto=format&fit=crop&w=1000&q=80',
  },
  {
    'title': 'Private Lakeside Sauna & Spa',
    'subtitle': 'Rejuvenate your senses with traditional wood-fired thermal sessions.',
    'image': 'https://images.unsplash.com/photo-1540555700478-4be289fbecef?auto=format&fit=crop&w=1000&q=80',
  },
];

final List<String> kGalleryImages = [
  'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&w=1000&q=80',
  'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=1000&q=80',
  'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1000&q=80',
  'https://images.unsplash.com/photo-1518780664697-55e3ad937233?auto=format&fit=crop&w=1000&q=80',
  'https://images.unsplash.com/photo-1571896349842-33c89424de2d?auto=format&fit=crop&w=1000&q=80',
  'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=1000&q=80',
];

class WoodNestApp extends StatelessWidget {
  const WoodNestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazevalley',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'sans-serif',
        scaffoldBackgroundColor: const Color(0xFF0F1720),
        brightness: Brightness.dark,
      ),
      home: const WoodNestHomeScreen(),
    );
  }
}

class WoodNestHomeScreen extends StatefulWidget {
  const WoodNestHomeScreen({super.key});

  @override
  State<WoodNestHomeScreen> createState() => _WoodNestHomeScreenState();
}

class _WoodNestHomeScreenState extends State<WoodNestHomeScreen>
    with TickerProviderStateMixin {
  late final ScrollController _scrollController;
  late final AnimationController _zoomController;
  late final AnimationController _loadingController;

  double _scrollProgress = 0.0;
  bool _isLoadingComplete = false;
  int _selectedLodgeIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    _zoomController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3500),
    );

    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..forward().then((_) {
      setState(() {
        _isLoadingComplete = true;
      });
      _zoomController.forward();
    });
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    if (maxScroll > 0) {
      setState(() {
        _scrollProgress = (_scrollController.offset / maxScroll).clamp(0.0, 1.0);
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _zoomController.dispose();
    _loadingController.dispose();
    super.dispose();
  }

  void _scrollToSection(double offset) {
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final currentLodge = kLocationsData[_selectedLodgeIndex];

    return Scaffold(
      body: Stack(
        children: [
          // 1. Dynamic Background with Zoom
          AnimatedBuilder(
            animation: Listenable.merge([_zoomController, _scrollController]),
            builder: (context, child) {
              final zoomVal = 1.0 + (_zoomController.value * 0.15) - (_scrollProgress * 0.1);
              return Stack(
                fit: StackFit.expand,
                children: [
                  Transform.scale(
                    scale: zoomVal.clamp(0.9, 1.2),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(currentLodge.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.35 + (_scrollProgress * 0.2)),
                          Colors.black.withOpacity(0.85),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // 2. Scrollable Content Layer
          ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(scrollbars: false),
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  // Hero Section
                  SizedBox(
                    height: size.height,
                    child: Stack(
                      children: [
                        Positioned(top: 0, left: 0, right: 0, child: _buildTopNavBar(context)),
                        Positioned(
                          top: size.height * 0.22,
                          left: 60,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Nature's\nPerfect\nHideaways",
                                style: TextStyle(
                                  fontFamily: 'serif',
                                  fontSize: 58,
                                  fontWeight: FontWeight.w400,
                                  height: 1.05,
                                  color: Colors.white,
                                  letterSpacing: -1,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Container(
                                constraints: const BoxConstraints(maxWidth: 340),
                                child: Text(
                                  currentLodge.description,
                                  style: const TextStyle(fontSize: 14, color: Colors.white70, height: 1.5),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  const Text("4.7", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFFFB800))),
                                  const SizedBox(width: 8),
                                  const Icon(Icons.star, color: Color(0xFFFFB800), size: 16),
                                  const SizedBox(width: 12),
                                  Text("from 1,800+ stays", style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.6))),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: size.height * 0.22,
                          right: 60,
                          child: _buildReservationGlassCard(currentLodge),
                        ),
                      ],
                    ),
                  ),

                  // Locations Section
                  _buildSectionContainer(
                    title: 'Locations',
                    subtitle: 'Breathtaking hideaways nestled deep in untouched wilderness.',
                    child: _buildLodgeGrid(kLocationsData),
                  ),

                  // Rooms Section
                  _buildSectionContainer(
                    title: 'Rooms & Cabins',
                    subtitle: 'Architectural masterpieces designed for ultimate relaxation.',
                    child: _buildLodgeGrid(kRoomsData),
                  ),

                  // Experiences Section
                  _buildSectionContainer(
                    title: 'Experiences',
                    subtitle: 'Curated adventures to connect deeply with nature.',
                    child: _buildExperiencesGrid(),
                  ),

                  // About Us Section
                  _buildAboutUsSection(),

                  // Bottom Awesome Image Slider / Carousel Gallery
                  _buildSliderGallerySection(),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),

          // 3. Loading Percentage Animation Overlay
          if (!_isLoadingComplete)
            AnimatedBuilder(
              animation: _loadingController,
              builder: (context, child) {
                final percent = (_loadingController.value * 100).toInt();
                return Positioned(
                  bottom: 50,
                  left: 60,
                  child: Row(
                    children: [
                      Container(width: 40, height: 2, color: Colors.white70),
                      const SizedBox(width: 16),
                      Text(
                        "$percent%",
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w300, color: Colors.white, letterSpacing: 2),
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }

  Widget _buildTopNavBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => _scrollToSection(0),
            child: Row(
              children: const [
                Icon(Icons.eco, color: Colors.white, size: 22),
                SizedBox(width: 8),
                Text('Amazevalley', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 0.5, color: Colors.white)),
              ],
            ),
          ),
          Row(
            children: [
              _navMenuItem('Locations', () => _scrollToSection(MediaQuery.of(context).size.height * 0.95)),
              const SizedBox(width: 32),
              _navMenuItem('Rooms', () => _scrollToSection(MediaQuery.of(context).size.height * 1.8)),
              const SizedBox(width: 32),
              _navMenuItem('Experiences', () => _scrollToSection(MediaQuery.of(context).size.height * 2.6)),
              const SizedBox(width: 32),
              _navMenuItem('About Us', () => _scrollToSection(MediaQuery.of(context).size.height * 3.4)),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            ),
            onPressed: () => _scrollToSection(0),
            child: const Text('Book Now', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          ),
        ],
      ),
    );
  }

  Widget _navMenuItem(String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Text(title, style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 13, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildSectionContainer({required String title, required String subtitle, required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontFamily: 'serif', fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 8),
          Text(subtitle, style: const TextStyle(fontSize: 14, color: Colors.white70)),
          const SizedBox(height: 32),
          child,
        ],
      ),
    );
  }

  Widget _buildLodgeGrid(List<Lodge> list) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 2.5, // Increased width proportion for better image visibility
      ),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final lodge = list[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.06),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white12),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      lodge.imageUrl,
                      width: 400, // Increased width for better image view
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(lodge.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: 4),
                        Text(lodge.subtitle, style: const TextStyle(fontSize: 12, color: Colors.white70)),
                        const SizedBox(height: 8),
                        Text('${lodge.price}/night', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFFFFB800))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildExperiencesGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 1.2,
      ),
      itemCount: kExperiencesData.length,
      itemBuilder: (context, index) {
        final exp = kExperiencesData[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                exp['image']!,
                fit: BoxFit.cover,
                // Added error fallback builder to ensure image is always handled correctly
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey.shade900,
                  child: const Center(child: Icon(Icons.broken_image, color: Colors.white54)),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(exp['title']!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 4),
                    Text(exp['subtitle']!, style: const TextStyle(fontSize: 11, color: Colors.white70)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAboutUsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 80),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        border: const Border(top: BorderSide(color: Colors.white12), bottom: BorderSide(color: Colors.white12)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('About WoodNest', style: TextStyle(fontFamily: 'serif', fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white)),
                SizedBox(height: 20),
                Text(
                  'Founded with a passion for pristine wilderness and architectural excellence, WoodNest curates secluded cabins that blend seamlessly into nature without compromising on luxury comfort.\n\nWe believe in sustainable travel, digital detox, and giving travelers an intimate sanctuary away from the noise of modern life.',
                  style: TextStyle(fontSize: 14, color: Colors.white70, height: 1.6),
                ),
              ],
            ),
          ),
          const SizedBox(width: 60),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _aboutMetric('100+', 'Handcrafted Cabins'),
                _aboutMetric('15k+', 'Happy Guests'),
                _aboutMetric('100%', 'Eco-Powered'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Awesome Slideable / Horizontal Pic Gallery
  Widget _buildSliderGallerySection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 60),
            child: Text(
              'Atmospheric Gallery',
              style: TextStyle(fontFamily: 'serif', fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 260,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 45),
              itemCount: kGalleryImages.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 380,
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 15, offset: const Offset(0, 8)),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      kGalleryImages[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReservationGlassCard(Lodge lodge) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          width: 340,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.18), width: 1.2),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 25, offset: const Offset(0, 10)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(lodge.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 2),
                      Text(lodge.subtitle, style: const TextStyle(fontSize: 13, color: Colors.white70)),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), shape: BoxShape.circle),
                    child: const Icon(Icons.bookmark_border, size: 18, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(child: _datePickerBox('Feb 11', Icons.calendar_today_outlined)),
                  const SizedBox(width: 12),
                  Expanded(child: _datePickerBox('Mar 25', Icons.calendar_today_outlined)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Check-in\nAfter 2:00 PM', style: TextStyle(fontSize: 11, color: Colors.white70, height: 1.3)),
                  Text('Check-out\nUntil 12:00 PM', style: TextStyle(fontSize: 11, color: Colors.white70, height: 1.3)),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(color: Colors.white12, height: 1),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(lodge.price, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
                      const Text('/night', style: TextStyle(fontSize: 12, color: Colors.white70)),
                    ],
                  ),
                  Text(lodge.guests, style: const TextStyle(fontSize: 12, color: Colors.white70)),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () {},
                  child: const Text('Reserve', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _datePickerBox(String date, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(date, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.white)),
          Icon(icon, size: 14, color: Colors.white70),
        ],
      ),
    );
  }

  Widget _aboutMetric(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFFFFB800))),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.white70)),
      ],
    );
  }
}