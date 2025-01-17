import 'package:flutter/material.dart';
import 'package:fullscreen_window/fullscreen_window.dart'; // Import the fullscreen_window package
import 'package:flutter/services.dart'; // Import for SystemChrome
import 'SplashScreen.dart';
import 'Home.dart'; // Make sure to import the Home screen

void main() {
  // Initialize fullscreen mode
  WidgetsFlutterBinding.ensureInitialized();
  FullScreenWindow.setFullScreen(true); // Enter fullscreen

  // Set transparent status and navigation bars
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // Transparent status bar
    statusBarIconBrightness: Brightness.light, // White icons for dark backgrounds
    systemNavigationBarColor: Colors.transparent, // Transparent navigation bar
    systemNavigationBarIconBrightness: Brightness.light, // White icons for dark backgrounds
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weeber',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const SplashScreen(
        nextScreen: MyHomePage(title: 'Weeber'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Home(); // Simply return the Home widget here
  }
}
