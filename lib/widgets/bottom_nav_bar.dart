import 'package:flutter/material.dart';
import 'package:sleep_soundscape_app/core/assets.dart';
import 'package:sleep_soundscape_app/core/theme.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppTheme.backgroundColor,
      selectedItemColor: AppTheme.iconSelectedColor,
      unselectedItemColor: AppTheme.iconUnselectedColor,
      selectedLabelStyle: TextStyle(
        color: Colors.white,
      ),
      unselectedLabelStyle: TextStyle(
        color: AppTheme.greyText,
      ),
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            Assets.iconHome,
            width: 24,
            height: 24,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            Assets.iconLibrary,
            width: 24,
            height: 24,
          ),
          label: 'Library',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            Assets.iconCreate,
            width: 24,
            height: 24,
          ),
          label: 'Create',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            Assets.iconAlarm,
            width: 24,
            height: 24,
          ),
          label: 'Alarm',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            Assets.iconAwards,
            width: 24,
            height: 24,
          ),
          label: 'Awards',
        ),
      ],
    );
  }
}
