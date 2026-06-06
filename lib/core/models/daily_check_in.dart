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

  factory DailyCheckIn.fromJson(Map<String, dynamic> json) {
    return DailyCheckIn(
      id: json['id'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      mood: json['mood'] as int,
      energy: json['energy'] as int,
      focus: json['focus'] as int,
      emotionTags: List<String>.from(json['emotionTags'] as List<dynamic>),
      journalEntry: json['journalEntry'] as String?,
      completionTimeSeconds: json['completionTimeSeconds'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'timestamp': timestamp.toIso8601String(),
      'mood': mood,
      'energy': energy,
      'focus': focus,
      'emotionTags': emotionTags,
      'journalEntry': journalEntry,
      'completionTimeSeconds': completionTimeSeconds,
    };
  }
}
