import 'package:flutter/material.dart';
import 'create_mix_bottom_sheet.dart';

class CustomMiniFab extends StatelessWidget {
  final String icon;
  final String tooltip;

  const CustomMiniFab({
    super.key,
    required this.icon,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: true,
      tooltip: tooltip,
      onPressed: () {
        if (tooltip == "Create") {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (ctx) {
              return const CreateMixBottomSheet();
            },
          );
        }
        else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Clicked $tooltip")),
          );
        }
      },
      child: ImageIcon(
        AssetImage(icon),
      ),
    );
  }
}
