import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/constants/app_colors.dart';
import 'package:habit_tracker/shared/glass_container.dart';
import 'package:habit_tracker/features/habits/presentation/providers/habit_provider.dart';

class AddHabitScreen extends ConsumerStatefulWidget {
  const AddHabitScreen({super.key});

  @override
  ConsumerState<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends ConsumerState<AddHabitScreen> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, 
      appBar: AppBar(
        title: Text(
          'New Habit',
          style: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'What do you want to track?',
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              GlassContainer(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: TextField(
                  controller: _nameController,
                  autofocus: true,
                  style: GoogleFonts.outfit(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'e.g., Drink Water, Read 10 Pages',
                    hintStyle: GoogleFonts.outfit(color: Colors.white54),
                    border: InputBorder.none,
                    icon: const Icon(Icons.edit, color: Colors.white70),
                  ),
                ),
              ),
              const SizedBox(height: 16),
               GlassContainer(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: TextField(
                  controller: _descController,
                   style: GoogleFonts.outfit(color: Colors.white),
                   decoration: InputDecoration(
                    hintText: 'Description (optional)',
                    hintStyle: GoogleFonts.outfit(color: Colors.white54),
                    border: InputBorder.none,
                    icon: const Icon(Icons.notes, color: Colors.white70),
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  if (_nameController.text.trim().isEmpty) return;
                  
                  await ref.read(habitProvider.notifier).addHabit(
                    _nameController.text.trim(),
                    _descController.text.trim(),
                  );
                  
                  if (mounted) {
                    Navigator.of(context).pop();
                  }
                },
                child: GlassContainer(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [AppColors.secondary, AppColors.primary],
                  ),
                  child: Center(
                    child: Text(
                      'Create Habit',
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
