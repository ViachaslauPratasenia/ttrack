import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/ui_constants.dart';

class GearPerformanceIndex extends StatelessWidget {
  const GearPerformanceIndex({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    // Mock data - TODO: Get from state management
    // Change values to null to show empty state
    final int? gpiScore = 82;
    final int? gqsScore = 80;
    final int? sawiScore = 84;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.chartTertiary.withOpacity(0.08), theme.colorScheme.card],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.chartTertiary.withOpacity(0.3), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.chartTertiary.withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ShadCard(
        padding: const EdgeInsets.all(24 + 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.chartTertiary.withOpacity(0.8),
                        AppColors.chartTertiary.withOpacity(0.6),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.chartTertiary.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(LucideIcons.zap, size: 24, color: AppColors.textPrimary),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gear Performance Index',
                        style: theme.textTheme.h3.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Your paddle\'s complete performance score',
                        style: theme.textTheme.small.copyWith(
                          color: theme.colorScheme.mutedForeground,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24 + 4),

            if (gpiScore != null && gqsScore != null && sawiScore != null)
              _FilledGPIState(
                theme: theme,
                gpiScore: gpiScore,
                gqsScore: gqsScore,
                sawiScore: sawiScore,
              )
            else
              _EmptyGPIState(theme: theme),
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
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < UIConstants.breakpointSmall;

        return Column(
          children: [
            // Gear info card with gradient
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.gearAccent.withOpacity(0.15),
                    AppColors.gearAccent.withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.gearAccent.withOpacity(0.3), width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12 - 2),
                        decoration: BoxDecoration(
                          color: AppColors.gearAccent.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12 - 2),
                        ),
                        child: Icon(LucideIcons.package, size: 20, color: AppColors.gearAccent),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'main',
                        style: theme.textTheme.h4.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.gearAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildGearDetail(LucideIcons.layers, 'Blade', 'Time bell etc'),
                  const SizedBox(height: 8),
                  _buildGearDetail(LucideIcons.move, 'FH Rubber', 'Soana 2.1'),
                  const SizedBox(height: 8),
                  _buildGearDetail(LucideIcons.move, 'BH Rubber', 'Soana 1.9'),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // GPI Circle with improved design
            Center(
              child: Container(
                width: isSmallScreen ? 180 : 220,
                height: isSmallScreen ? 180 : 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.chartTertiary.withOpacity(0.2),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: isSmallScreen ? 180 : 220,
                      height: isSmallScreen ? 180 : 220,
                      child: CircularProgressIndicator(
                        value: 1.0,
                        strokeWidth: isSmallScreen ? 12 : 16,
                        backgroundColor: theme.colorScheme.muted.withOpacity(0.2),
                        valueColor: AlwaysStoppedAnimation(
                          theme.colorScheme.muted.withOpacity(0.3),
                        ),
                      ),
                    ),
                    Container(
                      width: isSmallScreen ? 140 : 170,
                      height: isSmallScreen ? 140 : 170,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            theme.colorScheme.card,
                            theme.colorScheme.muted.withOpacity(0.1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'N/A',
                            style: theme.textTheme.h1.copyWith(
                              fontSize: isSmallScreen ? 40 : 52,
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.mutedForeground,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'GPI Score',
                            style: theme.textTheme.small.copyWith(
                              color: theme.colorScheme.mutedForeground.withOpacity(0.7),
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Info message
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12 - 2),
                decoration: BoxDecoration(
                  color: AppColors.chartTertiary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.chartTertiary.withOpacity(0.3), width: 1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(LucideIcons.info, size: 18, color: AppColors.chartTertiary),
                    const SizedBox(width: 12 - 2),
                    Text(
                      'Log a test session to calculate GPI',
                      style: theme.textTheme.small.copyWith(
                        color: AppColors.chartTertiary,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Metrics in responsive grid
            if (isSmallScreen)
              Column(
                children: [
                  _MetricCard(
                    theme: theme,
                    title: 'Gear Quality Score',
                    subtitle: 'GQS',
                    value: 'N/A',
                    color: AppColors.info,
                  ),
                  const SizedBox(height: 12),
                  _MetricCard(
                    theme: theme,
                    title: 'Match Win Index',
                    subtitle: 'SAWI',
                    value: 'N/A',
                    color: AppColors.error,
                  ),
                ],
              )
            else
              Row(
                children: [
                  Expanded(
                    child: _MetricCard(
                      theme: theme,
                      title: 'Gear Quality Score',
                      subtitle: 'GQS',
                      value: 'N/A',
                      color: AppColors.info,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _MetricCard(
                      theme: theme,
                      title: 'Match Win Index',
                      subtitle: 'SAWI',
                      value: 'N/A',
                      color: AppColors.error,
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 24),

            // Divider
            Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    theme.colorScheme.border.withOpacity(0.5),
                    Colors.transparent,
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Sub-metrics header
            Row(
              children: [
                Icon(LucideIcons.activity, size: 18, color: theme.colorScheme.mutedForeground),
                const SizedBox(width: 12 - 2),
                Text(
                  'KPI Breakdown',
                  style: theme.textTheme.p.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.mutedForeground,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Sub-metrics
            _SubMetricRow(
              theme: theme,
              label: 'Short-Game Control',
              icon: LucideIcons.target,
              value: 0,
            ),
            const SizedBox(height: 12),
            _SubMetricRow(
              theme: theme,
              label: 'Spin Potential',
              icon: LucideIcons.repeat,
              value: 0,
            ),
            const SizedBox(height: 12),
            _SubMetricRow(theme: theme, label: 'Power', icon: LucideIcons.zap, value: 0),
            const SizedBox(height: 12),
            _SubMetricRow(theme: theme, label: 'Stability', icon: LucideIcons.shield, value: 0),
            const SizedBox(height: 12),
            _SubMetricRow(
              theme: theme,
              label: 'Spin Sensitivity',
              icon: LucideIcons.gauge,
              value: 0,
            ),
          ],
        );
      },
    );
  }

  Widget _buildGearDetail(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.gearAccent.withOpacity(0.7)),
        const SizedBox(width: 12 - 2),
        Text(
          '$label: ',
          style: theme.textTheme.small.copyWith(
            color: theme.colorScheme.mutedForeground,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.small.copyWith(
            color: theme.colorScheme.foreground,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  final ShadThemeData theme;
  final String title;
  final String subtitle;
  final String value;
  final Color color;

  const _MetricCard({
    required this.theme,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.15), color.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8 - 2),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              subtitle,
              style: theme.textTheme.small.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 11,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: theme.textTheme.h1.copyWith(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: theme.textTheme.small.copyWith(
              color: theme.colorScheme.mutedForeground,
              fontWeight: FontWeight.w500,
              fontSize: 11,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _SubMetricRow extends StatelessWidget {
  final ShadThemeData theme;
  final String label;
  final IconData icon;
  final int value;

  const _SubMetricRow({
    required this.theme,
    required this.label,
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.muted.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12 - 2),
        border: Border.all(color: theme.colorScheme.border.withOpacity(0.3), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _getColorForValue(theme, value).withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: _getColorForValue(theme, value)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label, style: theme.textTheme.small.copyWith(fontWeight: FontWeight.w500)),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 120,
            child: Stack(
              children: [
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.muted.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: value / 100,
                  child: Container(
                    height: 8,
                    decoration: BoxDecoration(
                      color: _getColorForValue(theme, value),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12 - 2, vertical: 4),
            decoration: BoxDecoration(
              color: _getColorForValue(theme, value).withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              value.toString(),
              style: theme.textTheme.small.copyWith(
                fontWeight: FontWeight.bold,
                color: _getColorForValue(theme, value),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getColorForValue(ShadThemeData theme, int value) {
    if (value == 0) return theme.colorScheme.mutedForeground.withOpacity(0.5);
    if (value >= 80) return AppColors.success;
    if (value >= 60) return AppColors.info;
    if (value >= 40) return AppColors.warning;
    return AppColors.error;
  }
}

class _FilledGPIState extends StatelessWidget {
  final ShadThemeData theme;
  final int gpiScore;
  final int gqsScore;
  final int sawiScore;

  const _FilledGPIState({
    required this.theme,
    required this.gpiScore,
    required this.gqsScore,
    required this.sawiScore,
  });

  Color _getGPIColor() {
    if (gpiScore >= 80) return AppColors.success;
    if (gpiScore >= 60) return AppColors.info;
    if (gpiScore >= 40) return AppColors.warning;
    return AppColors.error;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isSmallScreen = constraints.maxWidth < UIConstants.breakpointSmall;

        return Column(
          children: [
            // Gear info card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.gearAccent.withOpacity(0.15),
                    AppColors.gearAccent.withOpacity(0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.gearAccent.withOpacity(0.3), width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12 - 2),
                        decoration: BoxDecoration(
                          color: AppColors.gearAccent.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12 - 2),
                        ),
                        child: Icon(LucideIcons.package, size: 20, color: AppColors.gearAccent),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'main',
                        style: theme.textTheme.h4.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.gearAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildGearDetail(LucideIcons.layers, 'Blade', 'Butterfly Viscaria'),
                  const SizedBox(height: 8),
                  _buildGearDetail(LucideIcons.move, 'FH Rubber', 'Tenergy 05 2.1mm'),
                  const SizedBox(height: 8),
                  _buildGearDetail(LucideIcons.move, 'BH Rubber', 'Tenergy 05 1.9mm'),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // GPI Circle
            Center(
              child: Container(
                width: isSmallScreen ? 180 : 220,
                height: isSmallScreen ? 180 : 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: _getGPIColor().withOpacity(0.3),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: isSmallScreen ? 180 : 220,
                      height: isSmallScreen ? 180 : 220,
                      child: CircularProgressIndicator(
                        value: gpiScore / 100,
                        strokeWidth: isSmallScreen ? 12 : 16,
                        backgroundColor: theme.colorScheme.muted.withOpacity(0.2),
                        valueColor: AlwaysStoppedAnimation(_getGPIColor()),
                      ),
                    ),
                    Container(
                      width: isSmallScreen ? 140 : 170,
                      height: isSmallScreen ? 140 : 170,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            theme.colorScheme.card,
                            theme.colorScheme.muted.withOpacity(0.1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '$gpiScore',
                            style: theme.textTheme.h1.copyWith(
                              fontSize: isSmallScreen ? 48 : 56,
                              fontWeight: FontWeight.bold,
                              color: _getGPIColor(),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'GPI Score',
                            style: theme.textTheme.small.copyWith(
                              color: theme.colorScheme.mutedForeground,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Metrics
            if (isSmallScreen)
              Column(
                children: [
                  _MetricCard(
                    theme: theme,
                    title: 'Gear Quality Score',
                    subtitle: 'GQS',
                    value: '$gqsScore',
                    color: AppColors.info,
                  ),
                  const SizedBox(height: 12),
                  _MetricCard(
                    theme: theme,
                    title: 'Match Win Index',
                    subtitle: 'SAWI',
                    value: '$sawiScore',
                    color: AppColors.error,
                  ),
                ],
              )
            else
              Row(
                children: [
                  Expanded(
                    child: _MetricCard(
                      theme: theme,
                      title: 'Gear Quality Score',
                      subtitle: 'GQS',
                      value: '$gqsScore',
                      color: AppColors.info,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _MetricCard(
                      theme: theme,
                      title: 'Match Win Index',
                      subtitle: 'SAWI',
                      value: '$sawiScore',
                      color: AppColors.error,
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 24),

            Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    theme.colorScheme.border.withOpacity(0.5),
                    Colors.transparent,
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            Row(
              children: [
                Icon(LucideIcons.activity, size: 18, color: theme.colorScheme.mutedForeground),
                const SizedBox(width: 12 - 2),
                Text(
                  'KPI Breakdown',
                  style: theme.textTheme.p.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.mutedForeground,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            _SubMetricRow(
              theme: theme,
              label: 'Short-Game Control',
              icon: LucideIcons.target,
              value: 85,
            ),
            const SizedBox(height: 12),
            _SubMetricRow(
              theme: theme,
              label: 'Spin Potential',
              icon: LucideIcons.repeat,
              value: 78,
            ),
            const SizedBox(height: 12),
            _SubMetricRow(theme: theme, label: 'Power', icon: LucideIcons.zap, value: 82),
            const SizedBox(height: 12),
            _SubMetricRow(theme: theme, label: 'Stability', icon: LucideIcons.shield, value: 90),
            const SizedBox(height: 12),
            _SubMetricRow(
              theme: theme,
              label: 'Spin Sensitivity',
              icon: LucideIcons.gauge,
              value: 75,
            ),
          ],
        );
      },
    );
  }

  Widget _buildGearDetail(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.gearAccent.withOpacity(0.7)),
        const SizedBox(width: 12 - 2),
        Text(
          '$label: ',
          style: theme.textTheme.small.copyWith(
            color: theme.colorScheme.mutedForeground,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.small.copyWith(
            color: theme.colorScheme.foreground,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
