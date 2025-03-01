import 'package:flutter/material.dart';
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
    // TODO: Implement navigation based on index
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Main background color
      appBar: CustomAppBar(title: ''),
      body: Column(
        children: [
          // Tab bar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.purple.shade900,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text("Sounds", style: TextStyle(color: Colors.white)),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text("Saved", style: TextStyle(color: Colors.white70)),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Category Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: ["All", "Rain", "Water", "Wind", "Instrument"].map((category) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Chip(
                    backgroundColor: Colors.purple.shade800,
                    label: Text(category, style: const TextStyle(color: Colors.white)),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(height: 16),

          // Sound Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: 12, // TODO: Replace with dynamic sound list
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.purple.shade900,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.music_note, color: Colors.white),
                        SizedBox(height: 8),
                        Text("Sound", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: _selectedIndex, onTap: _onNavBarTap),
    );
  }

}