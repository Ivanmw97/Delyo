import 'package:flutter/material.dart';
import 'package:delyo/presentation/theme/app_colors.dart';
import 'package:delyo/features/home/presentation/home_page.dart';
import 'package:delyo/features/matches/presentation/pages/matches_list_page.dart';
import 'package:delyo/features/stats/presentation/stats_page.dart';
import 'package:delyo/l10n/app_localizations.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    HomePage(),
    MatchesListPage(),
    StatsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.accent,
        unselectedItemColor: AppColors.draw,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            activeIcon: const Icon(Icons.home),
            label: AppLocalizations.of(context)!.navigationHome,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.sports_tennis),
            label: AppLocalizations.of(context)!.navigationMatches,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.bar_chart_outlined),
            activeIcon: const Icon(Icons.bar_chart),
            label: AppLocalizations.of(context)!.navigationStats,
          ),
        ],
      ),
    );
  }
}
