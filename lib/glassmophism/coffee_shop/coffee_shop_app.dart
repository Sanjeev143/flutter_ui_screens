import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(const CoffeeShopApp());
}

// Global Data Models & State
class CartItem {
  final String name;
  final String image;
  final double price;
  final String size;
  int quantity;

  CartItem({
    required this.name,
    required this.image,
    required this.price,
    required this.size,
    this.quantity = 1,
  });
}

List<CartItem> globalCart = [];
List<Map<String, dynamic>> globalFavorites = [];

// 18-Item Coffee, Tea & Dessert Catalog with working images
final List<Map<String, dynamic>> allCatalogItems = [
  {
    'name': 'Caramel Latte',
    'category': 'Hot Coffee',
    'price': 6.50,
    'oldPrice': 8.50,
    'rating': '4.8k',
    'image': 'https://images.unsplash.com/photo-1570968915860-54d5c301fa9f?q=80&w=600&auto=format&fit=crop',
    'description': 'Smooth espresso blended with creamy milk and rich caramel flavor for a perfect balance of sweetness and boldness.',
    'isFavorite': true,
  },
  {
    'name': 'Vanilla Cappuccino',
    'category': 'Hot Coffee',
    'price': 5.75,
    'oldPrice': 7.25,
    'rating': '3.2k',
    'image': 'https://images.unsplash.com/photo-1534778101976-62847782c213?q=80&w=600&auto=format&fit=crop',
    'description': 'Rich espresso with a deep layer of foam and smooth vanilla hint.',
    'isFavorite': false,
  },
  {
    'name': 'Hazelnut Mocha',
    'category': 'Hot Coffee',
    'price': 6.00,
    'oldPrice': 8.00,
    'rating': '5.0k',
    'image': 'https://images.unsplash.com/photo-1517701550927-30cf4ba1dba5?q=80&w=600&auto=format&fit=crop',
    'description': 'Decadent chocolate meets roasted hazelnut and premium espresso.',
    'isFavorite': true,
  },
  {
    'name': 'Espresso Macchiato',
    'category': 'Hot Coffee',
    'price': 4.00,
    'oldPrice': 5.50,
    'rating': '2.7k',
    'image': 'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?q=80&w=600&auto=format&fit=crop',
    'description': 'Bold espresso marked with a dollop of foamed milk.',
    'isFavorite': false,
  },
  {
    'name': 'Iced Caramel Cold Brew',
    'category': 'Cold Brew',
    'price': 6.25,
    'oldPrice': 7.50,
    'rating': '4.9k',
    'image': 'https://images.unsplash.com/photo-1517701604599-bb29b565090c?q=80&w=600&auto=format&fit=crop',
    'description': 'Slow-steeped cold brew infused with sweet vanilla syrup and topped with cold cream.',
    'isFavorite': false,
  },
  {
    'name': 'Nitro Cold Brew',
    'category': 'Cold Brew',
    'price': 5.50,
    'oldPrice': 6.80,
    'rating': '4.6k',
    'image': 'https://images.unsplash.com/photo-1518832553480-cd0e625ed3e6?q=80&w=600&auto=format&fit=crop',
    'description': 'Velvety smooth cold brew infused with nitrogen for a creamy cascade effect.',
    'isFavorite': false,
  },
  {
    'name': 'Matcha Green Tea Latte',
    'category': 'Tea',
    'price': 5.80,
    'oldPrice': 7.00,
    'rating': '4.7k',
    'image': 'https://images.unsplash.com/photo-1536256263959-770b48d82b0a?q=80&w=600&auto=format&fit=crop',
    'description': 'Fine ceremonial-grade Japanese matcha blended with steamed organic milk.',
    'isFavorite': true,
  },
  {
    'name': 'Earl Grey Milk Tea',
    'category': 'Tea',
    'price': 4.90,
    'oldPrice': 6.00,
    'rating': '4.1k',
    'image': 'https://images.unsplash.com/photo-1576092768241-dec231879fc3?q=80&w=600&auto=format&fit=crop',
    'description': 'Classic black tea infused with aromatic bergamot oil and creamy honey milk.',
    'isFavorite': false,
  },
  {
    'name': 'Classic Tiramisu',
    'category': 'Dessert',
    'price': 7.00,
    'oldPrice': 9.00,
    'rating': '4.9k',
    'image': 'https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?q=80&w=600&auto=format&fit=crop',
    'description': 'Italian sponge cake soaked in espresso, layered with rich mascarpone cream and cocoa.',
    'isFavorite': false,
  },
  {
    'name': 'Chocolate Lava Cake',
    'category': 'Dessert',
    'price': 6.50,
    'oldPrice': 8.00,
    'rating': '4.8k',
    'image': 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?q=80&w=600&auto=format&fit=crop',
    'description': 'Warm chocolate cake with a molten, gooey liquid center, served with powdered sugar.',
    'isFavorite': true,
  },
  {
    'name': 'Caffe Americano',
    'category': 'Hot Coffee',
    'price': 3.75,
    'oldPrice': 4.80,
    'rating': '4.3k',
    'image': 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?q=80&w=600&auto=format&fit=crop',
    'description': 'Espresso shots topped with hot water create a light layer of crema.',
    'isFavorite': false,
  },
  {
    'name': 'Caramel Macchiato',
    'category': 'Hot Coffee',
    'price': 6.20,
    'oldPrice': 7.90,
    'rating': '4.9k',
    'image': 'https://images.unsplash.com/photo-1572442388796-11668a67e53d?q=80&w=600&auto=format&fit=crop',
    'description': 'Freshly steamed milk with vanilla-flavored syrup marked with espresso and caramel drizzle.',
    'isFavorite': false,
  },
  {
    'name': 'Iced Brown Sugar Shaken Espresso',
    'category': 'Cold Brew',
    'price': 6.80,
    'oldPrice': 8.20,
    'rating': '5.0k',
    'image': 'https://images.unsplash.com/photo-1517256064527-09c73fc73e38?q=80&w=600&auto=format&fit=crop',
    'description': 'Blonde espresso, brown sugar, and cinnamon shaken together and topped with oat milk.',
    'isFavorite': false,
  },
  {
    'name': 'Jasmine Pearl Green Tea',
    'category': 'Tea',
    'price': 4.50,
    'oldPrice': 5.50,
    'rating': '4.4k',
    'image': 'https://images.unsplash.com/photo-1597481499750-3e6b22637e12?q=80&w=600&auto=format&fit=crop',
    'description': 'Hand-rolled green tea leaves scented with fresh night-blooming jasmine flowers.',
    'isFavorite': false,
  },
  {
    'name': 'Masala Chai Latte',
    'category': 'Tea',
    'price': 5.20,
    'oldPrice': 6.50,
    'rating': '4.8k',
    'image': 'https://images.unsplash.com/photo-1544787219-7f47ccb76574?q=80&w=600&auto=format&fit=crop',
    'description': 'Black tea brewed with aromatic Indian spices, ginger, and steamed whole milk.',
    'isFavorite': true,
  },
  {
    'name': 'Berry Cheesecake',
    'category': 'Dessert',
    'price': 7.50,
    'oldPrice': 9.20,
    'rating': '4.9k',
    'image': 'https://images.unsplash.com/photo-1533134242443-d4fd215305ad?q=80&w=600&auto=format&fit=crop',
    'description': 'New York style velvety cheesecake topped with fresh strawberry and blueberry compote.',
    'isFavorite': false,
  },
  {
    'name': 'Flat White',
    'category': 'Hot Coffee',
    'price': 5.00,
    'oldPrice': 6.50,
    'rating': '4.5k',
    'image': 'https://images.unsplash.com/photo-1577968897966-3d4325b36b61?q=80&w=600&auto=format&fit=crop',
    'description': 'Smooth ristretto shots infused with velvety microfoam milk.',
    'isFavorite': false,
  },
  {
    'name': 'Affogato al Caffè',
    'category': 'Dessert',
    'price': 6.00,
    'oldPrice': 7.50,
    'rating': '4.7k',
    'image': 'https://images.unsplash.com/photo-1594631252845-29fc4cc8cde9?q=80&w=600&auto=format&fit=crop',
    'description': 'A scoop of artisan vanilla bean gelato drowned with a hot shot of rich espresso.',
    'isFavorite': false,
  },
];

// Reusable Glassmorphic Container Widget /// parent widget
class GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final Color? color;
  final double blur;

  const GlassContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = 16.0,
    this.color,
    this.blur = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: color ?? Colors.white.withOpacity(0.06),
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: Colors.white.withOpacity(0.12),
                width: 1.2,
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.08),
                  Colors.white.withOpacity(0.02),
                ],
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class CoffeeShopApp extends StatelessWidget {
  const CoffeeShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Luxury Coffee App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0705),
        primaryColor: const Color(0xFFC67C4E),
        fontFamily: 'Sans-Serif',
      ),
      home: const WelcomeScreen(),
    );
  }
}

// ==========================================
// 1. WELCOME SCREEN (Glass UI on Bottom)
// ==========================================
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?q=80&w=1000&auto=format&fit=crop',
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.5),
                  const Color(0xFF0A0705),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Luxury Awaits\nYour Stay',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Discover and book luxury stays curated\nfor your perfect getaway.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const MainNavScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC67C4E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 8,
                        shadowColor: const Color(0xFFC67C4E).withOpacity(0.5),
                      ),
                      child: const Text(
                        'Get started',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
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
// MAIN NAVIGATION WRAPPER (Frosted Glass Nav)
// ==========================================
class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const FavoritesScreen(),
    const CartScreenFromTab(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _screens[_currentIndex],
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: GlassContainer(
              borderRadius: 24,
              blur: 16,
              color: Colors.black.withOpacity(0.4),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavIcon(Icons.home, 0),
                  _buildNavIcon(Icons.favorite_border, 1),
                  _buildNavIcon(Icons.shopping_bag_outlined, 2),
                  _buildNavIcon(Icons.person_outline, 3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavIcon(IconData icon, int index) {
    bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFC67C4E).withOpacity(0.3) : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
          border: isSelected ? Border.all(color: const Color(0xFFC67C4E).withOpacity(0.6)) : null,
        ),
        child: Icon(
          icon,
          color: isSelected ? const Color(0xFFC67C4E) : Colors.grey[400],
          size: 24,
        ),
      ),
    );
  }
}

// ==========================================
// 2. HOME SCREEN (Glass Cards)
// ==========================================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';
  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final filteredCoffees = allCatalogItems.where((item) {
      final matchesCategory = selectedCategory == 'All' || item['category'] == selectedCategory;
      final matchesSearch = item['name'].toString().toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 22,
                      backgroundImage: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=200&auto=format&fit=crop'),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Leonardo', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                        Text('Test with us', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
                GlassContainer(
                  borderRadius: 12,
                  padding: const EdgeInsets.all(10),
                  child: const Icon(Icons.notifications_none, color: Colors.white, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: GlassContainer(
                    borderRadius: 16,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      onChanged: (val) => setState(() => searchQuery = val),
                      decoration: const InputDecoration(
                        hintText: 'Search coffee, tea, dessert...',
                        hintStyle: TextStyle(color: Colors.grey),
                        icon: Icon(Icons.search, color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GlassContainer(
                  borderRadius: 16,
                  color: const Color(0xFFC67C4E).withOpacity(0.3),
                  padding: const EdgeInsets.all(14),
                  child: const Icon(Icons.tune, color: Colors.white, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryChip('All'),
                  _buildCategoryChip('Hot Coffee'),
                  _buildCategoryChip('Cold Brew'),
                  _buildCategoryChip('Tea'),
                  _buildCategoryChip('Dessert'),
                ],
              ),
            ),
            const SizedBox(height: 24),
            filteredCoffees.isEmpty
                ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 40),
              child: Center(child: Text('No items found', style: TextStyle(color: Colors.grey))),
            )
                : GridView.builder(
              itemCount: filteredCoffees.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                final coffee = filteredCoffees[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(coffee: coffee),
                      ),
                    ).then((_) => setState(() {}));
                  },
                  child: GlassContainer(
                    borderRadius: 20,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image.network(
                                coffee['image'],
                                height: 110,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 8,
                              left: 8,
                              child: GlassContainer(
                                borderRadius: 8,
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                child: Row(
                                  children: [
                                    const Icon(Icons.star, color: Colors.amber, size: 12),
                                    const SizedBox(width: 4),
                                    Text(coffee['rating'], style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          coffee['name'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          coffee['category'],
                          style: TextStyle(color: Colors.grey[400], fontSize: 10),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${coffee['price'].toStringAsFixed(2)}',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
                            ),
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFC67C4E),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFC67C4E).withOpacity(0.4),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  )
                                ],
                              ),
                              child: const Icon(Icons.add, size: 16, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label) {
    bool isSelected = selectedCategory == label;
    return GestureDetector(
      onTap: () => setState(() => selectedCategory = label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFC67C4E) : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.white.withOpacity(0.1),
          ),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: const Color(0xFFC67C4E).withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[400],
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 3. COFFEE DETAIL SCREEN (Glass Sheet Overlay)
// ==========================================
class DetailScreen extends StatefulWidget {
  final Map<String, dynamic> coffee;

  const DetailScreen({super.key, required this.coffee});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String selectedSize = 'Small';
  int quantity = 1;

  double get adjustedPrice {
    double base = widget.coffee['price'];
    if (selectedSize == 'Medium') base += 1.0;
    if (selectedSize == 'Large') base += 2.0;
    return base * quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Image.network(
              widget.coffee['image'],
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 48,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: GlassContainer(
                    borderRadius: 12,
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.arrow_back_ios_new, size: 18, color: Colors.white),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.coffee['isFavorite'] = !(widget.coffee['isFavorite'] ?? false);
                    });
                  },
                  child: GlassContainer(
                    borderRadius: 12,
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      widget.coffee['isFavorite'] == true ? Icons.favorite : Icons.favorite_border,
                      size: 18,
                      color: widget.coffee['isFavorite'] == true ? Colors.red : Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.42,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF0A0705).withOpacity(0.92),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.coffee['name'],
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              const SizedBox(height: 4),
                              Text(widget.coffee['category'], style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                            ],
                          ),
                        ),
                        GlassContainer(
                          borderRadius: 12,
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove, size: 16, color: Colors.white),
                                onPressed: () {
                                  if (quantity > 1) setState(() => quantity--);
                                },
                              ),
                              Text('$quantity', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              IconButton(
                                icon: const Icon(Icons.add, size: 16, color: Color(0xFFC67C4E)),
                                onPressed: () => setState(() => quantity++),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(widget.coffee['rating'], style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text(' (230)', style: TextStyle(color: Colors.grey[500])),
                      ],
                    ),
                    const Divider(height: 30, color: Colors.white12),
                    const Text('Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                    const SizedBox(height: 8),
                    Text(
                      widget.coffee['description'],
                      style: TextStyle(color: Colors.grey[400], fontSize: 13, height: 1.5),
                    ),
                    const SizedBox(height: 20),
                    const Text('Size', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: ['Small', 'Medium', 'Large'].map((size) {
                        bool isSelected = selectedSize == size;
                        return GestureDetector(
                          onTap: () => setState(() => selectedSize = size),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 100,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFFC67C4E).withOpacity(0.2) : Colors.white.withOpacity(0.04),
                              border: Border.all(
                                color: isSelected ? const Color(0xFFC67C4E) : Colors.white.withOpacity(0.08),
                                width: isSelected ? 1.5 : 1.0,
                              ),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              size,
                              style: TextStyle(
                                color: isSelected ? const Color(0xFFC67C4E) : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    GlassContainer(
                      borderRadius: 14,
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: const [
                          CircleAvatar(
                            backgroundColor: Colors.green,
                            child: Text('☕', style: TextStyle(fontSize: 16)),
                          ),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Starbucks', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                              Text('Premium Roast Quality', style: TextStyle(color: Colors.grey, fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: GlassContainer(
        borderRadius: 0,
        blur: 20,
        color: const Color(0xFF0A0705).withOpacity(0.85),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Price', style: TextStyle(color: Colors.grey, fontSize: 12)),
                Text(
                  '\$${adjustedPrice.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFC67C4E)),
                ),
              ],
            ),
            const SizedBox(width: 20),
            Expanded(
              child: SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    globalCart.add(CartItem(
                      name: widget.coffee['name'],
                      image: widget.coffee['image'],
                      price: adjustedPrice / quantity,
                      size: selectedSize,
                      quantity: quantity,
                    ));
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Added to cart successfully!'), duration: Duration(seconds: 1)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC67C4E),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 6,
                    shadowColor: const Color(0xFFC67C4E).withOpacity(0.5),
                  ),
                  child: const Text('Add to Cart', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 4. FAVORITES SCREEN
// ==========================================
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final favoriteItems = allCatalogItems.where((item) => item['isFavorite'] == true).toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Favorite Items', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 16),
            Expanded(
              child: favoriteItems.isEmpty
                  ? const Center(
                child: Text('No favorite items added yet.', style: TextStyle(color: Colors.grey)),
              )
                  : ListView.builder(
                itemCount: favoriteItems.length,
                itemBuilder: (context, index) {
                  final item = favoriteItems[index];
                  return GlassContainer(
                    borderRadius: 16,
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(item['image'], width: 60, height: 60, fit: BoxFit.cover),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)),
                              const SizedBox(height: 4),
                              Text(item['category'], style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                              const SizedBox(height: 4),
                              Text('\$${item['price'].toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFC67C4E))),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.favorite, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              item['isFavorite'] = false;
                            });
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 5. CART SCREEN & ORDER COMPLETE DIALOG
// ==========================================
class CartScreenFromTab extends StatefulWidget {
  const CartScreenFromTab({super.key});

  @override
  State<CartScreenFromTab> createState() => _CartScreenFromTabState();
}

class _CartScreenFromTabState extends State<CartScreenFromTab> {
  double get totalAmount {
    return globalCart.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  void _showOrderCompletePopup() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF14100D),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: Colors.white.withOpacity(0.12)),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            const CircleAvatar(
              radius: 35,
              backgroundColor: Color(0xFFC67C4E),
              child: Icon(Icons.check, size: 40, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text(
              'Order Complete!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              'Your delicious order is being prepared and will be delivered shortly.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[400], fontSize: 13),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    globalCart.clear();
                  });
                  Navigator.pop(context); // Close dialog
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MainNavScreen()),
                        (route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC67C4E),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Back to Home', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('My Cart', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 16),
            Expanded(
              child: globalCart.isEmpty
                  ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_bag_outlined, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text('Your cart is empty', style: TextStyle(color: Colors.grey, fontSize: 16)),
                  ],
                ),
              )
                  : ListView.builder(
                itemCount: globalCart.length,
                itemBuilder: (context, index) {
                  final item = globalCart[index];
                  return GlassContainer(
                    borderRadius: 16,
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(item.image, width: 60, height: 60, fit: BoxFit.cover),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)),
                              const SizedBox(height: 4),
                              Text('Size: ${item.size}', style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                              const SizedBox(height: 4),
                              Text('\$${(item.price * item.quantity).toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFC67C4E))),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, size: 16, color: Colors.white),
                              onPressed: () {
                                setState(() {
                                  if (item.quantity > 1) {
                                    item.quantity--;
                                  } else {
                                    globalCart.removeAt(index);
                                  }
                                });
                              },
                            ),
                            Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.bold)),
                            IconButton(
                              icon: const Icon(Icons.add, size: 16, color: Color(0xFFC67C4E)),
                              onPressed: () {
                                setState(() {
                                  item.quantity++;
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            if (globalCart.isNotEmpty) ...[
              const Divider(color: Colors.white12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Amount:', style: TextStyle(color: Colors.grey, fontSize: 16)),
                  Text('\$${totalAmount.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _showOrderCompletePopup,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC67C4E),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 6,
                    shadowColor: const Color(0xFFC67C4E).withOpacity(0.5),
                  ),
                  child: const Text('Complete Order', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 6. PROFILE SCREEN
// ==========================================
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=300&auto=format&fit=crop'),
            ),
            const SizedBox(height: 16),
            const Text('Leonardo', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            const Text('leonardo.test@example.com', style: TextStyle(color: Colors.grey, fontSize: 14)),
            const SizedBox(height: 32),
            GlassContainer(
              borderRadius: 20,
              padding: EdgeInsets.zero,
              child: Column(
                children: const [
                  ListTile(
                    leading: Icon(Icons.history, color: Color(0xFFC67C4E)),
                    title: Text('Order History', style: TextStyle(color: Colors.white)),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  ),
                  Divider(height: 1, color: Colors.white12),
                  ListTile(
                    leading: Icon(Icons.location_on_outlined, color: Color(0xFFC67C4E)),
                    title: Text('Shipping Addresses', style: TextStyle(color: Colors.white)),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  ),
                  Divider(height: 1, color: Colors.white12),
                  ListTile(
                    leading: Icon(Icons.payment, color: Color(0xFFC67C4E)),
                    title: Text('Payment Methods', style: TextStyle(color: Colors.white)),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}