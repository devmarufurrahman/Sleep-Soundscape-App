import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sleep_soundscape_app/screens/sound_selection/sound_selection_screen.dart';

void main() {
  runApp(
    ProviderScope(child: const MyApp(),)
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sleep Soundscape',
      debugShowCheckedModeBanner: false,
      home: SoundSelectionScreen(),

    );
  }
}

