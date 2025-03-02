import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/sound_provider.dart';

class SoundGrid extends ConsumerWidget {
  const SoundGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final soundState = ref.watch(soundProvider);

    final category = soundState.selectedCategory;

    final allSounds = [
      "Typhoon", "Sleet", "Heavenly Drift", "Snowy Winter",
      "Cloudiness", "Deep Wind", "Starry Nights", "Tribal Drums",
    ];

    final filtered = category == "All"
        ? allSounds
        : allSounds.where((sound) => sound.contains("Wind")).toList();

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filtered.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            filtered[index],
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
}
