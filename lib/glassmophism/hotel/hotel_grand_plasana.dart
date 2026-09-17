import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const HotelGrandPalsanaApp());
}

class HotelGrandPalsanaApp extends StatelessWidget {
  const HotelGrandPalsanaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Hotel Grand Palsana',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B6B3D),
          primary: const Color(0xFF8B6B3D),
          secondary: const Color(0xFFC5A059),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/main_shell': (context) => const MainShellScreen(),
        '/room_details': (context) => const RoomDetailsScreen(room: allRoomsData0),
        '/booking_flow': (context) => const BookingFlowScreen(room: allRoomsData0),
        '/booking_confirmed': (context) => const BookingConfirmedScreen(room: allRoomsData0),
        '/booking_details': (context) => const BookingDetailScreen(
          bookingId: 'GP2025001',
          roomName: 'Deluxe Room A1',
          dates: '12 Aug 2025 - 14 Aug 2025',
          price: '₹4,700',
          status: 'Confirmed',
          statusColor: Colors.green,
          guestName: 'Ali Khan',
          guestsCount: '2',
          paymentStatus: 'Paid',
        ),
      },
    );
  }
}



// Model for Room / Hotel Data
class RoomItem {
  final String title;
  final String category; // 'Deluxe', 'Premium', 'Suite'
  final String price;
  final String guests;
  final String bed;
  final String imageUrl;

  const RoomItem({
    required this.title,
    required this.category,
    required this.price,
    required this.guests,
    required this.bed,
    required this.imageUrl,
  });
}

const RoomItem allRoomsData0 = RoomItem(
  title: 'Deluxe Room A1',
  category: 'Deluxe',
  price: '₹2,000 / night',
  guests: '2 Guests',
  bed: 'King Bed',
  imageUrl: 'https://images.unsplash.com/photo-1591088398332-8a7791972843?auto=format&fit=crop&w=600&q=80',
);

// Master list of 25+ rooms/hotels across categories
const List<RoomItem> allRoomsData = [
  allRoomsData0,
  RoomItem(title: 'Deluxe Room A2', category: 'Deluxe', price: '₹2,200 / night', guests: '2 Guests', bed: 'Queen Bed', imageUrl: 'https://images.unsplash.com/photo-1618773928121-c32242e63f39?auto=format&fit=crop&w=600&q=80'),
  RoomItem(title: 'Deluxe Garden View', category: 'Deluxe', price: '₹2,400 / night', guests: '2 Guests', bed: 'King Bed', imageUrl: 'https://images.unsplash.com/photo-1566665797739-1674de7a421a?auto=format&fit=crop&w=600&q=80'),
  RoomItem(title: 'Deluxe Poolside', category: 'Deluxe', price: '₹2,600 / night', guests: '3 Guests', bed: 'Twin Beds', imageUrl: 'https://images.unsplash.com/photo-1578683010236-d716f9a3f461?auto=format&fit=crop&w=600&q=80'),
  RoomItem(title: 'Deluxe Executive', category: 'Deluxe', price: '₹2,800 / night', guests: '2 Guests', bed: 'King Bed', imageUrl: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=600&q=80'),
  RoomItem(title: 'Classic Deluxe', category: 'Deluxe', price: '₹2,100 / night', guests: '2 Guests', bed: 'Queen Bed', imageUrl: 'https://images.unsplash.com/photo-1591088398332-8a7791972843?auto=format&fit=crop&w=600&q=80'),
  RoomItem(title: 'Deluxe Comfort', category: 'Deluxe', price: '₹2,300 / night', guests: '2 Guests', bed: 'King Bed', imageUrl: 'https://images.unsplash.com/photo-1618773928121-c32242e63f39?auto=format&fit=crop&w=600&q=80'),
  RoomItem(title: 'Deluxe Grand', category: 'Deluxe', price: '₹2,500 / night', guests: '3 Guests', bed: 'King Bed', imageUrl: 'https://images.unsplash.com/photo-1566665797739-1674de7a421a?auto=format&fit=crop&w=600&q=80'),
  RoomItem(title: 'Deluxe City View', category: 'Deluxe', price: '₹2,700 / night', guests: '2 Guests', bed: 'Queen Bed', imageUrl: 'https://images.unsplash.com/photo-1578683010236-d716f9a3f461?auto=format&fit=crop&w=600&q=80'),

  RoomItem(title: 'Premium Room B1', category: 'Premium', price: '₹3,500 / night', guests: '3 Guests', bed: 'King Bed', imageUrl: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=600&q=80'),
  RoomItem(title: 'Premium Sea View', category: 'Premium', price: '₹3,800 / night', guests: '3 Guests', bed: 'King Bed', imageUrl: 'https://images.unsplash.com/photo-1591088398332-8a7791972843?auto=format&fit=crop&w=600&q=80'),
  RoomItem(title: 'Premium Balcony', category: 'Premium', price: '₹4,000 / night', guests: '4 Guests', bed: 'Dual Queen Beds', imageUrl: 'https://images.unsplash.com/photo-1618773928121-c32242e63f39?auto=format&fit=crop&w=600&q=80'),
  RoomItem(title: 'Premium Luxury', category: 'Premium', price: '₹4,200 / night', guests: '3 Guests', bed: 'King Bed', imageUrl: 'https://images.unsplash.com/photo-1566665797739-1674de7a421a?auto=format&fit=crop&w=600&q=80'),
  RoomItem(title: 'Premium Corner', category: 'Premium', price: '₹3,600 / night', guests: '2 Guests', bed: 'King Bed', imageUrl: 'https://images.unsplash.com/photo-1578683010236-d716f9a3f461?auto=format&fit=crop&w=600&q=80'),
  RoomItem(title: 'Premium Horizon', category: 'Premium', price: '₹3,900 / night', guests: '3 Guests', bed: 'King Bed', imageUrl: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=600&q=80'),
  RoomItem(title: 'Premium Vista', category: 'Premium', price: '₹4,100 / night', guests: '4 Guests', bed: 'Dual Beds', imageUrl: 'https://images.unsplash.com/photo-1591088398332-8a7791972843?auto=format&fit=crop&w=600&q=80'),
  RoomItem(title: 'Premium Elite', category: 'Premium', price: '₹4,300 / night', guests: '3 Guests', bed: 'King Bed', imageUrl: 'https://images.unsplash.com/photo-1618773928121-c32242e63f39?auto=format&fit=crop&w=600&q=80'),

  RoomItem(title: 'Royal Suite C1', category: 'Suite', price: '₹6,000 / night', guests: '4 Guests', bed: 'Super King Bed', imageUrl: 'https://images.unsplash.com/photo-1578683010236-d716f9a3f461?auto=format&fit=crop&w=600&q=80'),
  RoomItem(title: 'Presidential Suite', category: 'Suite', price: '₹8,500 / night', guests: '6 Guests', bed: 'Multi-King Beds', imageUrl: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=600&q=80'),
  RoomItem(title: 'Penthouse Suite', category: 'Suite', price: '₹9,500 / night', guests: '5 Guests', bed: 'California King', imageUrl: 'https://images.unsplash.com/photo-1566665797739-1674de7a421a?auto=format&fit=crop&w=600&q=80'),
  RoomItem(title: 'Imperial Suite', category: 'Suite', price: '₹7,200 / night', guests: '4 Guests', bed: 'King Bed', imageUrl: 'https://images.unsplash.com/photo-1591088398332-8a7791972843?auto=format&fit=crop&w=600&q=80'),
  RoomItem(title: 'Duplex Suite', category: 'Suite', price: '₹6,800 / night', guests: '4 Guests', bed: 'Queen & King Beds', imageUrl: 'https://images.unsplash.com/photo-1618773928121-c32242e63f39?auto=format&fit=crop&w=600&q=80'),
  RoomItem(title: 'Honeymoon Suite', category: 'Suite', price: '₹5,800 / night', guests: '2 Guests', bed: 'Round King Bed', imageUrl: 'https://images.unsplash.com/photo-1578683010236-d716f9a3f461?auto=format&fit=crop&w=600&q=80'),
  RoomItem(title: 'Executive Suite', category: 'Suite', price: '₹6,500 / night', guests: '4 Guests', bed: 'King Bed', imageUrl: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=600&q=80'),
  RoomItem(title: 'Grand Palace Suite', category: 'Suite', price: '₹10,000 / night', guests: '6 Guests', bed: 'Master King Beds', imageUrl: 'https://images.unsplash.com/photo-1566665797739-1674de7a421a?auto=format&fit=crop&w=600&q=80'),
];

// Reusable Glassmorphism Container with Gradient Border
class GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;

  const GlassContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(
          colors: [
            Colors.white.withValues(alpha: 0.25),
            Colors.white.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(1.5),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B).withValues(alpha: 0.65),
          borderRadius: BorderRadius.circular(borderRadius - 1),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius - 1),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
            child: Padding(
              padding: padding ?? const EdgeInsets.all(16.0),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 1. SPLASH / LAUNCH SCREEN
// ==========================================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = false;

  void _handleGetStarted() {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/main_shell');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&w=1200&q=80',
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withValues(alpha: 0.7), Colors.black.withValues(alpha: 0.4), Colors.black.withValues(alpha: 0.8)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  GlassContainer(
                    borderRadius: 30,
                    padding: const EdgeInsets.all(24),
                    child: const Icon(Icons.hotel, size: 70, color: Color(0xFFD4AF37)),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'THE HOTEL\nGRAND PALSANA',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'An Elegant Stay. A Grand Experience.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 15, letterSpacing: 0.5),
                  ),
                  const Spacer(),
                  _isLoading
                      ? const CircularProgressIndicator(color: Color(0xFFD4AF37))
                      : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD4AF37),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 5,
                      ),
                      onPressed: _handleGetStarted,
                      child: const Text(
                        'Get Started',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 2. MAIN SHELL SCREEN (PageView + Glassmorphic Bottom Nav)
// ==========================================
class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  void _onTabTapped(int index) {
    if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => BookingFlowScreen(room: allRoomsData[0])));
      return;
    }
    setState(() {
      _currentIndex = index;
      _pageController.jumpToPage(index == 4 ? 4 : index > 2 ? index - 1 : index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomeScreen(),
          RoomsListingScreen(),
          DiningScreen(),
          MyBookingScreen(),
        ],
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index >= 2 ? index + 1 : index;
          });
        },
      ),
      bottomNavigationBar: GlassContainer(
        borderRadius: 0,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, Icons.home, 'Home'),
            _buildNavItem(1, Icons.meeting_room, 'Rooms'),
            _buildNavItem(2, Icons.book_online, 'Book Now'),
            _buildNavItem(3, Icons.restaurant, 'Dining'),
            _buildNavItem(4, Icons.person, 'More'),
          ],
        ),
      ),
    );
  }

  /// Nav Item UI
  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        if (index == 2) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => BookingFlowScreen(room: allRoomsData[0])));
        } else {
          int pageIdx = index > 2 ? index - 1 : index;
          _pageController.jumpToPage(pageIdx);
          setState(() {
            _currentIndex = index;
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? const Color(0xFFD4AF37) : Colors.white60),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? const Color(0xFFD4AF37) : Colors.white60,
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 3. HOME SCREEN
// ==========================================
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.black26,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
        title: const Column(
          children: [
            Text('THE HOTEL', style: TextStyle(fontSize: 10, color: Color(0xFFD4AF37), letterSpacing: 1.5)),
            Text('GRAND PALSANA', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GlassContainer(
              padding: const EdgeInsets.all(0),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=800&q=80',
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('The Perfect Stay', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                        const Text('Luxury • Comfort • Elegance', style: TextStyle(color: Colors.white70, fontSize: 12)),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFD4AF37),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          ),
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const RoomsListingScreen())),
                          child: const Text('Book Now', style: TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                /// No Call on click so far but you can as per requirement
                _buildCategoryItem(context, Icons.meeting_room, 'Rooms', () {}),
                _buildCategoryItem(context, Icons.restaurant, 'Dining', () {}),
                _buildCategoryItem(context, Icons.room_service, 'AC Hall', () {}),
              ],
            ),
            const SizedBox(height: 24),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Featured Rooms', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
              ],
            ),
            const SizedBox(height: 12),
            ...allRoomsData.take(4).map((room) => Padding( // Only 4 Item
              // displaying
              padding: const EdgeInsets.only(bottom: 12.0),
              child: _buildHomeRoomCard(context, room),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return GlassContainer(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFFD4AF37), size: 28),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildHomeRoomCard(BuildContext context, RoomItem room) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RoomDetailsScreen(room: room)),
        );
      },
      child: GlassContainer(
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(room.imageUrl, height: 140, width: double.infinity, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(room.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 4),
                      Text(room.price, style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white54),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 4. ROOMS LISTING SCREEN
// ==========================================
class RoomsListingScreen extends StatefulWidget {
  const RoomsListingScreen({super.key});

  @override
  State<RoomsListingScreen> createState() => _RoomsListingScreenState();
}

class _RoomsListingScreenState extends State<RoomsListingScreen> {
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    List<RoomItem> filteredRooms = _selectedCategory == 'All'
        ? allRoomsData
        : allRoomsData.where((room) => room.category == _selectedCategory).toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Rooms', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black26,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                _buildFilterChip('All'),
                _buildFilterChip('Deluxe'),
                _buildFilterChip('Premium'),
                _buildFilterChip('Suite'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredRooms.length,
              itemBuilder: (context, index) {
                return _buildRoomCard(context, filteredRooms[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    bool isSelected = _selectedCategory == label;
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        selectedColor: const Color(0xFF8B6B3D),
        // Explicitly styled unselected chip background for high visibility
        backgroundColor: Colors.white24,
        labelStyle: TextStyle(
          // Crisp white text color whether selected or unselected
          color: isSelected? Colors.white : const Color(0xFF8B6B3D),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
        ),
        onSelected: (bool selected) {
          setState(() {
            _selectedCategory = label;
          });
        },
      ),
    );
  }

  Widget _buildRoomCard(BuildContext context, RoomItem room) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RoomDetailsScreen(room: room)),
        );
      },
      child: GlassContainer(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(room.imageUrl, height: 150, width: double.infinity, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(room.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 4),
                      Text(room.price, style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.person_outline, size: 14, color: Colors.white54),
                          const SizedBox(width: 4),
                          Text(room.guests, style: const TextStyle(fontSize: 12, color: Colors.white54)),
                          const SizedBox(width: 12),
                          const Icon(Icons.bed_outlined, size: 14, color: Colors.white54),
                          const SizedBox(width: 4),
                          Text(room.bed, style: const TextStyle(fontSize: 12, color: Colors.white54)),
                        ],
                      ),
                    ],
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white54),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 5. DINING SCREEN
// ==========================================
class DiningScreen extends StatelessWidget {
  const DiningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Dining & Restaurants', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black26,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDiningCard(
            context,
            'The Grand Palate (Fine Dining)',
            'Multi-cuisine delicacies crafted by celebrity chefs.',
            '7:00 AM - 11:30 PM',
            'https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=600&q=80',
          ),
          const SizedBox(height: 16),
          _buildDiningCard(
            context,
            'Skyline Rooftop Café',
            'Enjoy cocktails and barbecue with a panoramic view.',
            '4:00 PM - 1:00 AM',
            'https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=600&q=80',
          ),
        ],
      ),
    );
  }

  Widget _buildDiningCard(BuildContext context, String title, String description, String timings, String imageUrl) {
    return GlassContainer(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.network(imageUrl, height: 160, width: double.infinity, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 6),
                Text(description, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 14, color: Color(0xFFD4AF37)),
                    const SizedBox(width: 6),
                    Text(timings, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12, color: Color(0xFFD4AF37))),
                  ],
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8B6B3D),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Table reservation inquiry sent for $title!')),
                      );
                    },
                    child: const Text('Reserve a Table'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 6. ROOM DETAILS SCREEN
// ==========================================
class RoomDetailsScreen extends StatelessWidget {
  final RoomItem room;
  const RoomDetailsScreen({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: Colors.black45,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(room.imageUrl, fit: BoxFit.cover),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GlassContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(room.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 4),
                    Text(room.price, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFD4AF37))),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.person_outline, size: 16, color: Colors.white54),
                        const SizedBox(width: 4),
                        Text(room.guests, style: const TextStyle(color: Colors.white54)),
                        const SizedBox(width: 16),
                        const Icon(Icons.bed_outlined, size: 16, color: Colors.white54),
                        const SizedBox(width: 4),
                        Text(room.bed, style: const TextStyle(color: Colors.white54)),
                      ],
                    ),
                    const Divider(height: 32, color: Colors.white24),
                    const Text('Room Facilities', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 12),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _FacilityIcon(icon: Icons.ac_unit, label: 'AC'),
                        _FacilityIcon(icon: Icons.wifi, label: 'Wi-Fi'),
                        _FacilityIcon(icon: Icons.tv, label: 'TV'),
                        _FacilityIcon(icon: Icons.bathtub_outlined, label: 'Bathroom'),
                      ],
                    ),
                    const Divider(height: 32, color: Colors.white24),
                    const Text('Description', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 8),
                    const Text(
                      'Spacious and elegantly designed room with modern amenities for a comfortable stay.',
                      style: TextStyle(color: Colors.white70, height: 1.4),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD4AF37),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => BookingFlowScreen(room: room)),
                          );
                        },
                        child: const Text('BOOK NOW', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FacilityIcon extends StatelessWidget {
  const _FacilityIcon({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFFD4AF37)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.white70)),
      ],
    );
  }
}

// ==========================================
// 7. BOOKING FLOW (WIZARD)
// ==========================================
class BookingFlowScreen extends StatefulWidget {
  final RoomItem room;
  const BookingFlowScreen({super.key, required this.room});

  @override
  State<BookingFlowScreen> createState() => _BookingFlowScreenState();
}

class _BookingFlowScreenState extends State<BookingFlowScreen> {
  int _step = 0;
  int roomCount = 1;

  String _getStepLabel(int index) {
    switch (index) {
      case 0: return 'Dates';
      case 1: return 'Guests';
      case 2: return 'Rooms';
      case 3: return 'Details';
      case 4: return 'Payment';
      default: return '';
    }
  }

  String _getTitleForStep() {
    switch (_step) {
      case 0: return 'Book Your Room';
      case 1: return 'Select Room';
      case 2: return 'Guest Details';
      case 3: return 'Payment';
      default: return 'Booking';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: Text(_getTitleForStep(), style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.black26,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            color: Colors.black12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(5, (index) {
                bool isActive = index <= _step;
                return Column(
                  children: [
                    CircleAvatar(
                      radius: 14,
                      backgroundColor: isActive ? const Color(0xFFD4AF37) : Colors.white24,
                      child: Text('${index + 1}', style: TextStyle(color: isActive ? Colors.black : Colors.white54, fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 4),
                    Text(_getStepLabel(index), style: const TextStyle(fontSize: 10, color: Colors.white60)),
                  ],
                );
              }),
            ),
          ),
          const Divider(height: 1, color: Colors.white24),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: GlassContainer(child: _buildStepContent()),
            ),
          ),
          GlassContainer(
            borderRadius: 0,
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4AF37),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  setState(() {
                    if (_step < 3) {
                      _step++;
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BookingConfirmedScreen(room: widget.room)),
                      );
                    }
                  });
                },
                child: Text(_step == 3 ? 'PAY NOW' : 'NEXT', style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_step) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Check-in Date', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 8),
            _buildDatePickerField('12 Aug 2025'),
            const SizedBox(height: 16),
            const Text('Check-out Date', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 8),
            _buildDatePickerField('14 Aug 2025'),
            const SizedBox(height: 16),
            const Text('Guests', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(border: Border.all(color: Colors.white24), borderRadius: BorderRadius.circular(8)),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('2 Guests', style: TextStyle(color: Colors.white70)),
                  Icon(Icons.keyboard_arrow_down, color: Colors.white54),
                ],
              ),
            ),
          ],
        );
      case 1:
        return Column(
          children: [
            GlassContainer(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(widget.room.imageUrl, height: 120, width: double.infinity, fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.room.title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                      Text(widget.room.price, style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Rooms Quantity:', style: TextStyle(color: Colors.white70)),
                      Row(
                        children: [
                          IconButton(icon: const Icon(Icons.remove, color: Colors.white), onPressed: () => setState(() { if (roomCount > 1) roomCount--; })),
                          Text('$roomCount', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                          IconButton(icon: const Icon(Icons.add, color: Colors.white), onPressed: () => setState(() { roomCount++; })),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('Full Name', 'Enter your name'),
            const SizedBox(height: 16),
            _buildTextField('Phone Number', '+91 98765 43210'),
            const SizedBox(height: 16),
            _buildTextField('Email (Optional)', 'Enter your email'),
            const SizedBox(height: 16),
            _buildTextField('Special Request (Optional)', 'Any special request...', maxLines: 3),
          ],
        );
      case 3:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Price Summary', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 12),
            _priceRow(widget.room.title, widget.room.price),
            _priceRow('Extra Guest Charges', '₹300'),
            _priceRow('Taxes & Charges', '₹400'),
            const Divider(height: 24, color: Colors.white24),
            _priceRow('Total Amount', '₹4,700', isBold: true),
            const SizedBox(height: 24),
            const Text('Payment Method', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 12),
            RadioListTile(value: 0, groupValue: 0, onChanged: (v) {}, title: const Text('UPI (PhonePe / GPay / Paytm)', style: TextStyle(color: Colors.white)), secondary: const Icon(Icons.payment, color: Color(0xFFD4AF37))),
            RadioListTile(value: 1, groupValue: 0, onChanged: (v) {}, title: const Text('Credit / Debit Card', style: TextStyle(color: Colors.white)), secondary: const Icon(Icons.credit_card, color: Colors.white54)),
          ],
        );
      default:
        return Container();
    }
  }

  Widget _buildDatePickerField(String date) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(border: Border.all(color: Colors.white24), borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [const Icon(Icons.calendar_today, size: 18, color: Color(0xFFD4AF37)), const SizedBox(width: 8), Text(date, style: const TextStyle(color: Colors.white))]),
          const Icon(Icons.edit_calendar, size: 18, color: Colors.white54),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, String hint, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 6),
        TextField(
          maxLines: maxLines,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white38),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.white24)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Colors.white24)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _priceRow(String title, String price, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal, fontSize: isBold ? 16 : 14, color: Colors.white70)),
          Text(price, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal, color: isBold ? const Color(0xFFD4AF37) : Colors.white, fontSize: isBold ? 16 : 14)),
        ],
      ),
    );
  }
}

// ==========================================
// 8. BOOKING CONFIRMED SCREEN
// ==========================================
class BookingConfirmedScreen extends StatelessWidget {
  final RoomItem room;
  const BookingConfirmedScreen({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, iconTheme: const IconThemeData(color: Colors.white)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: GlassContainer(
          child: Column(
            children: [
              const CircleAvatar(radius: 36, backgroundColor: Colors.green, child: Icon(Icons.check, size: 48, color: Colors.white)),
              const SizedBox(height: 16),
              const Text('Booking Confirmed!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 4),
              const Text('Your booking has been successfully confirmed.', style: TextStyle(color: Colors.white60, fontSize: 12)),
              const SizedBox(height: 24),
              Column(
                children: [
                  _detailRow('Booking ID', 'GP2025001'),
                  _detailRow('Guest Name', 'Ali Khan'),
                  _detailRow('Room', room.title),
                  _detailRow('Check-in', '12 Aug 2025'),
                  _detailRow('Check-out', '14 Aug 2025'),
                  _detailRow('Guests', '2'),
                  _detailRow('Amount', '₹4,700', isBold: true),
                  _detailRow('Payment Status', 'Paid', color: Colors.green),
                  _detailRow('Booking Status', 'Confirmed', color: Colors.green),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8B6B3D), padding: const EdgeInsets.symmetric(vertical: 14)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BookingDetailScreen(
                          bookingId: 'GP2025001',
                          roomName: 'Deluxe Room A1',
                          dates: '12 Aug 2025 - 14 Aug 2025',
                          price: '₹4,700',
                          status: 'Confirmed',
                          statusColor: Colors.green,
                          guestName: 'Ali Khan',
                          guestsCount: '2',
                          paymentStatus: 'Paid',
                        ),
                      ),
                    );
                  },
                  child: const Text('View Booking Details', style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/main_shell', (route) => false),
                child: const Text('Go to Home', style: TextStyle(color: Color(0xFFD4AF37))),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value, {Color? color, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white60)),
          Text(value, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.w500, color: color ?? Colors.white)),
        ],
      ),
    );
  }
}

// ==========================================
// 9. MY BOOKING SCREEN
// ==========================================
class MyBookingScreen extends StatelessWidget {
  const MyBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('My Booking', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black26,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                _tabButton('All', false),
                const SizedBox(width: 8),
                _tabButton('Upcoming', true),
                const SizedBox(width: 8),
                _tabButton('Completed', false),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _bookingCard(
                  context,
                  'GP2025001',
                  'Deluxe Room A1',
                  '12 Aug 2025 - 14 Aug 2025',
                  '₹4,700',
                  'Confirmed',
                  Colors.green,
                  'Ali Khan',
                  '2',
                  'Paid',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabButton(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF8B6B3D) : Colors.white10,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.white70, fontWeight: FontWeight.bold)),
    );
  }

  Widget _bookingCard(
      BuildContext context,
      String id,
      String roomName,
      String dates,
      String price,
      String status,
      Color statusColor,
      String guestName,
      String guestsCount,
      String paymentStatus,
      ) {
    return GlassContainer(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(id, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: statusColor.withOpacity(0.2), borderRadius: BorderRadius.circular(6)),
                child: Text(status, style: TextStyle(color: statusColor, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const Divider(height: 20, color: Colors.white24),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network('https://images.unsplash.com/photo-1591088398332-8a7791972843?auto=format&fit=crop&w=200&q=80', width: 60, height: 60, fit: BoxFit.cover),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(roomName, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 4),
                  Text(dates, style: const TextStyle(color: Colors.white60, fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(price, style: const TextStyle(color: Color(0xFFD4AF37), fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFF8B6B3D))),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingDetailScreen(
                      bookingId: id,
                      roomName: roomName,
                      dates: dates,
                      price: price,
                      status: status,
                      statusColor: statusColor,
                      guestName: guestName,
                      guestsCount: guestsCount,
                      paymentStatus: paymentStatus,
                    ),
                  ),
                );
              },
              child: const Text('View Details', style: TextStyle(color: Color(0xFFD4AF37))),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 10. DEDICATED BOOKING DETAIL SCREEN
// ==========================================
class BookingDetailScreen extends StatelessWidget {
  final String bookingId;
  final String roomName;
  final String dates;
  final String price;
  final String status;
  final Color statusColor;
  final String guestName;
  final String guestsCount;
  final String paymentStatus;

  const BookingDetailScreen({
    super.key,
    required this.bookingId,
    required this.roomName,
    required this.dates,
    required this.price,
    required this.status,
    required this.statusColor,
    required this.guestName,
    required this.guestsCount,
    required this.paymentStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text('Booking Details', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black26,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: GlassContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(bookingId, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: statusColor.withOpacity(0.2), borderRadius: BorderRadius.circular(6)),
                    child: Text(status, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const Divider(height: 24, color: Colors.white24),
              _infoRow('Guest Name', guestName),
              _infoRow('Room Type', roomName),
              _infoRow('Duration / Dates', dates),
              _infoRow('Number of Guests', guestsCount),
              _infoRow('Total Amount', price, isBold: true),
              _infoRow('Payment Status', paymentStatus, color: paymentStatus == 'Paid' ? Colors.green : Colors.orange),
              _infoRow('Booking Status', status, color: statusColor),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8B6B3D), padding: const EdgeInsets.symmetric(vertical: 14)),
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(context, '/main_shell', (route) => false),
                  child: const Text('Back to Home', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value, {Color? color, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.white60)),
          Text(value, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.w500, color: color ?? Colors.white)),
        ],
      ),
    );
  }
}