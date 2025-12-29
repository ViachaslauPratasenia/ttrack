import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../../../core/theme/app_colors.dart';

class BadgesSection extends StatelessWidget {
  const BadgesSection({super.key});

  @override
  Widget build(BuildContext context) {
    const currentHours = 127.0;
    const nextBadgeHours = 250.0;
    const nextBadgeName = 'Enthusiast';

    final progress = currentHours / nextBadgeHours;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    // For mobile, show in column, for desktop in row
    if (isMobile) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BadgeCard(
            label: 'Current Badge',
            badgeName: 'Starter',
            subtitle: '100+ hours logged',
            icon: LucideIcons.award,
            accentColor: AppColors.info,
            isCurrentBadge: true,
          ),
          const SizedBox(height: 16),
          BadgeCard(
            label: 'Next Badge',
            badgeName: nextBadgeName,
            icon: LucideIcons.target,
            accentColor: AppColors.warning,
            isCurrentBadge: false,
            currentHours: currentHours,
            targetHours: nextBadgeHours,
            progress: progress,
          ),
        ],
      );
    }

    return Row(
      children: [
        // Current Badge Card
        Expanded(
          child: BadgeCard(
            label: 'Current Badge',
            badgeName: 'Starter',
            subtitle: '100+ hours logged',
            icon: LucideIcons.award,
            accentColor: AppColors.info,
            isCurrentBadge: true,
            height: 160,
          ),
        ),
        const SizedBox(width: 20),
        // Next Badge Card
        Expanded(
          child: BadgeCard(
            label: 'Next Badge',
            badgeName: nextBadgeName,
            icon: LucideIcons.target,
            accentColor: AppColors.warning,
            isCurrentBadge: false,
            currentHours: currentHours,
            targetHours: nextBadgeHours,
            progress: progress,
            height: 160,
          ),
        ),
      ],
    );
  }
}

/// Unified Badge Card widget for displaying badge information
class BadgeCard extends StatelessWidget {
  final String label;
  final String badgeName;
  final String? subtitle;
  final IconData icon;
  final Color accentColor;
  final bool isCurrentBadge;
  final double? currentHours;
  final double? targetHours;
  final double? progress;

  final double? height;

  const BadgeCard({
    super.key,
    required this.label,
    required this.badgeName,
    this.subtitle,
    required this.icon,
    required this.accentColor,
    required this.isCurrentBadge,
    this.currentHours,
    this.targetHours,
    this.progress,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [accentColor.withOpacity(0.12), accentColor.withOpacity(0.04)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accentColor.withOpacity(0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon and label
            Text(
              label,
              style: theme.textTheme.h4.copyWith(
                color: theme.colorScheme.mutedForeground,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            // Badge name and info
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Star icon
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [accentColor.withOpacity(0.25), accentColor.withOpacity(0.1)],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(LucideIcons.star, size: 22, color: accentColor),
                ),
                const SizedBox(width: 12),

                // Badge name and subtitle/hours
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        badgeName,
                        style: theme.textTheme.h4.copyWith(
                          color: accentColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          height: 1.1,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (isCurrentBadge && subtitle != null)
                        Text(
                          subtitle!,
                          style: theme.textTheme.small.copyWith(
                            color: theme.colorScheme.mutedForeground,
                            fontSize: 11,
                          ),
                        )
                      else if (!isCurrentBadge && currentHours != null && targetHours != null)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: accentColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: accentColor.withOpacity(0.3), width: 1),
                          ),
                          child: Text(
                            '${(targetHours! - currentHours!).toInt()}h to go',
                            style: theme.textTheme.small.copyWith(
                              color: accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),

            // Progress bar (only for next badge)
            if (!isCurrentBadge && progress != null) ...[
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${currentHours?.toInt() ?? 0}h',
                    style: theme.textTheme.small.copyWith(
                      color: theme.colorScheme.mutedForeground,
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                  Text(
                    '${targetHours?.toInt() ?? 0}h',
                    style: theme.textTheme.small.copyWith(
                      color: theme.colorScheme.mutedForeground,
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Stack(
                children: [
                  Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.muted.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: progress,
                    child: Container(
                      height: 6,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [accentColor, accentColor.withOpacity(0.7)],
                        ),
                        borderRadius: BorderRadius.circular(3),
                        boxShadow: [
                          BoxShadow(
                            color: accentColor.withOpacity(0.4),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
