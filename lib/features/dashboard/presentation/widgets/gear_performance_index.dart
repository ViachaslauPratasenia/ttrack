import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class GearPerformanceIndex extends StatelessWidget {
  const GearPerformanceIndex({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    
    // Mock data - TODO: Get from state management
    const hasData = false;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ShadCard(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gear Performance Index (GPI)',
              style: theme.textTheme.h3,
            ),
            const SizedBox(height: 20),
            
            if (!hasData) ...[
              // Empty state
              _EmptyGPIState(theme: theme),
            ]
            // TODO: Add else case for GPI data display when hasData is true
          ],
        ),
      ),
    );
  }
}

class _EmptyGPIState extends StatelessWidget {
  final ShadThemeData theme;
  
  const _EmptyGPIState({required this.theme});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Gear info
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.muted.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'main',
                style: theme.textTheme.large.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Binder: Time bell etc',
                style: theme.textTheme.small.copyWith(
                  color: theme.colorScheme.mutedForeground,
                ),
              ),
              Text(
                'Fh: Soana 2.1',
                style: theme.textTheme.small.copyWith(
                  color: theme.colorScheme.mutedForeground,
                ),
              ),
              Text(
                'Bh: Soana 1.9',
                style: theme.textTheme.small.copyWith(
                  color: theme.colorScheme.mutedForeground,
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 24),
        
        // GPI Circle
        Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: CircularProgressIndicator(
                  value: 0,
                  strokeWidth: 12,
                  backgroundColor: theme.colorScheme.muted.withOpacity(0.3),
                  color: theme.colorScheme.primary,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'N/A',
                    style: theme.textTheme.h1.copyWith(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.destructive,
                    ),
                  ),
                  Text(
                    'GPI',
                    style: theme.textTheme.small.copyWith(
                      color: theme.colorScheme.mutedForeground,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 16),
        
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                LucideIcons.info,
                size: 16,
                color: theme.colorScheme.mutedForeground,
              ),
              const SizedBox(width: 8),
              Text(
                'Log a test session',
                style: theme.textTheme.small.copyWith(
                  color: theme.colorScheme.mutedForeground,
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Metrics
        Row(
          children: [
            Expanded(
              child: _MetricCard(
                theme: theme,
                title: 'Gear Quality (GQS)',
                value: 'N/A',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _MetricCard(
                theme: theme,
                title: 'Match Win (SAW)',
                value: 'N/A',
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Sub-metrics
        _SubMetricRow(
          theme: theme,
          label: 'Short-Game',
          value: 0,
        ),
        const SizedBox(height: 8),
        _SubMetricRow(
          theme: theme,
          label: 'Power',
          value: 0,
        ),
        const SizedBox(height: 8),
        _SubMetricRow(
          theme: theme,
          label: 'Spin Sensitivity',
          value: 0,
        ),
        const SizedBox(height: 16),
        _SubMetricRow(
          theme: theme,
          label: 'Spin Potential',
          value: 0,
        ),
        const SizedBox(height: 8),
        _SubMetricRow(
          theme: theme,
          label: 'Stability',
          value: 0,
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  final ShadThemeData theme;
  final String title;
  final String value;
  
  const _MetricCard({
    required this.theme,
    required this.title,
    required this.value,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.muted.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: theme.textTheme.small.copyWith(
              color: theme.colorScheme.mutedForeground,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.h3.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _SubMetricRow extends StatelessWidget {
  final ShadThemeData theme;
  final String label;
  final int value;
  
  const _SubMetricRow({
    required this.theme,
    required this.label,
    required this.value,
  });
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: theme.textTheme.small,
        ),
        Row(
          children: [
            Container(
              width: 150,
              height: 6,
              decoration: BoxDecoration(
                color: theme.colorScheme.muted.withOpacity(0.3),
                borderRadius: BorderRadius.circular(3),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: value / 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: _getColorForValue(theme, value),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 20,
              child: Text(
                value.toString(),
                style: theme.textTheme.small.copyWith(
                  fontWeight: FontWeight.w600,
                  color: _getColorForValue(theme, value),
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ],
    );
  }
  
  Color _getColorForValue(ShadThemeData theme, int value) {
    if (value == 0) return theme.colorScheme.mutedForeground;
    if (value >= 8) return Colors.green;
    if (value >= 5) return Colors.blue;
    return Colors.orange;
  }
}

