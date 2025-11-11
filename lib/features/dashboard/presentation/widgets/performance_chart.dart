import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class PerformanceChart extends StatelessWidget {
  const PerformanceChart({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ShadCard(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'График прогресса',
              style: theme.textTheme.h4,
            ),
            const SizedBox(height: 16),
            
            // Placeholder for chart - TODO: Add actual chart
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: theme.colorScheme.muted.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: theme.colorScheme.border,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      LucideIcons.trendingUp,
                      size: 48,
                      color: theme.colorScheme.mutedForeground,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'График будет здесь',
                      style: theme.textTheme.muted,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 12),
            
            ShadButton.ghost(
              onPressed: () {
                // TODO: Navigate to detailed stats
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Показать подробнее'),
                  SizedBox(width: 4),
                  Icon(LucideIcons.arrowRight, size: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
