import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/session.dart';

class SessionDetailDialog extends StatelessWidget {
  final Session session;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const SessionDetailDialog({
    super.key,
    required this.session,
    required this.onEdit,
    required this.onDelete,
  });

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    if (hours > 0) {
      return '${hours}ч ${minutes}мин';
    }
    return '${minutes}мин';
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}.${dateTime.month.toString().padLeft(2, '0')}.${dateTime.year} '
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _getSessionTypeLabel(SessionType type) {
    switch (type) {
      case SessionType.practice:
        return 'Тренировка';
      case SessionType.match:
        return 'Матч';
      case SessionType.gearTest:
        return 'Тест экипировки';
    }
  }

  String _getOpponentLevelLabel(OpponentLevel level) {
    switch (level) {
      case OpponentLevel.higher:
        return 'Выше';
      case OpponentLevel.similar:
        return 'Схожий';
      case OpponentLevel.lower:
        return 'Ниже';
    }
  }

  Color _getSessionTypeColor(BuildContext context) {
    switch (session.type) {
      case SessionType.practice:
        return AppColors.info;
      case SessionType.match:
        return AppColors.error;
      case SessionType.gearTest:
        return AppColors.chartTertiary;
    }
  }

  IconData _getSessionTypeIcon() {
    switch (session.type) {
      case SessionType.practice:
        return LucideIcons.dumbbell;
      case SessionType.match:
        return LucideIcons.trophy;
      case SessionType.gearTest:
        return LucideIcons.flaskConical;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return ShadDialog(
      title: const SizedBox.shrink(),
      child: Container(
        constraints: BoxConstraints(
          maxWidth: isSmallScreen ? double.infinity : 600,
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        decoration: BoxDecoration(
          color: AppColors.dialogBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Custom header with gradient background
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    _getSessionTypeColor(context).withOpacity(0.8),
                    _getSessionTypeColor(context).withOpacity(0.5),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.textPrimary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(_getSessionTypeIcon(), size: 28, color: AppColors.textPrimary),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _getSessionTypeLabel(session.type),
                              style: theme.textTheme.h3.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(
                                  LucideIcons.calendar,
                                  size: 14,
                                  color: AppColors.textPrimary.withOpacity(0.9),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  _formatDateTime(session.startTime),
                                  style: theme.textTheme.small.copyWith(
                                    color: AppColors.textPrimary.withOpacity(0.9),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Scrollable content
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Basic info cards in grid
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final cardWidth = constraints.maxWidth;
                        final showGrid = cardWidth > 400;

                        if (showGrid) {
                          return Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              _buildInfoCard(
                                context,
                                LucideIcons.mapPin,
                                'Локация',
                                session.location,
                                flex: 2,
                              ),
                              _buildInfoCard(
                                context,
                                LucideIcons.clock,
                                'Продолжительность',
                                _formatDuration(session.duration),
                                flex: 1,
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              _buildInfoCard(
                                context,
                                LucideIcons.mapPin,
                                'Локация',
                                session.location,
                              ),
                              const SizedBox(height: 12),
                              _buildInfoCard(
                                context,
                                LucideIcons.clock,
                                'Продолжительность',
                                _formatDuration(session.duration),
                              ),
                            ],
                          );
                        }
                      },
                    ),

                    const SizedBox(height: 20),
                    _buildDivider(context),
                    const SizedBox(height: 20),

                    // Type-specific content
                    if (session.type == SessionType.practice) ...[
                      _buildSectionHeader(context, 'Оценки производительности', LucideIcons.target),
                      const SizedBox(height: 16),
                      _buildRatingCard(
                        context,
                        'Техника',
                        'Technical Skills',
                        session.technicalRating ?? 0,
                        LucideIcons.zap,
                      ),
                      const SizedBox(height: 12),
                      _buildRatingCard(
                        context,
                        'Тактика',
                        'Tactical Awareness',
                        session.tacticalRating ?? 0,
                        LucideIcons.brain,
                      ),
                      const SizedBox(height: 12),
                      _buildRatingCard(
                        context,
                        'Ментальность',
                        'Mental Strength',
                        session.mentalRating ?? 0,
                        LucideIcons.heart,
                      ),
                    ],

                    if (session.type == SessionType.match) ...[
                      _buildSectionHeader(context, 'Информация о матче', LucideIcons.trophy),
                      const SizedBox(height: 16),
                      _buildMatchScoreCard(context),
                      const SizedBox(height: 12),
                      _buildInfoCard(
                        context,
                        LucideIcons.user,
                        'Соперник',
                        session.opponentName ?? 'Не указан',
                      ),
                      const SizedBox(height: 12),
                      _buildOpponentLevelCard(context),
                    ],

                    if (session.type == SessionType.gearTest) ...[
                      _buildSectionHeader(
                        context,
                        'KPI Показатели экипировки',
                        LucideIcons.activity,
                      ),
                      const SizedBox(height: 16),
                      _buildKPICard(
                        context,
                        'Контроль в короткой игре',
                        'Short-Game Control',
                        session.sgc ?? 0,
                        LucideIcons.target,
                      ),
                      const SizedBox(height: 12),
                      _buildKPICard(
                        context,
                        'Потенциал вращения',
                        'Spin Potential',
                        session.spn ?? 0,
                        LucideIcons.repeat,
                      ),
                      const SizedBox(height: 12),
                      _buildKPICard(
                        context,
                        'Мощность',
                        'Power / Throughput',
                        session.pwr ?? 0,
                        LucideIcons.zap,
                      ),
                      const SizedBox(height: 12),
                      _buildKPICard(
                        context,
                        'Стабильность',
                        'Stability / Forgiveness',
                        session.stb ?? 0,
                        LucideIcons.shield,
                      ),
                      const SizedBox(height: 12),
                      _buildKPICard(
                        context,
                        'Чувствительность к вращению',
                        'Spin Sensitivity',
                        session.sns ?? 0,
                        LucideIcons.activity,
                      ),
                    ],

                    if (session.notes != null && session.notes!.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      _buildDivider(context),
                      const SizedBox(height: 20),
                      _buildSectionHeader(context, 'Заметки', LucideIcons.fileText),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.muted.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: theme.colorScheme.border.withOpacity(0.5),
                            width: 1,
                          ),
                        ),
                        width: double.infinity,
                        child: Text(
                          session.notes!,
                          style: theme.textTheme.p.copyWith(
                            color: theme.colorScheme.foreground.withOpacity(0.9),
                            height: 1.6,
                          ),
                        ),
                      ),
                    ],

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Actions at bottom
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: theme.colorScheme.border.withOpacity(0.5), width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (!isSmallScreen) ...[
                    Expanded(
                      child: ShadButton.outline(
                        onPressed: onDelete,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(LucideIcons.trash2, size: 16),
                            SizedBox(width: 8),
                            Text('Удалить'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ShadButton(
                        onPressed: onEdit,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(LucideIcons.pencil, size: 16),
                            SizedBox(width: 8),
                            Text('Изменить'),
                          ],
                        ),
                      ),
                    ),
                  ] else ...[
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ShadButton(
                              onPressed: onEdit,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(LucideIcons.pencil, size: 16),
                                  SizedBox(width: 8),
                                  Text('Изменить'),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: ShadButton.outline(
                              onPressed: onDelete,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(LucideIcons.trash2, size: 16),
                                  SizedBox(width: 8),
                                  Text('Удалить'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, IconData icon) {
    final theme = ShadTheme.of(context);
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: theme.colorScheme.primary),
        ),
        const SizedBox(width: 12),
        Text(title, style: theme.textTheme.h4.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildDivider(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.background,
            theme.colorScheme.border.withOpacity(0.5),
            AppColors.background,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    IconData icon,
    String label,
    String value, {
    int flex = 1,
  }) {
    final theme = ShadTheme.of(context);
    return Container(
      width: flex == 2 ? double.infinity : null,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.muted.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.border.withOpacity(0.3), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 20, color: theme.colorScheme.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: theme.textTheme.small.copyWith(
                    color: theme.colorScheme.mutedForeground,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(value, style: theme.textTheme.p.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingCard(
    BuildContext context,
    String title,
    String subtitle,
    int value,
    IconData icon,
  ) {
    final theme = ShadTheme.of(context);
    final percentage = value / 10;

    Color getRatingColor() {
      if (value >= 8) return AppColors.success;
      if (value >= 6) return AppColors.info;
      if (value >= 4) return AppColors.warning;
      return AppColors.error;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.border.withOpacity(0.5), width: 1),
        boxShadow: [
          BoxShadow(
            color: getRatingColor().withOpacity(0.1),
            blurRadius: 8,
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
                  color: getRatingColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 20, color: getRatingColor()),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: theme.textTheme.p.copyWith(fontWeight: FontWeight.w600)),
                    Text(
                      subtitle,
                      style: theme.textTheme.small.copyWith(
                        color: theme.colorScheme.mutedForeground,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: getRatingColor().withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$value/10',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: getRatingColor(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Stack(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: theme.colorScheme.muted.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              FractionallySizedBox(
                widthFactor: percentage,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [getRatingColor(), getRatingColor().withOpacity(0.7)],
                    ),
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: getRatingColor().withOpacity(0.4),
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
      ),
    );
  }

  Widget _buildKPICard(
    BuildContext context,
    String title,
    String subtitle,
    int value,
    IconData icon,
  ) {
    final theme = ShadTheme.of(context);
    final percentage = value / 100;

    Color getKPIColor() {
      if (value >= 80) return AppColors.success;
      if (value >= 60) return AppColors.info;
      if (value >= 40) return AppColors.warning;
      return AppColors.error;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.colorScheme.border.withOpacity(0.5), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: getKPIColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 18, color: getKPIColor()),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: theme.textTheme.small.copyWith(fontWeight: FontWeight.w600)),
                    Text(
                      subtitle,
                      style: theme.textTheme.small.copyWith(
                        color: theme.colorScheme.mutedForeground,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: getKPIColor().withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$value',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: getKPIColor()),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
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
                widthFactor: percentage,
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: getKPIColor(),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMatchScoreCard(BuildContext context) {
    final theme = ShadTheme.of(context);
    final isWin = (session.playerScore ?? 0) > (session.opponentScore ?? 0);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isWin
              ? [AppColors.success.withOpacity(0.2), AppColors.success.withOpacity(0.05)]
              : [AppColors.error.withOpacity(0.2), AppColors.error.withOpacity(0.05)],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isWin ? AppColors.success.withOpacity(0.3) : AppColors.error.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isWin ? LucideIcons.trophy : LucideIcons.x,
            size: 32,
            color: isWin ? AppColors.success : AppColors.error,
          ),
          const SizedBox(width: 16),
          Column(
            children: [
              Text(
                isWin ? 'Победа' : 'Поражение',
                style: theme.textTheme.h4.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isWin ? AppColors.success : AppColors.error,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    '${session.playerScore ?? 0}',
                    style: theme.textTheme.h2.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.foreground,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      ':',
                      style: theme.textTheme.h2.copyWith(color: theme.colorScheme.mutedForeground),
                    ),
                  ),
                  Text(
                    '${session.opponentScore ?? 0}',
                    style: theme.textTheme.h2.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.foreground,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOpponentLevelCard(BuildContext context) {
    final theme = ShadTheme.of(context);
    final level = session.opponentLevel ?? OpponentLevel.similar;

    Color getLevelColor() {
      switch (level) {
        case OpponentLevel.higher:
          return AppColors.error;
        case OpponentLevel.similar:
          return AppColors.info;
        case OpponentLevel.lower:
          return AppColors.success;
      }
    }

    IconData getLevelIcon() {
      switch (level) {
        case OpponentLevel.higher:
          return LucideIcons.trendingUp;
        case OpponentLevel.similar:
          return LucideIcons.minus;
        case OpponentLevel.lower:
          return LucideIcons.trendingDown;
      }
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: getLevelColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: getLevelColor().withOpacity(0.3), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: getLevelColor().withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(getLevelIcon(), size: 20, color: getLevelColor()),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Уровень соперника',
                  style: theme.textTheme.small.copyWith(
                    color: theme.colorScheme.mutedForeground,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _getOpponentLevelLabel(level),
                  style: theme.textTheme.p.copyWith(
                    fontWeight: FontWeight.w600,
                    color: getLevelColor(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
