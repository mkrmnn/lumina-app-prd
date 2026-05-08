import '../models/daily_check_in.dart';

class MockLuminaRepository {
  DailyCheckIn? _todayCheckIn;

  Future<void> saveCheckIn(DailyCheckIn checkIn) async {
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    _todayCheckIn = checkIn;
  }

  DailyCheckIn? get todayCheckIn => _todayCheckIn;
}
