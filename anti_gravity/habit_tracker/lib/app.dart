import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/core/constants/app_colors.dart';
import 'package:habit_tracker/features/habits/presentation/screens/home_screen.dart';

class HabitTrackerApp extends StatelessWidget {
  const HabitTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Set system overlay style for light status bar on dark gradient
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Habit Tracker',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: Colors.transparent, // Important for background gradient
        textTheme: GoogleFonts.outfitTextTheme().apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark, // Dark theme base for glass
          surface: Colors.transparent, // Glass
        ),
      ),
      home: Container( // Global background wrapper
         decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
         child: const HomeScreen(),
      ),
    );
  }
}
