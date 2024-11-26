import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data/model/habit.dart';

final habitProvider = StateNotifierProvider<HabitNotifier, List<Habit>>((ref) {
  return HabitNotifier();
});

class HabitNotifier extends StateNotifier<List<Habit>> {
  HabitNotifier() : super([]);

  Future<void> getAllHabits() async {
    final box = await Hive.openBox('habitBox');
    state = box.values.cast<Habit>().toList();
  }

  void addHabit(Habit habit) async {
    final box = await Hive.openBox('habitBox');
    box.add(habit);
    state = [...state, habit];
  }
}
