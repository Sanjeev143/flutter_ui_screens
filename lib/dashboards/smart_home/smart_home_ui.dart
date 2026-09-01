import 'package:flutter/material.dart';


/// This is the first part of this tutorial ...

void main() {
  runApp(const SmartHomeApp());
}

class SmartHomeApp extends StatelessWidget {
  const SmartHomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home Control Dashboard',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),
      home: const DashboardHome(),
    );
  }
}

// --- MODELS ---
class SmartDevice {
  final String id;
  final String name;
  final String room;
  final IconData icon;
  bool isOn;
  String statusText;
  double sliderValue;

  SmartDevice({
    required this.id,
    required this.name,
    required this.room,
    required this.icon,
    required this.isOn,
    required this.statusText,
    this.sliderValue = 50.0,
  });
}

class ActivityLog {
  final String title;
  final String time;
  final IconData icon;

  ActivityLog({required this.title, required this.time, required this.icon});
}

// --- MAIN SCREEN ---
class DashboardHome extends StatefulWidget {
  const DashboardHome({super.key});

  @override
  State<DashboardHome> createState() => _DashboardHomeState();
}

class _DashboardHomeState extends State<DashboardHome> {
  int _currentIndex = 0;
  String _selectedRoom = 'All';

  // Navigation Controller state stack for sub-screens
  SmartDevice? _selectedDeviceController;
  String? _selectedRoomController;
  String? _selectedAutomationController;

  // Interactive Devices State
  final List<SmartDevice> _devices = [
    SmartDevice(
      id: '1',
      name: 'Living Room Lights',
      room: 'Living Room',
      icon: Icons.lightbulb_rounded,
      isOn: true,
      statusText: '80% Brightness',
      sliderValue: 80.0,
    ),
    SmartDevice(
      id: '2',
      name: 'Master AC',
      room: 'Bedroom',
      icon: Icons.ac_unit_rounded,
      isOn: true,
      statusText: '22°C - Cooling',
      sliderValue: 22.0,
    ),
    SmartDevice(
      id: '3',
      name: 'Smart TV',
      room: 'Living Room',
      icon: Icons.tv_rounded,
      isOn: false,
      statusText: 'Standby',
      sliderValue: 0.0,
    ),
    SmartDevice(
      id: '4',
      name: 'Front Door Lock',
      room: 'Office',
      icon: Icons.lock_rounded,
      isOn: true,
      statusText: 'Locked securely',
      sliderValue: 100.0,
    ),
    SmartDevice(
      id: '5',
      name: 'Security Camera',
      room: 'Living Room',
      icon: Icons.videocam_rounded,
      isOn: true,
      statusText: 'Live Feed Active',
      sliderValue: 100.0,
    ),
    SmartDevice(
      id: '6',
      name: 'Window Curtains',
      room: 'Bedroom',
      icon: Icons.blinds_rounded,
      isOn: false,
      statusText: 'Closed',
      sliderValue: 0.0,
    ),
    SmartDevice(
      id: '7',
      name: 'Sound System',
      room: 'Living Room',
      icon: Icons.speaker_rounded,
      isOn: false,
      statusText: 'Disconnected',
      sliderValue: 30.0,
    ),
    SmartDevice(
      id: '8',
      name: 'Coffee Maker',
      room: 'Kitchen',
      icon: Icons.coffee_rounded,
      isOn: true,
      statusText: 'Ready - Brewed',
      sliderValue: 100.0,
    ),
  ];

  final List<String> _rooms = [
    'All',
    'Living Room',
    'Bedroom',
    'Kitchen',
    'Office',
    'Bathroom',
  ];

  final List<ActivityLog> _activities = [
    ActivityLog(
      title: 'Living Room Light turned ON',
      time: '2 min ago',
      icon: Icons.lightbulb,
    ),
    ActivityLog(
      title: 'AC temperature changed to 22°C',
      time: '10 min ago',
      icon: Icons.ac_unit,
    ),
    ActivityLog(
      title: 'Front Door locked',
      time: '25 min ago',
      icon: Icons.lock,
    ),
    ActivityLog(
      title: 'Bedroom curtain closed',
      time: '1 hour ago',
      icon: Icons.blinds,
    ),
  ];

  void _activateScene(String sceneName) {
    setState(() {
      if (sceneName == 'Good Night') {
        for (var d in _devices) {
          if (d.icon != Icons.lock_rounded) {
            d.isOn = false;
            d.statusText = 'Off';
          }
        }
      } else if (sceneName == 'Movie Time') {
        for (var d in _devices) {
          if (d.name.contains('Lights')) {
            d.isOn = true;
            d.statusText = '10% Dimmed';
            d.sliderValue = 10.0;
          } else if (d.name.contains('TV') || d.name.contains('Sound')) {
            d.isOn = true;
            d.statusText = 'Active';
          } else {
            d.isOn = false;
          }
        }
      } else if (sceneName == 'Morning') {
        for (var d in _devices) {
          if (d.icon == Icons.blinds_rounded ||
              d.icon == Icons.coffee_rounded) {
            d.isOn = true;
            d.statusText = 'Active';
          }
        }
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '⚡ Scene Activated: $sceneName',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1E293B),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      body: Stack(
        children: [
          // Indoor Modern Lobby / Hall Background Image with Dark Gradient Overlay
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1618221195710-dd6b41faaea6?q=80&w=1920&auto=format&fit=crop',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF0F172A).withValues(alpha: 0.09),
                    const Color(0xFF0F172A).withValues(alpha: 0.08)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // Main Layout Content
          SafeArea(
            child: Row(
              children: [
                if (isDesktop)
                  NavigationRail(
                    backgroundColor: Colors.transparent,
                    selectedIndex: _currentIndex,
                    onDestinationSelected: (val) {
                      setState(() {
                        _currentIndex = val;
                        _selectedDeviceController = null;
                        _selectedRoomController = null;
                        _selectedAutomationController = null;
                      });
                    },
                    labelType: NavigationRailLabelType.all,
                    selectedIconTheme: const IconThemeData(
                      color: Color(0xFF818CF8),
                    ),
                    unselectedIconTheme: const IconThemeData(
                      color: Colors.white70,
                    ),
                    selectedLabelTextStyle: const TextStyle(
                      color: Color(0xFF818CF8),
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelTextStyle: const TextStyle(
                      color: Colors.white70,
                    ),
                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(Icons.home_rounded),
                        label: Text('Home'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.meeting_room_rounded),
                        label: Text('Rooms'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.devices_rounded),
                        label: Text('Devices'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.auto_awesome_rounded),
                        label: Text('Automation'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.person_rounded),
                        label: Text('Profile'),
                      ),
                    ],
                  ),
                if (isDesktop)
                  VerticalDivider(
                    thickness: 1,
                    width: 1,
                    color: Colors.white.withOpacity(0.1),
                  ),

                Expanded(
                  child: Column(
                    children: [
                      // Universal Header
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Good Morning, Aisha 👋",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "My Smart Home • 12 Connected Devices",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Stack(
                                  children: [
                                    // IconButton(
                                    //   icon: const Icon(
                                    //     Icons.notifications_outlined,
                                    //     color: Colors.white,
                                    //   ),
                                    //   onPressed: () {},
                                    // ),
                                    // Positioned(
                                    //   right: 12,
                                    //   top: 12,
                                    //   child: Container(
                                    //     width: 8,
                                    //     height: 8,
                                    //     decoration: const BoxDecoration(
                                    //       color: Colors.redAccent,
                                    //       shape: BoxShape.circle,
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                                const SizedBox(width: 8),
                                // IconButton(
                                //   icon: const Icon(
                                //     Icons.settings_outlined,
                                //     color: Colors.white,
                                //   ),
                                //   onPressed: () {},
                                // ),
                                const SizedBox(width: 12),
                                const CircleAvatar(
                                  radius: 22,
                                  backgroundImage: NetworkImage(
                                    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=100',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Dynamic Body Content or Controller Screens
                      Expanded(
                        child: KeyedSubtree(
                          key: ValueKey(
                            '$_currentIndex-${_selectedDeviceController?.id}-${_selectedRoomController ?? ''}',
                          ),
                          child: _buildActiveScreen(isDesktop),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: isDesktop
          ? null
          : NavigationBar(
              backgroundColor: const Color(0xFF0F172A).withOpacity(0.95),
              indicatorColor: const Color(0xFF6366F1),
              selectedIndex: _currentIndex,
              onDestinationSelected: (val) {
                setState(() {
                  _currentIndex = val;
                  _selectedDeviceController = null;
                  _selectedRoomController = null;
                  _selectedAutomationController = null;
                });
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined, color: Colors.white70),
                  selectedIcon: Icon(Icons.home_rounded, color: Colors.white),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.meeting_room_outlined,
                    color: Colors.white70,
                  ),
                  selectedIcon: Icon(
                    Icons.meeting_room_rounded,
                    color: Colors.white,
                  ),
                  label: 'Rooms',
                ),
                NavigationDestination(
                  icon: Icon(Icons.devices_outlined, color: Colors.white70),
                  selectedIcon: Icon(
                    Icons.devices_rounded,
                    color: Colors.white,
                  ),
                  label: 'Devices',
                ),
                NavigationDestination(
                  icon: Icon(
                    Icons.auto_awesome_outlined,
                    color: Colors.white70,
                  ),
                  selectedIcon: Icon(
                    Icons.auto_awesome_rounded,
                    color: Colors.white,
                  ),
                  label: 'Automation',
                ),
                NavigationDestination(
                  icon: Icon(Icons.person_outline, color: Colors.white70),
                  selectedIcon: Icon(Icons.person_rounded, color: Colors.white),
                  label: 'Profile',
                ),
              ],
            ),
    );
  }

  Widget _buildActiveScreen(bool isDesktop) {
    if (_selectedDeviceController != null) {
      return _buildDeviceControllerScreen(_selectedDeviceController!);
    }
    if (_selectedRoomController != null) {
      return _buildRoomControllerScreen(_selectedRoomController!, isDesktop);
    }
    if (_selectedAutomationController != null) {
      return _buildAutomationControllerScreen(_selectedAutomationController!);
    }

    switch (_currentIndex) {
      case 0:
        return _buildHomeTab(isDesktop);
      case 1:
        return _buildRoomsTab(isDesktop);
      case 2:
        return _buildDevicesTab(isDesktop);
      case 3:
        return _buildAutomationTab();
      case 4:
        return _buildProfileTab();
      default:
        return _buildHomeTab(isDesktop);
    }
  }

  // --- CONTROLLER SCREENS ---

  Widget _buildDeviceControllerScreen(SmartDevice device) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.white,
                ),
                onPressed: () =>
                    setState(() => _selectedDeviceController = null),
              ),
              const Text(
                "Back to Dashboard",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: const Color(0xFF1E293B).withOpacity(0.9),
              border: Border.all(
                color: const Color(0xFF818CF8).withOpacity(0.5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6366F1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            device.icon,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              device.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Location: ${device.room}",
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Switch.adaptive(
                      value: device.isOn,
                      activeColor: Colors.white,
                      activeTrackColor: const Color(0xFF6366F1),
                      onChanged: (val) {
                        setState(() {
                          device.isOn = val;
                          device.statusText = val ? 'Active / On' : 'Off';
                        });
                      },
                    ),
                  ],
                ),
                const Divider(height: 32, color: Colors.white24),
                const Text(
                  "Controller Adjustment",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "Intensity / Value: ${device.sliderValue.toInt()}%",
                  style: const TextStyle(color: Color(0xFFC7D2FE)),
                ),
                Slider(
                  value: device.sliderValue,
                  min: 0,
                  max: 100,
                  activeColor: const Color(0xFF6366F1),
                  inactiveColor: Colors.white24,
                  onChanged: (val) {
                    setState(() {
                      device.sliderValue = val;
                      device.statusText = '${val.toInt()}% Level Set';
                    });
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  "Quick Options",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6366F1),
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            device.isOn = true;
                            device.sliderValue = 100;
                            device.statusText = 'Maximum Output';
                          });
                        },
                        child: const Text("Max Boost"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.white30),
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            device.isOn = false;
                            device.sliderValue = 0;
                            device.statusText = 'Standby / Low';
                          });
                        },
                        child: const Text("Eco Sleep"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoomControllerScreen(String roomName, bool isDesktop) {
    final roomDevices = _devices.where((d) => d.room == roomName).toList();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.white,
                ),
                onPressed: () => setState(() => _selectedRoomController = null),
              ),
              Text(
                "Rooms / $roomName Control Center",
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            "Manage All Devices in $roomName",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isDesktop ? 3 : 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.15,
              ),
              itemCount: roomDevices.length,
              itemBuilder: (context, index) {
                final device = roomDevices[index];
                return GestureDetector(
                  onTap: () => setState(() {
                    _selectedRoomController = null;
                    _selectedDeviceController = device;
                  }),
                  child: SmartDeviceCard(
                    device: device,
                    onToggle: (val) {
                      setState(() {
                        device.isOn = val;
                        device.statusText = val ? 'Active / On' : 'Off';
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAutomationControllerScreen(String routineTitle) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.white,
                ),
                onPressed: () =>
                    setState(() => _selectedAutomationController = null),
              ),
              const Text(
                "Automation Routines",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: const Color(0xFF1E293B).withOpacity(0.9),
              border: Border.all(
                color: const Color(0xFF818CF8).withOpacity(0.5),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Routine Editor: $routineTitle",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Trigger Condition",
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Everyday at 11:00 PM",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(Icons.edit, color: Color(0xFF818CF8), size: 18),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Linked Actions",
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "• Turn off all non-secure lighting\n• Arm doors and perimeter locks\n• Set AC to 24°C sleep mode",
                    style: TextStyle(color: Colors.white70, height: 1.4),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 44),
                  ),
                  onPressed: () {
                    setState(() => _selectedAutomationController = null);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Routine settings updated successfully!"),
                      ),
                    );
                  },
                  child: const Text("Save Routine Changes"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- MAIN TABS ---

  Widget _buildHomeTab(bool isDesktop) {
    final List<SmartDevice> filteredDevices = _selectedRoom == 'All'
        ? _devices
        : _devices.where((d) => d.room == _selectedRoom).toList();

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const HomeOverviewCard(),
              const SizedBox(height: 24),
              const Text(
                "Quick Scenes",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildSceneButton('🏠 Home', () => _activateScene('Home')),
                    _buildSceneButton(
                      '🌙 Good Night',
                      () => _activateScene('Good Night'),
                    ),
                    _buildSceneButton(
                      '🎬 Movie Time',
                      () => _activateScene('Movie Time'),
                    ),
                    _buildSceneButton(
                      '☀️ Morning',
                      () => _activateScene('Morning'),
                    ),
                    _buildSceneButton(
                      '💼 Work Mode',
                      () => _activateScene('Work Mode'),
                    ),
                    _buildSceneButton(
                      '✈️ Away Mode',
                      () => _activateScene('Away Mode'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Rooms & Areas",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "$_selectedRoom — ${filteredDevices.length} Devices",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _rooms.length,
                  itemBuilder: (context, index) {
                    final String room = _rooms[index];
                    final bool isSelected = _selectedRoom == room;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: Text(room),
                        selected: isSelected,
                        selectedColor: const Color(0xFF6366F1),
                        backgroundColor: const Color(
                          0xFF1E293B,
                        ).withOpacity(0.8),
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.white70,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                        side: BorderSide(
                          color: isSelected
                              ? const Color(0xFF818CF8)
                              : Colors.white.withOpacity(0.15),
                        ),
                        onSelected: (selected) {
                          setState(() {
                            _selectedRoom = room;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isDesktop ? 4 : 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.15,
                ),
                itemCount: filteredDevices.length,
                itemBuilder: (context, index) {
                  final SmartDevice device = filteredDevices[index];
                  return GestureDetector(
                    onTap: () =>
                        setState(() => _selectedDeviceController = device),
                    child: SmartDeviceCard(
                      device: device,
                      onToggle: (val) {
                        setState(() {
                          device.isOn = val;
                          device.statusText = val ? 'Active / On' : 'Off';
                        });
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              const EnergyConsumptionCard(),
              const SizedBox(height: 24),
              const SecurityOverviewCard(),
              const SizedBox(height: 24),
              const Text(
                "Recent Activity",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xFF1E293B).withOpacity(0.7),
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _activities.length,
                  itemBuilder: (context, index) {
                    final ActivityLog act = _activities[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6366F1).withOpacity(0.3),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              act.icon,
                              size: 18,
                              color: const Color(0xFF818CF8),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  act.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  act.time,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 40),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildRoomsTab(bool isDesktop) {
    final List<String> roomList = _rooms.where((r) => r != 'All').toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView(
        children: [
          const Text(
            "Smart Rooms Management",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop ? 3 : 1,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 2.2,
            ),
            itemCount: roomList.length,
            itemBuilder: (context, index) {
              final String roomName = roomList[index];
              final int count = _devices
                  .where((d) => d.room == roomName)
                  .length;
              return GestureDetector(
                onTap: () => setState(() => _selectedRoomController = roomName),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFF1E293B).withOpacity(0.85),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            roomName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Icon(
                            Icons.meeting_room_rounded,
                            color: Color(0xFF818CF8),
                          ),
                        ],
                      ),
                      Text(
                        "$count Connected Devices",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 13,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6366F1),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 36),
                        ),
                        onPressed: () =>
                            setState(() => _selectedRoomController = roomName),
                        child: const Text("Open Room Controller"),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDevicesTab(bool isDesktop) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "All Connected Hardware",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isDesktop ? 4 : 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.15,
              ),
              itemCount: _devices.length,
              itemBuilder: (context, index) {
                final SmartDevice device = _devices[index];
                return GestureDetector(
                  onTap: () =>
                      setState(() => _selectedDeviceController = device),
                  child: SmartDeviceCard(
                    device: device,
                    onToggle: (val) {
                      setState(() {
                        device.isOn = val;
                        device.statusText = val ? 'Active / On' : 'Off';
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAutomationTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView(
        children: [
          const Text(
            "Smart Automation Routines",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: () => setState(
              () => _selectedAutomationController = "Good Night Routine",
            ),
            child: _buildAutomationRoutineRow(
              "🌙 Good Night Routine",
              "Turns off all lights and non-secure devices at 11:00 PM",
              true,
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => setState(
              () => _selectedAutomationController = "Morning Sunrise",
            ),
            child: _buildAutomationRoutineRow(
              "☀️ Morning Sunrise",
              "Opens curtains and starts coffee maker at 6:30 AM",
              true,
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => setState(
              () => _selectedAutomationController = "Cinema Movie Time",
            ),
            child: _buildAutomationRoutineRow(
              "🎬 Cinema Movie Time",
              "Dims living room lights to 10% and switches on sound system",
              false,
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () => setState(
              () => _selectedAutomationController = "Away Security Mode",
            ),
            child: _buildAutomationRoutineRow(
              "✈️ Away Security Mode",
              "Activates perimeter cameras and locks all external doors",
              true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAutomationRoutineRow(
    String title,
    String subtitle,
    bool active,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFF1E293B).withOpacity(0.85),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: active,
            activeColor: Colors.white,
            activeTrackColor: const Color(0xFF6366F1),
            onChanged: (val) {},
          ),
        ],
      ),
    );
  }

  Widget _buildProfileTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ListView(
        children: [
          const Center(
            child: CircleAvatar(
              radius: 45,
              backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200',
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Center(
            child: Text(
              "Aisha",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Center(
            child: Text(
              "amazevalley@gmail.com",
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ),
          const SizedBox(height: 24),
          _buildProfileOptionRow(
            Icons.home_work_rounded,
            "Primary Residence",
            "My Smart Home (Navi Mumbai)",
          ),
          _buildProfileOptionRow(
            Icons.devices_other_rounded,
            "Connected Hubs",
            "Matter & Zigbee Gateway v3.2",
          ),
          _buildProfileOptionRow(
            Icons.security_rounded,
            "Security Passcode",
            "•••• (Configured)",
          ),
          _buildProfileOptionRow(
            Icons.info_outline_rounded,
            "System Firmware",
            "v2.8.4-stable",
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOptionRow(IconData icon, String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFF1E293B).withOpacity(0.85),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF818CF8)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14,
            color: Colors.white54,
          ),
        ],
      ),
    );
  }

  Widget _buildSceneButton(String label, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: ActionChip(
        label: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: const Color(0xFF1E293B).withOpacity(0.8),
        side: BorderSide(color: Colors.white.withOpacity(0.15)),
        onPressed: onTap,
      ),
    );
  }
}

// --- SUB-WIDGETS ---

class HomeOverviewCard extends StatelessWidget {
  const HomeOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF4F46E5), Color(0xFF3B82F6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withOpacity(0.4),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.wb_sunny_rounded,
                    color: Colors.amberAccent,
                    size: 28,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Partly Cloudy",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  child: Text(
                    "✓ Secure",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _OverviewMetric(
                label: 'Temperature',
                value: '24°C',
                icon: Icons.thermostat,
              ),
              _OverviewMetric(
                label: 'Humidity',
                value: '56%',
                icon: Icons.water_drop,
              ),
              _OverviewMetric(
                label: 'Air Quality',
                value: 'Good',
                icon: Icons.air,
              ),
              _OverviewMetric(
                label: 'Power Usage',
                value: '4.8 kWh',
                icon: Icons.bolt,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _OverviewMetric extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _OverviewMetric({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.white70, size: 18),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 10),
        ),
      ],
    );
  }
}

class SmartDeviceCard extends StatelessWidget {
  final SmartDevice device;
  final ValueChanged<bool> onToggle;

  const SmartDeviceCard({
    super.key,
    required this.device,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: device.isOn
            ? const Color(0xFF6366F1).withOpacity(0.3)
            : const Color(0xFF1E293B).withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: device.isOn
              ? const Color(0xFF818CF8).withOpacity(0.6)
              : Colors.white.withOpacity(0.1),
          width: device.isOn ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: device.isOn
                      ? const Color(0xFF6366F1)
                      : const Color(0xFF0F172A).withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(device.icon, color: Colors.white, size: 20),
              ),
              Switch.adaptive(
                value: device.isOn,
                activeColor: Colors.white,
                activeTrackColor: const Color(0xFF6366F1),
                onChanged: onToggle,
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                device.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                device.statusText,
                style: TextStyle(
                  color: device.isOn ? const Color(0xFFC7D2FE) : Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EnergyConsumptionCard extends StatelessWidget {
  const EnergyConsumptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xFF1E293B).withOpacity(0.8),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Energy Analytics",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today's Usage",
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  Text(
                    "4.8 kWh",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "Estimated Cost",
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                  Text(
                    "₹42.50",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.greenAccent.shade400,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 100,
            width: double.infinity,
            child: CustomPaint(painter: EnergyChartPainter()),
          ),
        ],
      ),
    );
  }
}

class EnergyChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintLine = Paint()
      ..color = const Color(0xFF818CF8)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final paintFill = Paint()
      ..shader = LinearGradient(
        colors: [
          const Color(0xFF6366F1).withOpacity(0.4),
          const Color(0xFF6366F1).withOpacity(0.0),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final path = Path();
    final fillPath = Path();

    final points = [
      Offset(0, size.height * 0.7),
      Offset(size.width * 0.2, size.height * 0.4),
      Offset(size.width * 0.4, size.height * 0.6),
      Offset(size.width * 0.6, size.height * 0.2),
      Offset(size.width * 0.8, size.height * 0.5),
      Offset(size.width, size.height * 0.3),
    ];

    path.moveTo(points[0].dx, points[0].dy);
    fillPath.moveTo(0, size.height);
    fillPath.lineTo(points[0].dx, points[0].dy);

    for (int i = 0; i < points.length - 1; i++) {
      final p1 = points[i];
      final p2 = points[i + 1];
      final controlPoint = Offset((p1.dx + p2.dx) / 2, (p1.dy + p2.dy) / 2);
      path.quadraticBezierTo(p1.dx, p1.dy, controlPoint.dx, controlPoint.dy);
      fillPath.quadraticBezierTo(
        p1.dx,
        p1.dy,
        controlPoint.dx,
        controlPoint.dy,
      );
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, paintFill);
    canvas.drawPath(path, paintLine);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class SecurityOverviewCard extends StatelessWidget {
  const SecurityOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xFF1E293B).withOpacity(0.8),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Home Security Status",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.greenAccent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "✓ Home Secure",
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const _SecurityRow(
            title: 'Front Door',
            status: 'Locked',
            isOnline: true,
          ),
          Divider(height: 16, color: Colors.white.withOpacity(0.1)),
          const _SecurityRow(
            title: 'Back Door',
            status: 'Locked',
            isOnline: true,
          ),
          Divider(height: 16, color: Colors.white.withOpacity(0.1)),
          const _SecurityRow(
            title: 'Living Room Camera',
            status: 'Online',
            isOnline: true,
          ),
          Divider(height: 16, color: Colors.white.withOpacity(0.1)),
          const _SecurityRow(
            title: 'Motion Sensor',
            status: 'No Activity',
            isOnline: false,
          ),
        ],
      ),
    );
  }
}

class _SecurityRow extends StatelessWidget {
  final String title;
  final String status;
  final bool isOnline;

  const _SecurityRow({
    required this.title,
    required this.status,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13,
            color: Colors.white,
          ),
        ),
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: isOnline ? Colors.greenAccent : Colors.orangeAccent,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              status,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}



/// THANKS FOR WATCHING PLEASE DO LIKE AND SUBSCRIBE ... CODE WILL BE UPDATED
/// IN THE DESCRIPTION ...HAPPY CODING ...!!
