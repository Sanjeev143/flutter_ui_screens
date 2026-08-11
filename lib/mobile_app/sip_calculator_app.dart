import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() {
  runApp(const SipCalculatorApp());
}

class SipCalculatorApp extends StatelessWidget {
  const SipCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SIP Calculator',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5B5FEF),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F6FA),
      ),
      home: const SipCalculatorPage(),
    );
  }
}

class SipCalculatorPage extends StatefulWidget {
  const SipCalculatorPage({super.key});

  @override
  State<SipCalculatorPage> createState() => _SipCalculatorPageState();
}

class _SipCalculatorPageState extends State<SipCalculatorPage> {
  // ------------------------------------------------------------
  // Controllers
  // ------------------------------------------------------------

  final TextEditingController sipController =
  TextEditingController(text: '10000');

  final TextEditingController lumpsumController =
  TextEditingController(text: '0');

  final TextEditingController interestController =
  TextEditingController(text: '12');

  final TextEditingController topupController =
  TextEditingController(text: '10');

  final TextEditingController tenureController =
  TextEditingController(text: '10');

  // ------------------------------------------------------------
  // Values
  // ------------------------------------------------------------

  double sip = 10000;
  double lumpsum = 100000;
  double interest = 12;
  double topup = 10;
  double tenure = 10;

  double investedAmount = 0;
  double estimatedReturns = 0;
  double totalValue = 0;

  @override
  void initState() {
    super.initState();
    calculateSIP();
  }

  @override
  void dispose() {
    sipController.dispose();
    lumpsumController.dispose();
    interestController.dispose();
    topupController.dispose();
    tenureController.dispose();
    super.dispose();
  }

  // ------------------------------------------------------------
  // Format Currency
  // ------------------------------------------------------------

  String formatCurrency(double value) {
    if (value.isNaN || value.isInfinite) {
      return '₹0';
    }

    if (value >= 10000000) {
      return '₹${(value / 10000000).toStringAsFixed(2)} Cr';
    }

    if (value >= 100000) {
      return '₹${(value / 100000).toStringAsFixed(2)} L';
    }

    if (value >= 1000) {
      return '₹${(value / 1000).toStringAsFixed(1)} K';
    }

    return '₹${value.toStringAsFixed(0)}';
  }

  String formatFullCurrency(double value) {
    final rounded = value.round().toString();

    String result = '';
    int count = 0;

    for (int i = rounded.length - 1; i >= 0; i--) {
      result = rounded[i] + result;
      count++;

      if (count == 3 && i != 0) {
        result = ',$result';
        count = 0;
      }
    }

    return '₹$result';
  }

  // ------------------------------------------------------------
  // SIP Calculation
  // ------------------------------------------------------------

  void calculateSIP() {
    final monthlyRate = interest / 100 / 12;
    final totalMonths = tenure.round() * 12;

    double totalInvested = lumpsum;
    double futureValue = lumpsum;

    double currentSip = sip;

    for (int month = 1; month <= totalMonths; month++) {
      // Monthly SIP is invested at the end of each month.
      futureValue += currentSip;

      // Apply monthly return after the SIP investment.
      futureValue *= (1 + monthlyRate);

      totalInvested += currentSip;

      // Increase SIP after every 12 months.
      if (month % 12 == 0 && month < totalMonths) {
        currentSip *= (1 + topup / 100);
      }
    }

    // Remove one month's interest from the final SIP
    // because the last SIP is invested at the end of the month.
    if (totalMonths > 0 && monthlyRate > 0) {
      futureValue = futureValue / (1 + monthlyRate);
    }

    setState(() {
      investedAmount = totalInvested;
      totalValue = futureValue;
      estimatedReturns = totalValue - investedAmount;
    });
  }

  // ------------------------------------------------------------
  // Input Validation
  // ------------------------------------------------------------

  double clampValue(
      double value,
      double min,
      double max,
      ) {
    return value.clamp(min, max).toDouble();
  }

  void updateFromController(
      TextEditingController controller,
      double min,
      double max,
      Function(double) onChanged,
      ) {
    final value = double.tryParse(
      controller.text.replaceAll(',', ''),
    );

    if (value == null) return;

    final finalValue = clampValue(value, min, max);

    onChanged(finalValue);
    calculateSIP();
  }

  // ------------------------------------------------------------
  // Build
  // ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 1200,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        buildHeader(),
                        const SizedBox(height: 24),

                        if (constraints.maxWidth > 850)
                          buildDesktopLayout()
                        else
                          buildMobileLayout(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // Header
  // ------------------------------------------------------------

  Widget buildHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF5B5FEF),
            Color(0xFF7B61FF),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.18),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.trending_up_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  'SIP Calculator',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Plan your investments and estimate future wealth',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // Desktop Layout
  // ------------------------------------------------------------

  Widget buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: buildInputCard(),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 5,
          child: buildResultSection(),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // Mobile Layout
  // ------------------------------------------------------------

  Widget buildMobileLayout() {
    return Column(
      children: [
        buildInputCard(),
        const SizedBox(height: 20),
        buildResultSection(),
      ],
    );
  }

  // ------------------------------------------------------------
  // Input Card
  // ------------------------------------------------------------

  Widget buildInputCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          const Text(
            'Investment Details',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),

          buildInputSlider(
            title: 'Monthly SIP',
            controller: sipController,
            value: sip,
            min: 100,
            max: 1000000,
            divisions: 9999,
            prefix: '₹',
            onChanged: (value) {
              setState(() {
                sip = value;
                sipController.text =
                    value.round().toString();
              });
              calculateSIP();
            },
          ),

          buildInputSlider(
            title: 'Lumpsum Investment',
            controller: lumpsumController,
            value: lumpsum,
            min: 0,
            max: 100000000,
            divisions: 9999,
            prefix: '₹',
            onChanged: (value) {
              setState(() {
                lumpsum = value;
                lumpsumController.text =
                    value.round().toString();
              });
              calculateSIP();
            },
          ),

          buildInputSlider(
            title: 'Expected Return',
            controller: interestController,
            value: interest,
            min: 1,
            max: 40,
            divisions: 39,
            suffix: '%',
            onChanged: (value) {
              setState(() {
                interest = value;
                interestController.text =
                    value.toStringAsFixed(1);
              });
              calculateSIP();
            },
          ),

          buildInputSlider(
            title: 'Annual SIP Top-up',
            controller: topupController,
            value: topup,
            min: 1,
            max: 20,
            divisions: 19,
            suffix: '%',
            onChanged: (value) {
              setState(() {
                topup = value;
                topupController.text =
                    value.toStringAsFixed(1);
              });
              calculateSIP();
            },
          ),

          buildInputSlider(
            title: 'Investment Tenure',
            controller: tenureController,
            value: tenure,
            min: 1,
            max: 60,
            divisions: 59,
            suffix: ' Years',
            onChanged: (value) {
              setState(() {
                tenure = value;
                tenureController.text =
                    value.round().toString();
              });
              calculateSIP();
            },
          ),

          const SizedBox(height: 10),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: calculateSIP,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                const Color(0xFF5B5FEF),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Calculate SIP',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // Input Slider
  // ------------------------------------------------------------

  Widget buildInputSlider({
    required String title,
    required TextEditingController controller,
    required double value,
    required double min,
    required double max,
    required int divisions,
    String? prefix,
    String? suffix,
    required Function(double) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                width: 150,
                height: 42,
                child: TextField(
                  controller: controller,
                  keyboardType:
                  const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    prefixText: prefix,
                    suffixText: suffix,
                    contentPadding:
                    const EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    filled: true,
                    fillColor:
                    const Color(0xFFF5F6FA),
                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onSubmitted: (_) {
                    updateFromController(
                      controller,
                      min,
                      max,
                      onChanged,
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor:
              const Color(0xFF5B5FEF),
              inactiveTrackColor:
              const Color(0xFFE5E7F0),
              thumbColor:
              const Color(0xFF5B5FEF),
              overlayColor:
              const Color(0xFF5B5FEF)
                  .withOpacity(.12),
              trackHeight: 5,
            ),
            child: Slider(
              value: value.clamp(min, max),
              min: min,
              max: max,
              divisions: divisions,
              onChanged: onChanged,
            ),
          ),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Text(
                prefix != null
                    ? '$prefix${min.toStringAsFixed(0)}'
                    : suffix != null
                    ? '${min.toStringAsFixed(0)}$suffix'
                    : min.toStringAsFixed(0),
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
              Text(
                prefix != null
                    ? '$prefix${max.toStringAsFixed(0)}'
                    : suffix != null
                    ? '${max.toStringAsFixed(0)}$suffix'
                    : max.toStringAsFixed(0),
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // Results
  // ------------------------------------------------------------

  Widget buildResultSection() {
    return Column(
      children: [
        buildTotalValueCard(),
        const SizedBox(height: 16),
        buildBreakdownCard(),
        const SizedBox(height: 16),
        buildChartCard(),
      ],
    );
  }

  // ------------------------------------------------------------
  // Total Value
  // ------------------------------------------------------------

  Widget buildTotalValueCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF15172B),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          const Text(
            'Estimated Total Value',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            formatCurrency(totalValue),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 38,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              '$interest% expected return • $tenure years',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // Breakdown
  // ------------------------------------------------------------

  Widget buildBreakdownCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 15,
          ),
        ],
      ),
      child: Column(
        children: [
          buildResultRow(
            'Invested Amount',
            investedAmount,
            Icons.account_balance_wallet_outlined,
          ),
          const Divider(height: 28),
          buildResultRow(
            'Estimated Returns',
            estimatedReturns,
            Icons.trending_up_rounded,
          ),
          const Divider(height: 28),
          buildResultRow(
            'Total Value',
            totalValue,
            Icons.savings_outlined,
            highlight: true,
          ),
        ],
      ),
    );
  }

  Widget buildResultRow(
      String title,
      double value,
      IconData icon, {
        bool highlight = false,
      }) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: highlight
                ? const Color(0xFF5B5FEF)
                .withOpacity(.1)
                : const Color(0xFFF3F4F8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF5B5FEF),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          formatFullCurrency(value),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: highlight
                ? const Color(0xFF5B5FEF)
                : const Color(0xFF20212D),
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // Chart
  // ------------------------------------------------------------

  Widget buildChartCard() {
    final total = investedAmount + estimatedReturns;

    double investedPercentage =
    total == 0 ? 0 : investedAmount / total;

    double returnsPercentage =
    total == 0 ? 0 : estimatedReturns / total;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          const Text(
            'Investment Breakdown',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 190,
            child: CustomPaint(
              painter: DonutPainter(
                investedPercentage:
                investedPercentage,
                returnsPercentage:
                returnsPercentage,
              ),
              child: Center(
                child: Column(
                  mainAxisSize:
                  MainAxisSize.min,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      formatCurrency(totalValue),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceEvenly,
            children: [
              buildLegend(
                'Invested',
                investedPercentage,
              ),
              buildLegend(
                'Returns',
                returnsPercentage,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildLegend(
      String title,
      double percentage,
      ) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: title == 'Invested'
                ? const Color(0xFF5B5FEF)
                : const Color(0xFF24B47E),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 7),
        Text(
          '$title ${(percentage * 100).toStringAsFixed(1)}%',
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// ------------------------------------------------------------
// Donut Painter
// ------------------------------------------------------------

class DonutPainter extends CustomPainter {
  final double investedPercentage;
  final double returnsPercentage;

  DonutPainter({
    required this.investedPercentage,
    required this.returnsPercentage,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(
      size.width / 2,
      size.height / 2,
    );

    final radius =
        math.min(size.width, size.height) / 2 - 15;

    final rect = Rect.fromCircle(
      center: center,
      radius: radius,
    );

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25
      ..strokeCap = StrokeCap.butt;

    const startAngle = -math.pi / 2;

    paint.color = const Color(0xFF5B5FEF);

    canvas.drawArc(
      rect,
      startAngle,
      2 * math.pi * investedPercentage,
      false,
      paint,
    );

    paint.color = const Color(0xFF24B47E);

    canvas.drawArc(
      rect,
      startAngle +
          2 * math.pi * investedPercentage,
      2 * math.pi * returnsPercentage,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(
      covariant DonutPainter oldDelegate,
      ) {
    return oldDelegate.investedPercentage !=
        investedPercentage ||
        oldDelegate.returnsPercentage !=
            returnsPercentage;
  }
}