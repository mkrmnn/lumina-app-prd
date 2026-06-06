import '../models/daily_check_in.dart';
import '../models/micro_intervention.dart';
import '../models/user_progress.dart';
import 'lumina_repository_interface.dart';

class MockLuminaRepository implements ILuminaRepository {
  DailyCheckIn? _todayCheckIn;
  int _totalCheckIns = 27;
  int _currentStreak = 6;
  final List<int> _recentMoods = <int>[3, 4, 4, 2, 5, 4, 3];

  @override
  Future<DailyCheckIn?> getTodayCheckIn() async {
    await Future.delayed(const Duration(milliseconds: 1200));
    return _todayCheckIn;
  }

  @override
  Future<void> saveCheckIn(DailyCheckIn checkIn) async {
    await Future.delayed(const Duration(milliseconds: 1200));
    _todayCheckIn = checkIn;
    _totalCheckIns += 1;
    _currentStreak += 1;
    _recentMoods.add(checkIn.mood);
    if (_recentMoods.length > 7) {
      _recentMoods.removeAt(0);
    }
  }

  @override
  Future<MicroIntervention> getAiRecommendation(int mood, int energy) async {
    await Future.delayed(const Duration(milliseconds: 1200));

    if (mood <= 2 || energy <= 2) {
      return MicroIntervention(
        id: 'mi_breath_reset',
        category: 'Nefes',
        title: '2 Dakikalik Sakinlestirici Nefes',
        aiRationale:
            'Odak seviyen dusuk oldugu icin bu kisa nefes egzersizi sana iyi gelecek.',
        durationSeconds: 120,
        isPremium: false,
        contentSteps: <String>[
          'Rahat bir pozisyonda otur ve omuzlarini gevset.',
          '4 saniye boyunca burnundan derin nefes al.',
          '4 saniye nefesini tut.',
          '6 saniye boyunca nefesi yavasca ver.',
          'Bu donguyu 6 kez tekrar et.',
        ],
      );
    }

    if (mood >= 4 && energy >= 4) {
      return MicroIntervention(
        id: 'mi_focus_sprint',
        category: 'Odak',
        title: '5 Dakikalik Mikro Odak Sprinti',
        aiRationale:
            'Enerjin ve ruh halin yuksek oldugu icin bu anlik odak sprinti verimini artirabilir.',
        durationSeconds: 300,
        isPremium: true,
        contentSteps: <String>[
          'Tek bir gorev sec ve zamanlayiciyi 5 dakikaya ayarla.',
          'Bildirimleri kapat ve sadece goreve odaklan.',
          'Bitiste 30 saniye degerlendirme notu al.',
        ],
      );
    }

    return MicroIntervention(
      id: 'mi_grounding_scan',
      category: 'Farkindalik',
      title: '3 Dakikalik Duyusal Topraklama',
      aiRationale:
          'Dengen orta seviyede; bu kisa topraklama calismasi zihinsel berrakligini destekler.',
      durationSeconds: 180,
      isPremium: false,
      contentSteps: <String>[
        'Cevrende gordugun 5 seyi fark et.',
        'Dokunabildigin 4 seye odaklan.',
        'Duydugun 3 sesi belirle.',
        'Kokladigin 2 kokuyu ayirt et.',
        'Tadabildigin 1 seyi fark et ve derin bir nefes al.',
      ],
    );
  }

  @override
  Future<UserProgress> getUserProgress() async {
    await Future.delayed(const Duration(milliseconds: 1200));
    final double averageMood =
        _recentMoods.reduce((int a, int b) => a + b) / _recentMoods.length;

    return UserProgress(
      currentStreak: _currentStreak,
      totalCheckIns: _totalCheckIns,
      weeklyMoodAverage: double.parse(averageMood.toStringAsFixed(1)),
    );
  }
}
