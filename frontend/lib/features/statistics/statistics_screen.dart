import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../core/theme/app_theme.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  bool _isLoading = true;
  double _avgMood = 0;
  double _avgFocus = 0;
  double _avgEnergy = 0;
  List<dynamic> _recentLogs = [];

  final String apiUrl = 'https://lumina-api-735e.onrender.com';

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
        if (data.isNotEmpty) {
          double totalMood = 0;
          double totalFocus = 0;
          double totalEnergy = 0;

          for (var item in data) {
            totalMood += (item['mood'] ?? 0).toDouble();
            totalFocus += (item['focus'] ?? 0).toDouble();
            totalEnergy += (item['energy'] ?? 0).toDouble();
          }

          setState(() {
            _avgMood = totalMood / data.length;
            _avgFocus = totalFocus / data.length;
            _avgEnergy = totalEnergy / data.length;
            _recentLogs = data.take(5).toList();
            _isLoading = false;
          });
        } else {
          setState(() => _isLoading = false);
        }
      }
    } catch (e) {
      debugPrint('İstatistik hatası: $e');
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
            children: [
              const Text('Analizler', style: AppTextStyles.screenTitle),
              const SizedBox(height: 20),
              Row(
                children: [
                  _buildStatCard('Mood', _avgMood.toStringAsFixed(1), Icons.wb_sunny_outlined, Colors.orange),
                  const SizedBox(width: 12),
                  _buildStatCard('Odak', _avgFocus.toStringAsFixed(1), Icons.center_focus_strong, Colors.blue),
                ],
              ),
              const SizedBox(height: 12),
              _buildStatCard('Enerji', _avgEnergy.toStringAsFixed(1), Icons.bolt, Colors.amber, fullWidth: true),
              const SizedBox(height: 25),
              const Text('Son Kayıtlar', style: AppTextStyles.sectionTitle),
              const SizedBox(height: 12),
              ..._recentLogs.map((log) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(15), border: Border.all(color: AppColors.border)),
                child: Row(
                  children: [
                    CircleAvatar(backgroundColor: AppColors.lilac, child: Text(log['mood'].toString(), style: const TextStyle(color: AppColors.deepPurple, fontWeight: FontWeight.bold))),
                    const SizedBox(width: 15),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(log['aiSentiment'] ?? 'Analiz Bekleniyor', style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(log['journalEntry'] ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.hint),
                    ])),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color, {bool fullWidth = false}) {
    return Expanded(
      flex: fullWidth ? 0 : 1,
      child: Container(
        width: fullWidth ? double.infinity : null, padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
        child: Column(children: [Icon(icon, color: color), const SizedBox(height: 8), Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary)), Text(title, style: AppTextStyles.hint)]),
      ),
    );
  }
}