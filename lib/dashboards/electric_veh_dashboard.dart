import 'dart:math';
import 'package:flutter/material.dart';

class CarDashboardApp extends StatelessWidget {
  const CarDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool emergencyOn = true;
  double climateTemp = 23;
  double petrol = 65;
  double battery = 60;
  double speed = 57;

  final Color neon = const Color(0xFFB8FF00);

  @override
  Widget build(BuildContext context) {
    return Scaffold( // This was missing and causing black screen
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isWide = constraints.maxWidth > 900;
            return Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFF0A0A0A),
                border: Border.all(color: neon.withOpacity(0.3), width: 2),
                borderRadius: BorderRadius.circular(24),
              ),
              child: isWide? _buildDesktop() : _buildMobile(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDesktop() {
    return Row(
      children: [
        _sideNav(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _topBar(),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: _leftColumn()),
                    const SizedBox(width: 20),
                    Expanded(flex: 2, child: _rightColumn()),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildMobile() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(children: [
        _topBar(),
        const SizedBox(height: 16),
        _leftColumn(),
        const SizedBox(height: 16),
        _rightColumn(),
      ]),
    );
  }

  Widget _sideNav() {
    List<IconData> icons = [Icons.home, Icons.camera_alt, Icons.phone, Icons.play_circle, Icons.settings];
    return Container(
      width: 80,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Icon(Icons.shield, color: neon, size: 36),
          const SizedBox(height: 30),
          ...icons.map((e) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: CircleAvatar(
              backgroundColor: const Color(0xFF2A2A2A),
              child: Icon(e, color: Colors.white70),
            ),
          ))
        ],
      ),
    );
  }

  Widget _topBar() {
    return Row(
      children: [
        const Text("Dashboard", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(width: 16),
        Expanded(
            child: Material(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(20),
              child: const TextField(
                decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search, size: 18),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12)
                ),
              ),
            )
        ),
        const SizedBox(width: 16),
        const Icon(Icons.cloud),
        const SizedBox(width: 8),
        const Column(children: [
          Text("25°C", style: TextStyle(fontSize: 16)),
          Text("Rainy", style: TextStyle(fontSize: 10))
        ]),
        const SizedBox(width: 16),
        const CircleAvatar(child: Icon(Icons.person))
      ],
    );
  }

  Widget _leftColumn() {
    return Column(children: [
      LayoutBuilder(builder: (context, c) {
        return c.maxWidth < 500
            ? Column(children: [_mapCard(), const SizedBox(height:16), _climateCard()])
            : Row(children: [Expanded(child: _mapCard()), const SizedBox(width: 16), Expanded(child: _climateCard())]);
      }),
      const SizedBox(height: 16),
      _calendarCard(),
      const SizedBox(height: 16),
      _musicCard(),
      const SizedBox(height: 16),
      Wrap(spacing: 8, runSpacing: 8, children: [
        _controlBtn(Icons.water_drop, "Humidity"),
        _controlBtn(Icons.air, "Wind"),
        _controlBtn(Icons.bluetooth, "Bluetooth"),
        _controlBtn(Icons.message, "Message"),
        _controlBtn(Icons.event_seat, "20"),
      ])
    ]);
  }

  Widget _rightColumn() {
    return Column(children: [
      _emergencyCard(),
      const SizedBox(height: 16),
      _carView(),
      const SizedBox(height: 16),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        _iconBtn(Icons.wb_sunny, "Brightness"),
        _iconBtn(Icons.fingerprint, "Fingerprint"),
        _iconBtn(Icons.pie_chart, "Statistics"),
      ]),
      const SizedBox(height: 16),
      Wrap(alignment: WrapAlignment.center, spacing: 20, children: [
        _gauge("Petrol", petrol, Icons.local_gas_station),
        _speedo(),
        _gauge("Battery", battery, Icons.battery_charging_full),
      ])
    ]);
  }

  Widget _mapCard() => _card(child: Column(children: [
    _tile(title: "600m", subtitle: "In 500m take turning right", icon: Icons.turn_right),
    const SizedBox(height: 60, child: Center(child: Text("Map View"))),
    const Text("Club Town Gardens"),
    const Text("MM Feeder Road, Kolkata", style: TextStyle(fontSize: 12)),
    const Row(children: [Text("2 Km"), Spacer(), Text("3 min")])
  ]));

  Widget _climateCard() => _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text("Climate"),
    Text("INTERIOR: 24° C", style: TextStyle(color: Colors.grey[400], fontSize: 12)),
    const SizedBox(height: 10),
    Row(children: [
      Text("${climateTemp.round()}°C", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
      const Spacer(),
      Icon(Icons.ac_unit, color: neon)
    ]),
    const Text("WINDOW CLOSED"),
    Material(
        color: Colors.transparent,
        child: Slider(value: climateTemp, min: 10, max: 40, activeColor: neon, onChanged: (v) => setState(() => climateTemp = v))
    )
  ]));

  Widget _calendarCard() => _card(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text("My Calendar"),
    Text("5 Aug - 2022", style: TextStyle(color: Colors.grey[400], fontSize: 12)),
    const Divider(),
    const Row(children: [Text("5:00"), SizedBox(width: 10), Expanded(child: Text("Meeting with clients"))])
  ]));

  Widget _musicCard() => _card(child: Row(children: [
    Container(width: 60, height: 60, color: Colors.grey[800]),
    const SizedBox(width: 12),
    Expanded(child: Material(
      color: Colors.transparent,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text("Love me like you do"),
        const Text("Ellie Goulding", style: TextStyle(fontSize: 12)),
        Slider(value: 0.2, onChanged: (_) {}, activeColor: neon)
      ]),
    )),
    IconButton(onPressed: () {}, icon: Icon(Icons.pause_circle, color: neon))
  ]));

  Widget _emergencyCard() => _card(child: Row(children: [
    const Icon(Icons.warning, color: Colors.red),
    const SizedBox(width: 12),
    const Expanded(child: Text("Emergency")),
    Material(color: Colors.transparent, child: Switch(value: emergencyOn, activeColor: neon, onChanged: (v) => setState(() => emergencyOn = v)))
  ]));

  Widget _carView() => Container(
    height: 200,
    decoration: BoxDecoration(color: const Color(0xFF151515), borderRadius: BorderRadius.circular(16)),
    child: Center(child: Icon(Icons.directions_car, size: 100, color: Colors.grey[700])),
  );

  Widget _card({required Widget child}) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: const Color(0xFF151515), borderRadius: BorderRadius.circular(16)),
    child: child,
  );

  Widget _tile({required String title, required String subtitle, required IconData icon}) => Material(
    color: const Color(0xFF1F1F1F),
    borderRadius: BorderRadius.circular(12),
    child: ListTile(leading: Icon(icon, color: neon), title: Text(title), subtitle: Text(subtitle)),
  );

  Widget _controlBtn(IconData icon, String label) => Container(
    width: 90, padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(color: const Color(0xFF151515), borderRadius: BorderRadius.circular(12)),
    child: Column(children: [Icon(icon), const SizedBox(height: 4), Text(label, style: const TextStyle(fontSize: 12))]),
  );

  Widget _iconBtn(IconData icon, String label) => Column(children: [
    CircleAvatar(backgroundColor: const Color(0xFF2A2A2A), child: Icon(icon)),
    const SizedBox(height: 4),
    Text(label, style: const TextStyle(fontSize: 12))
  ]);

  Widget _gauge(String label, double value, IconData icon) => Column(children: [
    SizedBox(width: 80, height: 50, child: CustomPaint(painter: GaugePainter(value, neon))),
    Icon(icon, size: 18),
    Text(label, style: const TextStyle(fontSize: 12)),
    Text("${value.round()}%")
  ]);

  Widget _speedo() => SizedBox(
    width: 180, height: 180,
    child: CustomPaint(
      painter: SpeedoPainter(speed, neon),
      child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("${speed.round()}", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        const Text("Km/h")
      ])),
    ),
  );
}

class GaugePainter extends CustomPainter {
  final double value; final Color color;
  GaugePainter(this.value, this.color);
  @override
  void paint(Canvas canvas, Size size) {
    Paint bg = Paint()..color = Colors.grey[800]!..strokeWidth = 8..style = PaintingStyle.stroke;
    Paint fg = Paint()..color = color..strokeWidth = 8..style = PaintingStyle.stroke..strokeCap = StrokeCap.round;
    canvas.drawArc(Rect.fromLTWH(0, 0, size.width, size.width), pi, pi, false, bg);
    canvas.drawArc(Rect.fromLTWH(0, 0, size.width, size.width), pi, pi * value / 100, false, fg);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class SpeedoPainter extends CustomPainter {
  final double speed; final Color color;
  SpeedoPainter(this.speed, this.color);
  @override
  void paint(Canvas canvas, Size size) {
    Paint bg = Paint()..color = Colors.grey[800]!..strokeWidth = 10..style = PaintingStyle.stroke;
    Paint fg = Paint()..color = color..strokeWidth = 10..style = PaintingStyle.stroke..strokeCap = StrokeCap.round;
    canvas.drawArc(Rect.fromLTWH(10, 10, size.width - 20, size.width - 20), 0.75 * pi, 1.5 * pi, false, bg);
    canvas.drawArc(Rect.fromLTWH(10, 10, size.width - 20, size.width - 20), 0.75 * pi, 1.5 * pi * speed / 180, false, fg);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}