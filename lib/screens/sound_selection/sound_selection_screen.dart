import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sleep_soundscape_app/core/assets.dart';
import 'package:sleep_soundscape_app/screens/sound_selection/sound_filter_row.dart';
import 'package:sleep_soundscape_app/widgets/custom_app_bar.dart';
import 'package:sleep_soundscape_app/widgets/custom_mini_fab.dart';
import '../../model/sound_item.dart';
import '../../providers/sound_provider.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/create_mix_bottom_sheet.dart';
import '../../widgets/sound_grid.dart';

final List<SoundItem> allSoundItems = [
  SoundItem(
      name: "Typhoon",
      iconPath: Assets.iconTyphoon,
      isLocked: false,
      category: "Wind"),
  SoundItem(
      name: "Sleet",
      iconPath: Assets.iconSleet,
      isLocked: false,
      category: "Rain"),
  SoundItem(
      name: "Heavenly Drift", iconPath: "", isLocked: false, category: "Wind"),
  SoundItem(
      name: "Snowy Winter",
      iconPath: Assets.iconSnowyWinter,
      isLocked: false,
      category: ""),
  SoundItem(
      name: "Cloudiness", iconPath: "", isLocked: false, category: "Rain"),
  SoundItem(
      name: "Desert Wind",
      iconPath: Assets.iconDesertWind,
      isLocked: false,
      category: "Wind"),
  SoundItem(
      name: "Starry Nights",
      iconPath: Assets.iconStarryNight,
      isLocked: false,
      category: ""),
  SoundItem(
      name: "Tribal Drums",
      iconPath: Assets.iconTribalDrums,
      isLocked: false,
      category: ""),
  SoundItem(
      name: "Light Rain ", iconPath: "", isLocked: true, category: "Rain"),
  SoundItem(name: "Wind", iconPath: "", isLocked: true, category: "Wind"),
  SoundItem(name: "Thunder", iconPath: "", isLocked: true, category: "Rain"),
  SoundItem(name: "Tornado", iconPath: "", isLocked: true, category: "Wind"),
  SoundItem(name: "Medium Rain", iconPath: "", isLocked: true, category: ""),
  SoundItem(
      name: "Snowy Breeze", iconPath: "", isLocked: true, category: "Wind"),
  SoundItem(name: "Heavy Rain", iconPath: "", isLocked: true, category: "Rain"),
  SoundItem(name: "Wind", iconPath: "", isLocked: true, category: "Wind"),
];

class SoundSelectionScreen extends ConsumerStatefulWidget {
  const SoundSelectionScreen({super.key});

  @override
  ConsumerState<SoundSelectionScreen> createState() =>
      _SoundSelectionScreenState();
}

class _SoundSelectionScreenState extends ConsumerState<SoundSelectionScreen> {
  int _selectedIndex = 2;
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";
  bool _showFAB = false;

  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _handleTileTap(SoundItem item) {
    if (item.iconPath.isNotEmpty) {
      setState(() {
        _showFAB = true;
      });
    }
  }

  List<SoundItem> _getFilteredItems(String selectedCategory) {
    List<SoundItem> filtered = allSoundItems;
    if (selectedCategory != "All") {
      filtered = filtered
          .where((item) =>
              item.category.toLowerCase() == selectedCategory.toLowerCase())
          .toList();
    }
    if (_searchText.isNotEmpty) {
      filtered = filtered
          .where((item) =>
              item.name.toLowerCase().contains(_searchText.toLowerCase()))
          .toList();
    }
    return filtered;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final soundState = ref.watch(soundProvider);
    final soundNotifier = ref.read(soundProvider.notifier);
    final filteredItems = _getFilteredItems(soundState.selectedCategory);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: CustomAppBar(
        title: "",
        isSearching: _isSearching,
        searchController: _searchController,
        onSearchTap: () {
          setState(() {
            _isSearching = true;
          });
        },
        onCloseSearch: () {
          setState(() {
            _isSearching = false;
            _searchText = "";
            _searchController.clear();
          });
        },
        onSearchTextChanged: (value) {
          setState(() {
            _searchText = value;
          });
        },
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Assets.backgroundImage),
                    fit: BoxFit.cover)),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 140, left: 20, right: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => soundNotifier.changeTab(0),
                          child: Container(
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: soundState.selectedTab == 0
                                  ? const LinearGradient(
                                      colors: [
                                        Color(0xFF42098F),
                                        Color(0xFFB53FFE)
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    )
                                  : null,
                              color: soundState.selectedTab == 0
                                  ? null
                                  : const Color(0xFF09001F),
                            ),
                            child: Text(
                              "Sounds",
                              style: TextStyle(
                                color: soundState.selectedTab == 0
                                    ? Colors.white
                                    : Colors.white54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: InkWell(
                          onTap: () => soundNotifier.changeTab(1),
                          child: Container(
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: soundState.selectedTab == 1
                                  ? const LinearGradient(
                                      colors: [
                                        Color(0xFF42098F),
                                        Color(0xFFB53FFE)
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    )
                                  : null,
                              color: soundState.selectedTab == 1
                                  ? null
                                  : const Color(0xFF09001F),
                            ),
                            child: Text(
                              "Saved",
                              style: TextStyle(
                                color: soundState.selectedTab == 1
                                    ? Colors.white
                                    : Colors.white54,
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
                  child: soundState.selectedTab == 0
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const SoundFilterRow(),
                            Expanded(
                                child: SoundGrid(
                              items: filteredItems,
                              onTileTap: _handleTileTap,
                            )),
                          ],
                        )
                      : Center(
                          child: Text(
                            "Saved Content Here",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                ),
                if (_showFAB)
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                        child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20),
                        ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomMiniFab(icon: Assets.iconPause, tooltip: "Pause"),
                              const SizedBox(width: 8),
                              CustomMiniFab(icon: Assets.iconCreate, tooltip: "Create"),
                              const SizedBox(width: 8),
                              CustomMiniFab(icon: Assets.iconHeart, tooltip: "Favourite"),
                              const SizedBox(width: 8),
                              CustomMiniFab(icon: Assets.iconClose, tooltip: "Close"),
                            ],
                          ),
                        ),
                      ),
                    )
                  ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          BottomNavBar(currentIndex: _selectedIndex, onTap: _onNavBarTap),
    );
  }

}
