import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

void main() {
  runApp(const ARRealEstateApp());
}

class ARRealEstateApp extends StatelessWidget {
  const ARRealEstateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AR Real Estate Explorer',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D0E12),
        fontFamily: 'Roboto',
      ),
      home: const PropertyExplorerScreen(),
    );
  }
}

class Property {
  final String id;
  final String title;
  final String location;
  final String price;
  final String bedrooms;
  final String bathrooms;
  final String area;
  final String glbModelUrl;

  Property({
    required this.id,
    required this.title,
    required this.location,
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.glbModelUrl,
  });
}

class PropertyExplorerScreen extends StatefulWidget {
  const PropertyExplorerScreen({super.key});

  @override
  State<PropertyExplorerScreen> createState() => _PropertyExplorerScreenState();
}

class _PropertyExplorerScreenState extends State<PropertyExplorerScreen> {
  // Sample Real Estate 3D Model Listings
  final List<Property> _properties = [
    Property(
      id: '1',
      title: 'Astronaut Suite',
      location: 'Beverly Hills, CA',
      price: '\$2,850,000',
      bedrooms: '4 Bed',
      bathrooms: '3.5 Bath',
      area: '3,400 sqft',
      glbModelUrl: 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
    ),
    // Property(
    //   id: '2',
    //   title: 'Modern Neil Armstrong',
    //   location: 'Downtown Chicago, IL',
    //   price: '\$1,420,000',
    //   bedrooms: '2 Bed',
    //   bathrooms: '2 Bath',
    //   area: '1,850 sqft',
    //   glbModelUrl: 'https://raw.githubusercontent.com/KhronosGroup/glTF-Sample-Models/main/2.0/Avocado/glTF-Binary/Avocado.glb',
    // ),
    Property(
      id: '3',
      title: 'Heritage Helmet Residence',
      location: 'Austin, TX',
      price: '\$980,000',
      bedrooms: '3 Bed',
      bathrooms: '2 Bath',
      area: '2,100 sqft',
      glbModelUrl: 'https://raw.githubusercontent.com/KhronosGroup/glTF-Sample-Models/main/2.0/DamagedHelmet/glTF-Binary/DamagedHelmet.glb',
    ),
  ];

  int _selectedPropertyIndex = 0;
  bool _isFloorPlanView = false;

  @override
  Widget build(BuildContext context) {
    final activeProperty = _properties[_selectedPropertyIndex];

    return Scaffold(
      body: Stack(
        children: [
          // 1. 3D & AR VIEWPORT (BACKGROUND)
          ModelViewer(
            key: ValueKey(activeProperty.id),
            src: activeProperty.glbModelUrl,
            alt: activeProperty.title,
            ar: true,
            arModes: const ['scene-viewer', 'quick-look', 'webxr'],
            autoRotate: true,
            cameraControls: true,
            shadowIntensity: 1.0, // 👈 Fix: Must be between 0.0 and 1.0 (Changed from 1.5)
            exposure: 1.0,
            backgroundColor: Colors.transparent,
          ),

          // 2. TOP FLOATING APP BAR
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildBlurIconButton(
                    icon: Icons.arrow_back_ios_new,
                    onTap: () {},
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.65),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white24),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.view_in_ar_rounded, color: Colors.cyanAccent, size: 18),
                        SizedBox(width: 8),
                        Text(
                          'AR READY',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildBlurIconButton(
                    icon: Icons.bookmark_border_rounded,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),

          // 3. BOTTOM OVERLAY CARD & ACTIONS
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.95),
                    Colors.black.withOpacity(0.8),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.7, 1.0],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title & Price Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              activeProperty.title,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.location_on_outlined, color: Colors.grey, size: 14),
                                const SizedBox(width: 4),
                                Text(
                                  activeProperty.location,
                                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Text(
                        activeProperty.price,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.cyanAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Key Property Features Pills
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildSpecChip(Icons.king_bed_outlined, activeProperty.bedrooms),
                      _buildSpecChip(Icons.bathtub_outlined, activeProperty.bathrooms),
                      _buildSpecChip(Icons.square_foot_outlined, activeProperty.area),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Property Switcher Tabs
                  SizedBox(
                    height: 42,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _properties.length,
                      itemBuilder: (context, index) {
                        final isSelected = index == _selectedPropertyIndex;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedPropertyIndex = index;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.white : Colors.white.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                _properties[index].title,
                                style: TextStyle(
                                  color: isSelected ? Colors.black : Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // AR View Action Button
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Tap the AR cube inside the 3D viewport to place this model in your room!'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyanAccent,
                      foregroundColor: Colors.black,
                      minimumSize: const Size.fromHeight(54),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.view_in_ar_rounded, size: 22, color: Colors.black),
                        SizedBox(width: 10),
                        Text(
                          'Place Property in AR',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
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

  Widget _buildBlurIconButton({required IconData icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.65),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white12),
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
    );
  }

  Widget _buildSpecChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 16),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}