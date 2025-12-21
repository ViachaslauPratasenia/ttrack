import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class StatsCards extends StatelessWidget {
  const StatsCards({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data - TODO: Get from state management
    const totalHours = 2.0;
    const totalMinutes = 0;
    const totalSessions = 1;
    const wins = 0;
    const matches = 1;
    const winRate = 0.0;

    return Row(
      children: [
        Expanded(
          child: _StatCard(
            title: 'Lifetime Hours',
            value: '${totalHours.toInt()}h ${totalMinutes}m',
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            title: 'Total Sessions',
            value: totalSessions.toString(),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            title: 'Win Rate',
            value: '${winRate.toStringAsFixed(1)}%',
            subtitle: '$wins Wins / $matches Matches',
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;

  const _StatCard({
    required this.title,
    required this.value,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return ShadCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.small.copyWith(
              color: theme.colorScheme.mutedForeground,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: theme.textTheme.h1.copyWith(
              fontSize: 32,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: theme.textTheme.small.copyWith(
                color: theme.colorScheme.mutedForeground,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
