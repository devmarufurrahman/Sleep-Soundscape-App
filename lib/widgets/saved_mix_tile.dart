import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/saved_mix.dart';
import '../model/mix_item.dart';
import '../providers/mix_provider.dart';
import '../../core/assets.dart';
import 'create_mix_bottom_sheet.dart';

final Map<String, String> defaultSoundIconMap = {
  "Typhoon": Assets.iconTyphoon,
  "Sleet": Assets.iconSleet,
  "Desert Wind": Assets.iconDesertWind,
  "Starry Night": Assets.iconStarryNight,
  "Tribal Drums": Assets.iconTribalDrums,
  "Rain": Assets.iconSleet,
};

class SavedMixTile extends ConsumerStatefulWidget {
  final SavedMix mix;
  const SavedMixTile({super.key, required this.mix});

  @override
  ConsumerState<SavedMixTile> createState() => _SavedMixTileState();
}

class _SavedMixTileState extends ConsumerState<SavedMixTile> {
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    final soundNames = widget.mix.items.keys.toList();

    return GestureDetector(
      onTap: () {
        final newMixItems = widget.mix.items.entries.map((entry) {
          final assetPath = defaultSoundIconMap[entry.key];
          return MixItem(
            name: entry.key,
            value: entry.value,
            icon: assetPath ?? '',
          );
        }).toList();

        ref.read(mixProvider.notifier).setMixItems(newMixItems);

        ref.read(currentMixNameProvider.notifier).state = widget.mix.name;

        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => CreateMixBottomSheet(),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: soundNames.take(6).map((sound) {
                final assetPath = defaultSoundIconMap[sound];
                return Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: assetPath != null && assetPath.isNotEmpty
                      ? ImageIcon(
                    AssetImage(assetPath),
                    color: Colors.white,
                    size: 14,
                  )
                      : const Icon(
                    Icons.music_note,
                    color: Colors.white,
                    size: 20,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 8),

            Text(
              widget.mix.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            if (soundNames.isNotEmpty) ...[
              const SizedBox(height: 2),
              Text(
                soundNames.join(' • '),
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],

            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isPlaying = !isPlaying;
                  });
                },
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: const BoxDecoration(
                    color: Color(0xFF9747FF),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
