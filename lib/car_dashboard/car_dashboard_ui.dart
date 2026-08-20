import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;

void main() {
  runApp(const CarDashboardApp());
}

class CarDashboardApp extends StatelessWidget {
  const CarDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modern Car Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'sans-serif',
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),
      home: const CarDashboardScreen(),
    );
  }
}

class CarDashboardScreen extends StatefulWidget {
  const CarDashboardScreen({super.key});

  @override
  State<CarDashboardScreen> createState() => _CarDashboardScreenState();
}

class _CarDashboardScreenState extends State<CarDashboardScreen>
    with TickerProviderStateMixin {
  // Functional State variables
  bool _isAcOn = true;
  double _temperature = 25.2;
  String _selectedGear = 'D';
  bool _isHeadlightsOn = true;
  bool _isMusicPlaying = true;
  double _musicVolume = 0.6;
  bool _isEngineStarted = true;
  int _selectedSidebarIndex = 0;
  bool _isVoiceActive = false;

  late final AnimationController _carRotateController;
  late final AnimationController _enginePulseController;

  @override
  void initState() {
    super.initState();
    _carRotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    _enginePulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _carRotateController.dispose();
    _enginePulseController.dispose();
    super.dispose();
  }

  // Opens a custom interactive popup dialog corresponding to the menu clicked
  void _showMenuPopup(String title, Widget content) {
    showDialog(
      context: context,
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: AlertDialog(
          backgroundColor: const Color(0xFF1E293B).withOpacity(0.9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(color: Colors.white.withOpacity(0.15)),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.white70, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          content: SizedBox(
            width: 400,
            child: content,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0B132B), Color(0xFF1C2541), Color(0xFF0B132B)],
          ),
        ),
        child: SafeArea(
          child: Row(
            children: [
              // Left Vertical Navigation Sidebar
              _buildSidebar(),

              // Main Dashboard Content Grid with 2 | 4 | 2 Split Ratio
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      // Top Bar: Time, Voice Command & User Profile
                      _buildTopBar(),
                      const SizedBox(height: 16),

                      // Grid Body Content (2 | 4 | 2 Ratio)
                      Expanded(
                        child: Row(
                          children: [
                            // Column 1 (Left - Flex 2)
                            Expanded(flex: 2, child: _buildVehicleColumn()),
                            const SizedBox(width: 16),

                            // Column 2 (Middle - Flex 4)
                            Expanded(flex: 4, child: _buildWidgetsColumn()),
                            const SizedBox(width: 16),

                            // Column 3 (Right - Flex 2)
                            Expanded(flex: 2, child: _buildControlsAndMapColumn()),
                          ],
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

  // Vertical Left Sidebar
  Widget _buildSidebar() {
    final icons = [
      Icons.grid_view_rounded,
      Icons.speed,
      Icons.filter_alt_outlined,
      Icons.access_time_rounded,
      Icons.wb_sunny_outlined,
      Icons.menu_rounded,
      Icons.power_settings_new,
    ];

    return Container(
      width: 75,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        border: const Border(right: BorderSide(color: Colors.white10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Rotating Black Car Object Icon
          AnimatedBuilder(
            animation: _carRotateController,
            builder: (context, child) {
              return Transform.rotate(
                angle: _carRotateController.value * 2 * math.pi,
                child: CustomPaint(
                  size: const Size(32, 32),
                  painter: BlackCarShapePainter(),
                ),
              );
            },
          ),
          ...List.generate(icons.length, (index) {
            final isActive = _selectedSidebarIndex == index;
            return GestureDetector(
              onTap: () {
                setState(() => _selectedSidebarIndex = index);
                if (index == 0) {
                  _showMenuPopup('Dashboard Layout Configurator', Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Customize your instrument cluster widgets and telemetry themes.', style: TextStyle(color: Colors.white70, fontSize: 13)),
                      const SizedBox(height: 16),
                      SwitchListTile(title: const Text('Performance HUD'), value: true, onChanged: (v) {}),
                      SwitchListTile(title: const Text('Eco Leaf Indicator'), value: false, onChanged: (v) {}),
                    ],
                  ));
                } else if (index == 1) {
                  _showMenuPopup('Performance Telemetry', Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const LinearProgressIndicator(value: 0.82, color: Color(0xFF38BDF8)),
                      const SizedBox(height: 12),
                      const Text('G-Force Peak: 1.24 G\nTorque Vectoring: Active\nMotor Temperature: 78°C', style: TextStyle(color: Colors.white70, height: 1.5)),
                    ],
                  ));
                } else if (index == 2) {
                  _showMenuPopup('Aerodynamic Active Filters', Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Adjust active grill shutters and spoiler angle downforce.', style: TextStyle(color: Colors.white70)),
                      const SizedBox(height: 16),
                      Slider(value: 0.7, onChanged: (v) {}),
                      const Text('Downforce Level: 70%', style: TextStyle(color: Color(0xFF38BDF8))),
                    ],
                  ));
                } else if (index == 3) {
                  _showMenuPopup('Trip Logs & Chronometer', Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      ListTile(leading: Icon(Icons.timer), title: Text('Lap 1: 01:14.82')),
                      ListTile(leading: Icon(Icons.timer), title: Text('Lap 2: 01:12.45 (Fastest)')),
                    ],
                  ));
                } else if (index == 4) {
                  _showMenuPopup('Ambient Atmosphere & Lighting', Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Cabin LED Color Spectrum', style: TextStyle(color: Colors.white70)),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(backgroundColor: Colors.cyan, radius: 16),
                          CircleAvatar(backgroundColor: Colors.purple, radius: 16),
                          CircleAvatar(backgroundColor: Colors.amber, radius: 16),
                          CircleAvatar(backgroundColor: Colors.green, radius: 16),
                        ],
                      ),
                    ],
                  ));
                } else if (index == 5) {
                  _showMenuPopup('Onboard Settings Menu', Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      ListTile(leading: Icon(Icons.wifi), title: Text('Wi-Fi & LTE Hotspot')),
                      ListTile(leading: Icon(Icons.bluetooth), title: Text('Bluetooth Devices')),
                      ListTile(leading: Icon(Icons.security), title: Text('Driver Assistance Settings')),
                    ],
                  ));
                } else if (index == 6) {
                  setState(() => _isEngineStarted = !_isEngineStarted);
                  _showMenuPopup('Powertrain Power State', Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(_isEngineStarted ? Icons.power : Icons.power_off, size: 48, color: _isEngineStarted ? Colors.green : Colors.red),
                      const SizedBox(height: 12),
                      Text(_isEngineStarted ? 'Vehicle High-Voltage System Active' : 'Vehicle Shut Down Safely', style: const TextStyle(color: Colors.white70)),
                    ],
                  ));
                }
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isActive ? Colors.white.withOpacity(0.12) : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icons[index], color: isActive ? Colors.white : Colors.white54, size: 22),
              ),
            );
          }),
        ],
      ),
    );
  }

  // Top Bar Widget
  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: const [
            Text('17:45', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
            SizedBox(width: 4),
            Text('pm', style: TextStyle(fontSize: 14, color: Colors.white60)),
            SizedBox(width: 16),
            Text('Sunday | 24 May 2023', style: TextStyle(fontSize: 13, color: Colors.white60)),
          ],
        ),
        // Functional Voice Command Bar
        GestureDetector(
          onTap: () {
            setState(() => _isVoiceActive = !_isVoiceActive);
            _showMenuPopup('Neural Voice Assistant', Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.mic, size: 48, color: Color(0xFF38BDF8)),
                const SizedBox(height: 12),
                const Text('"Navigate to nearest supercharger"', style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white70)),
                const SizedBox(height: 16),
                LinearProgressIndicator(backgroundColor: Colors.white12, color: const Color(0xFF38BDF8)),
              ],
            ));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: _isVoiceActive ? const Color(0xFF38BDF8).withOpacity(0.2) : Colors.white.withOpacity(0.07),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: _isVoiceActive ? const Color(0xFF38BDF8) : Colors.white12),
            ),
            child: Row(
              children: [
                Icon(Icons.mic_none, size: 18, color: _isVoiceActive ? const Color(0xFF38BDF8) : Colors.white70),
                const SizedBox(width: 8),
                Text(_isVoiceActive ? 'Listening...' : 'Give a Voice Command', style: TextStyle(fontSize: 13, color: _isVoiceActive ? const Color(0xFF38BDF8) : Colors.white70)),
              ],
            ),
          ),
        ),
        // Utilities & Profile
        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() => _isHeadlightsOn = !_isHeadlightsOn);
              },
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: _isHeadlightsOn ? Colors.white24 : Colors.transparent,
                      child: Icon(Icons.nightlight_round, size: 14, color: _isHeadlightsOn ? Colors.white : Colors.white38),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.wb_sunny, size: 16, color: !_isHeadlightsOn ? Colors.white : Colors.white38),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () => _showMenuPopup('System Notification Center', Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  ListTile(leading: Icon(Icons.info_outline), title: Text('Software Update v14.2 Ready')),
                  ListTile(leading: Icon(Icons.warning_amber), title: Text('Tire pressure optimal across all wheels')),
                ],
              )),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.08), shape: BoxShape.circle),
                child: const Icon(Icons.notifications_none, size: 18, color: Colors.white70),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () => _showMenuPopup('Driver Profile Management', Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CircleAvatar(radius: 30, backgroundImage: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80')),
                  SizedBox(height: 12),
                  Text('Alex Rivera (Primary Driver)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                  Text('Seat Memory Position #1 Loaded', style: TextStyle(fontSize: 12, color: Colors.white60)),
                ],
              )),
              child: const CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage('https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Column 1: Vehicle Status & Speedometer Gauge
  Widget _buildVehicleColumn() {
    return _glassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Animated Vector Object representing Car Chassis
          SizedBox(
            height: 90,
            width: double.infinity,
            child: AnimatedBuilder(
              animation: _enginePulseController,
              builder: (context, child) {
                return CustomPaint(
                  painter: InteractiveCarChassisPainter(pulseValue: _enginePulseController.value, isRunning: _isEngineStarted),
                );
              },
            ),
          ),
          const Text('BMW Model N5', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          Text(_isEngineStarted ? '2020 Release • Engine Active' : 'Engine Standby', style: TextStyle(fontSize: 9, color: _isEngineStarted ? const Color(0xFF10B981) : Colors.amber)),
          const SizedBox(height: 6),

          // Speedometer Arc Display
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 85,
                child: CustomPaint(
                  painter: SpeedometerArcPainter(progress: _isEngineStarted ? 0.65 : 0.0),
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 10),
                  Text(_isEngineStarted ? '64%' : '0%', style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white)),
                  const Text('km/h', style: TextStyle(fontSize: 10, color: Color(0xFF38BDF8))),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Trip stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text('240 km', style: TextStyle(fontSize: 11, color: Colors.white70)),
              Text('128 Km/Wh', style: TextStyle(fontSize: 11, color: Colors.white70)),
              Text('21.8 km', style: TextStyle(fontSize: 11, color: Colors.white70)),
            ],
          ),
          const SizedBox(height: 10),

          // Battery & Tire Status Grid with interactive popups
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 2.1,
            children: [
              GestureDetector(
                onTap: () => _showMenuPopup('High-Voltage Battery Diagnostics', Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    LinearProgressIndicator(value: 0.98, color: Colors.amber),
                    SizedBox(height: 12),
                    Text('Capacity: 100 kWh\nCell Health: 99.4%\nEstimated Range: 430 miles', style: TextStyle(color: Colors.white70, height: 1.5)),
                  ],
                )),
                child: _statusMiniCard('Good', 'Battery', Icons.bolt, Colors.amber),
              ),
              GestureDetector(
                onTap: () => _showMenuPopup('Tire Pressure Monitoring System (TPMS)', Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('Front Left: 35 psi | Front Right: 35 psi\nRear Left: 34 psi | Rear Right: 35 psi\nStatus: All pressures balanced.', style: TextStyle(color: Colors.white70, height: 1.5)),
                  ],
                )),
                child: _statusMiniCard('95%', 'Pressure', Icons.speed, Colors.purpleAccent),
              ),
              GestureDetector(
                onTap: () => _showMenuPopup('Powertrain Component Lifespan', Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('Inverter efficiency: 98.2%\nGearbox wear: Minimal\nNext scheduled service: 15,000 mi', style: TextStyle(color: Colors.white70, height: 1.5)),
                  ],
                )),
                child: _statusMiniCard('332', 'Lifetime', Icons.settings_outlined, Colors.cyan),
              ),
              GestureDetector(
                onTap: () => _showMenuPopup('Thermal Management', Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('Coolant Temp: 85°C\nAmbient Temp: 22°C\nHeat pump status: Nominal', style: TextStyle(color: Colors.white70, height: 1.5)),
                  ],
                )),
                child: _statusMiniCard('35psi', 'Temp', Icons.thermostat, Colors.green),
              ),
            ],
          ),
          const Spacer(),

          // Gear Selector
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: ['R', 'P', 'N', 'D', 'S'].map((gear) {
                final isSelected = _selectedGear == gear;
                return GestureDetector(
                  onTap: () => setState(() => _selectedGear = gear),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF38BDF8) : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      gear,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: isSelected ? Colors.black : Colors.white70,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusMiniCard(String val, String title, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, size: 12, color: color),
              const SizedBox(width: 4),
              Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white)),
            ],
          ),
          const SizedBox(height: 2),
          Text(title, style: const TextStyle(fontSize: 9, color: Colors.white54)),
        ],
      ),
    );
  }

  // Column 2: Media, Weather, Camera & App Grid
  Widget _buildWidgetsColumn() {
    return Column(
      children: [
        // Media Player Card
        GestureDetector(
          onTap: () => _showMenuPopup('Now Playing - Audio Equalizer', Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Track: I wanna Be Yours\nArtist: Arctic Monkeys', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Slider(value: _musicVolume, onChanged: (v) => setState(() => _musicVolume = v)),
              const Text('Surround Sound: Dolby Atmos Active', style: TextStyle(color: Colors.white60, fontSize: 12)),
            ],
          )),
          child: _glassCard(
            padding: 14,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=200&q=80',
                    width: 55,
                    height: 55,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('I wanna Be Yours', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      const Text('Arctic Monkey', style: TextStyle(fontSize: 12, color: Colors.white60)),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(value: 0.6, backgroundColor: Colors.white12, color: Colors.white),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () => setState(() => _isMusicPlaying = !_isMusicPlaying),
                  child: Icon(_isMusicPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill, color: Colors.white, size: 32),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Weather Report Card
        GestureDetector(
          onTap: () => _showMenuPopup('Detailed Meteorological Forecast', Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text('Condition: Light Snow Flurries\nVisibility: 8 miles\nBarometric Pressure: 1013 hPa\nWind Direction: NW at 26 km/h', style: TextStyle(color: Colors.white70, height: 1.5)),
            ],
          )),
          child: _glassCard(
            padding: 14,
            child: Row(
              children: [
                const Icon(Icons.cloudy_snowing, color: Colors.blueAccent, size: 36),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Todays Weather Report', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('💨 26 km/h', style: TextStyle(fontSize: 11, color: Colors.white60)),
                          Text('☁️ 83%', style: TextStyle(fontSize: 11, color: Colors.white60)),
                          Text('⚙️ 2 of 10', style: TextStyle(fontSize: 11, color: Colors.white60)),
                          Text('⚙️ 2 of 15', style: TextStyle(fontSize: 11, color: Colors.white60)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Rear View Camera Preview Card
        Expanded(
          child: GestureDetector(
            onTap: () => _showMenuPopup('Surround View 360° Camera Feed', Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: NetworkImage('https://images.unsplash.com/photo-1508974239320-0a029497e820?auto=format&fit=crop&w=600&q=80'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                const Text('Sonar sensors active: Clear distance behind vehicle (2.4m)', style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            )),
            child: _glassCard(
              padding: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Rear View Camera', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      Icon(Icons.camera_alt_outlined, size: 16, color: Colors.white60),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1508974239320-0a029497e820?auto=format&fit=crop&w=600&q=80',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Quick App Grid Menu
        _glassCard(
          padding: 12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _quickAppIcon(Icons.dashboard, 'Dashboard'),
              _quickAppIcon(Icons.headphones, 'Media'),
              _quickAppIcon(Icons.radar, 'Radar'),
              _quickAppIcon(Icons.speaker, 'Audio'),
              _quickAppIcon(Icons.memory, 'Diagnostics'),
              _quickAppIcon(Icons.movie_outlined, 'Media Player'),
              _quickAppIcon(Icons.alt_route, 'Navigation'),
              _quickAppIcon(Icons.access_alarm, 'Timer'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _quickAppIcon(IconData icon, String name) {
    return GestureDetector(
      onTap: () => _showMenuPopup('$name Hub', Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48, color: const Color(0xFF38BDF8)),
          const SizedBox(height: 12),
          Text('Welcome to the $name control center. All subroutines operating normally.', style: const TextStyle(color: Colors.white70, fontSize: 13), textAlign: TextAlign.center),
        ],
      )),
      child: Icon(icon, size: 22, color: Colors.white70),
    );
  }

  // Column 3: Air Conditioning & Live Location Map
  Widget _buildControlsAndMapColumn() {
    return Column(
      children: [
        // Air Conditioning Control Card
        _glassCard(
          padding: 14,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Air Condition', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  Switch(
                    value: _isAcOn,
                    activeColor: const Color(0xFF38BDF8),
                    onChanged: (val) => setState(() => _isAcOn = val),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Center(
                child: GestureDetector(
                  onTap: () => _showMenuPopup('Climate Zone Manager', Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Target Temperature Settings', style: TextStyle(color: Colors.white70)),
                      const SizedBox(height: 12),
                      Slider(value: _temperature, min: 16, max: 32, divisions: 32, label: '$_temperature°C', onChanged: (v) => setState(() => _temperature = v)),
                      Text('Current: ${_temperature.toStringAsFixed(1)}°C', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  )),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: CircularProgressIndicator(
                          value: _temperature / 35.0,
                          backgroundColor: Colors.white12,
                          color: const Color(0xFF38BDF8),
                          strokeWidth: 5,
                        ),
                      ),
                      Text('${_temperature.toStringAsFixed(1)}°C', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Icon(Icons.air, size: 16, color: Color(0xFF38BDF8)),
                  Icon(Icons.airline_seat_legroom_normal, size: 16, color: Colors.white54),
                  Icon(Icons.airline_seat_individual_suite, size: 16, color: Colors.white54),
                  Icon(Icons.ac_unit, size: 16, color: Colors.white54),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        // Live Location Map View Card
        // Live Location Map View Card
        Expanded(
          child: GestureDetector(
            onTap: () => _showMenuPopup('GPS Satellite Navigation Map', Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Destination: Downtown Financial District\nETA: 14 mins (6.2 miles)\nTraffic: Flowing smoothly',
                  style: TextStyle(color: Colors.white70, height: 1.5),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF38BDF8),
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Reroute via Highway'),
                ),
              ],
            )),
            child: _glassCard(
              padding: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Live Location', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      Icon(Icons.navigation_outlined, size: 16, color: Colors.white60),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        color: const Color(0xFF1E293B),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomPaint(
                              size: const Size(double.infinity, double.infinity),
                              painter: MapGridPainter(),
                            ),
                            const Icon(Icons.location_on, color: Color(0xFF38BDF8), size: 36),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _glassCard({required Widget child, double padding = 16}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: EdgeInsets.all(padding),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.12), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

// Custom Painter for Interactive Car Chassis Object in Left Section
class InteractiveCarChassisPainter extends CustomPainter {
  final double pulseValue;
  final bool isRunning;

  InteractiveCarChassisPainter({required this.pulseValue, required this.isRunning});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);

    if (isRunning) {
      final glowPaint = Paint()
        ..color = const Color(0xFF38BDF8).withOpacity(0.2 + (0.2 * pulseValue))
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
      canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: center, width: 90, height: 45), const Radius.circular(12)), glowPaint);
    }

    final bodyPaint = Paint()
      ..color = const Color(0xFF1E293B)
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = isRunning ? const Color(0xFF38BDF8) : Colors.white30
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final rect = Rect.fromCenter(center: center, width: 84, height: 38);
    final rRect = RRect.fromRectAndRadius(rect, const Radius.circular(10));
    canvas.drawRRect(rRect, bodyPaint);
    canvas.drawRRect(rRect, borderPaint);

    final headLightPaint = Paint()..color = isRunning ? Colors.cyanAccent : Colors.grey;
    final tailLightPaint = Paint()..color = Colors.redAccent;

    canvas.drawCircle(Offset(center.dx + 38, center.dy - 10), 3, headLightPaint);
    canvas.drawCircle(Offset(center.dx + 38, center.dy + 10), 3, headLightPaint);
    canvas.drawCircle(Offset(center.dx - 38, center.dy - 10), 2.5, tailLightPaint);
    canvas.drawCircle(Offset(center.dx - 38, center.dy + 10), 2.5, tailLightPaint);
  }

  @override
  bool shouldRepaint(covariant InteractiveCarChassisPainter oldDelegate) {
    return oldDelegate.pulseValue != pulseValue || oldDelegate.isRunning != isRunning;
  }
}

// Custom Painter for Animated Rotating Black Car Shape
class BlackCarShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = const Color(0xFF38BDF8).withOpacity(0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path = Path();
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: 18, height: 28),
      const Radius.circular(6),
    ));

    canvas.drawPath(path, paint);
    canvas.drawPath(path, borderPaint);

    final glassPaint = Paint()..color = const Color(0xFF38BDF8).withOpacity(0.4);
    canvas.drawRect(Rect.fromCenter(center: Offset(size.width / 2, size.height / 2 - 2), width: 12, height: 8), glassPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom Painter for Speedometer Arc
class SpeedometerArcPainter extends CustomPainter {
  final double progress;
  SpeedometerArcPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCircle(center: Offset(size.width / 2, size.height), radius: 70);
    final paint = Paint()
      ..color = Colors.white12
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, math.pi, math.pi, false, paint);

    final progressPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFF10B981), Color(0xFFFFB800), Color(0xFF38BDF8)],
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, math.pi, math.pi * progress, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant SpeedometerArcPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}

// Custom Painter for Map Grid background simulation
class MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..strokeWidth = 1;

    for (double i = 0; i < size.width; i += 30) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    }
    for (double i = 0; i < size.height; i += 30) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}