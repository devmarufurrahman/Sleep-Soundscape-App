import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sleep_soundscape_app/widgets/save_mix_bottom_sheet.dart';
import '../providers/mix_provider.dart';
import '../model/mix_item.dart';

class CreateMixBottomSheet extends ConsumerWidget {
  const CreateMixBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mixItems = ref.watch(mixProvider);
    final mixNotifier = ref.read(mixProvider.notifier);
    final currentMixName = ref.watch(currentMixNameProvider);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1A0B2E),
            Color(0xFF0D0619),
          ],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(
              currentMixName,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
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

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(
                    icon: Icons.save,
                    label: "Save",
                    onTap: () {
                      final mixItems = ref.read(mixProvider);
                      final Map<String, double> currentMixMap = {
                        for (var item in mixItems) item.name: item.value,
                      };

                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (_) {
                          return SaveMixBottomSheet(
                            currentMixItems: currentMixMap,
                          );
                        },
                      );
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.pause,
                    label: "Pause",
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Paused")),
                      );
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.refresh,
                    label: "Clear All",
                    onTap: () {
                      mixNotifier.clearAll();
                    },
                  ),
                  _buildActionButton(
                    icon: Icons.close,
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
                height: 48,
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
                left: (filledWidth - 16).clamp(0, maxWidth - 32),
                top: 6,
                child: Container(
                  width: 32,
                  height: 32,
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
                    size: 24,
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
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Color(0xFF9747FF), size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF9747FF),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
