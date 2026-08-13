import 'package:flutter/material.dart';
import 'mobile_app/ai_job_finder.dart';
import 'mobile_app/thumbnail.dart';



void main() {
  runApp(const AIJobFinderApp());
  // runApp(const BankingApp());
}



class BankingApp extends StatelessWidget {
  const BankingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Finance App',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const YouTubeThumbnailWidget(),
    );
  }
}