import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class BadgesSection extends StatelessWidget {
  const BadgesSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data - TODO: Get from state management
    const currentHours = 2.0;
    const nextBadgeHours = 10.0;
    const nextBadgeName = 'Starter';

    final progress = currentHours / nextBadgeHours;
    final theme = ShadTheme.of(context);

    return Column(
      children: [
        // Current Badge Card
        ShadCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Current Badge',
                style: theme.textTheme.small.copyWith(
                  color: theme.colorScheme.mutedForeground,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'No badge yet',
                style: theme.textTheme.p.copyWith(
                  color: theme.colorScheme.mutedForeground,
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Next Badge Card
        ShadCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Next Badge',
                style: theme.textTheme.small.copyWith(
                  color: theme.colorScheme.mutedForeground,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(
                    LucideIcons.star,
                    size: 24,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    nextBadgeName,
                    style: theme.textTheme.large.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ShadProgress(
                value: progress,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${nextBadgeHours.toInt()} hours',
                    style: theme.textTheme.small.copyWith(
                      color: theme.colorScheme.mutedForeground,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
