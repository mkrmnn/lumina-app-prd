class UserProgress {
  UserProgress({
    required this.currentStreak,
    required this.totalCheckIns,
    required this.weeklyMoodAverage,
  });

  final int currentStreak;
  final int totalCheckIns;
  final double weeklyMoodAverage;

  factory UserProgress.fromJson(Map<String, dynamic> json) {
    return UserProgress(
      currentStreak: json['currentStreak'] as int,
      totalCheckIns: json['totalCheckIns'] as int,
      weeklyMoodAverage: (json['weeklyMoodAverage'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'currentStreak': currentStreak,
      'totalCheckIns': totalCheckIns,
      'weeklyMoodAverage': weeklyMoodAverage,
    };
  }
}
