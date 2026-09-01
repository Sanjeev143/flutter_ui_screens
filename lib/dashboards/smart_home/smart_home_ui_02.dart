import 'package:flutter/material.dart';
import 'dart:ui';

void main() {
  runApp(const SmartHomeApp());
}

class SmartHomeApp extends StatelessWidget {
  const SmartHomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Smart Home Control Panel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),
      home: const SmartHomeDashboardScreen(),
    );
  }
}

class CameraState {
  String name;
  bool isOn;
  String imageUrl;

  CameraState({required this.name, required this.isOn, required this.imageUrl});
}

class RoomState {
  bool hasAcAndTv;
  bool hasShower;
  bool hasMultipleCameras;

  bool isAcOn;
  bool isAirPurifierOn;
  bool isTvOn;
  bool isCurtainsOn;
  bool isWeatherOn;
  bool isBrightnessWidgetOn;
  bool isInternetOn;
  bool isAmbientLightOn;
  bool isShowerOn;

  List<CameraState> cameras;

  double acTemperature;
  double fanSpeed;
  String acMode;
  double curtainOpenPercentage;
  double brightness;
  double globalBrightness;
  String ambientColour;
  String ambientScene;
  bool isScheduleActive;
  bool isMusicSyncOn;
  double waterTemperature;
  double waterFlowRate;

  // Air Purifier specific
  int aqiValue;

  // Weather specific
  String weatherCondition; // 'Sunny', 'Rainy', 'Cloudy'
  int weatherTemperature;  // Dynamic temperature based on condition

  RoomState({
    this.hasAcAndTv = true,
    this.hasShower = false,
    this.hasMultipleCameras = false,
    this.isAcOn = true,
    this.isAirPurifierOn = true,
    this.isTvOn = true,
    this.isCurtainsOn = true,
    this.isWeatherOn = true,
    this.isBrightnessWidgetOn = true,
    this.isInternetOn = true,
    this.isAmbientLightOn = true,
    this.isShowerOn = true,
    required this.cameras,
    this.acTemperature = 22.0,
    this.fanSpeed = 2.0,
    this.acMode = 'Cooling',
    this.curtainOpenPercentage = 68.0,
    this.brightness = 27.0,
    this.globalBrightness = 52.0,
    this.ambientColour = 'White',
    this.ambientScene = 'Gorgeous',
    this.isScheduleActive = true,
    this.isMusicSyncOn = false,
    this.waterTemperature = 38.0,
    this.waterFlowRate = 3.0,
    this.aqiValue = 35,
    this.weatherCondition = 'Sunny',
    this.weatherTemperature = 28,
  });
}

class SmartHomeDashboardScreen extends StatefulWidget {
  const SmartHomeDashboardScreen({super.key});

  @override
  State<SmartHomeDashboardScreen> createState() => _SmartHomeDashboardScreenState();
}

class _SmartHomeDashboardScreenState extends State<SmartHomeDashboardScreen> {
  String _selectedRoom = 'Living Room';
  final List<String> _rooms = ['Living Room', 'Dining room', 'Bed room', 'Bathroom', 'Balcony', 'Camera', 'About Us'];

  final Map<String, RoomState> _roomStates = {
    'Living Room': RoomState(
      hasAcAndTv: true,
      hasShower: false,
      hasMultipleCameras: true,
      weatherCondition: 'Sunny',
      weatherTemperature: 28,
      cameras: [
        CameraState(name: 'Backyard', isOn: true, imageUrl: 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=800&q=80'),
        CameraState(name: 'Entrance', isOn: true, imageUrl: 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=800&q=80'),
        CameraState(name: 'Kitchen', isOn: true, imageUrl: 'https://images.unsplash.com/photo-1556911220-e15b29be8c8f?auto=format&fit=crop&w=800&q=80'),
        CameraState(name: 'Hall', isOn: true, imageUrl: 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=800&q=80'),
      ],
    ),
    'Dining room': RoomState(
      hasAcAndTv: true,
      hasShower: false,
      hasMultipleCameras: false,
      acTemperature: 22.0,
      globalBrightness: 40.0,
      weatherCondition: 'Cloudy',
      weatherTemperature: 21,
      aqiValue: 65,
      cameras: [CameraState(name: 'Kitchen', isOn: true, imageUrl: 'https://images.unsplash.com/photo-1556911220-e15b29be8c8f?auto=format&fit=crop&w=800&q=80')],
    ),
    'Bed room': RoomState(
      hasAcAndTv: true,
      hasShower: false,
      hasMultipleCameras: false,
      acTemperature: 20.0,
      globalBrightness: 20.0,
      weatherCondition: 'Rainy',
      weatherTemperature: 18,
      aqiValue: 20,
      cameras: [CameraState(name: 'Hall', isOn: true, imageUrl: 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=800&q=80')],
    ),
    'Bathroom': RoomState(
      hasAcAndTv: false,
      hasShower: true,
      hasMultipleCameras: false,
      globalBrightness: 60.0,
      weatherCondition: 'Rainy',
      weatherTemperature: 18,
      aqiValue: 45,
      cameras: [CameraState(name: 'Entrance', isOn: true, imageUrl: 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=800&q=80')],
    ),
    'Balcony': RoomState(
      hasAcAndTv: false,
      hasShower: false,
      hasMultipleCameras: false,
      globalBrightness: 80.0,
      weatherCondition: 'Sunny',
      weatherTemperature: 28,
      aqiValue: 85,
      cameras: [CameraState(name: 'Backyard', isOn: true, imageUrl: 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=800&q=80')],
    ),
    'Camera': RoomState(
      hasAcAndTv: false,
      hasShower: false,
      hasMultipleCameras: false,
      cameras: [
        CameraState(name: 'Camera 01 - Backyard', isOn: false, imageUrl: 'http'
            's://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=800&q=80'),
        CameraState(name: 'Camera 02 - Entrance', isOn: false, imageUrl: 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=800&q=80'),
        CameraState(name: 'Camera 03 - Kitchen', isOn: false, imageUrl: 'https://images.unsplash.com/photo-1556911220-e15b29be8c8f?auto=format&fit=crop&w=800&q=80'),
        CameraState(name: 'Camera 04 - Hall', isOn: false, imageUrl: 'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=800&q=80'),
        CameraState(name: 'Camera 05 - Garage', isOn: false, imageUrl: 'https://images.unsplash.com/photo-1507652313519-d4e9174996dd?auto=format&fit=crop&w=800&q=80'),
        CameraState(name: 'Camera 06 - Patio', isOn: false, imageUrl: 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=800&q=80'),
        CameraState(name: 'Camera 07 - Driveway', isOn: false, imageUrl: 'https://images.unsplash.com/photo-1595526114035-0d45ed16cfbf?auto=format&fit=crop&w=800&q=80'),
        CameraState(name: 'Camera 08 - Rooftop', isOn: false, imageUrl: 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=800&q=80'),
        CameraState(name: 'Camera 09 - Balcony', isOn: false, imageUrl: 'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?auto=format&fit=crop&w=800&q=80'),
        CameraState(name: 'Camera 10 - Perimeter', isOn: false, imageUrl: 'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?auto=format&fit=crop&w=800&q=80'),
      ],
    ),
    'About Us': RoomState(hasAcAndTv: false, hasShower: false, hasMultipleCameras: false, cameras: []),
  };

  RoomState get _currentState => _roomStates[_selectedRoom]!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=2000&q=80',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
              child: Container(
                color: Colors.black.withOpacity(0.45),
              ),
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                bool isMobile = constraints.maxWidth < 900;
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 16.0 : 24.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTopNavigationBar(isMobile),
                      const SizedBox(height: 16),
                      // _buildHeaderIntroSection(),
                      const SizedBox(height: 20),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: _selectedRoom == 'About Us'
                              ? _buildAboutUsView()
                              : (_selectedRoom == 'Camera' ? _buildDedicatedCameraTabView(isMobile) : (isMobile ? _buildMobileLayout() : _buildDesktopLayout())),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // --- TITLE & DESCRIPTION BANNER ---
  Widget _buildHeaderIntroSection() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'AI-Powered Smart Home – A Smarter Way to Live',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Transform your home into an intelligent environment with AI-powered automation. Manage connected devices, create smart routines, monitor your home, optimize energy consumption, and receive intelligent recommendations designed around your lifestyle.',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- ABOUT US VIEW (AMAZEVALLEY) ---
  Widget _buildAboutUsView() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'About Amazevalley',
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                'Welcome to Amazevalley, your premier destination for cutting-edge software design, modern UI/UX engineering, and innovative cross-platform Flutter applications. We specialize in building immersive, high-performance digital experiences with state-of-the-art glassmorphic aesthetics, custom shaders, and seamless responsive layouts.',
                style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
              ),
              SizedBox(height: 16),
              Text(
                'What We Do',
                style: TextStyle(color: Colors.cyanAccent, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '• Publishing in-depth software design tutorials and engaging tech short videos.\n'
                    '• Creating advanced AI-powered promotional videos, graphics, music compositions, and custom UI assets.\n'
                    '• Crafting futuristic IoT smart home dashboards and enterprise application prototypes.',
                style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.6),
              ),
              SizedBox(height: 20),
              Text(
                'Thank you for exploring our interactive smart home control platform. Stay tuned for more innovative projects and developer guides from Amazevalley!',
                style: TextStyle(color: Colors.white60, fontSize: 12, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- DEDICATED 10-CAMERA TAB VIEW WITH RESPONSIVE HEIGHT ---
  Widget _buildDedicatedCameraTabView(bool isMobile) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Security Cameras Control Center (10 Unique Feeds)',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: (_currentState.cameras.length / (isMobile ? 1 : 2)).ceil(),
                itemBuilder: (context, rowIndex) {
                  int firstIndex = rowIndex * (isMobile ? 1 : 2);
                  int secondIndex = firstIndex + 1;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildCameraFeedCard(_currentState.cameras[firstIndex], isMobile),
                        ),
                        if (!isMobile && secondIndex < _currentState.cameras.length) ...[
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildCameraFeedCard(_currentState.cameras[secondIndex], isMobile),
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- RESPONSIVE LAYOUTS ---
  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            children: [
              if (_currentState.hasAcAndTv) _buildAirConditionerCard(),
              if (_currentState.hasShower) _buildShowerControllerCard(),
              const SizedBox(height: 20),
              _currentState.hasMultipleCameras ? _buildMultiCameraGrid() : _buildCameraFeedCard(_currentState.cameras[0], false),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 5,
          child: Column(
            children: [
              _buildAirPurifierCard(),
              const SizedBox(height: 16),
              if (_currentState.hasAcAndTv) _buildSonyTvCard(),
              if (_currentState.hasAcAndTv) const SizedBox(height: 16),
              _buildWindowCurtainsCard(),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 5,
          child: Column(
            children: [
              _buildWeatherCard(),
              const SizedBox(height: 16),
              _buildBrightnessSliderCard(),
              const SizedBox(height: 16),
              _buildInternetSpeedCard(),
              const SizedBox(height: 16),
              _buildAddWidgetButton(),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 5,
          child: _buildAmbientLightsCard(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        if (_currentState.hasAcAndTv) _buildAirConditionerCard(),
        if (_currentState.hasShower) _buildShowerControllerCard(),
        const SizedBox(height: 16),
        _currentState.hasMultipleCameras ? _buildMultiCameraGrid() : _buildCameraFeedCard(_currentState.cameras[0], true),
        const SizedBox(height: 16),
        _buildAirPurifierCard(),
        const SizedBox(height: 16),
        if (_currentState.hasAcAndTv) _buildSonyTvCard(),
        if (_currentState.hasAcAndTv) const SizedBox(height: 16),
        _buildWindowCurtainsCard(),
        const SizedBox(height: 16),
        _buildWeatherCard(),
        const SizedBox(height: 16),
        _buildBrightnessSliderCard(),
        const SizedBox(height: 16),
        _buildInternetSpeedCard(),
        const SizedBox(height: 16),
        _buildAmbientLightsCard(),
        const SizedBox(height: 16),
        _buildAddWidgetButton(),
      ],
    );
  }

  Widget _buildTopNavigationBar(bool isMobile) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!isMobile)
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: const Icon(Icons.menu, color: Colors.white, size: 20),
          ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white.withOpacity(0.15)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: _rooms.map((room) {
                  final isSelected = _selectedRoom == room;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedRoom = room),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white.withOpacity(0.25) : Colors.transparent,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            room == 'Living Room'
                                ? Icons.weekend
                                : room == 'Dining room'
                                ? Icons.restaurant
                                : room == 'Bed room'
                                ? Icons.bed
                                : room == 'Bathroom'
                                ? Icons.bathtub
                                : room == 'Balcony'
                                ? Icons.balcony
                                : room == 'Camera'
                                ? Icons.videocam
                                : Icons.info_outline,
                            size: 14,
                            color: isSelected ? Colors.white : Colors.white60,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            room,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.white70,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Row(
          children: [
            if (!isMobile) ...[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: const Icon(Icons.notifications_none, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 10),
            ],
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.4), width: 2),
              ),
              child: const CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMultiCameraGrid() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Living Room Cameras (4 Views)', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: (_currentState.cameras.length / 2).ceil(),
                itemBuilder: (context, rowIndex) {
                  int firstIndex = rowIndex * 2;
                  int secondIndex = firstIndex + 1;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      children: [
                        Expanded(child: _buildMiniCameraTile(_currentState.cameras[firstIndex])),
                        if (secondIndex < _currentState.cameras.length) ...[
                          const SizedBox(width: 10),
                          Expanded(child: _buildMiniCameraTile(_currentState.cameras[secondIndex])),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMiniCameraTile(CameraState cam) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.black54,
          image: cam.isOn ? DecorationImage(image: NetworkImage(cam.imageUrl), fit: BoxFit.cover) : null,
        ),
        child: Stack(
          children: [
            if (!cam.isOn)
              Container(
                color: Colors.black87,
                child: const Center(
                  child: Text('OFF', style: TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ),
            Positioned(
              top: 6,
              left: 8,
              child: Text(cam.name, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
            Positioned(
              top: 4,
              right: 6,
              child: Row(
                children: [
                  if (cam.isOn) ...[
                    Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle)),
                    const SizedBox(width: 4),
                  ],
                  Transform.scale(
                    scale: 0.65,
                    child: Switch(
                      value: cam.isOn,
                      activeColor: Colors.white,
                      activeTrackColor: Colors.cyanAccent,
                      onChanged: (val) => setState(() => cam.isOn = val),
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

  // --- CAMERA FEED CARD WITH RESPONSIVE HEIGHT (Mobile: 160, Web/Desktop: 240) ---
  Widget _buildCameraFeedCard(CameraState cam, bool isMobile) {
    double cardHeight = isMobile ? 160.0 : 240.0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          height: cardHeight,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
            image: cam.isOn ? DecorationImage(image: NetworkImage(cam.imageUrl), fit: BoxFit.cover) : null,
          ),
          child: Stack(
            children: [
              if (!cam.isOn)
                Container(
                  color: Colors.black87,
                  child: const Center(
                    child: Text('CAMERA OFF', style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                  ),
                ),
              Positioned(
                top: 12,
                left: 12,
                child: Row(
                  children: [
                    Text(cam.name, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              Positioned(
                top: 6,
                right: 12,
                child: Row(
                  children: [
                    if (cam.isOn) ...[
                      Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle)),
                      const SizedBox(width: 4),
                      const Text('Live', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 12),
                    ],
                    Switch(
                      value: cam.isOn,
                      activeColor: Colors.white,
                      activeTrackColor: Colors.cyanAccent,
                      onChanged: (val) => setState(() => cam.isOn = val),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShowerControllerCard() {
    final state = _currentState;
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Smart Shower Controller', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                  Switch(
                    value: state.isShowerOn,
                    activeColor: Colors.white,
                    activeTrackColor: Colors.cyanAccent,
                    onChanged: (val) => setState(() => state.isShowerOn = val),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Opacity(
                opacity: state.isShowerOn ? 1.0 : 0.4,
                child: AbsorbPointer(
                  absorbing: !state.isShowerOn,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(Icons.shower, color: Colors.cyanAccent, size: 48),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('${state.waterTemperature.toStringAsFixed(1)}°C', style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                              const Text('Water Temperature', style: TextStyle(color: Colors.white60, fontSize: 10)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Flow Rate', style: TextStyle(color: Colors.white70, fontSize: 12)),
                          Text('${state.waterFlowRate.toInt()} Bar', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Slider(
                        value: state.waterFlowRate,
                        min: 1,
                        max: 5,
                        divisions: 4,
                        activeColor: Colors.cyanAccent,
                        inactiveColor: Colors.white24,
                        onChanged: (val) => setState(() => state.waterFlowRate = val),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- AC CONTROLLER WITH LIQUID-MORPHIC TEMPERATURE SEEK BAR ---
  Widget _buildAirConditionerCard() {
    final state = _currentState;
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Air Conditioner ($_selectedRoom)', style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                  Switch(
                    value: state.isAcOn,
                    activeColor: Colors.white,
                    activeTrackColor: Colors.cyanAccent,
                    onChanged: (val) => setState(() => state.isAcOn = val),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Opacity(
                opacity: state.isAcOn ? 1.0 : 0.4,
                child: AbsorbPointer(
                  absorbing: !state.isAcOn,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 110,
                                height: 110,
                                child: CircularProgressIndicator(
                                  value: (state.acTemperature - 16) / (32 - 16),
                                  strokeWidth: 8,
                                  backgroundColor: Colors.white12,
                                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.cyanAccent),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('${state.acTemperature.toInt()}°C', style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                                  const Text('Target', style: TextStyle(color: Colors.white60, fontSize: 10)),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              _buildAcModeButton('Cooling', Icons.ac_unit, state.acMode == 'Cooling', state),
                              const SizedBox(height: 8),
                              _buildAcModeButton('Heat', Icons.local_fire_department, state.acMode == 'Heat', state),
                              const SizedBox(height: 8),
                              _buildAcModeButton('Dry', Icons.water_drop, state.acMode == 'Dry', state),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Temperature Control', style: TextStyle(color: Colors.white70, fontSize: 12)),
                              Text('${state.acTemperature.toInt()}°C (16°C - 32°C)', style: const TextStyle(color: Colors.cyanAccent, fontSize: 12, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            height: 36,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              gradient: const LinearGradient(
                                colors: [Colors.blueAccent, Colors.cyanAccent, Colors.amberAccent, Colors.deepOrangeAccent],
                              ),
                              boxShadow: [
                                BoxShadow(color: Colors.cyanAccent.withOpacity(0.3), blurRadius: 10, spreadRadius: 1),
                              ],
                            ),
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                trackHeight: 36,
                                activeTrackColor: Colors.transparent,
                                inactiveTrackColor: Colors.transparent,
                                thumbColor: Colors.white,
                                thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 16, elevation: 6),
                                overlayColor: Colors.white.withOpacity(0.2),
                              ),
                              child: Slider(
                                value: state.acTemperature,
                                min: 16.0,
                                max: 32.0,
                                divisions: 16,
                                onChanged: (val) => setState(() => state.acTemperature = val),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Fan Speed', style: TextStyle(color: Colors.white70, fontSize: 12)),
                          Text('${state.fanSpeed.toInt()}', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Slider(
                        value: state.fanSpeed,
                        min: 1,
                        max: 4,
                        divisions: 3,
                        activeColor: Colors.cyanAccent,
                        inactiveColor: Colors.white24,
                        onChanged: (val) => setState(() => state.fanSpeed = val),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAcModeButton(String label, IconData icon, bool isSelected, RoomState state) {
    return GestureDetector(
      onTap: () => setState(() => state.acMode = label),
      child: Container(
        width: 80,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withOpacity(0.3) : Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isSelected ? Colors.white54 : Colors.transparent),
        ),
        child: Column(
          children: [
            Icon(icon, size: 16, color: isSelected ? Colors.cyanAccent : Colors.white70),
            const SizedBox(height: 2),
            Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.white70, fontSize: 10, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  // --- AIR PURIFIER CONTROLLER WITH AQI LIQUID METER ---
  Widget _buildAirPurifierCard() {
    final state = _currentState;
    String aqiStatus = state.aqiValue <= 50 ? 'Good' : (state.aqiValue <= 100 ? 'Moderate' : 'Polluted');
    Color aqiColor = state.aqiValue <= 50 ? Colors.greenAccent : (state.aqiValue <= 100 ? Colors.amberAccent : Colors.redAccent);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Air Purifier', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                  Switch(
                    value: state.isAirPurifierOn,
                    activeColor: Colors.white,
                    activeTrackColor: Colors.cyanAccent,
                    onChanged: (val) => setState(() => state.isAirPurifierOn = val),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Opacity(
                opacity: state.isAirPurifierOn ? 1.0 : 0.4,
                child: AbsorbPointer(
                  absorbing: !state.isAirPurifierOn,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Air Quality Index (AQI):', style: TextStyle(color: Colors.white70, fontSize: 12)),
                          Row(
                            children: [
                              Text('${state.aqiValue}', style: TextStyle(color: aqiColor, fontSize: 16, fontWeight: FontWeight.bold)),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(color: aqiColor.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                                child: Text(aqiStatus, style: TextStyle(color: aqiColor, fontSize: 10, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: aqiColor,
                          inactiveTrackColor: Colors.white24,
                          thumbColor: Colors.white,
                          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                        ),
                        child: Slider(
                          value: state.aqiValue.toDouble(),
                          min: 0,
                          max: 200,
                          onChanged: (val) => setState(() => state.aqiValue = val.toInt()),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- SONY SMART TV SECTION WITH REAL BACKGROUND PREVIEW ---
  Widget _buildSonyTvCard() {
    final state = _currentState;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
            image: state.isTvOn
                ? const DecorationImage(
              image: NetworkImage('https://images.unsplash.com/photo-1593784991095-a205069470b6?auto=format&fit=crop&w=800&q=80'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
            )
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Smart TV', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                  Switch(
                    value: state.isTvOn,
                    activeColor: Colors.white,
                    activeTrackColor: Colors.cyanAccent,
                    onChanged: (val) => setState(() => state.isTvOn = val),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Opacity(
                opacity: state.isTvOn ? 1.0 : 0.4,
                child: AbsorbPointer(
                  absorbing: !state.isTvOn,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state.isTvOn)
                        Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(color: Colors.cyanAccent.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                          child: const Text('Playing: Cinematic 4K Stream', style: TextStyle(color: Colors.cyanAccent, fontSize: 10, fontWeight: FontWeight.bold)),
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildAppShortcut('Netflix', Colors.red),
                          _buildAppShortcut('Prime', Colors.blue),
                          _buildAppShortcut('Hotstar', Colors.indigo),
                          _buildAppShortcut('Tata', Colors.purple),
                          _buildAppShortcut('Zee5', Colors.green),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(color: Colors.white24, shape: BoxShape.circle),
                            child: const Icon(Icons.add, size: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppShortcut(String name, Color color) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(name[0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
      ),
    );
  }

  // --- WINDOW CURTAINS WITH DYNAMIC VISUAL CURTAIN VIEW AS PER % ---
  Widget _buildWindowCurtainsCard() {
    final state = _currentState;
    double openRatio = state.curtainOpenPercentage / 100.0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Window Curtains', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                  Switch(
                    value: state.isCurtainsOn,
                    activeColor: Colors.white,
                    activeTrackColor: Colors.cyanAccent,
                    onChanged: (val) => setState(() => state.isCurtainsOn = val),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Opacity(
                opacity: state.isCurtainsOn ? 1.0 : 0.4,
                child: AbsorbPointer(
                  absorbing: !state.isCurtainsOn,
                  child: Column(
                    children: [
                      Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: const DecorationImage(
                            image: NetworkImage('https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=800&q=80'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          children: [
                            AnimatedAlign(
                              duration: const Duration(milliseconds: 200),
                              alignment: Alignment(-1.0 + openRatio, 0),
                              child: Container(
                                width: 120,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey.shade900.withOpacity(0.85),
                                  borderRadius: const BorderRadius.horizontal(right: Radius.circular(8)),
                                ),
                              ),
                            ),
                            AnimatedAlign(
                              duration: const Duration(milliseconds: 200),
                              alignment: Alignment(1.0 - openRatio, 0),
                              child: Container(
                                width: 120,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey.shade900.withOpacity(0.85),
                                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(8)),
                                ),
                              ),
                            ),
                            Center(
                              child: Text('Curtains: ${state.curtainOpenPercentage.toInt()}% Open', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold, shadows: [Shadow(color: Colors.black, blurRadius: 4)])),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Text('Open %', style: TextStyle(color: Colors.white70, fontSize: 11)),
                          Expanded(
                            child: Slider(
                              value: state.curtainOpenPercentage,
                              min: 0,
                              max: 100,
                              activeColor: Colors.amberAccent,
                              inactiveColor: Colors.white24,
                              onChanged: (val) => setState(() => state.curtainOpenPercentage = val),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- WEATHER SECTION UPDATED WITH DYNAMIC TEMPERATURE BASED ON CONDITION ---
  Widget _buildWeatherCard() {
    final state = _currentState;
    IconData weatherIcon = state.weatherCondition == 'Sunny' ? Icons.wb_sunny : (state.weatherCondition == 'Rainy' ? Icons.water_drop : Icons.cloud);
    Color weatherColor = state.weatherCondition == 'Sunny' ? Colors.amber : (state.weatherCondition == 'Rainy' ? Colors.blueAccent : Colors.white70);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Weather Station', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                  Switch(
                    value: state.isWeatherOn,
                    activeColor: Colors.white,
                    activeTrackColor: Colors.cyanAccent,
                    onChanged: (val) => setState(() => state.isWeatherOn = val),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Opacity(
                opacity: state.isWeatherOn ? 1.0 : 0.4,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(weatherIcon, color: weatherColor, size: 40),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('${state.weatherCondition} Day', style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                            Text('${state.weatherTemperature}°C', style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                            const Text('Temperature Outside', style: TextStyle(color: Colors.white60, fontSize: 9)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildWeatherChip('Sunny', 28),
                        _buildWeatherChip('Cloudy', 21),
                        _buildWeatherChip('Rainy', 18),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherChip(String cond, int temp) {
    final state = _currentState;
    bool isSelected = state.weatherCondition == cond;
    return GestureDetector(
      onTap: () => setState(() {
        state.weatherCondition = cond;
        state.weatherTemperature = temp;
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.cyanAccent.withOpacity(0.3) : Colors.white10,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isSelected ? Colors.cyanAccent : Colors.transparent),
        ),
        child: Text(cond, style: TextStyle(color: isSelected ? Colors.white : Colors.white60, fontSize: 10, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildBrightnessSliderCard() {
    final state = _currentState;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Global Brightness', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                  Switch(
                    value: state.isBrightnessWidgetOn,
                    activeColor: Colors.white,
                    activeTrackColor: Colors.cyanAccent,
                    onChanged: (val) => setState(() => state.isBrightnessWidgetOn = val),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Opacity(
                opacity: state.isBrightnessWidgetOn ? 1.0 : 0.4,
                child: AbsorbPointer(
                  absorbing: !state.isBrightnessWidgetOn,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Level', style: TextStyle(color: Colors.white70, fontSize: 11)),
                          Text('${state.globalBrightness.toInt()}%', style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Slider(
                        value: state.globalBrightness,
                        min: 0,
                        max: 100,
                        activeColor: Colors.white,
                        inactiveColor: Colors.white24,
                        onChanged: (val) => setState(() => state.globalBrightness = val),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInternetSpeedCard() {
    final state = _currentState;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.wifi, color: Colors.white, size: 32),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Internet speed', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                      Text(state.isInternetOn ? '76 MP/S' : 'OFFLINE', style: TextStyle(color: state.isInternetOn ? Colors.white : Colors.redAccent, fontSize: 15, fontWeight: FontWeight.bold)),
                      const Text('5 Device connected', style: TextStyle(color: Colors.white60, fontSize: 10)),
                    ],
                  ),
                ],
              ),
              Switch(
                value: state.isInternetOn,
                activeColor: Colors.white,
                activeTrackColor: Colors.cyanAccent,
                onChanged: (val) => setState(() => state.isInternetOn = val),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddWidgetButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white54, style: BorderStyle.solid),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.add, color: Colors.white, size: 18),
          SizedBox(width: 8),
          Text('Add Widget', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildAmbientLightsCard() {
    final state = _currentState;
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Ambient lights', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                  Switch(
                    value: state.isAmbientLightOn,
                    activeColor: Colors.white,
                    activeTrackColor: Colors.cyanAccent,
                    onChanged: (val) => setState(() => state.isAmbientLightOn = val),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Opacity(
                opacity: state.isAmbientLightOn ? 1.0 : 0.4,
                child: AbsorbPointer(
                  absorbing: !state.isAmbientLightOn,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Brightness', style: TextStyle(color: Colors.white70, fontSize: 12)),
                          Row(
                            children: [
                              Text('${state.brightness.toInt()}%', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                              const SizedBox(width: 4),
                              const Icon(Icons.wb_sunny, size: 14, color: Colors.amber),
                            ],
                          ),
                        ],
                      ),
                      Slider(
                        value: state.brightness,
                        min: 0,
                        max: 100,
                        activeColor: Colors.white,
                        inactiveColor: Colors.white24,
                        onChanged: (val) => setState(() => state.brightness = val),
                      ),
                      const SizedBox(height: 12),
                      _buildControlRow('Colour', state.ambientColour),
                      const SizedBox(height: 16),
                      _buildControlRow('Scene', state.ambientScene),
                      const SizedBox(height: 16),
                      _buildToggleRow('Schedule', state.isScheduleActive, (val) => setState(() => state.isScheduleActive = val)),
                      const SizedBox(height: 16),
                      _buildMusicSyncRow('Music Sync', state.isMusicSyncOn, (val) => setState(() => state.isMusicSyncOn = val)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControlRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(value, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildToggleRow(String title, bool isActive, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        GestureDetector(
          onTap: () => onChanged(!isActive),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: isActive ? Colors.white.withOpacity(0.25) : Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(isActive ? 'Setup' : 'Off', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _buildMusicSyncRow(String title, bool isActive, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        GestureDetector(
          onTap: () => onChanged(!isActive),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: isActive ? Colors.cyanAccent.withOpacity(0.3) : Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(isActive ? 'On' : 'Off', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}