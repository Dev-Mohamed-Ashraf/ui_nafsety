import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

// ---------------------------------------------------------------------------
// Static UI data (no state management layer)
// ---------------------------------------------------------------------------

class _DayProgress {
  final String label;
  final int minutes;
  final bool isToday;

  const _DayProgress({
    required this.label,
    required this.minutes,
    required this.isToday,
  });
}

class _RecentSession {
  final String title;
  final String subtitle;
  final int minutes;
  final String emoji;

  const _RecentSession({
    required this.title,
    required this.subtitle,
    required this.minutes,
    required this.emoji,
  });
}

abstract final class _ProgressUiData {
  static const double weeklyGoalPercent = 0.72;
  static const int totalSessions = 14;
  static const int totalMinutes = 210;
  static const int streakDays = 5;

  static const List<_DayProgress> weekDays = [
    _DayProgress(label: 'S', minutes: 20, isToday: false),
    _DayProgress(label: 'M', minutes: 35, isToday: false),
    _DayProgress(label: 'T', minutes: 15, isToday: false),
    _DayProgress(label: 'W', minutes: 40, isToday: false),
    _DayProgress(label: 'T', minutes: 30, isToday: true),
    _DayProgress(label: 'F', minutes: 0, isToday: false),
    _DayProgress(label: 'S', minutes: 0, isToday: false),
  ];

  static const List<_RecentSession> recentSessions = [
    _RecentSession(
      title: 'Breathing Exercise',
      subtitle: 'Today, 9:00 AM',
      minutes: 10,
      emoji: '🌬️',
    ),
    _RecentSession(
      title: 'Guided Meditation',
      subtitle: 'Yesterday, 8:30 PM',
      minutes: 20,
      emoji: '🧘',
    ),
    _RecentSession(
      title: 'Mood Journal',
      subtitle: 'Yesterday, 6:00 PM',
      minutes: 5,
      emoji: '📓',
    ),
  ];
}

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _GoalCard(
              pct: _ProgressUiData.weeklyGoalPercent,
              streakDays: _ProgressUiData.streakDays,
            ),
            const SizedBox(height: 20),
            const _StatsRow(
              totalSessions: _ProgressUiData.totalSessions,
              totalMinutes: _ProgressUiData.totalMinutes,
              streakDays: _ProgressUiData.streakDays,
            ),
            const SizedBox(height: 20),
            const _WeeklyChart(days: _ProgressUiData.weekDays),
            const SizedBox(height: 20),
            _MoodTracker(
              selectedMood: 3,
              onSelect: (_) {},
            ),
            const SizedBox(height: 20),
            const _RecentSessions(sessions: _ProgressUiData.recentSessions),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Progress',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 2),
            Text(
              'Keep it up! You\'re doing great 🌿',
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),
          ],
        ),
        CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.primary,
          child: Icon(Icons.bar_chart_rounded, color: Colors.white, size: 20),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Goal card
// ---------------------------------------------------------------------------

class _GoalCard extends StatelessWidget {
  final double pct;
  final int streakDays;

  const _GoalCard({required this.pct, required this.streakDays});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, Color(0xFF00A86B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.35),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Weekly Goal',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${(pct * 100).round()}% Completed',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 14),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: pct,
                    minHeight: 8,
                    backgroundColor: Colors.white24,
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '$streakDays day streak 🔥',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          SizedBox(
            width: 80,
            height: 80,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: pct,
                  strokeWidth: 7,
                  backgroundColor: Colors.white24,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                Text(
                  '${(pct * 100).round()}%',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Stats row
// ---------------------------------------------------------------------------

class _StatsRow extends StatelessWidget {
  final int totalSessions;
  final int totalMinutes;
  final int streakDays;

  const _StatsRow({
    required this.totalSessions,
    required this.totalMinutes,
    required this.streakDays,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _StatCard(
          icon: Icons.self_improvement_rounded,
          value: '$totalSessions',
          label: 'Sessions',
          color: const Color(0xFF6C63FF),
        ),
        const SizedBox(width: 12),
        _StatCard(
          icon: Icons.timer_outlined,
          value: '$totalMinutes',
          label: 'Minutes',
          color: const Color(0xFFFF6B6B),
        ),
        const SizedBox(width: 12),
        _StatCard(
          icon: Icons.local_fire_department_rounded,
          value: '$streakDays',
          label: 'Day Streak',
          color: const Color(0xFFFFB347),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Weekly bar chart
// ---------------------------------------------------------------------------

class _WeeklyChart extends StatelessWidget {
  final List<_DayProgress> days;

  const _WeeklyChart({required this.days});

  @override
  Widget build(BuildContext context) {
    final maxMinutes =
        days.map((d) => d.minutes).fold(0, (a, b) => a > b ? a : b);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'This Week',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                'Minutes',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: days.map((day) {
              final ratio = maxMinutes == 0 ? 0.0 : day.minutes / maxMinutes;
              final isMax = maxMinutes > 0 && day.minutes == maxMinutes;
              return _DayBar(
                day: day,
                ratio: ratio.toDouble(),
                isMax: isMax,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _DayBar extends StatelessWidget {
  final _DayProgress day;
  final double ratio;
  final bool isMax;

  const _DayBar({
    required this.day,
    required this.ratio,
    required this.isMax,
  });

  @override
  Widget build(BuildContext context) {
    Color barColor;
    if (day.isToday) {
      barColor = AppColors.primary;
    } else if (isMax) {
      barColor = const Color(0xFF6C63FF);
    } else if (ratio == 0) {
      barColor = const Color(0xFFE5E7EB);
    } else {
      barColor = AppColors.primary.withValues(alpha: 0.35);
    }

    return Column(
      children: [
        if (day.minutes > 0)
          Text(
            '${day.minutes}m',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: day.isToday ? AppColors.primary : AppColors.textSecondary,
            ),
          ),
        if (day.minutes == 0) const SizedBox(height: 14),
        const SizedBox(height: 4),
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOutCubic,
          width: 28,
          height: 80 * (ratio == 0 ? 0.08 : ratio),
          decoration: BoxDecoration(
            color: barColor,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          day.label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: day.isToday ? FontWeight.w700 : FontWeight.w400,
            color: day.isToday ? AppColors.primary : AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Mood tracker
// ---------------------------------------------------------------------------

class _MoodTracker extends StatelessWidget {
  final int selectedMood;
  final ValueChanged<int> onSelect;

  const _MoodTracker({required this.selectedMood, required this.onSelect});

  static const _moods = ['😢', '😕', '😐', '🙂', '😄'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'How are you feeling today?',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_moods.length, (i) {
              final mood = i + 1;
              final isSelected = selectedMood == mood;
              return GestureDetector(
                onTap: () => onSelect(mood),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary.withValues(alpha: 0.12)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primary
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    _moods[i],
                    style: TextStyle(
                      fontSize: isSelected ? 30 : 26,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Recent sessions
// ---------------------------------------------------------------------------

class _RecentSessions extends StatelessWidget {
  final List<_RecentSession> sessions;

  const _RecentSessions({required this.sessions});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Sessions',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        ...sessions.map((s) => _SessionTile(session: s)),
      ],
    );
  }
}

class _SessionTile extends StatelessWidget {
  final _RecentSession session;

  const _SessionTile({required this.session});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(session.emoji, style: const TextStyle(fontSize: 22)),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  session.title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  session.subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${session.minutes} min',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
