import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../core/theme/app_theme.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _streak = 0;
  List<int> _moodBars = [];
  String _aiRecommendation = 'Analiz ediliyor...';
  bool _isLoading = true;
  String? _errorMessage;

final String apiUrl = 'https://lumina-api-735e.onrender.com/api/v1/check-ins';

  @override
  void initState() {
    super.initState();
    _fetchRealData();
  }

  Future<void> _fetchRealData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
        
        if (data.isEmpty) {
          setState(() {
            _isLoading = false;
            _moodBars = [1, 1, 1, 1, 1, 1, 1]; 
          });
          return;
        }

        List<int> fetchedMoods = [];
        String latestRecommendation = 'Tavsiyeler yüklenemedi.';

        // En son kayıtlar ilk sırada (first) olduğu için veriyi düzgün işliyoruz
        final recentData = data.length > 7 ? data.sublist(0, 7) : data;
        final reversedForGraph = recentData.reversed.toList();
        
        for (var item in reversedForGraph) {
           fetchedMoods.add(item['mood'] ?? 3);
        }

        final latestEntry = data.first;
        if (latestEntry['aiRecommendation'] != null) {
          latestRecommendation = latestEntry['aiRecommendation'];
        }

        setState(() {
          _moodBars = fetchedMoods;
          _aiRecommendation = latestRecommendation;
          _streak = data.length; 
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Sunucu Hatası: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Sunucuya bağlanılamadı.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator(color: AppColors.primary));
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Hos geldin Mukremin', style: AppTextStyles.screenTitle),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: <Color>[AppColors.deepPurple, AppColors.primary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.local_fire_department, color: Colors.white, size: 30),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('$_streak Toplam Kayıt', style: AppTextStyles.button),
                        const Text('Harika gidiyorsun!', style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _DashboardCard(
                title: 'Haftalık Mood Özeti',
                child: SizedBox(
                  height: 160,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List<Widget>.generate(_moodBars.length, (int index) {
                      final int value = _moodBars[index];
                      final double barHeight = 22 + (value * 22);
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                height: barHeight,
                                decoration: BoxDecoration(
                                  color: AppColors.purple.withOpacity(0.82),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text('G${index + 1}', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _InfoCard(
                title: 'Gemini Analizi',
                description: _aiRecommendation,
                iconData: Icons.auto_awesome,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// _DashboardCard ve _InfoCard sınıflarını buraya eklemeyi unutma (senin mevcut kodundaki aynı sınıflar)
class _DashboardCard extends StatelessWidget {
  const _DashboardCard({required this.title, required this.child});
  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Text(title, style: AppTextStyles.sectionTitle), const SizedBox(height: 12), child,
      ]),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.description, required this.iconData});
  final String title;
  final String description;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.border)),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppColors.lilac, borderRadius: BorderRadius.circular(10)), child: Icon(iconData, color: AppColors.deepPurple)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Text(title, style: AppTextStyles.sectionTitle), const SizedBox(height: 8), Text(description, style: AppTextStyles.hint.copyWith(height: 1.4)),
        ])),
      ]),
    );
  }
}