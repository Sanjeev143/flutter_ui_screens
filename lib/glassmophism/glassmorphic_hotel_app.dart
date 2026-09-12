import 'dart:ui';
import 'package:flutter/material.dart';

// void main() {
//   runApp(const GlassmorphicTravelApp());
// }

class GlassmorphicTravelApp extends StatelessWidget {
  const GlassmorphicTravelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glass Travel UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'sans-serif',
      ),
      home: MainContainerScreen(), // here is the main container we are calling
    );
  }
}

// ==========================================
// BACKGROUND WRAPPER WIDGET
// ==========================================
class GlassScaffold extends StatelessWidget { /// parent widget
  final Widget child;
  const GlassScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          /// for background image
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?auto=format&fit=crop&w=1200&q=80',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.35),
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(child: child), /// here child is screens
        ],
      ),
    );
  }
}

// ==========================================
// HOTEL DATA MODEL
// ==========================================
class HotelItem {
  final String name;
  final String address;
  final String imageUrl;
  final String beds;
  final String wifi;
  final String parking;
  final String description;

  const HotelItem({
    required this.name,
    required this.address,
    required this.imageUrl,
    required this.beds,
    required this.wifi,
    required this.parking,
    required this.description,
  });
}

// Dataset containing 25+ hotel cards
final List<HotelItem> dummyHotels = [
  const HotelItem(
    name: 'Velura Suites',
    address: '1450 Kalakaua Avenue Honolulu, HI 96815',
    imageUrl: 'https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=700&q=80',
    beds: '2 Beds', wifi: 'Wi-Fi', parking: 'Parking',
    description: 'Elysium Hotel invites guests to experience comfort and nature, offering luxurious accommodations and Carpathian views.',
  ),
  const HotelItem(
    name: 'Kewalo Bay Villas',
    address: '88 Kewalo St, Honolulu, HI 96814',
    imageUrl: 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=700&q=80',
    beds: '3 Beds', wifi: 'Wi-Fi', parking: 'Valet',
    description: 'Nestled right by the ocean shore, Kewalo Bay Villas provide serene modern living spaces with direct beach access.',
  ),
  const HotelItem(
    name: 'Mountain Crest Lodge',
    address: '420 Pali Hwy, Honolulu, HI 96817',
    imageUrl: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=700&q=80',
    beds: '1 Bed', wifi: 'Wi-Fi', parking: 'Free',
    description: 'A cozy escape into the lush green mountains, featuring private balconies, quiet workspaces, and breathtaking valley vistas.',
  ),
  const HotelItem(
    name: 'Azure Horizon Resort',
    address: '2255 Kalakaua Ave, Honolulu, HI 96815',
    imageUrl: 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?auto=format&fit=crop&w=700&q=80',
    beds: '2 Beds', wifi: 'Wi-Fi', parking: 'Parking',
    description: 'Overlooking Waikiki beach, offering world-class infinity pools, luxury spas, and premium oceanfront dining.',
  ),
  const HotelItem(
    name: 'Emerald Valley Inn',
    address: '120 Hana Hwy, Kahului, HI 96732',
    imageUrl: 'https://images.unsplash.com/photo-1540541338287-41700207dee6?auto=format&fit=crop&w=700&q=80',
    beds: '1 Bed', wifi: 'Wi-Fi', parking: 'Free',
    description: 'Surrounded by tropical rainforest waterfalls and scenic hiking tracks, perfect for nature lovers.',
  ),
  const HotelItem(
    name: 'Pacific Breeze Suites',
    address: '500 Ala Moana Blvd, Honolulu, HI 96813',
    imageUrl: 'https://images.unsplash.com/photo-1561501900-3701fa6a0864?auto=format&fit=crop&w=700&q=80',
    beds: '2 Beds', wifi: 'Wi-Fi', parking: 'Valet',
    description: 'Modern urban luxury right next to the harbor with pristine sunset boat tour access.',
  ),
  const HotelItem(
    name: 'Pineapple Hill Cottage',
    address: '77 Kaanapali Shores, Lahaina, HI 96761',
    imageUrl: 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=700&q=80',
    beds: '3 Beds', wifi: 'Wi-Fi', parking: 'Free',
    description: 'Spacious private cottage nestled in quiet plantation fields with panoramic coastal views.',
  ),
  const HotelItem(
    name: 'Coral Reef Sanctuary',
    address: '333 Ohua Ave, Honolulu, HI 96815',
    imageUrl: 'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?auto=format&fit=crop&w=700&q=80',
    beds: '1 Bed', wifi: 'Wi-Fi', parking: 'Parking',
    description: 'Dive straight into vibrant marine life exploration right outside your private balcony.',
  ),
  const HotelItem(
    name: 'Volcano Mist Retreat',
    address: '11 Volcano Rd, Volcano, HI 96785',
    imageUrl: 'https://images.unsplash.com/photo-1507652313519-d4e9174996dd?auto=format&fit=crop&w=700&q=80',
    beds: '2 Beds', wifi: 'Wi-Fi', parking: 'Free',
    description: 'Cozy fireplace cabin situated near the majestic Hawaii Volcanoes National Park.',
  ),
  const HotelItem(
    name: 'Sunset Palm Villas',
    address: '445 Seaside Ave, Honolulu, HI 96815',
    imageUrl: 'https://images.unsplash.com/photo-1578683010236-d716f9a3f461?auto=format&fit=crop&w=700&q=80',
    beds: '2 Beds', wifi: 'Wi-Fi', parking: 'Valet',
    description: 'Vibrant boutique hotel featuring rooftop cocktail bars and aesthetic minimalist rooms.',
  ),
  const HotelItem(
    name: 'Highland Moss Cabin',
    address: '900 Tantalus Dr, Honolulu, HI 96822',
    imageUrl: 'https://images.unsplash.com/photo-1449844908441-8829872d2607?auto=format&fit=crop&w=700&q=80',
    beds: '1 Bed', wifi: 'Wi-Fi', parking: 'Free',
    description: 'Secluded mountain hideaway wrapped in cool mist and tranquil forest canopies.',
  ),
  const HotelItem(
    name: 'Royal Hawaiian Oasis',
    address: '2259 Kalakaua Ave, Honolulu, HI 96815',
    imageUrl: 'https://images.unsplash.com/photo-1584132967334-10e028bd69f7?auto=format&fit=crop&w=700&q=80',
    beds: '4 Beds', wifi: 'Wi-Fi', parking: 'Valet',
    description: 'Iconic pink-palace inspired luxury estate offering royal hospitality and private beach cabanas.',
  ),
  const HotelItem(
    name: 'Waterfall Eco-Lodge',
    address: '15 Akaka Falls Rd, Honomu, HI 96728',
    imageUrl: 'https://images.unsplash.com/photo-1596394516093-501ba68a0ba6?auto=format&fit=crop&w=700&q=80',
    beds: '2 Beds', wifi: 'Wi-Fi', parking: 'Free',
    description: 'Eco-friendly bamboo architecture nestled directly beside cascading jungle streams.',
  ),
  const HotelItem(
    name: 'Diamond Head Suites',
    address: '2987 Kalakaua Ave, Honolulu, HI 96815',
    imageUrl: 'https://images.unsplash.com/photo-1618773928121-c32242e63f39?auto=format&fit=crop&w=700&q=80',
    beds: '2 Beds', wifi: 'Wi-Fi', parking: 'Parking',
    description: 'Stunning panoramic views of the legendary Diamond Head crater and turquoise surf breaks.',
  ),
  const HotelItem(
    name: 'Starlight Cliffside Inn',
    address: '88 North Shore Rd, Haleiwa, HI 96712',
    imageUrl: 'https://images.unsplash.com/photo-1591088398332-8a7791972843?auto=format&fit=crop&w=700&q=80',
    beds: '3 Beds', wifi: 'Wi-Fi', parking: 'Free',
    description: 'Watch professional surfers catch epic winter swells from your private cliffside deck.',
  ),
  const HotelItem(
    name: 'Garden Isle Bungalows',
    address: '3420 Kuhio Hwy, Princeville, HI 96722',
    imageUrl: 'https://images.unsplash.com/photo-1568495248636-6432b97bd949?auto=format&fit=crop&w=700&q=80',
    beds: '1 Bed', wifi: 'Wi-Fi', parking: 'Parking',
    description: 'Tropical garden paradise featuring open-air showers and fragrant plumeria trees.',
  ),
  const HotelItem(
    name: 'Silken Sands Resort',
    address: '100 Wailea Ike Dr, Wailea, HI 96753',
    imageUrl: 'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&w=700&q=80',
    beds: '3 Beds', wifi: 'Wi-Fi', parking: 'Valet',
    description: 'Chic resort offering championship golf courses and golden sand sunset strolls.',
  ),
  const HotelItem(
    name: 'Whispering Palms Loft',
    address: '610 Lauula St, Honolulu, HI 96815',
    imageUrl: 'https://images.unsplash.com/photo-1505691938895-1758d7feb511?auto=format&fit=crop&w=700&q=80',
    beds: '1 Bed', wifi: 'Wi-Fi', parking: 'Parking',
    description: 'Cozy metropolitan loft located steps away from premier shopping and dining districts.',
  ),
  const HotelItem(
    name: 'Blue Lagoon Hideaway',
    address: '777 Lagoon Dr, Honolulu, HI 96819',
    imageUrl: 'https://images.unsplash.com/photo-1512915922686-57c11dde9b6b?auto=format&fit=crop&w=700&q=80',
    beds: '2 Beds', wifi: 'Wi-Fi', parking: 'Free',
    description: 'Secluded lagoon-side sanctuary featuring private paddleboard docks and hammock gardens.',
  ),
  const HotelItem(
    name: 'Summit Star Chalet',
    address: '55 Mauna Kea Access Rd, Hilo, HI 96720',
    imageUrl: 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=700&q=80',
    beds: '3 Beds', wifi: 'Wi-Fi', parking: 'Free',
    description: 'High-altitude stargazing haven equipped with professional telescopes and heated fireplaces.',
  ),
  const HotelItem(
    name: 'Canyon Ridge Villa',
    address: '400 Waimea Canyon Dr, Waimea, HI 96796',
    imageUrl: 'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?auto=format&fit=crop&w=700&q=80',
    beds: '4 Beds', wifi: 'Wi-Fi', parking: 'Valet',
    description: 'Dramatic cliffside villa overlooking the magnificent Grand Canyon of the Pacific.',
  ),
  const HotelItem(
    name: 'Banyan Tree Estate',
    address: '99 Lahainaluna Rd, Lahaina, HI 96761',
    imageUrl: 'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?auto=format&fit=crop&w=700&q=80',
    beds: '2 Beds', wifi: 'Wi-Fi', parking: 'Parking',
    description: 'Historic plantation estate shaded by century-old heritage banyan branches.',
  ),
  const HotelItem(
    name: 'Moonlight Bay Suites',
    address: '320 Malama St, Kailua, HI 96734',
    imageUrl: 'https://images.unsplash.com/photo-1600566753376-12c8ab7fb75b?auto=format&fit=crop&w=700&q=80',
    beds: '1 Bed', wifi: 'Wi-Fi', parking: 'Free',
    description: 'Pristine turquoise waters and powdery white sands right outside your doorstep.',
  ),
  const HotelItem(
    name: 'Volcanic Caldera Lodge',
    address: '75 Crater Rim Dr, Volcano, HI 96785',
    imageUrl: 'https://images.unsplash.com/photo-1600585154526-990dced4db0d?auto=format&fit=crop&w=700&q=80',
    beds: '2 Beds', wifi: 'Wi-Fi', parking: 'Free',
    description: 'Unique volcanic rock architecture offering geothermal spa pools and scenic overlooks.',
  ),
  const HotelItem(
    name: 'Emerald Ridge Haven',
    address: '800 Haiku Rd, Kaneohe, HI 96744',
    imageUrl: 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=700&q=80',
    beds: '3 Beds', wifi: 'Wi-Fi', parking: 'Parking',
    description: 'Majestic emerald mountain ridge backdrops framing ultimate peaceful Hawaiian living.',
  ),
];

/// To handle the state while call from other class
final GlobalKey<MainContainerScreenState> mainContainerKey = GlobalKey<MainContainerScreenState>();

// ==========================================
// MAIN SHELL WIDGET
// ==========================================
class MainContainerScreen extends StatefulWidget {
  const MainContainerScreen({super.key});

  @override
  MainContainerScreenState createState() => MainContainerScreenState();
}

class MainContainerScreenState extends State<MainContainerScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const DetailsStackedScreen(),
    const ExploreMapScreen(),
    const CalendarScreen(),
    const SettingsScreen(), /// we have 5 options / tab in nav bar
  ];

  void switchToTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      child: Stack(
        children: [
          /// below positioned widget take care of whole screen view apart
          /// from bottom nav
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 90.0), /// Thi padding
              /// fro scrollable hotels list
              child: _screens[_currentIndex], /// we are calling index and on
              /// the basis of index we have screens lets move on...
            ),
          ),
          Positioned( /// this position widget have all the nav ui
            left: 20,
            right: 20,
            bottom: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  height: 65,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _navIcon(Icons.home_rounded, 0),
                      _navIcon(Icons.favorite_border_rounded, 1),
                      _navIcon(Icons.location_on_rounded, 2),
                      _navIcon(Icons.calendar_today_rounded, 3),
                      _navIcon(Icons.settings_rounded, 4),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Here is the Nav iocn ui
  Widget _navIcon(IconData icon, int index) { /// 2 parameters
    bool isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () => switchToTab(index), /// navigate to particular index
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.white.withOpacity(0.15) : Colors.transparent,
        ),
        child: Icon(
          icon,
          color: isSelected ? const Color(0xFF00E676) : Colors.white60,
          size: 22,
        ),
      ),
    );
  }
}

// ==========================================
// SCREEN 1: HOME SCREEN
// ==========================================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = ''; // for search

  @override
  Widget build(BuildContext context) {
    /// Keyword based seach applied
    final filteredHotels = dummyHotels.where((hotel) {
      final query = _searchQuery.toLowerCase();
      return hotel.name.toLowerCase().contains(query) ||
          hotel.address.toLowerCase().contains(query) ||
          hotel.description.toLowerCase().contains(query);
    }).toList(); /// this is filter logic, lets move first to Ui

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          /// Top row with avtar and icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80'),
              ),
              Row(
                children: [
                  _glassCircleButton(Icons.notifications_none),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () => mainContainerKey.currentState?.switchToTab(4),
                    child: _glassCircleButton(Icons.settings_outlined),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          /// Searchbar
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        /// Once user type any keyword setstate is called,
                        /// which refresh the whole screen and in that way
                        /// search filtered called
                        onChanged: (value) => setState(() => _searchQuery = value),
                        style: const TextStyle(color: Colors.white, fontSize: 13),
                        decoration: const InputDecoration(
                          hintText: 'Search hotels, locations...',
                          hintStyle: TextStyle(color: Colors.white60, fontSize: 13),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        border: Border(left: BorderSide(color: Colors.white.withOpacity(0.3))),
                      ),
                      child: const Text('Hawaii', style: TextStyle(color: Colors.white, fontSize: 11)),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(color: Color(0xFF00C853), shape: BoxShape.circle),
                      child: const Icon(Icons.search, color: Colors.white, size: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Available Suites & Hotels', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              Text('${filteredHotels.length} found', style: const TextStyle(fontSize: 12, color: Colors.white60)),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: filteredHotels.isEmpty /// this condition is search based
                ? const Center(
              child: Text('No hotels found matching your search.', style: TextStyle(color: Colors.white60, fontSize: 13)),
            )
                : ListView.builder(
              padding: const EdgeInsets.only(bottom: 20),
              itemCount: filteredHotels.length,
              itemBuilder: (context, index) {
                final hotel = filteredHotels[index];
                /// These are the cards list
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HotelDetailScreen(hotel:
                          hotel), /// on click, HotelDetailScreen will open
                          /// will discuss later it's ui
                        ),
                      );
                    },
                    /// here is the ui started for cards
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.12),
                              /// this is update value
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: Colors.white.withOpacity(0.25)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(hotel.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                                Text(hotel.address, style: const TextStyle(fontSize: 10, color: Colors.white70)),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.hotel, size: 13, color: Colors.white70),
                                          const SizedBox(width: 3),
                                          Flexible(child: Text(hotel.beds, style: const TextStyle(fontSize: 11, color: Colors.white70), overflow: TextOverflow.ellipsis)),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.wifi, size: 13, color: Colors.white70),
                                          const SizedBox(width: 3),
                                          Flexible(child: Text(hotel.wifi, style: const TextStyle(fontSize: 11, color: Colors.white70), overflow: TextOverflow.ellipsis)),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.local_parking, size: 13, color: Colors.white70),
                                          const SizedBox(width: 3),
                                          Flexible(child: Text(hotel.parking, style: const TextStyle(fontSize: 11, color: Colors.white70), overflow: TextOverflow.ellipsis)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    hotel.imageUrl,
                                    height: 150,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
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
    );
  }

  /// This is the top icons ui
  Widget _glassCircleButton(IconData icon) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
      ),
    );
  }
}

// ==========================================
// HOTEL DETAIL SCREEN WIDGET
// ==========================================

/// lets discuss hotel detail screen
class HotelDetailScreen extends StatelessWidget {
  final HotelItem hotel;
  const HotelDetailScreen({super.key, required this.hotel});
  /// this is dialog for booking
  void _showBookingSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.65),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Color(0xFF00C853),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.check, color: Colors.white, size: 32),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Booking Successful!',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your reservation at ${hotel.name} has been confirmed.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12, color: Colors.white70),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00C853),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        onPressed: () {
                          Navigator.pop(dialogContext);
                          Navigator.pop(context);
                          mainContainerKey.currentState?.switchToTab(0);
                        },
                        child: const Text('OK', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    /// here is the actual ui started
    return GlassScaffold(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  /// back button
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: _glassCircleButton(Icons.arrow_back),
                  ),
                  const Text('Property Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(width: 40),
                ],
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.14),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Stack(
                            children: [
                              /// hotel image
                              Image.network(
                                hotel.imageUrl,
                                height: 210,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child: GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(color: Colors
                                        .black.withValues(alpha: 0.4), shape:
                                    BoxShape
                                        .circle),
                                    child: const Icon(Icons.close, size: 14, color: Colors.white),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 10,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(color: Colors.amber.withValues(alpha:0.8), shape: BoxShape.circle),
                                  child: const Icon(Icons.star, size: 14, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(hotel.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: 2),
                        Text(hotel.address, style: const TextStyle(fontSize: 11, color: Colors.white70)),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.hotel, size: 13, color: Colors.white70),
                                  const SizedBox(width: 3),
                                  Flexible(child: Text(hotel.beds, style: const TextStyle(fontSize: 11, color: Colors.white70), overflow: TextOverflow.ellipsis)),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.wifi, size: 13, color: Colors.white70),
                                  const SizedBox(width: 3),
                                  Flexible(child: Text(hotel.wifi, style: const TextStyle(fontSize: 11, color: Colors.white70), overflow: TextOverflow.ellipsis)),
                                ],
                              ),
                            ),
                            Flexible(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.local_parking, size: 13, color: Colors.white70),
                                  const SizedBox(width: 3),
                                  Flexible(child: Text(hotel.parking, style: const TextStyle(fontSize: 11, color: Colors.white70), overflow: TextOverflow.ellipsis)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Text(
                          hotel.description,
                          style: const TextStyle(fontSize: 11, color: Colors.white60, height: 1.4),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () => _showBookingSuccessDialog(context),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.white.withOpacity(0.3)),
                            ),
                            child: const Center(
                              child: Text('Book Now', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                            ),
                          ),
                        ),
                      ],
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

  Widget _glassCircleButton(IconData icon) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Icon(icon, color: Colors.white, size: 18),
        ),
      ),
    );
  }
}

// ==========================================
// SCREEN 2: EXPLORE / MAP SCREEN WITH THUMBNAIL PINS & CONNECTING LINES
// ==========================================
class ExploreMapScreen extends StatelessWidget {
  const ExploreMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Here is the ui started
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: SizedBox(
              height: constraints.maxHeight - 20,
              child: Stack(
                children: [
                  // Connecting lines behind map pins
                  Positioned.fill(
                    child: CustomPaint(
                      painter: MapPointsLinePainter(),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _categoryPill(Icons.hotel, 'Hotel'),
                          _categoryPill(Icons.explore, 'Excursions'),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _categoryPill(Icons.storefront, 'Restaurants'),
                          _categoryPill(Icons.spa, 'SPA'),
                        ],
                      ),
                    ],
                  ),
                  // Map Pins with Image Thumbnails for Reference
                  /// Positioned based as per device screen
                  const Positioned(
                    top: 170,
                    left: 30,
                    child: _MapThumbPin(
                      price: '140\$',
                      imageUrl: 'https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&w=300&q=80',
                    ),
                  ),
                  const Positioned(
                    top: 110,
                    right: 40,
                    child: _MapThumbPin(
                      price: '115\$',
                      imageUrl: 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=300&q=80',
                    ),
                  ),
                  const Positioned(
                    top: 270,
                    right: 90,
                    child: _MapThumbPin(
                      price: '180\$',
                      imageUrl: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=300&q=80',
                    ),
                  ),
                  const Positioned(
                    top: 350,
                    left: 90,
                    child: _MapThumbPin(
                      price: '210\$',
                      imageUrl: 'https://images.unsplash.com/photo-1571896349842-33c89424de2d?auto=format&fit=crop&w=300&q=80',
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white.withOpacity(0.2)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.remove_red_eye, color: Colors.white, size: 20),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('Explore Now', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                                    SizedBox(height: 2),
                                    Text('Interactive pins with thumbnail references.',
                                        style: TextStyle(fontSize: 10, color: Colors.white70)),
                                  ],
                                ),
                              ),
                              const Icon(Icons.close, color: Colors.white70, size: 18),
                            ],
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
      },
    );
  }

  Widget _categoryPill(IconData icon, String label) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white.withOpacity(0.25)),
          ),
          child: Row(
            children: [
              Icon(icon, size: 16, color: Colors.white),
              const SizedBox(width: 8),
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Painter to draw connecting lines between map pins
class MapPointsLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00E676).withOpacity(0.7)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(70, 190)
      ..lineTo(size.width - 70, 130)
      ..lineTo(size.width - 110, 290)
      ..lineTo(130, 370);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Map pin component featuring price badge and reference thumbnail image
class _MapThumbPin extends StatelessWidget {
  final String price;
  final String imageUrl;

  const _MapThumbPin({required this.price, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.18),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.2),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Reference Thumbnail Image
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  width: 32,
                  height: 32,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 6),
              // Price and Icon Badge
              Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: Row(
                  children: [
                    const Icon(Icons.remove_red_eye, size: 12, color: Colors.white),
                    const SizedBox(width: 4),
                    Text(price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white)),
                  ],
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
// SCREEN 3: STACKED CARDS TAB VIEW
// ==========================================
class DetailsStackedScreen extends StatelessWidget {
  const DetailsStackedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: dummyHotels.take(8).map((hotel) => Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.14),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        hotel.imageUrl,
                        height: 160,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(hotel.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 2),
                    Text(hotel.address, style: const TextStyle(fontSize: 11, color: Colors.white70)),
                  ],
                ),
              ),
            ),
          ),
        )).toList(),
      ),
    );
  }
}

// ==========================================
// SCREEN 4: CALENDAR / SCHEDULE VIEW
// ==========================================
class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});
/// lets see the calender ui
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Trip Schedule', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 4),
          const Text('June 2026 • Hawaii Excursion', style: TextStyle(fontSize: 12, color: Colors.white60)),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
                ),
                child: Column(
                  children: [
                    /// this is custom design
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Mon', style: TextStyle(color: Colors.white54, fontSize: 12)),
                        Text('Tue', style: TextStyle(color: Colors.white54, fontSize: 12)),
                        Text('Wed', style: TextStyle(color: Colors.white54, fontSize: 12)),
                        Text('Thu', style: TextStyle(color: Colors.white54, fontSize: 12)),
                        Text('Fri', style: TextStyle(color: Colors.white54, fontSize: 12)),
                        Text('Sat', style: TextStyle(color: Colors.white54, fontSize: 12)),
                        Text('Sun', style: TextStyle(color: Colors.white54, fontSize: 12)),
                      ],
                    ),
                    const Divider(color: Colors.white24, height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _calDay('20', false),
                        _calDay('21', false),
                        _calDay('22', false),
                        _calDay('23', true),
                        _calDay('24', false),
                        _calDay('25', false),
                        _calDay('26', false),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Upcoming Itinerary', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: [
                _itineraryCard('Check-in: Velura Suites', 'June 22, 2026 • 2:00 PM', Icons.hotel, Colors.greenAccent),
                _itineraryCard('Excursion: Mountain Trail', 'June 23, 2026 • 9:30 AM', Icons.explore, Colors.amberAccent),
                _itineraryCard('SPA Relaxation Session', 'June 24, 2026 • 4:00 PM', Icons.spa, Colors.pinkAccent),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _calDay(String day, bool isSelected) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? const Color(0xFF00E676) : Colors.transparent,
      ),
      child: Text(
        day,
        style: TextStyle(
          color: isSelected ? Colors.black87 : Colors.white,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _itineraryCard(String title, String subtitle, IconData icon, Color accentColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white.withOpacity(0.15)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: accentColor.withOpacity(0.2),
                  ),
                  child: Icon(icon, color: accentColor, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.white)),
                      const SizedBox(height: 2),
                      Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.white60)),
                    ],
                  ),
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
// SCREEN 5: SETTINGS SCREEN
// ==========================================
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Settings', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                _settingTile(Icons.person_outline, 'Account Information', 'Update your personal details'),
                _settingTile(Icons.notifications_active_outlined, 'Notifications', 'Manage alerts & push messages'),
                _settingTile(Icons.security, 'Security & Privacy', 'Password, FaceID, and data permissions'),
                _settingTile(Icons.language, 'Currency & Language', 'USD (\$ ) • English'),
                _settingTile(Icons.help_outline, 'Help & Support', 'FAQs and customer service chat'),
                _settingTile(Icons.info_outline, 'About App', 'Version 2.4.1 (Glass UI Edition)'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _settingTile(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.greenAccent, size: 24),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white)),
                      const SizedBox(height: 2),
                      Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.white60)),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 14),
              ],
            ),
          ),
        ),
      ),
    );
  }
}






































