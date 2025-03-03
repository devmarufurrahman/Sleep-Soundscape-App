import 'package:flutter/material.dart';
import '../model/sound_item.dart';

class SoundGrid extends StatelessWidget {
  final List<SoundItem> items;
  final void Function(SoundItem)? onTileTap;
  const SoundGrid({super.key, required this.items, this.onTileTap,});

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
        return GestureDetector(
          onTap: () {
            onTileTap?.call(sound);
          },
          child: SoundTile(item: sound),
        );
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
                  child: item.iconPath.isNotEmpty
                      ? ImageIcon(
                    AssetImage(item.iconPath),
                    size: 24,
                    color: Colors.white,
                  )
                      : const SizedBox.shrink(),

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

  LinearGradient? _getGradientForSound(String soundName) {
    if (soundName.toLowerCase() == 'sleet') {
      return LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF9C4DFF),
          Color(0xFF5C1E99),
        ],
      );
    } else if (soundName.toLowerCase() == 'typhoon') {
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
