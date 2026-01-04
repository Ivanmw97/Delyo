import 'package:flutter/material.dart';
import 'package:padel_tracker/features/onboarding/repositories/onboarding_repository.dart';
import 'package:padel_tracker/presentation/navigation/main_navigation_page.dart';
import 'package:padel_tracker/l10n/app_localizations.dart';

/// Onboarding screen with 3 pages introducing the app features
///
/// Shows a minimal walkthrough for first-time users with:
/// - Screen 1: Track matches
/// - Screen 2: Analyze progress
/// - Screen 3: Start anytime
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  final OnboardingRepository _onboardingRepository = OnboardingRepository();
  int _currentPage = 0;

  // Animation controllers for each page
  late List<AnimationController> _animationControllers;
  late List<Animation<double>> _iconFadeAnimations;
  late List<Animation<double>> _iconScaleAnimations;
  late List<Animation<Offset>> _titleSlideAnimations;
  late List<Animation<double>> _titleFadeAnimations;
  late List<Animation<double>> _subtitleFadeAnimations;
  late AnimationController _buttonController;
  late Animation<double> _buttonFadeAnimation;

  @override
  void initState() {
    super.initState();
    _onboardingRepository.init();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    // Create animation controllers for each page (increased duration by 40%)
    _animationControllers = List.generate(
      3,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 840),
        vsync: this,
      ),
    );

    // Icon animations (fade + scale)
    _iconFadeAnimations = _animationControllers
        .map(
          (controller) => Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: controller,
              curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
            ),
          ),
        )
        .toList();

    _iconScaleAnimations = _animationControllers
        .map(
          (controller) => Tween<double>(begin: 0.9, end: 1.0).animate(
            CurvedAnimation(
              parent: controller,
              curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
            ),
          ),
        )
        .toList();

    // Title animations (fade + slide up)
    _titleFadeAnimations = _animationControllers
        .map(
          (controller) => Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: controller,
              curve: const Interval(0.2, 0.6, curve: Curves.easeOut),
            ),
          ),
        )
        .toList();

    _titleSlideAnimations = _animationControllers
        .map(
          (controller) =>
              Tween<Offset>(
                begin: const Offset(0, 0.15),
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: controller,
                  curve: const Interval(0.2, 0.6, curve: Curves.easeOut),
                ),
              ),
        )
        .toList();

    // Subtitle animations (fade with delay)
    _subtitleFadeAnimations = _animationControllers
        .map(
          (controller) => Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
              parent: controller,
              curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
            ),
          ),
        )
        .toList();

    // Button animation controller (increased duration by 30%)
    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 390),
      vsync: this,
    );

    _buttonFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeOut),
    );

    // Start animation for first page
    _animationControllers[0].forward();
    _buttonController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    _buttonController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });

    // Trigger animation for the new page
    _animationControllers[page].reset();
    _animationControllers[page].forward();
  }

  Future<void> _completeOnboarding() async {
    await _onboardingRepository.markOnboardingCompleted();

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainNavigationPage()),
      );
    }
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Column(
          children: [
            // Page indicator
            Padding(
              padding: const EdgeInsets.only(top: 32, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == _currentPage
                          ? const Color(0xFF007AFF)
                          : const Color(0xFF007AFF).withOpacity(0.2),
                    ),
                  );
                }),
              ),
            ),

            // PageView content
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                children: [
                  _buildOnboardingScreen(
                    pageIndex: 0,
                    icon: Icons.sports_tennis_outlined,
                    title: AppLocalizations.of(context)!.onboardingTitle1,
                    subtitle: AppLocalizations.of(context)!.onboardingSubtitle1,
                  ),
                  _buildOnboardingScreen(
                    pageIndex: 1,
                    icon: Icons.analytics_outlined,
                    title: AppLocalizations.of(context)!.onboardingTitle2,
                    subtitle: AppLocalizations.of(context)!.onboardingSubtitle2,
                  ),
                  _buildOnboardingScreen(
                    pageIndex: 2,
                    icon: Icons.schedule_outlined,
                    title: AppLocalizations.of(context)!.onboardingTitle3,
                    subtitle: AppLocalizations.of(context)!.onboardingSubtitle3,
                  ),
                ],
              ),
            ),

            // Bottom button with animation
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 16, 32, 32),
              child: AnimatedBuilder(
                animation: _buttonFadeAnimation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _currentPage == 2
                        ? _buttonFadeAnimation.value
                        : 1.0,
                    child: SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: _nextPage,
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF007AFF),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          _currentPage == 2
                              ? AppLocalizations.of(context)!.getStarted
                              : AppLocalizations.of(context)!.next,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingScreen({
    required int pageIndex,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated Icon
          AnimatedBuilder(
            animation: _animationControllers[pageIndex],
            builder: (context, child) {
              return Transform.scale(
                scale: _iconScaleAnimations[pageIndex].value,
                child: Opacity(
                  opacity: _iconFadeAnimations[pageIndex].value,
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xFF007AFF).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, size: 40, color: const Color(0xFF007AFF)),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 32),

          // Animated Title
          AnimatedBuilder(
            animation: _animationControllers[pageIndex],
            builder: (context, child) {
              return SlideTransition(
                position: _titleSlideAnimations[pageIndex],
                child: Opacity(
                  opacity: _titleFadeAnimations[pageIndex].value,
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1D1D1F),
                      letterSpacing: -0.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),

          // Animated Subtitle
          AnimatedBuilder(
            animation: _animationControllers[pageIndex],
            builder: (context, child) {
              return Opacity(
                opacity: _subtitleFadeAnimations[pageIndex].value,
                child: Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF1D1D1F).withOpacity(0.7),
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
