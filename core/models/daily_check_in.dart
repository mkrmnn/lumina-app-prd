class DailyCheckIn {
  DailyCheckIn({
    required this.id,
    required this.timestamp,
    required this.mood,
    required this.energy,
    required this.focus,
    required this.emotionTags,
    this.journalEntry,
    required this.completionTimeSeconds,
  });

  final String id;
  final DateTime timestamp;
  final int mood;
  final int energy;
  final int focus;
  final List<String> emotionTags;
  final String? journalEntry;
  final int completionTimeSeconds;
}
