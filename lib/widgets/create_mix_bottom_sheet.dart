import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sleep_soundscape_app/core/assets.dart';
import 'package:sleep_soundscape_app/widgets/save_mix_bottom_sheet.dart';
import '../providers/mix_provider.dart';
import '../model/mix_item.dart';

class CreateMixBottomSheet extends ConsumerStatefulWidget {
  const CreateMixBottomSheet({super.key});

  @override
  ConsumerState<CreateMixBottomSheet> createState() => _CreateMixBottomSheetState();
}

class _CreateMixBottomSheetState extends ConsumerState<CreateMixBottomSheet> {
  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    final mixItems = ref.watch(mixProvider);
    final mixNotifier = ref.read(mixProvider.notifier);
    final currentMixName = ref.watch(currentMixNameProvider);
    final bool isSaved = currentMixName != "Your Mix";

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: const BoxDecoration(
        color: Color(0xFF1E0036),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Text(
              currentMixName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 30),

            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: mixItems.length,
                itemBuilder: (context, index) {
                  final item = mixItems[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildSoundRow(item, ref),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(
                    icon: isSaved ? Assets.iconRename : Assets.iconHeart,
                    label: isSaved ? "Rename" : "Save",
                    onTap: () {
                      final mixItems = ref.read(mixProvider);
                      final Map<String, double> currentMixMap = {
                        for (var item in mixItems) item.name: item.value,
                      };

                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) => SaveMixBottomSheet(
                          currentMixItems: currentMixMap,
                          isRename: isSaved,
                          initialName: isSaved ? currentMixName : null,
                        ),
                      );
                    },
                  ),

                  _buildActionButton(
                    icon: isPlaying ? Assets.iconPause : Assets.iconPlay,
                    label: isPlaying ? "Pause" : "Play",
                    onTap: () {
                      setState(() {
                        isPlaying = !isPlaying;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(isPlaying ? "Playing" : "Paused"),
                        ),
                      );
                    },
                  ),
                  _buildActionButton(
                    icon: Assets.iconClose,
                    label: "Close",
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSoundRow(MixItem item, WidgetRef ref) {
    final mixNotifier = ref.read(mixProvider.notifier);
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF261945),
        borderRadius: BorderRadius.circular(24),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final filledWidth = maxWidth * item.value;

          return Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.centerLeft,
            children: [
              Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                width: filledWidth.clamp(0, maxWidth),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF9747FF), Color(0xFF7B3FE4)],
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  item.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Opacity(
                opacity: 0.0,
                child: Slider(
                  value: item.value,
                  min: 0.0,
                  max: 1.0,
                  onChanged: (newVal) {
                    mixNotifier.updateValue(item.name, newVal);
                  },
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 50),
                curve: Curves.easeInOut,
                left: (filledWidth - 20).clamp(0, maxWidth - 32),
                top: 6,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ImageIcon(
                    AssetImage(item.icon),
                    color: const Color(0xFF261945),
                    size: 6,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    mixNotifier.removeItem(item.name);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildActionButton({
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageIcon(
            AssetImage(icon),
            size: 24,
            color: Colors.white,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
