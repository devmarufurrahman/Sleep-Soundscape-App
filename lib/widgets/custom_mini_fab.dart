import 'package:flutter/material.dart';

class CustomMiniFab extends StatelessWidget {
  final String icon;
  final String tooltip;
  final bool isSelected;
  final VoidCallback onPressed;

  const CustomMiniFab({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: true,
      tooltip: tooltip,
      onPressed: onPressed,
      backgroundColor: isSelected ? Color(0xFF9747FF) : Colors.transparent,
      elevation: isSelected ? 6 : 1,
      child: ImageIcon(
        AssetImage(icon),
        size: 24,
        color: Colors.white,
      ),
    );
  }
}
