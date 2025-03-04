import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../model/saved_mix.dart';

final savedMixNotifierProvider = StateNotifierProvider<SavedMixNotifier, List<SavedMix>>((ref) {
  return SavedMixNotifier();
});

class SavedMixNotifier extends StateNotifier<List<SavedMix>> {
  final Box _box = Hive.box('saved_mixes');

  SavedMixNotifier() : super([]) {
    _loadFromHive();
  }

  Future<void> _loadFromHive() async {
    List<SavedMix> loadedList = [];
    for (var key in _box.keys) {
      final mixMap = _box.get(key);
      if (mixMap is Map) {
        loadedList.add(
          SavedMix(name: key, items: Map<String, double>.from(mixMap)),
        );
      }
    }
    state = loadedList;
  }

  Future<void> saveMix(String mixName, Map<String, double> items) async {
    await _box.put(mixName, items);
    List<SavedMix> newList = [...state];
    final existingIndex = newList.indexWhere((m) => m.name == mixName);
    if (existingIndex >= 0) {
      newList[existingIndex] = SavedMix(name: mixName, items: items);
    } else {
      newList.add(SavedMix(name: mixName, items: items));
    }
    state = newList;
  }
}
