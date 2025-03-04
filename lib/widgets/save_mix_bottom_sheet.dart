import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/mix_provider.dart';
import '../providers/saved_mix_provider.dart';

class SaveMixBottomSheet extends ConsumerStatefulWidget {
  final Map<String, double> currentMixItems;
  final String? initialName;
  final bool isRename;

  const SaveMixBottomSheet({
    super.key,
    required this.currentMixItems,
    this.initialName,
    this.isRename = false,
  });

  @override
  ConsumerState<SaveMixBottomSheet> createState() => _SaveMixBottomSheetState();
}

class _SaveMixBottomSheetState extends ConsumerState<SaveMixBottomSheet> {
  final TextEditingController _nameController = TextEditingController();
  bool _isSaveEnabled = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialName != null) {
      _nameController.text = widget.initialName!;
    }
    _nameController.addListener(() {
      setState(() {
        _isSaveEnabled = _nameController.text.trim().isNotEmpty;
      });
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


    final String title = widget.isRename ? "Rename this mix?" : "Save this mix?";
    final String saveButtonText = widget.isRename ? "Save Changes" : "Save";

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
          Text(
            title,
            style: const TextStyle(
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

              ElevatedButton(
                onPressed: _isSaveEnabled
                    ? () async {
                  final newName = _nameController.text.trim();
                  if (newName.isNotEmpty) {

                    if (widget.isRename &&
                        widget.initialName != null &&
                        widget.initialName != newName) {

                      await ref.read(savedMixNotifierProvider.notifier).removeMix(widget.initialName!);
                    }

                    await ref.read(savedMixNotifierProvider.notifier).saveMix(newName, widget.currentMixItems);

                    ref.read(currentMixNameProvider.notifier).state = newName;
                    Navigator.pop(context);
                  }
                }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isSaveEnabled ? const Color(0xFF9747FF) : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(saveButtonText, style: const TextStyle(color: Colors.white)),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
