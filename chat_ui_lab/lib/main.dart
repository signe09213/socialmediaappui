import 'package:flutter/material.dart';
import 'screens/feed_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Antogram', // Updated app title
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Colors.white,
          onPrimary: Colors.black,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        useMaterial3: true,
      ),
      home: const FeedScreen(),
    );
  }
}
