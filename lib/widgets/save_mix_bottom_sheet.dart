import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/mix_provider.dart';
import '../providers/saved_mix_provider.dart';

class SaveMixBottomSheet extends ConsumerStatefulWidget {
  final Map<String, double> currentMixItems;
  const SaveMixBottomSheet({super.key, required this.currentMixItems});

  @override
  ConsumerState<SaveMixBottomSheet> createState() => _SaveMixBottomSheetState();
}

class _SaveMixBottomSheetState extends ConsumerState<SaveMixBottomSheet> {
  final TextEditingController _nameController = TextEditingController();
  bool _isSaveEnabled = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      final isEnabled = _nameController.text.trim().isNotEmpty;
      if (isEnabled != _isSaveEnabled) {
        setState(() {
          _isSaveEnabled = isEnabled;
        });
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final savedMixNotifier = ref.read(savedMixNotifierProvider.notifier);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF1E0036),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Save this mix?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Write mix name",
                hintStyle: TextStyle(color: Colors.white54),
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Cancel Button
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white24,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Cancel", style: TextStyle(color: Colors.white)),
              ),
              // Save Button: Enable only when _isSaveEnabled == true
              ElevatedButton(
                onPressed: _isSaveEnabled
                    ? () async {
                  final name = _nameController.text.trim();
                  if (name.isNotEmpty) {
                    await savedMixNotifier.saveMix(name, widget.currentMixItems);
                    ref.read(currentMixNameProvider.notifier).state = name;
                    Navigator.pop(context); // Close SaveMixBottomSheet
                  }
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isSaveEnabled ? const Color(0xFF9747FF) : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Save", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
