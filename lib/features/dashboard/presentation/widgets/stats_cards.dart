import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class StatsCards extends StatelessWidget {
  const StatsCards({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data - TODO: Get from state management
    const totalHours = 42.5;
    const totalSessions = 28;
    const winRate = 65.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isPortrait = constraints.maxWidth < 600;

          if (isPortrait) {
            return Column(
              children: [
                _StatCard(
                  icon: LucideIcons.clock,
                  title: 'Часы',
                  value: totalHours.toStringAsFixed(1),
                  subtitle: 'Всего тренировок',
                ),
                const SizedBox(height: 12),
                _StatCard(
                  icon: LucideIcons.listChecks,
                  title: 'Сессии',
                  value: totalSessions.toString(),
                  subtitle: 'Записано',
                ),
                const SizedBox(height: 12),
                _StatCard(
                  icon: LucideIcons.trophy,
                  title: 'Win Rate',
                  value: '${winRate.toStringAsFixed(0)}%',
                  subtitle: 'Процент побед',
                ),
              ],
            );
          } else {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: _StatCard(
                    icon: LucideIcons.clock,
                    title: 'Часы',
                    value: totalHours.toStringAsFixed(1),
                    subtitle: 'Всего тренировок',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    icon: LucideIcons.listChecks,
                    title: 'Сессии',
                    value: totalSessions.toString(),
                    subtitle: 'Записано',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    icon: LucideIcons.trophy,
                    title: 'Win Rate',
                    value: '${winRate.toStringAsFixed(0)}%',
                    subtitle: 'Процент побед',
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String subtitle;

  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return ShadCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: theme.colorScheme.primary, size: 20),
              ),
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  title,
                  style: theme.textTheme.muted,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: theme.textTheme.h1,
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: theme.textTheme.small.copyWith(
              color: theme.colorScheme.mutedForeground,
            ),
          ),
        ],
      ),
    );
  }
}
