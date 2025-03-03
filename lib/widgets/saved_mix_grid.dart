import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/saved_mix_provider.dart';
import 'saved_mix_tile.dart';

class SavedMixGrid extends ConsumerWidget {
  const SavedMixGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedMixes = ref.watch(savedMixNotifierProvider);

    if (savedMixes.isEmpty) {
      return const Center(
        child: Text(
          "No saved mixes yet",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: savedMixes.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemBuilder: (context, index) {
        final mix = savedMixes[index];
        return SavedMixTile(mix: mix);
      },
    );
  }
}
