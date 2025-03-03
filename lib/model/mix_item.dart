import 'package:flutter/material.dart';

class MixItem {
  final String name;
  final double value;
  final IconData icon;

  MixItem({
    required this.name,
    required this.value,
    required this.icon,
  });


  MixItem copyWith({
    String? name,
    double? value,
    IconData? icon,
  }) {
    return MixItem(
      name: name ?? this.name,
      value: value ?? this.value,
      icon: icon ?? this.icon,
    );
  }
}
