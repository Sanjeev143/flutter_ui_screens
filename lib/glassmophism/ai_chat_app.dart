import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AIChatApp());
}

class AIChatApp extends StatelessWidget {
  const AIChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aura AI Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF090D16),
        fontFamily: 'Inter',
      ),
      home: const AIChatScreen(),
    );
  }
}

// =============================================================================
// REUSABLE GLASSMORPHIC CONTAINER & AMBIENT BACKGROUND
// =============================================================================

class GlassmorphicBackground extends StatelessWidget {
  final Widget child;
  const GlassmorphicBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF080C14),
      ),
      child: Stack(
        children: [
          // Top Left Ambient Aura (Indigo / Violet)
          Positioned(
            top: -60,
            left: -50,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF6366F1).withValues(alpha: 0.25),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),

          // Center Right Ambient Aura (Cyan / Emerald)
          Positioned(
            top: 250,
            right: -60,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF06B6D4).withValues(alpha: 0.22),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 110, sigmaY: 110),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),

          // Bottom Left Ambient Aura (Fuchsia / Magenta)
          Positioned(
            bottom: 20,
            left: -40,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFD946EF).withValues(alpha: 0.18),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),

          SafeArea(child: child),
        ],
      ),
    );
  }
}

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final Color? backgroundColor;
  final Border? border;
  final double blurSigma;

  const GlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius = 24,
    this.backgroundColor,
    this.border,
    this.blurSigma = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(borderRadius),
        border: border ??
            Border.all(
              color: Colors.white.withValues(alpha: 0.14),
              width: 1.0,
            ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// MESSAGE DATA MODEL
// =============================================================================

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

// =============================================================================
// MAIN CHAT SCREEN
// =============================================================================

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;

  final List<ChatMessage> _messages = [
    ChatMessage(
      text: "Hello! I am Aura, your personal AI assistant. How can I inspire your project today?",
      isUser: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
    ),
    ChatMessage(
      text: "Can you explain how Glassmorphism in Flutter works?",
      isUser: true,
      timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
    ),
    ChatMessage(
      text:
      "Glassmorphism relies on three core design principles:\n\n"
          "1. **Translucency & Blurring:** Using `BackdropFilter` with `ImageFilter.blur`.\n"
          "2. **Layered Shadows:** Creating high visual depth with multi-color radial auras.\n"
          "3. **Frosted Borders:** Using subtle translucent white strokes (`Colors.white.withOpacity(0.15)`).",
      isUser: false,
      timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
    ),
  ];

  final List<String> _quickPrompts = [
    "✨ Summarize article",
    "💻 Generate Flutter Code",
    "🎨 UI/UX Ideas",
    "🚀 Brainstorm Startup Names",
  ];

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          text: text.trim(),
          isUser: true,
          timestamp: DateTime.now(),
        ),
      );
      _isTyping = true;
    });

    _controller.clear();
    _scrollToBottom();

    // Simulate AI response stream / delay
    Future.delayed(const Duration(milliseconds: 1400), () {
      if (!mounted) return;
      setState(() {
        _isTyping = false;
        _messages.add(
          ChatMessage(
            text: _getSimulatedResponse(text),
            isUser: false,
            timestamp: DateTime.now(),
          ),
        );
      });
      _scrollToBottom();
    });
  }

  String _getSimulatedResponse(String query) {
    final lower = query.toLowerCase();
    if (lower.contains("code") || lower.contains("flutter")) {
      return "Here is a quick pattern for creating frosted components:\n\n```dart\nBackdropFilter(\n  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),\n  child: Container(color: Colors.white.withOpacity(0.08)),\n)\n```\nIt blends background shapes seamlessly!";
    } else if (lower.contains("hello") || lower.contains("hi")) {
      return "Hey there! Ready to build something remarkable today?";
    } else {
      return "I've analyzed '$query'. Combining generative token streams with frosted glass UI components gives your mobile application an ultra-modern aesthetic!";
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 80,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GlassmorphicBackground(
        child: Column(
          children: [
            // Glass App Bar Header
            _buildGlassHeader(),

            // Chat Messages List
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _buildMessageBubble(_messages[index]);
                },
              ),
            ),

            // AI Thinking / Typing Indicator
            if (_isTyping) _buildTypingIndicator(),

            // Quick Prompt Chips
            _buildQuickPromptsBar(),

            // Glass Input Box
            _buildGlassInputBar(),
          ],
        ),
      ),
    );
  }

  // --- Glass App Bar Header ---
  Widget _buildGlassHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
      child: GlassContainer(
        borderRadius: 22,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            // AI Avatar with Glow Ring
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF6366F1), Color(0xFF06B6D4)],
                ),
              ),
              child: const CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xFF111827),
                child: Icon(Icons.auto_awesome, color: Color(0xFF38BDF8), size: 18),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Aura AI",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: -0.3,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF10B981),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "GPT-4o • Online",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white.withValues(alpha: 0.6),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.more_vert_rounded, color: Colors.white70),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  // --- Glass Message Bubble ---
  Widget _buildMessageBubble(ChatMessage msg) {
    final isUser = msg.isUser;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.80,
        ),
        child: GlassContainer(
          borderRadius: 20,
          blurSigma: 12.0,
          backgroundColor: isUser
              ? const Color(0xFF6366F1).withValues(alpha: 0.28)
              : Colors.white.withValues(alpha: 0.07),
          border: Border.all(
            color: isUser
                ? const Color(0xFF818CF8).withValues(alpha: 0.45)
                : Colors.white.withValues(alpha: 0.12),
            width: 1.0,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                msg.text,
                style: TextStyle(
                  fontSize: 14.5,
                  height: 1.4,
                  color: isUser ? Colors.white : Colors.white.withValues(alpha: 0.92),
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "${msg.timestamp.hour.toString().padLeft(2, '0')}:${msg.timestamp.minute.toString().padLeft(2, '0')}",
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white.withValues(alpha: 0.45),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Pulsing Typing Indicator ---
  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 16, bottom: 8),
        child: GlassContainer(
          borderRadius: 16,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 12,
                height: 12,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Color(0xFF38BDF8),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                "Aura is typing...",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Horizontal Quick Prompts ---
  Widget _buildQuickPromptsBar() {
    return Container(
      height: 38,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _quickPrompts.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          return GestureDetector(
            onTap: () => _sendMessage(_quickPrompts[i]),
            child: GlassContainer(
              borderRadius: 18,
              blurSigma: 10,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              backgroundColor: Colors.white.withValues(alpha: 0.05),
              child: Center(
                child: Text(
                  _quickPrompts[i],
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.8),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // --- Glass Input & Send Action ---
  Widget _buildGlassInputBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 12),
      child: GlassContainer(
        borderRadius: 28,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        child: Row(
          children: [
            // Voice / Mic Action
            IconButton(
              icon: Icon(
                CupertinoIcons.mic_fill,
                color: Colors.white.withValues(alpha: 0.6),
                size: 20,
              ),
              onPressed: () {},
            ),

            // Text Input Field
            Expanded(
              child: TextField(
                controller: _controller,
                onSubmitted: _sendMessage,
                style: const TextStyle(color: Colors.white, fontSize: 14.5),
                decoration: InputDecoration(
                  hintText: "Ask Aura anything...",
                  hintStyle: TextStyle(
                    color: Colors.white.withValues(alpha: 0.35),
                    fontSize: 14.5,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),

            // Send Button with Neon Gradient
            GestureDetector(
              onTap: () => _sendMessage(_controller.text),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF06B6D4)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x666366F1),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_upward_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}