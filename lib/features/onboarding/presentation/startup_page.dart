import 'package:flutter/material.dart';
import 'package:padel_tracker/features/onboarding/repositories/onboarding_repository.dart';
import 'package:padel_tracker/features/onboarding/presentation/welcome_screen.dart';
import 'package:padel_tracker/features/onboarding/presentation/onboarding_page.dart';
import 'package:padel_tracker/presentation/navigation/main_navigation_page.dart';

/// Startup page that decides whether to show onboarding or go directly to home
///
/// This page handles the initial app logic:
/// - Check if user has seen onboarding
/// - Navigate to onboarding for first-time users
/// - Navigate to home for returning users
class StartupPage extends StatefulWidget {
  const StartupPage({super.key});

  @override
  State<StartupPage> createState() => _StartupPageState();
}

class _StartupPageState extends State<StartupPage> {
  final OnboardingRepository _onboardingRepository = OnboardingRepository();

  @override
  void initState() {
    super.initState();
    _checkOnboardingStatus();
  }

  Future<void> _checkOnboardingStatus() async {
    // Initialize the repository
    await _onboardingRepository.init();

    // Check if user has seen onboarding
    final hasSeenOnboarding = _onboardingRepository.hasSeenOnboarding();

    // Small delay to avoid jarring transitions
    await Future.delayed(const Duration(milliseconds: 500));

    if (mounted) {
      if (hasSeenOnboarding) {
        // User has seen onboarding, go to main app
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainNavigationPage()),
        );
      } else {
        // First-time user, show welcome screen first
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => WelcomeScreen(
              onComplete: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const OnboardingPage(),
                  ),
                );
              },
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: Center(child: CircularProgressIndicator(color: Color(0xFF007AFF))),
    );
  }
}
