import 'package:flutter/material.dart';

import '../theme/app_assets.dart';
import '../routes/app_routes.dart';

// --- Data Model ---

class OnboardingPage {
  final String image;
  final String title;

  const OnboardingPage({required this.image, required this.title});
}

// --- Screen ---

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const List<OnboardingPage> _pages = [
    OnboardingPage(
      image: AppAssets.screen1,
      title: 'Understand Your\nMental State',
    ),
    OnboardingPage(
      image: AppAssets.screen2,
      title:
          'Simple, actionable steps to\nsupport your mental and\nShort quizzes to track your\nprogress',
    ),
    OnboardingPage(
      image: AppAssets.screen3,
      title: 'Activities That Help You\nFeel Better',
    ),
  ];

  bool get _isFirst => _currentPage == 0;
  bool get _isLast => _currentPage == _pages.length - 1;

  void _goNext() {
    if (_isLast) {
      Navigator.pushReplacementNamed(context, AppRoutes.welcome);
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goBack() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            _DotsIndicator(count: _pages.length, current: _currentPage),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemBuilder: (_, i) => _OnboardingPageView(page: _pages[i]),
              ),
            ),
            _BottomNavRow(
              showBack: !_isFirst,
              onNext: _goNext,
              onBack: _goBack,
            ),
          ],
        ),
      ),
    );
  }
}

// --- Sub-widgets ---

class _OnboardingPageView extends StatelessWidget {
  final OnboardingPage page;
  const _OnboardingPageView({required this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            page.image,
            width: MediaQuery.of(context).size.width * 0.78,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 40),
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.grey,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _DotsIndicator extends StatelessWidget {
  final int count;
  final int current;

  const _DotsIndicator({required this.count, required this.current});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 38,
          height: 4,
          decoration: BoxDecoration(
            color: i == current
                ? const Color(0xFF008657)
                : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}

class _BottomNavRow extends StatelessWidget {
  final bool showBack;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const _BottomNavRow({
    required this.showBack,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(28, 8, 28, 28),
      child: Row(
        mainAxisAlignment: showBack
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.end,
        children: [
          if (showBack) _NavButton(label: 'Back', onTap: onBack, isBack: true),
          _NavButton(label: 'Next', onTap: onNext, isBack: false),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isBack;

  const _NavButton({
    required this.label,
    required this.onTap,
    required this.isBack,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        decoration: BoxDecoration(
          color: isBack
              ? const Color(0xFFE2D696) 
              : const Color(0xFF008657),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: isBack ? Colors.grey[800] : Colors.white,
          ),
        ),
      ),
    );
  }
}
