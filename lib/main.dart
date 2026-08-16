
import 'package:flutter/material.dart';
import 'package:ui_screens_exmp/splash_screens/morphic_splash_screen.dart';

import 'ar/audio_visualizer_withglsl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF070913),
      ),
      home: const MorphingAiSplashScreen(),
    );
  }
}