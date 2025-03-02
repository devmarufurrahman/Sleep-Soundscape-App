import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sleep_soundscape_app/core/assets.dart';
import 'package:sleep_soundscape_app/widgets/custom_app_bar.dart';

import '../../widgets/bottom_nav_bar.dart';

class SoundSelectionScreen extends StatefulWidget{
  const SoundSelectionScreen({super.key});

  @override
  State<SoundSelectionScreen> createState() => _SoundSelectionScreenState();

}

class _SoundSelectionScreenState extends State<SoundSelectionScreen>{
  int _selectedIndex = 2;
  int _selectedTab = 0;

  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: CustomAppBar(title: ''),
      body:  Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Assets.backgroundImage),
                    fit: BoxFit.cover
                )
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 120, left: 20, right: 20),
                  child: Row(
                    children: [
                      /// "Sounds" Button
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _selectedTab = 0;
                            });
                          },
                          child: Container(
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: _selectedTab == 0
                                  ? const LinearGradient(
                                colors: [Color(0xFF42098F), Color(0xFFB53FFE)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                                  : null,
                              /// না থাকলে Transparent + Border
                              color: _selectedTab == 0 ? null : Color(0xFF09001F),
                            ),
                            child: Text(
                              "Sounds",
                              style: TextStyle(
                                color: _selectedTab == 0 ? Colors.white : Colors.white54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      /// "Saved" Button
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _selectedTab = 1;
                            });
                          },
                          child: Container(
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: _selectedTab == 1
                                  ? const LinearGradient(
                                colors: [Color(0xFF42098F), Color(0xFFB53FFE)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                                  : null,
                              color: _selectedTab == 1 ? null : Color(0xFF09001F),

                            ),
                            child: Text(
                              "Saved",
                              style: TextStyle(
                                color: _selectedTab == 1 ? Colors.white : Colors.white54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: _selectedTab == 0
                        ? _buildSoundsContent()
                        : _buildSavedContent(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(currentIndex: _selectedIndex, onTap: _onNavBarTap),
    );
  }


  /// Dummy widget for "Sounds"
  Widget _buildSoundsContent() {
    return Center(
      child: Text(
        "Sounds Content Here",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

  /// Dummy widget for "Saved"
  Widget _buildSavedContent() {
    return Center(
      child: Text(
        "Saved Content Here",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }

}