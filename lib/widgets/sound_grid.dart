import 'package:flutter/material.dart';
import '../model/sound_item.dart';

class SoundGrid extends StatelessWidget {
  final List<SoundItem> items;
  const SoundGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 20,
        crossAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final sound = items[index];
        return SoundTile(item: sound);
      },
    );
  }
}

class SoundTile extends StatelessWidget {
  final SoundItem item;
  const SoundTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              // Main tile container
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF0B0020),
                  borderRadius: BorderRadius.circular(24), // More rounded corners
                  gradient: _getGradientForSound(item.name),
                ),
                child: Center(
                  child: _getIconForSound(item.name),
                ),
              ),

              // Lock icon
              if (item.isLocked)
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(4),
                    child: const Icon(
                      Icons.lock,
                      color: Colors.white,
                      size: 12,
                    ),
                  ),
                ),
            ],
          ),
        ),

        // Text below the tile
        const SizedBox(height: 8),
        Text(
          item.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _getIconForSound(String soundName) {
    IconData iconData;
    Color iconColor = Colors.white.withOpacity(0.8);
    double size = 28;

    switch (soundName.toLowerCase()) {
      case 'typhoon':
        iconData = Icons.cyclone;
        break;
      case 'heavenly drift':
        iconData = Icons.cloud;
        iconColor = Colors.white;
        break;
      case 'cloudiness':
        iconData = Icons.cloud_outlined;
        break;
      case 'desert wind':
        iconData = Icons.air;
        break;
      case 'starry nights':
        iconData = Icons.star;
        break;
      case 'tribal drums':
        iconData = Icons.music_note;
        break;
      case 'light rain':
        iconData = Icons.water_drop_outlined;
        break;
      case 'wind':
        iconData = Icons.air_outlined;
        break;
      case 'thunder':
        iconData = Icons.flash_on;
        break;
      case 'tornado':
        iconData = Icons.tornado;
        break;
      case 'medium rain':
        iconData = Icons.water_drop;
        break;
      case 'snowy breeze':
        iconData = Icons.ac_unit;
        break;
      case 'heavy rain':
        iconData = Icons.water;
        break;
      default:
        iconData = Icons.music_note;
    }

    return Icon(
      iconData,
      color: iconColor,
      size: size,
    );
  }


  LinearGradient? _getGradientForSound(String soundName) {
    if (soundName.toLowerCase() == 'heavenly drift') {
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF9C4DFF),
          Color(0xFF5C1E99),
        ],
      );
    } else if (soundName.toLowerCase() == 'tribal drums') {
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF8A2BE2),
          Color(0xFF4B0082),
        ],
      );
    }

    return null; // Return null for default color
  }

}
