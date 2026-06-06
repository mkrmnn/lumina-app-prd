class MicroIntervention {
  MicroIntervention({
    required this.id,
    required this.category,
    required this.title,
    required this.aiRationale,
    required this.durationSeconds,
    required this.isPremium,
    required this.contentSteps,
  });

  final String id;
  final String category;
  final String title;
  final String aiRationale;
  final int durationSeconds;
  final bool isPremium;
  final List<String> contentSteps;

  factory MicroIntervention.fromJson(Map<String, dynamic> json) {
    return MicroIntervention(
      id: json['id'] as String,
      category: json['category'] as String,
      title: json['title'] as String,
      aiRationale: json['aiRationale'] as String,
      durationSeconds: json['durationSeconds'] as int,
      isPremium: json['isPremium'] as bool,
      contentSteps: List<String>.from(json['contentSteps'] as List<dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'category': category,
      'title': title,
      'aiRationale': aiRationale,
      'durationSeconds': durationSeconds,
      'isPremium': isPremium,
      'contentSteps': contentSteps,
    };
  }
}
