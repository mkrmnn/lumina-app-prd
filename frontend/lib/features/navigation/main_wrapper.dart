import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../checkin/checkin_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../statistics/statistics_screen.dart'; 

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    DashboardScreen(),
    CheckInScreen(),
    StatisticsScreen(), 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() => _selectedIndex = index);
        },
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.lilac,
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Ana Sayfa'),
          NavigationDestination(icon: Icon(Icons.edit_note_outlined), selectedIcon: Icon(Icons.edit_note), label: 'Check-in'),
          NavigationDestination(icon: Icon(Icons.bar_chart_outlined), selectedIcon: Icon(Icons.bar_chart), label: 'İstatistikler'),
        ],
      ),
    );
  }
}