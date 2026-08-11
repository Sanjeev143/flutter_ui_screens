import 'dart:math';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:ui_screens_exmp/dashboards/wave_animation.dart';

// void main() {
//   runApp(const VoiceApp());
// }

class VoiceApp extends StatelessWidget {
  const VoiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const VoiceScreen(),
    );
  }
}

class VoiceScreen extends StatefulWidget {
  const VoiceScreen({super.key});

  @override
  State<VoiceScreen> createState() => _VoiceScreenState();
}

class _VoiceScreenState extends State<VoiceScreen>
    with TickerProviderStateMixin {
  final SpeechToText speech = SpeechToText();

  bool listening = false;

  double level = 0.05;

  late AnimationController glowController;

  late Animation<double> glowAnimation;
  String voice = "";

  @override
  void initState() {
    super.initState();

    glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    glowAnimation = Tween(
      begin: 0.6,
      end: 1.5,
    ).animate(
      CurvedAnimation(
        parent: glowController,
        curve: Curves.easeInOut,
      ),
    );

    initSpeech();
  }

  Future initSpeech() async {
    await speech.initialize();
  }

  Future startListening() async {
    if (!speech.isAvailable) return;

    listening = true;
    setState(() {});

    await speech.listen(
      onResult: (result) {
        print(result.recognizedWords);
        setState(() {
          if(voice != result.recognizedWords){
            level = (10 / 40).clamp(0.05, 1.0);
          }
          voice = result.recognizedWords;
        });
      },
      onSoundLevelChange: (value) {
        setState(() {
          level = (value.abs() / 40).clamp(0.05, 1.0);
        });
      },
    );
  }

  Future stopListening() async {
    listening = false;

    level = 0.05;

    setState(() {});

    await speech.stop();
  }

  @override
  void dispose() {
    glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [

            const Spacer(),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                voice,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 33,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),

            const SizedBox(height: 80),

            SizedBox(
              height: 180,
              width: double.infinity,
              child: AnimatedWaveWidget(
                amplitude: level,
              ),
            ),

            const Spacer(),

            AnimatedBuilder(
              animation: glowAnimation,
              builder: (_, __) {

                return Transform.scale(
                  scale: listening
                      ? glowAnimation.value
                      : 1,
                  child: GestureDetector(
                    onTap: () {

                      if (listening) {
                        stopListening();
                      } else {
                        startListening();
                      }

                    },
                    child: Container(
                      width: 95,
                      height: 95,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const RadialGradient(
                          colors: [
                            Color(0xffc85eff),
                            Color(0xff6b2cff),
                          ],
                        ),
                        boxShadow: listening
                            ? [
                          BoxShadow(
                            color: Colors.purpleAccent
                                .withOpacity(.7),
                            blurRadius: 35,
                            spreadRadius: 10,
                          ),
                        ]
                            : [],
                      ),
                      child: const Icon(
                        Icons.mic,
                        size: 42,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}