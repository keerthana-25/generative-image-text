import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/features/habits/data/habit_repository.dart';
import 'package:habit_tracker/features/habits/domain/habit_model.dart';
import 'package:uuid/uuid.dart';

final habitRepositoryProvider = Provider((ref) => HabitRepository());

final habitProvider = NotifierProvider<HabitNotifier, List<HabitModel>>(HabitNotifier.new);

class HabitNotifier extends Notifier<List<HabitModel>> {
  late final HabitRepository _repository;

  @override
  List<HabitModel> build() {
    _repository = ref.watch(habitRepositoryProvider);
    _loadHabits();
    return [];
  }

  Future<void> _loadHabits() async {
    await _repository.init();
    state = _repository.getAllHabits();
  }

  Future<void> addHabit(String name, String description) async {
    final habit = HabitModel(
      id: const Uuid().v4(),
      name: name,
      description: description,
      createdAt: DateTime.now(),
      completedDates: [],
      streakCount: 0,
    );
    await _repository.saveHabit(habit);
    state = [...state, habit];
  }

  Future<void> toggleHabitCompletion(String id) async {
    final index = state.indexWhere((h) => h.id == id);
    if (index == -1) return;

    final habit = state[index];
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    List<DateTime> updatedDates = List.from(habit.completedDates);
    int updatedStreak = habit.streakCount;

    if (habit.isCompletedToday) {
      // Uncheck today
      updatedDates.removeWhere((d) => 
        d.year == today.year && d.month == today.month && d.day == today.day);
      updatedStreak = _calculateStreak(updatedDates);
    } else {
      // Check today
      updatedDates.add(now);
      updatedDates.sort();
      updatedStreak = _calculateStreak(updatedDates);
    }

    final updatedHabit = habit.copyWith(
      completedDates: updatedDates,
      streakCount: updatedStreak,
    );

    await _repository.updateHabit(updatedHabit);
    state = [
      for (final h in state)
        if (h.id == id) updatedHabit else h
    ];
  }

  Future<void> deleteHabit(String id) async {
    await _repository.deleteHabit(id);
    state = state.where((h) => h.id != id).toList();
  }

  int _calculateStreak(List<DateTime> dates) {
    if (dates.isEmpty) return 0;
    
    // Sort unique dates by day
    final sortedDates = dates.map((d) => DateTime(d.year, d.month, d.day)).toSet().toList()..sort();
    
    int streak = 0;
    DateTime lastDate = DateTime.now();
    lastDate = DateTime(lastDate.year, lastDate.month, lastDate.day);

    // If not completed today, check if it was completed yesterday to continue streak
    if (sortedDates.last != lastDate) {
      final yesterday = lastDate.subtract(const Duration(days: 1));
      if (sortedDates.last != yesterday) return 0;
      lastDate = yesterday;
    }

    for (int i = sortedDates.length - 1; i >= 0; i--) {
      if (sortedDates[i] == lastDate) {
        streak++;
        lastDate = lastDate.subtract(const Duration(days: 1));
      } else {
        break;
      }
    }
    return streak;
  }
}
