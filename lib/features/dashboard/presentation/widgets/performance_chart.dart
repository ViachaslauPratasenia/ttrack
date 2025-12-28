import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../../../core/theme/app_colors.dart';

class PerformanceChart extends StatelessWidget {
  const PerformanceChart({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    // Mock data for chart - TODO: Get from state management
    // Set chartData to null to see empty state
    final List<_ChartPoint>? chartData = [
      _ChartPoint(date: 'Jan 15', value: 6.5),
      _ChartPoint(date: 'Jan 22', value: 7.0),
      _ChartPoint(date: 'Feb 5', value: 6.8),
      _ChartPoint(date: 'Feb 12', value: 7.5),
      _ChartPoint(date: 'Feb 19', value: 7.8),
      _ChartPoint(date: 'Feb 26', value: 8.2),
      _ChartPoint(date: 'Mar 5', value: 8.0),
    ];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.info.withOpacity(0.05), theme.colorScheme.card],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.info.withOpacity(0.2), width: 1),
      ),
      child: ShadCard(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.info.withOpacity(0.8), AppColors.info.withOpacity(0.6)],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.info.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(LucideIcons.trendingUp, size: 20, color: AppColors.textPrimary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Performance Trend',
                        style: theme.textTheme.h4.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Track your progress over time',
                        style: theme.textTheme.small.copyWith(
                          color: theme.colorScheme.mutedForeground,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Chart area
            Expanded(
              child: chartData != null && chartData.isNotEmpty
                  ? _PerformanceChartWidget(data: chartData, theme: theme)
                  : _EmptyChartState(theme: theme),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChartPoint {
  final String date;
  final double value;

  _ChartPoint({required this.date, required this.value});
}

class _EmptyChartState extends StatelessWidget {
  final ShadThemeData theme;

  const _EmptyChartState({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.muted.withOpacity(0.1),
            theme.colorScheme.muted.withOpacity(0.05),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.border.withOpacity(0.5), width: 1),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.muted.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(
                  LucideIcons.trendingUp,
                  size: 40,
                  color: theme.colorScheme.mutedForeground.withOpacity(0.5),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'No data yet',
                style: theme.textTheme.p.copyWith(
                  color: theme.colorScheme.mutedForeground,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Log at least two rated sessions\nto see your performance trend.',
                style: theme.textTheme.small.copyWith(
                  color: theme.colorScheme.mutedForeground.withOpacity(0.7),
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PerformanceChartWidget extends StatelessWidget {
  final List<_ChartPoint> data;
  final ShadThemeData theme;

  const _PerformanceChartWidget({required this.data, required this.theme});

  @override
  Widget build(BuildContext context) {
    final maxValue = data.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    final minValue = data.map((e) => e.value).reduce((a, b) => a < b ? a : b);
    final range = maxValue - minValue;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.muted.withOpacity(0.1),
            theme.colorScheme.muted.withOpacity(0.05),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.border.withOpacity(0.5), width: 1),
      ),
      child: Column(
        children: [
          // Stats row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _StatBadge(
                theme: theme,
                label: 'Average',
                value: (data.map((e) => e.value).reduce((a, b) => a + b) / data.length)
                    .toStringAsFixed(1),
                color: AppColors.info,
              ),
              _StatBadge(
                theme: theme,
                label: 'Best',
                value: maxValue.toStringAsFixed(1),
                color: AppColors.success,
              ),
              _StatBadge(
                theme: theme,
                label: 'Trend',
                value: data.last.value > data.first.value
                    ? '+${(data.last.value - data.first.value).toStringAsFixed(1)}'
                    : '${(data.last.value - data.first.value).toStringAsFixed(1)}',
                color: data.last.value > data.first.value ? AppColors.success : AppColors.error,
                icon: data.last.value > data.first.value
                    ? LucideIcons.trendingUp
                    : LucideIcons.trendingDown,
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Chart
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final chartWidth = constraints.maxWidth;
                final chartHeight = constraints.maxHeight;
                final pointSpacing = chartWidth / (data.length - 1);

                return Stack(
                  children: [
                    // Grid lines
                    ...List.generate(5, (index) {
                      final y = (chartHeight / 4) * index;
                      return Positioned(
                        top: y,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 1,
                          color: theme.colorScheme.border.withOpacity(0.2),
                        ),
                      );
                    }),

                    // Line chart
                    CustomPaint(
                      size: Size(chartWidth, chartHeight),
                      painter: _ChartPainter(
                        data: data,
                        maxValue: maxValue,
                        minValue: minValue,
                        color: AppColors.info,
                        theme: theme,
                      ),
                    ),

                    // Data points
                    ...data.asMap().entries.map((entry) {
                      final index = entry.key;
                      final point = entry.value;
                      final x = pointSpacing * index;
                      final normalizedValue = range > 0 ? (point.value - minValue) / range : 0.5;
                      final y = chartHeight - (normalizedValue * chartHeight);

                      return Positioned(
                        left: x - 6,
                        top: y - 6,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: AppColors.info,
                            shape: BoxShape.circle,
                            border: Border.all(color: theme.colorScheme.card, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.info.withOpacity(0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ],
                );
              },
            ),
          ),

          const SizedBox(height: 12),

          // X-axis labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: data
                .map(
                  (point) => Text(
                    point.date,
                    style: theme.textTheme.small.copyWith(
                      color: theme.colorScheme.mutedForeground,
                      fontSize: 10,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final ShadThemeData theme;
  final String label;
  final String value;
  final Color color;
  final IconData? icon;

  const _StatBadge({
    required this.theme,
    required this.label,
    required this.value,
    required this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: theme.textTheme.small.copyWith(
              color: theme.colorScheme.mutedForeground,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[Icon(icon, size: 14, color: color), const SizedBox(width: 4)],
              Text(
                value,
                style: theme.textTheme.p.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChartPainter extends CustomPainter {
  final List<_ChartPoint> data;
  final double maxValue;
  final double minValue;
  final Color color;
  final ShadThemeData theme;

  _ChartPainter({
    required this.data,
    required this.maxValue,
    required this.minValue,
    required this.color,
    required this.theme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final range = maxValue - minValue;
    final pointSpacing = size.width / (data.length - 1);

    final linePaint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final gradientPaint = Paint()
      ..shader = LinearGradient(
        colors: [color.withOpacity(0.3), color.withOpacity(0.05)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final linePath = Path();
    final gradientPath = Path();

    for (var i = 0; i < data.length; i++) {
      final x = pointSpacing * i;
      final normalizedValue = range > 0 ? (data[i].value - minValue) / range : 0.5;
      final y = size.height - (normalizedValue * size.height);

      if (i == 0) {
        linePath.moveTo(x, y);
        gradientPath.moveTo(x, size.height);
        gradientPath.lineTo(x, y);
      } else {
        linePath.lineTo(x, y);
        gradientPath.lineTo(x, y);
      }
    }

    // Complete gradient path
    gradientPath.lineTo(size.width, size.height);
    gradientPath.close();

    // Draw gradient area
    canvas.drawPath(gradientPath, gradientPaint);

    // Draw line
    canvas.drawPath(linePath, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
