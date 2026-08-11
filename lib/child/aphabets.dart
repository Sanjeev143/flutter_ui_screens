import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:audioplayers/audioplayers.dart';

// void main() => runApp(const AlphabetApp());

class AlphabetApp extends StatelessWidget {
  const AlphabetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        useMaterial3: true,
      ),
      home: const AlphabetScreen(),
    );
  }
}

class AlphabetScreen extends StatefulWidget {
  const AlphabetScreen({super.key});

  @override
  State<AlphabetScreen> createState() => _AlphabetScreenState();
}

class _AlphabetScreenState extends State<AlphabetScreen> with SingleTickerProviderStateMixin {
  final FlutterTts flutterTts = FlutterTts();
  final AudioPlayer bgmPlayer = AudioPlayer();
  bool isHindi = false;
  bool isMusicOn = true;
  String selectedLetter = "A";

  late AnimationController _controller; // FIX: now initialized in initState before use
  late Animation<double> _animation;

  final Map<String, Map<String, String>> alphabetData = {
    "A": {"en": "Apple", "hi": "Anar", "img": "https://cdn-icons-png.flaticon.com/512/415/415733.png"},
    "B": {"en": "Ball", "hi": "Ball", "img": "https://cdn-icons-png.flaticon.com/512/3081/3081559.png"},
    "C": {"en": "Cat", "hi": "Billi", "img": "https://cdn-icons-png.flaticon.com/512/616/616408.png"},
    "D": {"en": "Dog", "hi": "Kutta", "img": "https://cdn-icons-png.flaticon.com/512/616/616430.png"},
    "E": {"en": "Elephant", "hi": "Haathi", "img": "https://cdn-icons-png.flaticon.com/512/616/616438.png"},
    "F": {"en": "Fish", "hi": "Machhli", "img": "https://cdn-icons-png.flaticon.com/512/616/616439.png"},
    "G": {"en": "Goat", "hi": "Bakri", "img": "https://cdn-icons-png.flaticon.com/512/616/616445.png"},
    "H": {"en": "House", "hi": "Ghar", "img": "https://cdn-icons-png.flaticon.com/512/619/619153.png"},
    "I": {"en": "Ice Cream", "hi": "Ice Cream", "img": "https://cdn-icons-png.flaticon.com/512/3081/3081848.png"},
    "J": {"en": "Jug", "hi": "Jag", "img": "https://cdn-icons-png.flaticon.com/512/2936/2936886.png"},
    "K": {"en": "Kite", "hi": "Patang", "img": "https://cdn-icons-png.flaticon.com/512/2972/2972185.png"},
    "L": {"en": "Lion", "hi": "Sher", "img": "https://cdn-icons-png.flaticon.com/512/616/616450.png"},
    "M": {"en": "Monkey", "hi": "Bandar", "img": "https://cdn-icons-png.flaticon.com/512/616/616451.png"},
    "N": {"en": "Nest", "hi": "Ghonsla", "img": "https://cdn-icons-png.flaticon.com/512/4149/4149680.png"},
    "O": {"en": "Orange", "hi": "Santra", "img": "https://cdn-icons-png.flaticon.com/512/3081/3081881.png"},
    "P": {"en": "Parrot", "hi": "Tota", "img": "https://cdn-icons-png.flaticon.com/512/616/616458.png"},
    "Q": {"en": "Queen", "hi": "Rani", "img": "https://cdn-icons-png.flaticon.com/512/4149/4149951.png"},
    "R": {"en": "Rabbit", "hi": "Khargosh", "img": "https://cdn-icons-png.flaticon.com/512/616/616468.png"},
    "S": {"en": "Sun", "hi": "Suraj", "img": "https://cdn-icons-png.flaticon.com/512/869/869.png"},
    "T": {"en": "Tiger", "hi": "Baagh", "img": "https://cdn-icons-png.flaticon.com/512/616/616471.png"},
    "U": {"en": "Umbrella", "hi": "Chhatri", "img": "https://cdn-icons-png.flaticon.com/512/4149/4149475.png"},
    "V": {"en": "Violin", "hi": "Violin", "img": "https://cdn-icons-png.flaticon.com/512/2972/2972176.png"},
    "W": {"en": "Watch", "hi": "Ghadi", "img": "https://cdn-icons-png.flaticon.com/512/2972/2972215.png"},
    "X": {"en": "Xylophone", "hi": "Xylophone", "img": "https://cdn-icons-png.flaticon.com/512/2972/2972207.png"},
    "Y": {"en": "Yacht", "hi": "Nauka", "img": "https://cdn-icons-png.flaticon.com/512/4149/4149570.png"},
    "Z": {"en": "Zebra", "hi": "Zebra", "img": "https://cdn-icons-png.flaticon.com/512/616/616481.png"},
  };

  @override
  void initState() {
    super.initState();

    // FIX 1: Initialize animation controller FIRST
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _initTts();
    _playBGM();

    // FIX 2: Call speak after controller is ready
    Future.delayed(Duration.zero, () => _onLetterTap("A"));
  }

  void _initTts() async {
    await flutterTts.setSpeechRate(0.45);
    await flutterTts.setPitch(1.1);
  }

  void _playBGM() async {
    try {
      await bgmPlayer.setSourceUrl("https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3");
      await bgmPlayer.setVolume(0.15);
      await bgmPlayer.setReleaseMode(ReleaseMode.loop);
      if(isMusicOn) bgmPlayer.resume();
    } catch(e) {
      debugPrint("BGM Error: $e");
    }
  }

  Future _speak(String letter) async {
    String word = isHindi? alphabetData[letter]!["hi"]! : alphabetData[letter]!["en"]!;
    String text = isHindi? "$letter se $word" : "$letter for $word";
    await flutterTts.setLanguage(isHindi? "hi-IN" : "en-AU");
    await flutterTts.speak(text);
  }

  void _onLetterTap(String letter) {
    setState(() {
      selectedLetter = letter;
    });
    _controller.forward(from: 0); // restart animation
    _speak(letter);
  }

  void _toggleLanguage() {
    setState(() => isHindi =!isHindi);
    _speak(selectedLetter);
  }

  void _toggleMusic() async {
    setState(() => isMusicOn =!isMusicOn);
    isMusicOn? await bgmPlayer.resume() : await bgmPlayer.pause();
  }

  @override
  void dispose() {
    flutterTts.stop();
    bgmPlayer.dispose();
    _controller.dispose(); // FIX 3: dispose controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String word = isHindi? alphabetData[selectedLetter]!["hi"]! : alphabetData[selectedLetter]!["en"]!;
    String img = alphabetData[selectedLetter]!["img"]!;

    return Scaffold(
      appBar: AppBar(
        title: Text(isHindi? "ABC Seekho" : "ABC Learning"),
        backgroundColor: const Color(0xFF1A1A1A),
        actions: [
          IconButton(icon: Icon(isMusicOn? Icons.music_note : Icons.music_off), onPressed: _toggleMusic),
          IconButton(icon: Icon(isHindi? Icons.translate : Icons.language), onPressed: _toggleLanguage),
          IconButton(icon: const Icon(Icons.volume_up), onPressed: () => _speak(selectedLetter)),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            flex: 3,
            child: ScaleTransition( // Cleaner than Transform.scale
              scale: _animation,
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.purple.withOpacity(0.3), Colors.cyan.withOpacity(0.3)]),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.cyanAccent, width: 2)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(selectedLetter, style: const TextStyle(fontSize: 90, fontWeight: FontWeight.bold, color: Colors.cyanAccent)),
                    const SizedBox(height: 10),
                    ClipRRect(borderRadius: BorderRadius.circular(20),
                        child: Image.network(img, height: 120, errorBuilder: (_,__,___) => const Icon(Icons.image, size: 100))),
                    const SizedBox(height: 20),
                    Text(isHindi? "$selectedLetter se $word" : "$selectedLetter for $word",
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, crossAxisSpacing: 8, mainAxisSpacing: 8),
              itemCount: alphabetData.length,
              itemBuilder: (context, index) {
                String letter = alphabetData.keys.elementAt(index);
                bool isSelected = letter == selectedLetter;
                return GestureDetector(
                  onTap: () => _onLetterTap(letter),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                        color: isSelected? Colors.cyanAccent : const Color(0xFF2A2A2A),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: isSelected? [BoxShadow(color: Colors.cyanAccent.withOpacity(0.6), blurRadius: 15)] : []
                    ),
                    child: Center(child: Text(letter, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isSelected? Colors.black : Colors.white))),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}