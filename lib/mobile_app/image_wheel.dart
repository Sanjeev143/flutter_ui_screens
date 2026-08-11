import 'package:flutter/material.dart';

void main() {
  runApp(const ImageWheelApp());
}

class ImageWheelApp extends StatelessWidget {
  const ImageWheelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const ImageWheelScreen(),
    );
  }
}

class ImageWheelScreen extends StatefulWidget {
  const ImageWheelScreen({super.key});

  @override
  State<ImageWheelScreen> createState() => _ImageWheelScreenState();
}

class _ImageWheelScreenState extends State<ImageWheelScreen> {
  // Sample Unsplash Image URLs
  final List<String> _images = [
    'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=600',
    'https://images.unsplash.com/photo-1511884642898-4c92249e20b6?w=600',
    'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?w=600',
    'https://images.unsplash.com/photo-1426604966848-d7adac402bff?w=600',
    'https://images.unsplash.com/photo-1472214103451-9374bd1c798e?w=600',
    'https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=600',
    'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=600',
    'https://images.unsplash.com/photo-1511884642898-4c92249e20b6?w=600',
    'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?w=600',
    'https://images.unsplash.com/photo-1426604966848-d7adac402bff?w=600',
    'https://images.unsplash.com/photo-1472214103451-9374bd1c798e?w=600',
    'https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=600',
    'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=600',
    'https://images.unsplash.com/photo-1511884642898-4c92249e20b6?w=600',
    'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?w=600',
    'https://images.unsplash.com/photo-1426604966848-d7adac402bff?w=600',
    'https://images.unsplash.com/photo-1472214103451-9374bd1c798e?w=600',
    'https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=600',
  ];

  int _selectedIndex = 0;
  final FixedExtentScrollController _scrollController = FixedExtentScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0E12),
      appBar: AppBar(
        title: const Text('3D Image Wheel - Amazevalley', style: TextStyle
          (fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Selected Index Indicator
            Text(
              'Item ${_selectedIndex + 1} of ${_images.length}',
              style: const TextStyle(
                color: Colors.amber,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
            ),

            const SizedBox(height: 20),

            // 3D List Wheel Viewport
            Expanded(
              child: ListWheelScrollView.useDelegate(
                controller: _scrollController,
                itemExtent: 220, // Height of each wheel item
                diameterRatio: 1.8, // Adjusts wheel curvature radius
                perspective: 0.003, // Controls 3D depth perspective
                magnification: 1.2, // Enlarges the active centered item
                useMagnifier: true,
                physics: const FixedExtentScrollPhysics(), // Snaps to item on release
                onSelectedItemChanged: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                childDelegate: ListWheelChildBuilderDelegate(
                  childCount: _images.length,
                  builder: (context, index) {
                    final isSelected = index == _selectedIndex;

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: isSelected ? Colors.amber : Colors.white10,
                          width: isSelected ? 3 : 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isSelected
                                ? Colors.amber.withOpacity(0.3)
                                : Colors.black.withOpacity(0.5),
                            blurRadius: isSelected ? 16 : 8,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            // Image Render
                            Image.network(
                              _images[index],
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                color: Colors.grey.shade900,
                                child: const Icon(Icons.broken_image, color: Colors.white24, size: 48),
                              ),
                            ),

                            // Overlay Dimmer for Non-selected Items
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              color: isSelected ? Colors.transparent : Colors.black.withOpacity(0.4),
                            ),

                            // Badge Overlay
                            Positioned(
                              bottom: 12,
                              left: 12,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Photo #${index + 1}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
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
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Pagination Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.amber),
                  onPressed: _selectedIndex > 0
                      ? () {
                    _scrollController.animateToItem(
                      _selectedIndex - 1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  }
                      : null,
                ),
                const SizedBox(width: 20),
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, color: Colors.amber),
                  onPressed: _selectedIndex < _images.length - 1
                      ? () {
                    _scrollController.animateToItem(
                      _selectedIndex + 1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOut,
                    );
                  }
                      : null,
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}