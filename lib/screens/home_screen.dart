import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_assets.dart';

import '../screens/chat_screen.dart';

class MainShellScreen extends StatefulWidget {
  const MainShellScreen({super.key});

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    _HomeTab(),
    ChatScreen(),
    Scaffold(body: Center(child: Text("Progressing Screen"))), // Placeholder
    Scaffold(body: Center(child: Text("Settings Screen"))), // Placeholder
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackground,
      extendBody: true,
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: _BottomNav(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _HomeHeader(),
            SizedBox(height: 16),
            _HomeIllustration(),
            SizedBox(height: 20),
            _WeeklyProgressCard(),
            SizedBox(height: 20),
            _ActionCardsRow(),
            SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Header
// ---------------------------------------------------------------------------

class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(child: _GreetingText()),
          const SizedBox(width: 12),
          _AvatarCircle(),
        ],
      ),
    );
  }
}

class _GreetingText extends StatelessWidget {
  const _GreetingText();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hi Mohamed',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'We are here for you 🩷',
          style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

class _AvatarCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: AppColors.border,
      child: const Icon(Icons.person, color: AppColors.primary, size: 28),
    );
  }
}

// ---------------------------------------------------------------------------
// Illustration
// ---------------------------------------------------------------------------

class _HomeIllustration extends StatelessWidget {
  const _HomeIllustration();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Image.asset(
        AppAssets.screenHome,
        width: double.infinity,
        height: 180,
        fit: BoxFit.contain,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Weekly Progress
// ---------------------------------------------------------------------------

class _WeeklyProgressCard extends StatelessWidget {
  const _WeeklyProgressCard();

  static const List<_DayData> _days = [
    _DayData(label: 'M', state: _DayState.done),
    _DayData(label: 'T', state: _DayState.done),
    _DayData(label: 'W', state: _DayState.done),
    _DayData(label: 'T', state: _DayState.today),
    _DayData(label: 'F', state: _DayState.upcoming),
    _DayData(label: 'S', state: _DayState.upcoming),
    _DayData(label: 'S', state: _DayState.upcoming),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ProgressHeader(),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _days.map((d) => _DayCircle(data: d)).toList(),
          ),
        ],
      ),
    );
  }
}

class _ProgressHeader extends StatelessWidget {
  const _ProgressHeader();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'WEEKLY PROGRESS',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: AppColors.textWhite,
            letterSpacing: 1.2,
          ),
        ),
        Text(
          '85% Goal',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.checkBlue,
          ),
        ),
      ],
    );
  }
}

enum _DayState { done, today, upcoming }

class _DayData {
  final String label;
  final _DayState state;
  const _DayData({required this.label, required this.state});
}

class _DayCircle extends StatelessWidget {
  final _DayData data;
  const _DayCircle({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          data.label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Colors.white.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(color: _bgColor, shape: BoxShape.circle),
          child: Center(child: _icon),
        ),
      ],
    );
  }

  Color get _bgColor {
    switch (data.state) {
      case _DayState.done:
        return AppColors.checkBlue;
      case _DayState.today:
        return AppColors.checkGreen;
      case _DayState.upcoming:
        return Colors.white.withValues(alpha: 0.15);
    }
  }

  Widget get _icon {
    switch (data.state) {
      case _DayState.done:
        return const Icon(Icons.check, color: Colors.white, size: 16);
      case _DayState.today:
        return const Icon(Icons.play_arrow, color: Colors.white, size: 16);
      case _DayState.upcoming:
        return Text(
          data.label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        );
    }
  }
}

// ---------------------------------------------------------------------------
// Action Cards
// ---------------------------------------------------------------------------

class _ActionCardsRow extends StatelessWidget {
  const _ActionCardsRow();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: _ActionCard(
              icon: Icons.edit_note_rounded,
              title: 'Quiz',
              subtitle: 'here we track your progress.',
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: _ActionCard(
              icon: Icons.lightbulb_outline_rounded,
              title: 'Daily tips',
              subtitle: 'here your activities helps you.',
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.textWhite, size: 26),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.textWhite,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withValues(alpha: 0.8),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          const Align(alignment: Alignment.centerRight, child: _ArrowButton()),
        ],
      ),
    );
  }
}

class _ArrowButton extends StatelessWidget {
  const _ArrowButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.arrow_forward,
        color: AppColors.textWhite,
        size: 16,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Bottom Navigation
// ---------------------------------------------------------------------------

class _BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _BottomNav({required this.currentIndex, required this.onTap});

  static const List<_NavItem> _items = [
    _NavItem(icon: Icons.home_outlined, activeIcon: Icons.home_rounded),
    _NavItem(
      icon: Icons.chat_bubble_outline_rounded,
      activeIcon: Icons.chat_bubble_rounded,
    ),
    _NavItem(
      icon: Icons.insert_chart_outlined_rounded,
      activeIcon: Icons.insert_chart_rounded,
    ),
    _NavItem(icon: Icons.settings_outlined, activeIcon: Icons.settings),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A), // Dark blue/black as per screenshot
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryDark.withValues(alpha: 0.1),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              _items.length,
              (i) => _NavIconButton(
                item: _items[i],
                isActive: i == currentIndex,
                onTap: () => onTap(i),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  const _NavItem({required this.icon, required this.activeIcon});
}

class _NavIconButton extends StatelessWidget {
  final _NavItem item;
  final bool isActive;
  final VoidCallback onTap;

  const _NavIconButton({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isActive
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          isActive ? item.activeIcon : item.icon,
          color: isActive ? Colors.white : Colors.white.withValues(alpha: 0.5),
          size: 24,
        ),
      ),
    );
  }
}
