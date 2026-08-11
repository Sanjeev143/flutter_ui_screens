import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const WebLauncherApp());
}

class WebLauncherApp extends StatelessWidget {
  const WebLauncherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'URL Launcher Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // PUT YOUR STATIC URL HERE
  static const String staticUrl = 'https://flutter.dev';

  Future<void> _launchUrl(BuildContext context) async {
    final Uri url = Uri.parse(staticUrl);

    // This opens in in-app browser tab on Android/iOS
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView, // Options: platformDefault, inAppWebView, externalApplication
      webViewConfiguration: const WebViewConfiguration(
        enableJavaScript: true,
        enableDomStorage: true,
      ),
    )) {
      // If it fails, show error
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $staticUrl')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Open Webpage')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Tap button to open webpage', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => _launchUrl(context),
              icon: const Icon(Icons.open_in_browser),
              label: const Text('Open Flutter.dev'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
            ),
            const SizedBox(height: 20),
            Text('URL: $staticUrl', style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}