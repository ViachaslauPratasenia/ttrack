import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
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

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return ShadDialog(
      title: Text(_getSessionTypeLabel(session.type)),
      description: Text(_formatDateTime(session.startTime)),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),

            // Basic info
            _buildInfoRow(context, LucideIcons.mapPin, 'Локация', session.location),
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              LucideIcons.clock,
              'Продолжительность',
              _formatDuration(session.duration),
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              LucideIcons.calendar,
              'Начало',
              _formatDateTime(session.startTime),
            ),
            const SizedBox(height: 12),
            _buildInfoRow(
              context,
              LucideIcons.calendarCheck,
              'Окончание',
              _formatDateTime(session.endTime),
            ),

            // Type-specific fields
            if (session.type == SessionType.practice) ...[
              const SizedBox(height: 20),
              Text('Оценки', style: theme.textTheme.p.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              _buildRatingRow(context, 'Техника', session.technicalRating ?? 0),
              const SizedBox(height: 8),
              _buildRatingRow(context, 'Тактика', session.tacticalRating ?? 0),
              const SizedBox(height: 8),
              _buildRatingRow(context, 'Ментальность', session.mentalRating ?? 0),
            ],

            if (session.type == SessionType.match) ...[
              const SizedBox(height: 20),
              Text(
                'Информация о матче',
                style: theme.textTheme.p.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              _buildInfoRow(context, LucideIcons.user, 'Соперник', session.opponentName ?? ''),
              const SizedBox(height: 12),
              _buildInfoRow(
                context,
                LucideIcons.target,
                'Счет',
                '${session.playerScore}:${session.opponentScore}',
              ),
              const SizedBox(height: 12),
              _buildInfoRow(
                context,
                LucideIcons.trendingUp,
                'Уровень соперника',
                _getOpponentLevelLabel(session.opponentLevel ?? OpponentLevel.similar),
              ),
            ],

            if (session.type == SessionType.gearTest) ...[
              const SizedBox(height: 20),
              Text(
                'KPI показатели',
                style: theme.textTheme.p.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              _buildKPIRow(context, 'Speed & Control', session.sgc ?? 0),
              const SizedBox(height: 8),
              _buildKPIRow(context, 'Spin', session.spn ?? 0),
              const SizedBox(height: 8),
              _buildKPIRow(context, 'Power', session.pwr ?? 0),
              const SizedBox(height: 8),
              _buildKPIRow(context, 'Stability', session.stb ?? 0),
              const SizedBox(height: 8),
              _buildKPIRow(context, 'Sensitivity', session.sns ?? 0),
            ],

            if (session.notes != null && session.notes!.isNotEmpty) ...[
              const SizedBox(height: 20),
              Text('Заметки', style: theme.textTheme.p.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.muted.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                width: double.infinity,
                child: Text(session.notes!, style: theme.textTheme.small),
              ),
            ],

            const SizedBox(height: 24),

            // Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ShadButton.outline(
                  onPressed: onDelete,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(LucideIcons.trash2, size: 16),
                      SizedBox(width: 4),
                      Text('Удалить'),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                ShadButton(
                  onPressed: onEdit,
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(LucideIcons.pencil, size: 16),
                      SizedBox(width: 4),
                      Text('Изменить'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value) {
    final theme = ShadTheme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: theme.colorScheme.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.small.copyWith(color: theme.colorScheme.mutedForeground),
              ),
              const SizedBox(height: 2),
              Text(value, style: theme.textTheme.p),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRatingRow(BuildContext context, String label, int value) {
    final theme = ShadTheme.of(context);
    return Row(
      children: [
        Expanded(child: Text(label, style: theme.textTheme.small)),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...List.generate(
              10,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 2),
                child: Container(
                  width: 8,
                  height: 20,
                  decoration: BoxDecoration(
                    color: index < value
                        ? theme.colorScheme.primary
                        : theme.colorScheme.muted.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ShadBadge(child: Text('$value/10')),
          ],
        ),
      ],
    );
  }

  Widget _buildKPIRow(BuildContext context, String label, int value) {
    final theme = ShadTheme.of(context);
    return Row(
      children: [
        Expanded(child: Text(label, style: theme.textTheme.small)),
        SizedBox(
          width: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: value / 100,
              backgroundColor: theme.colorScheme.muted.withOpacity(0.3),
              valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary),
              minHeight: 8,
            ),
          ),
        ),
        const SizedBox(width: 8),
        ShadBadge(child: Text('$value')),
      ],
    );
  }
}
