import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import 'theme.dart';

class FlashcardApp extends StatelessWidget {
  const FlashcardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flashcard Quiz',
      theme: AppTheme.light,
      home: const HomeScreen(),
    );
  }
}
