import '../models/daily_check_in.dart';
import '../models/micro_intervention.dart';
import '../models/user_progress.dart';

abstract class ILuminaRepository {
  Future<DailyCheckIn?> getTodayCheckIn();
  Future<void> saveCheckIn(DailyCheckIn checkIn);
  Future<MicroIntervention> getAiRecommendation(int mood, int energy);
  Future<UserProgress> getUserProgress();
}
