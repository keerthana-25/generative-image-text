import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/app.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  // We'll open the box inside the repository init, but ensuring Hive is ready here.

  runApp(
    const ProviderScope(
      child: HabitTrackerApp(),
    ),
  );
}
