import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: A2UIGenUIScreen(),
    ),
  );
}

// ==========================================
// 1. A2UI 0.9.0 Schema & Data Model
// ==========================================
enum GenComponentType {
  heroCard,
  metricGrid,
  actionList,
  interactiveChart,
  bannerAlert,
}

class A2UINode {
  final String id;
  final GenComponentType type;
  final Map<String, dynamic> props;
  final List<A2UINode> children;

  A2UINode({
    required this.id,
    required this.type,
    required this.props,
    this.children = const [],
  });

  factory A2UINode.fromJson(Map<String, dynamic> json) {
    return A2UINode(
      id: json['id'] as String,
      type: GenComponentType.values.firstWhere(
            (e) => e.name == json['type'],
        orElse: () => GenComponentType.heroCard,
      ),
      props: Map<String, dynamic>.from(json['props'] ?? {}),
      children: (json['children'] as List<dynamic>?)
          ?.map((c) => A2UINode.fromJson(c as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }
}

// ==========================================
// 2. GenUI Dynamic Renderer Engine
// ==========================================
class GenUIRenderer {
  static Widget renderNode(A2UINode node, BuildContext context) {
    switch (node.type) {
      case GenComponentType.heroCard:
        return _buildHeroCard(node, context);
      case GenComponentType.metricGrid:
        return _buildMetricGrid(node, context);
      case GenComponentType.actionList:
        return _buildActionList(node, context);
      case GenComponentType.interactiveChart:
        return _buildInteractiveChart(node, context);
      case GenComponentType.bannerAlert:
        return _buildBannerAlert(node, context);
    }
  }

  static Widget _buildHeroCard(A2UINode node, BuildContext context) {
    final title = node.props['title'] ?? 'Dynamic Card';
    final subtitle = node.props['subtitle'] ?? '';
    final gradientColors = (node.props['colors'] as List<dynamic>?)
        ?.map((c) => Color(int.parse(c.toString())))
        .toList() ??
        [const Color(0xFF6366F1), const Color(0xFF9333EA)];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: gradientColors.first.withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "GenUI • A2UI v0.9",
                  style: GoogleFonts.firaCode(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Icon(Icons.auto_awesome, color: Colors.white, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: GoogleFonts.inter(
              color: Colors.white.withOpacity(0.85),
              fontSize: 14,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0);
  }

  static Widget _buildMetricGrid(A2UINode node, BuildContext context) {
    final metrics = (node.props['metrics'] as List<dynamic>?) ?? [];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: metrics.map((m) {
          final label = m['label'] ?? '';
          final value = m['value'] ?? '';
          final delta = m['delta'] ?? '';

          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFF334155)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF94A3B8),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    value,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    delta,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF10B981),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    ).animate().fadeIn(delay: 200.ms).scale(begin: const Offset(0.95, 0.95));
  }

  static Widget _buildInteractiveChart(A2UINode node, BuildContext context) {
    final bars = (node.props['data'] as List<dynamic>?)
        ?.map((e) => double.tryParse(e.toString()) ?? 0.0)
        .toList() ??
        [0.4, 0.7, 0.5, 0.9, 0.6, 0.8];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF334155)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            node.props['title'] ?? 'Realtime Token Stream Performance',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 90,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: bars.map((val) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Container(
                      height: 90 * val,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Color(0xFF3B82F6), Color(0xFF60A5FA)],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms);
  }

  static Widget _buildActionList(A2UINode node, BuildContext context) {
    final actions = (node.props['actions'] as List<dynamic>?) ?? [];

    return Column(
      children: actions.map((act) {
        final text = act['text'] ?? 'Action';
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: const Color(0xFF6366F1),
                  content: Text("A2UI Event Dispatched: $text"),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF334155),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              text,
              style: GoogleFonts.inter(fontWeight: FontWeight.w600),
            ),
          ),
        );
      }).toList(),
    ).animate().fadeIn(delay: 400.ms);
  }

  static Widget _buildBannerAlert(A2UINode node, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF064E3B),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF059669)),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, color: Color(0xFF34D399)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              node.props['message'] ?? 'A2UI 0.9.0 Pipeline Connected',
              style: GoogleFonts.inter(
                color: const Color(0xFFA7F3D0),
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn().shake(duration: 400.ms);
  }
}

// ==========================================
// 3. Interactive Main UI Screen
// ==========================================
class A2UIGenUIScreen extends StatefulWidget {
  const A2UIGenUIScreen({super.key});

  @override
  State<A2UIGenUIScreen> createState() => _A2UIGenUIScreenState();
}

class _A2UIGenUIScreenState extends State<A2UIGenUIScreen> {
  final List<A2UINode> _renderedNodes = [];
  bool _isStreaming = false;

  // Mock Streaming A2UI Generative Payloads from Agent
  final List<String> _mockA2UIPayloads = [
    '''
    {
      "id": "node_1",
      "type": "bannerAlert",
      "props": {
        "message": "Connected to Agent Stream (A2UI Protocol v0.9.0)"
      }
    }
    ''',
    '''
    {
      "id": "node_2",
      "type": "heroCard",
      "props": {
        "title": "Autonomous AI Agent Engine",
        "subtitle": "Generating native Flutter interfaces dynamically via token streams.",
        "colors": ["0xFF4F46E5", "0xFF7C3AED"]
      }
    }
    ''',
    '''
    {
      "id": "node_3",
      "type": "metricGrid",
      "props": {
        "metrics": [
          {"label": "Latency", "value": "18ms", "delta": "⚡ 99.4%"},
          {"label": "Tokens/sec", "value": "142", "delta": "+24%"}
        ]
      }
    }
    ''',
    '''
    {
      "id": "node_4",
      "type": "interactiveChart",
      "props": {
        "title": "GenUI Pipeline Response Timeline",
        "data": [0.3, 0.6, 0.45, 0.85, 0.65, 0.95]
      }
    }
    ''',
    '''
    {
      "id": "node_5",
      "type": "actionList",
      "props": {
        "actions": [
          {"text": "Deploy Generative Pipeline"},
          {"text": "Export A2UI AST Schema"}
        ]
      }
    }
    '''
  ];

  void _startAgentGenUIStream() async {
    setState(() {
      _renderedNodes.clear();
      _isStreaming = true;
    });

    for (var payload in _mockA2UIPayloads) {
      await Future.delayed(const Duration(milliseconds: 600));
      if (!mounted) return;
      final parsedJson = jsonDecode(payload);
      setState(() {
        _renderedNodes.add(A2UINode.fromJson(parsedJson));
      });
    }

    setState(() {
      _isStreaming = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _startAgentGenUIStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        elevation: 0,
        centerTitle: false,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.memory, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 10),
            Text(
              "GenUI • A2UI Engine",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: "Regenerate Stream",
            onPressed: _isStreaming ? null : _startAgentGenUIStream,
            icon: _isStreaming
                ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Color(0xFF818CF8),
              ),
            )
                : const Icon(Icons.refresh, color: Colors.white),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          ..._renderedNodes.map((node) => GenUIRenderer.renderNode(node, context)),
          if (_isStreaming)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.stream, color: Color(0xFF818CF8), size: 18),
                    const SizedBox(width: 8),
                    Text(
                      "Synthesizing A2UI Components...",
                      style: GoogleFonts.firaCode(
                        color: const Color(0xFF94A3B8),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ).animate(onPlay: (c) => c.repeat()).shimmer(duration: 1200.ms),
              ),
            ),
        ],
      ),
    );
  }
}