import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ARProductGalleryScreen(),
  ));
}

class ARProductGalleryScreen extends StatefulWidget {
  const ARProductGalleryScreen({super.key});

  @override
  State<ARProductGalleryScreen> createState() => _ARProductGalleryScreenState();
}

class _ARProductGalleryScreenState extends State<ARProductGalleryScreen> {
  final List<Map<String, String>> _products = [
    {
      'name': 'Eames Lounge Chair',
      'category': 'PREMIUM FURNITURE',
      'price': '\$1,240.00',
      'src': 'https://modelviewer.dev/shared-assets/models/Astronaut.glb',
    },
    {
      'name': 'Cyberpunk Sneaker',
      'category': 'FOOTWEAR',
      'price': '\$280.00',
      'src': 'https://modelviewer.dev/shared-assets/models/MaterialsVariantsShoe.glb',
    },
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final currentProduct = _products[_selectedIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F12),
      body: Stack(
        children: [
          // 3D & Native AR Viewport
          ModelViewer(
            key: ValueKey(currentProduct['src']),
            src: currentProduct['src']!,
            alt: currentProduct['name'],
            ar: true, // Enables AR camera mode on iOS & Android
            arModes: const ['scene-viewer', 'webxr', 'quick-look'],
            autoRotate: true,
            cameraControls: true,
            shadowIntensity: 1.5,
            exposure: 1.0,
            backgroundColor: Colors.transparent,
          ),

          // Product Overlay UI
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Top Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {},
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.cyanAccent),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.view_in_ar, color: Colors.cyanAccent, size: 16),
                            SizedBox(width: 6),
                            Text(
                              '3D ACTIVE',
                              style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Bottom Product Controls
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          currentProduct['category']!,
                          style: const TextStyle(color: Colors.cyanAccent, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              currentProduct['name']!,
                              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              currentProduct['price']!,
                              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],

                        ),
                        const SizedBox(height: 16),

                        // Model Selector Buttons
                        Row(
                          children: List.generate(_products.length, (index) {
                            final isSelected = index == _selectedIndex;
                            return GestureDetector(
                              onTap: () => setState(() => _selectedIndex = index),
                              child: Container(
                                margin: const EdgeInsets.only(right: 8),
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected ? Colors.white : Colors.white10,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  _products[index]['name']!,
                                  style: TextStyle(
                                    color: isSelected ? Colors.black : Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            );
                          }),
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
}