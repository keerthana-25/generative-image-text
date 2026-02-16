import 'package:hive_flutter/hive_flutter.dart';
import 'package:habit_tracker/features/habits/domain/habit_model.dart';

class HabitRepository {
  static const String boxName = 'habits_box';

  Future<void> init() async {
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox(boxName);
    }
  }

  List<HabitModel> getAllHabits() {
    final box = Hive.box(boxName);
    return box.values.map((e) {
      final map = Map<String, dynamic>.from(e as Map);
      return HabitModel.fromJson(map);
    }).toList();
  }

  Future<void> saveHabit(HabitModel habit) async {
    final box = Hive.box(boxName);
    await box.put(habit.id, habit.toJson());
  }

  Future<void> deleteHabit(String id) async {
    final box = Hive.box(boxName);
    await box.delete(id);
  }

  Future<void> updateHabit(HabitModel habit) async {
    await saveHabit(habit);
  }
}
