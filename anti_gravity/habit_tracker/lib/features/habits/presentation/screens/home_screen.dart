import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/constants/app_colors.dart';
import 'package:habit_tracker/shared/glass_container.dart';
import 'package:habit_tracker/features/habits/presentation/screens/add_habit_screen.dart';
import 'package:habit_tracker/features/habits/presentation/providers/habit_provider.dart';
import 'package:habit_tracker/features/stats/presentation/screens/stats_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Allow background gradient to show
      appBar: AppBar(
        title: Text(
          'My Habits',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const StatsScreen()),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddHabitScreen()),
          );
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: ref.watch(habitProvider).isEmpty
            ? Center(
                child: Text(
                  'No habits yet.\nTap + to start!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.outfit(color: Colors.white70, fontSize: 18),
                ),
              )
            : AnimationLimiter(
                child: Consumer(
                  builder: (context, ref, child) {
                    final habits = ref.watch(habitProvider);
                    return ListView.builder(
                      padding: const EdgeInsets.all(16.0),
                      itemCount: habits.length,
                      itemBuilder: (BuildContext context, int index) {
                        final habit = habits[index];
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Dismissible(
                                  key: Key(habit.id),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (_) {
                                    ref.read(habitProvider.notifier).deleteHabit(habit.id);
                                  },
                                  background: Container(
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.only(right: 20),
                                    decoration: BoxDecoration(
                                      color: Colors.red.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Icon(Icons.delete, color: Colors.white),
                                  ),
                                  child: GlassContainer(
                                    height: 100,
                                    child: Row(
                                      children: [
                                        // Checkbox (Toggle Completion)
                                        GestureDetector(
                                          onTap: () {
                                            ref.read(habitProvider.notifier).toggleHabitCompletion(habit.id);
                                          },
                                          child: Container(
                                              width: 50,
                                              height: 50,
                                              margin: const EdgeInsets.only(right: 16),
                                              decoration: BoxDecoration(
                                                color: habit.isCompletedToday 
                                                  ? AppColors.secondary.withOpacity(0.5) 
                                                  : Colors.white.withOpacity(0.1),
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: habit.isCompletedToday 
                                                    ? AppColors.secondary 
                                                    : Colors.white.withOpacity(0.5)
                                                ),
                                              ),
                                              child: Icon(
                                                Icons.check, 
                                                color: habit.isCompletedToday ? Colors.white : Colors.white.withOpacity(0.5)
                                              ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                habit.name,
                                                style: GoogleFonts.outfit(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  decoration: habit.isCompletedToday ? TextDecoration.lineThrough : null,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                'Streak: ${habit.streakCount} days',
                                                style: GoogleFonts.outfit(
                                                  color: Colors.white70,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Icon(Icons.chevron_right, color: Colors.white.withOpacity(0.7)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
      ),
    );
  }
}
