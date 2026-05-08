import 'package:flutter/material.dart';

import '../../core/models/daily_check_in.dart';
import '../../core/repositories/mock_lumina_repository.dart';
import '../../core/theme/app_theme.dart';

class CheckInScreen extends StatefulWidget {
  const CheckInScreen({super.key});

  @override
  State<CheckInScreen> createState() => _CheckInScreenState();
}

class _CheckInScreenState extends State<CheckInScreen> {
  final MockLuminaRepository _repository = MockLuminaRepository();
  final TextEditingController _noteController = TextEditingController();
  final List<String> _moods = <String>['😢', '😐', '🙂', '😊', '🤩'];

  int _selectedMood = 3;
  double _energy = 3.0;
  double _focus = 3.0;
  bool _isSaving = false;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _saveCheckIn() async {
    if (_isSaving) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final DateTime now = DateTime.now();
    final String note = _noteController.text.trim();

    final DailyCheckIn checkIn = DailyCheckIn(
      id: 'ci_${now.microsecondsSinceEpoch}',
      timestamp: now,
      mood: _selectedMood,
      energy: _energy.round(),
      focus: _focus.round(),
      emotionTags: const <String>[],
      journalEntry: note.isEmpty ? null : note,
      completionTimeSeconds: 0,
    );

    await _repository.saveCheckIn(checkIn);

    if (!mounted) {
      return;
    }

    setState(() {
      _isSaving = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Check-in kaydedildi.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: const Text('Lumina Check-in', style: AppTextStyles.sectionTitle),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Bugun nasilsin?', style: AppTextStyles.screenTitle),
              const SizedBox(height: 20),
              _SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('Mood Secici', style: AppTextStyles.sectionTitle),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List<Widget>.generate(_moods.length, (int index) {
                        final int moodValue = index + 1;
                        final bool isSelected = _selectedMood == moodValue;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedMood = moodValue;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primary.withValues(alpha: 0.15)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected ? AppColors.primary : AppColors.border,
                              ),
                            ),
                            child: Text(_moods[index], style: const TextStyle(fontSize: 28)),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Enerji: ${_energy.round()}', style: AppTextStyles.sectionTitle),
                    Slider(
                      min: 1.0,
                      max: 5.0,
                      divisions: 4,
                      value: _energy,
                      label: _energy.round().toString(),
                      activeColor: AppColors.primary,
                      onChanged: (double value) {
                        setState(() {
                          _energy = value;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    Text('Odak: ${_focus.round()}', style: AppTextStyles.sectionTitle),
                    Slider(
                      min: 1.0,
                      max: 5.0,
                      divisions: 4,
                      value: _focus,
                      label: _focus.round().toString(),
                      activeColor: AppColors.primary,
                      onChanged: (double value) {
                        setState(() {
                          _focus = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('Not', style: AppTextStyles.sectionTitle),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _noteController,
                      maxLines: 3,
                      style: AppTextStyles.body,
                      decoration: InputDecoration(
                        hintText: 'Kisa bir not ekle...',
                        hintStyle: AppTextStyles.hint,
                        filled: true,
                        fillColor: AppColors.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.primary),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: _isSaving ? null : _saveCheckIn,
                  child: _isSaving
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text('Kaydet', style: AppTextStyles.button),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: child,
    );
  }
}
