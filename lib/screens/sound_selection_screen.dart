import 'package:flutter/material.dart';
import 'package:sleep_soundscape_app/core/assets.dart';
import 'package:sleep_soundscape_app/widgets/custom_app_bar.dart';

import '../widgets/bottom_nav_bar.dart';

class SoundSelectionScreen extends StatefulWidget{
  const SoundSelectionScreen({super.key});

  @override
  State<SoundSelectionScreen> createState() => _SoundSelectionScreenState();

}

class _SoundSelectionScreenState extends State<SoundSelectionScreen>{
  int _selectedIndex = 2; // Default "Create" tab selected

  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Main background color
      appBar: CustomAppBar(title: ''),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.backgroundImage),
            fit: BoxFit.cover
          )
        ),
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: _selectedIndex, onTap: _onNavBarTap),
    );
  }

}