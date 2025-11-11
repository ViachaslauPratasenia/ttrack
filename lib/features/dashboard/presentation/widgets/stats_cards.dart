import 'package:flutter/material.dart';

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
          // Portrait mode: 1 column, Landscape/tablet: 3 columns
          final isPortrait = constraints.maxWidth < 600;

          if (isPortrait) {
            return Column(
              children: [
                _StatCard(
                  icon: Icons.access_time,
                  iconColor: Colors.blue,
                  title: 'Часы',
                  value: totalHours.toStringAsFixed(1),
                  subtitle: 'Всего тренировок',
                ),
                const SizedBox(height: 12),
                _StatCard(
                  icon: Icons.check_circle,
                  iconColor: Colors.green,
                  title: 'Сессии',
                  value: totalSessions.toString(),
                  subtitle: 'Записано',
                ),
                const SizedBox(height: 12),
                _StatCard(
                  icon: Icons.emoji_events,
                  iconColor: Colors.amber,
                  title: 'Win Rate',
                  value: '${winRate.toStringAsFixed(0)}%',
                  subtitle: 'Процент побед',
                ),
              ],
            );
          } else {
            return Row(
              children: [
                Expanded(
                  child: _StatCard(
                    icon: Icons.access_time,
                    iconColor: Colors.blue,
                    title: 'Часы',
                    value: totalHours.toStringAsFixed(1),
                    subtitle: 'Всего тренировок',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    icon: Icons.check_circle,
                    iconColor: Colors.green,
                    title: 'Сессии',
                    value: totalSessions.toString(),
                    subtitle: 'Записано',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    icon: Icons.emoji_events,
                    iconColor: Colors.amber,
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
  final Color iconColor;
  final String title;
  final String value;
  final String subtitle;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}

