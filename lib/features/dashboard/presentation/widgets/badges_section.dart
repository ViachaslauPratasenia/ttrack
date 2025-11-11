import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class BadgesSection extends StatelessWidget {
  const BadgesSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data - TODO: Get from state management
    const currentBadge = 'Новичок';
    const currentBadgeIcon = '🏓';
    const currentBadgeDescription = 'Начало вашего пути в настольный теннис';
    const currentHours = 42.5;
    const nextBadgeHours = 100.0;
    const nextBadgeName = 'Энтузиаст';

    final progress = currentHours / nextBadgeHours;
    final theme = ShadTheme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary,
              theme.colorScheme.primary.withOpacity(0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ваши достижения',
              style: theme.textTheme.large.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),

            // Current Badge
            Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Text(
                      currentBadgeIcon,
                      style: TextStyle(fontSize: 48),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentBadge,
                        style: theme.textTheme.h2.copyWith(
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        currentBadgeDescription,
                        style: theme.textTheme.small.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Progress to next badge
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        'До следующего: $nextBadgeName',
                        style: theme.textTheme.small.copyWith(
                          color: Colors.white.withOpacity(0.9),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ShadBadge(
                      backgroundColor: Colors.white.withOpacity(0.2),
                      child: Text(
                        '${currentHours.toStringAsFixed(0)}/${nextBadgeHours.toStringAsFixed(0)} ч',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ShadProgress(
                  value: progress,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
