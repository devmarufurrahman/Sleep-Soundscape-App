import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/mix_item.dart';
import '../model/saved_mix.dart';
import '../../core/assets.dart';
import '../providers/mix_provider.dart';
import 'create_mix_bottom_sheet.dart';

final Map<String, String> defaultSoundIconMap = {
  "Typhoon": Assets.iconTyphoon,
  "Sleet": Assets.iconSleet,
  "Desert Wind": Assets.iconDesertWind,
  "Starry Night": Assets.iconStarryNight,
  "Tribal Drums": Assets.iconTribalDrums,
  "Rain": Assets.iconSleet,
};

class SavedMixTile extends ConsumerWidget {
  final SavedMix mix;
  const SavedMixTile({super.key, required this.mix});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final soundNames = mix.items.keys.toList();

    return GestureDetector(
        onTap: () {
      // Convert saved mix (Map<String, double>) into List<MixItem>
      final newMixItems = mix.items.entries.map((entry) {
        final assetPath = defaultSoundIconMap[entry.key];
        return MixItem(
          name: entry.key,
          value: entry.value,
          // MixItem now expects a String for icon (asset path)
          icon: assetPath ?? '',
        );
      }).toList();

      // Update mixProvider with new mix items
      ref.read(mixProvider.notifier).setMixItems(newMixItems);

      // Update current mix name provider to show saved mix name
      ref.read(currentMixNameProvider.notifier).state = mix.name;

      // Open CreateMixBottomSheet for editing/playing the mix
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => const CreateMixBottomSheet(),
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(8), // কম padding
      child: IntrinsicHeight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Sound icons Wrap
            Wrap(
              spacing: 4, // spacing কমানো
              runSpacing: 4,
              children: soundNames.take(6).map((sound) {
                final assetPath = defaultSoundIconMap[sound];
                return Container(
                  width: 28, // container size কমানো
                  height: 28,
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: assetPath != null && assetPath.isNotEmpty
                      ? ImageIcon(
                    AssetImage(assetPath),
                    color: Colors.white,
                    size: 16, // icon size কমানো
                  )
                      : Icon(
                    Icons.music_note,
                    color: Colors.white,
                    size: 16,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 4),
            // Mix name text
            Text(
              mix.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14, // font size কমানো
                fontWeight: FontWeight.bold,
              ),
            ),
            // Sound list text
            if (soundNames.isNotEmpty) ...[
              const SizedBox(height: 2),
              Text(
                soundNames.join(' • '),
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            // Bottom play button
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Color(0xFF9747FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    )
    );
  }
}
