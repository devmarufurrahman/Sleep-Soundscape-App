import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sleep_soundscape_app/core/assets.dart';
import '../model/mix_item.dart';
import 'package:flutter/material.dart';

class MixNotifier extends StateNotifier<List<MixItem>> {
  MixNotifier()
      : super([
    MixItem(name: "Typhoon", value: 0.7, icon: Assets.iconTyphoon),
    MixItem(name: "Sleet", value: 0.8, icon: Assets.iconSleet),
    MixItem(name: "Desert Wind", value: 0.5, icon: Assets.iconDesertWind),
    MixItem(name: "Starry Night", value: 0.3, icon: Assets.iconStarryNight),
    MixItem(name: "Tribal Drums", value: 0.9, icon: Assets.iconTribalDrums),
  ]);


  void updateValue(String name, double newValue) {
    state = state.map((item) {
      if (item.name == name) {
        return item.copyWith(value: newValue);
      }
      return item;
    }).toList();
  }

  void removeItem(String name) {
    state = state.where((item) => item.name != name).toList();
  }

  void clearAll() {
    state = state.map((item) => item.copyWith(value: 0.0)).toList();
  }

  void setMixItems(List<MixItem> newItems) {
    state = newItems;
  }

}

final currentMixNameProvider = StateProvider<String>((ref) => "Your Mix");
final mixProvider = StateNotifierProvider<MixNotifier, List<MixItem>>((ref) {
  return MixNotifier();
});
