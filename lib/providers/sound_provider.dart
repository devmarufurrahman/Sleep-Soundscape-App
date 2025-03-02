import 'package:flutter_riverpod/flutter_riverpod.dart';

final categories = ["All", "Rain", "Water", "Wind", "Instrument", "Saved"];

class SoundState {
  final int selectedTab;
  final String selectedCategory;

  SoundState({required this.selectedTab, required this.selectedCategory});

  SoundState copyWith({int? selectedTab, String? selectedCategory}) {
    return SoundState(
      selectedTab: selectedTab ?? this.selectedTab,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}

class SoundNotifier extends StateNotifier<SoundState> {
  SoundNotifier() : super(SoundState(selectedTab: 0, selectedCategory: "All"));

  void changeTab(int tabIndex) {
    state = state.copyWith(selectedTab: tabIndex);
  }

  void changeCategory(String category) {
    state = state.copyWith(selectedCategory: category);
  }
}

final soundProvider = StateNotifierProvider<SoundNotifier, SoundState>((ref) {
  return SoundNotifier();
});
