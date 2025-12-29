import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../../../core/theme/app_colors.dart';

class StatsCards extends StatelessWidget {
  const StatsCards({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data - TODO: Get from state management
    const totalHours = 127.0;
    const totalMinutes = 35;
    const totalSessions = 48;
    const wins = 23;
    const matches = 35;
    const winRate = 65.7;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < 800; // Custom breakpoint for stat cards layout

        if (isSmallScreen) {
          // Stack cards vertically on small screens
          return Column(
            children: [
              _StatCard(
                title: 'Lifetime Hours',
                value: '${totalHours.toInt()}h ${totalMinutes}m',
                icon: LucideIcons.clock,
                color: AppColors.info,
              ),
              const SizedBox(height: 16),
              _StatCard(
                title: 'Total Sessions',
                value: totalSessions.toString(),
                icon: LucideIcons.activity,
                color: AppColors.success,
              ),
              const SizedBox(height: 16),
              _StatCard(
                title: 'Win Rate',
                value: '${winRate.toStringAsFixed(1)}%',
                subtitle: '$wins Wins / $matches Matches',
                icon: LucideIcons.trophy,
                color: AppColors.warning,
              ),
            ],
          );
        }

        // Horizontal layout for larger screens
        return Row(
          children: [
            Expanded(
              child: _StatCard(
                title: 'Lifetime Hours',
                value: '${totalHours.toInt()}h ${totalMinutes}m',
                icon: LucideIcons.clock,
                color: AppColors.info,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _StatCard(
                title: 'Total Sessions',
                value: totalSessions.toString(),
                icon: LucideIcons.activity,
                color: AppColors.success,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _StatCard(
                title: 'Win Rate',
                value: '${winRate.toStringAsFixed(1)}%',
                subtitle: '$wins Wins / $matches Matches',
                icon: LucideIcons.trophy,
                color: AppColors.warning,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Container(
      height: 175,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.colorScheme.card, theme.colorScheme.card],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
        boxShadow: [
          BoxShadow(color: color.withOpacity(0.1), blurRadius: 12, offset: const Offset(0, 4)),
        ],
      ),
      child: ShadCard(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: theme.textTheme.small.copyWith(
                    color: theme.colorScheme.mutedForeground,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, size: 22, color: color),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: theme.textTheme.h1.copyWith(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                    color: theme.colorScheme.foreground,
                  ),
                ),
                SizedBox(height: subtitle != null ? 8 : 0),
                if (subtitle != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.muted.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      subtitle!,
                      style: theme.textTheme.small.copyWith(
                        color: theme.colorScheme.mutedForeground,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                else
                  const SizedBox(height: 24),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
