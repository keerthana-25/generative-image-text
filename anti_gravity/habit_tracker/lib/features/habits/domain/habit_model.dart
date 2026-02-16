class HabitModel {
  final String id;
  final String name;
  final String description;
  final DateTime createdAt;
  final List<DateTime> completedDates;
  final int streakCount;

  HabitModel({
    required this.id,
    required this.name,
    this.description = '',
    required this.createdAt,
    this.completedDates = const [],
    this.streakCount = 0,
  });

  bool get isCompletedToday {
    if (completedDates.isEmpty) return false;
    final now = DateTime.now();
    final lastCompletion = completedDates.last;
    return lastCompletion.year == now.year &&
        lastCompletion.month == now.month &&
        lastCompletion.day == now.day;
  }

  HabitModel copyWith({
    String? name,
    String? description,
    List<DateTime>? completedDates,
    int? streakCount,
  }) {
    return HabitModel(
      id: id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt,
      completedDates: completedDates ?? this.completedDates,
      streakCount: streakCount ?? this.streakCount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'completedDates': completedDates.map((e) => e.toIso8601String()).toList(),
      'streakCount': streakCount,
    };
  }

  factory HabitModel.fromJson(Map<String, dynamic> json) {
    return HabitModel(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      completedDates: (json['completedDates'] as List)
          .map((e) => DateTime.parse(e))
          .toList(),
      streakCount: json['streakCount'] ?? 0,
    );
  }
}
