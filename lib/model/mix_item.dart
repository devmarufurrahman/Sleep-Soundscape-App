class MixItem {
  final String name;
  final double value;
  final String icon;

  MixItem({
    required this.name,
    required this.value,
    required this.icon,
  });

  MixItem copyWith({
    String? name,
    double? value,
    String? icon,
  }) {
    return MixItem(
      name: name ?? this.name,
      value: value ?? this.value,
      icon: icon ?? this.icon,
    );
  }
}
