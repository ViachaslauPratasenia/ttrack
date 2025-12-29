import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/ui_constants.dart';
import '../../../../core/utils/dialog_utils.dart';
import '../../../sessions/domain/entities/session.dart';
import '../../../sessions/presentation/widgets/session_detail_dialog.dart';

class RecentSessions extends StatelessWidget {
  const RecentSessions({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data - TODO: Get from state management
    final sessions = [
      Session(
        type: SessionType.match,
        location: 'City Sports Center',
        startTime: DateTime.now().subtract(const Duration(days: 1)),
        endTime: DateTime.now().subtract(const Duration(days: 1, hours: -2)),
        duration: const Duration(hours: 2),
        playerScore: 3,
        opponentName: 'Ivan Petrov',
        opponentScore: 2,
        opponentLevel: OpponentLevel.similar,
        notes: 'Close match, won in 5 sets',
      ),
      Session(
        type: SessionType.practice,
        location: 'Local Sports Club',
        startTime: DateTime.now().subtract(const Duration(days: 3)),
        endTime: DateTime.now().subtract(const Duration(days: 3, hours: -3)),
        duration: const Duration(hours: 3),
        technicalRating: 8,
        tacticalRating: 7,
        mentalRating: 9,
        notes: 'Worked on backhand loops and footwork',
      ),
      Session(
        type: SessionType.gearTest,
        location: 'Training Hall',
        startTime: DateTime.now().subtract(const Duration(days: 5)),
        endTime: DateTime.now().subtract(const Duration(days: 5, hours: -1, minutes: -30)),
        duration: const Duration(hours: 1, minutes: 30),
        sgc: 85,
        spn: 78,
        pwr: 82,
        stb: 90,
        sns: 75,
        paddleSetupId: 'main',
        notes: 'Testing new rubber setup',
      ),
    ];

    final theme = ShadTheme.of(context);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.success.withOpacity(0.05), theme.colorScheme.card],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.success.withOpacity(0.2), width: 1),
      ),
      child: ShadCard(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.success.withOpacity(0.8),
                            AppColors.success.withOpacity(0.6),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.success.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(LucideIcons.history, size: 20, color: AppColors.textPrimary),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recent Sessions',
                          style: theme.textTheme.h3.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Your latest training activities',
                          style: theme.textTheme.small.copyWith(
                            color: theme.colorScheme.mutedForeground,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                ShadButton.outline(
                  size: ShadButtonSize.sm,
                  onPressed: () {
                    // TODO: Navigate to full history
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text('View All'),
                      SizedBox(width: 6),
                      Icon(LucideIcons.arrowRight, size: 14),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Responsive layout
            LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < UIConstants.breakpointMedium) {
                  // Card layout for small screens
                  return Column(
                    children: sessions
                        .map(
                          (session) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _SessionCard(
                              session: session,
                              theme: theme,
                              onTap: () => _showSessionDetail(context, session),
                            ),
                          ),
                        )
                        .toList(),
                  );
                } else {
                  // Table layout for larger screens
                  return _buildSessionTable(context, sessions, theme);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionTable(BuildContext context, List<Session> sessions, ShadThemeData theme) {
    return Table(
      columnWidths: const {
        0: FixedColumnWidth(50),
        1: FlexColumnWidth(1.5),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(2.5),
        4: FixedColumnWidth(80),
      },
      border: TableBorder(
        horizontalInside: BorderSide(color: theme.colorScheme.border.withOpacity(0.3), width: 1),
      ),
      children: [
        // Header
        TableRow(
          decoration: BoxDecoration(
            color: theme.colorScheme.muted.withOpacity(0.2),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
          ),
          children: [
            _TableHeader(theme: theme, text: ''),
            _TableHeader(theme: theme, text: 'Date'),
            _TableHeader(theme: theme, text: 'Duration'),
            _TableHeader(theme: theme, text: 'Location'),
            _TableHeader(theme: theme, text: ''),
          ],
        ),

        // Data rows
        ...sessions.map(
          (session) => TableRow(
            children: [
              _SessionTypeIcon(session: session, theme: theme),
              _TableCell(theme: theme, text: _formatDate(session.startTime)),
              _TableCell(theme: theme, text: _formatDuration(session.duration)),
              _TableCell(theme: theme, text: session.location, maxLines: 2),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                child: ShadButton.outline(
                  size: ShadButtonSize.sm,
                  onPressed: () => _showSessionDetail(context, session),
                  child: const Icon(LucideIcons.eye, size: 14),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showSessionDetail(BuildContext context, Session session) {
    DialogUtils.showAdaptiveDialog(
      context: context,
      builder: (context) => SessionDetailDialog(
        session: session,
        onEdit: () {
          Navigator.pop(context);
          // TODO: Navigate to edit
        },
        onDelete: () {
          Navigator.pop(context);
          // TODO: Delete session
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return '${hours}h ${minutes}m';
  }
}

class _SessionCard extends StatelessWidget {
  final Session session;
  final ShadThemeData theme;
  final VoidCallback onTap;

  const _SessionCard({required this.session, required this.theme, required this.onTap});

  Color _getSessionColor(SessionType type) {
    switch (type) {
      case SessionType.practice:
        return AppColors.info;
      case SessionType.match:
        return AppColors.error;
      case SessionType.gearTest:
        return AppColors.chartTertiary;
    }
  }

  IconData _getSessionIcon(SessionType type) {
    switch (type) {
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
    final color = _getSessionColor(session.type);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.muted.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.3), width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(_getSessionIcon(session.type), size: 18, color: color),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        session.location,
                        style: theme.textTheme.p.copyWith(fontWeight: FontWeight.w600),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${_formatDate(session.startTime)} • ${_formatDuration(session.duration)}',
                        style: theme.textTheme.small.copyWith(
                          color: theme.colorScheme.mutedForeground,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(LucideIcons.chevronRight, size: 18, color: theme.colorScheme.mutedForeground),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return '${hours}h ${minutes}m';
  }
}

class _SessionTypeIcon extends StatelessWidget {
  final Session session;
  final ShadThemeData theme;

  const _SessionTypeIcon({required this.session, required this.theme});

  Color _getSessionColor(SessionType type) {
    switch (type) {
      case SessionType.practice:
        return AppColors.info;
      case SessionType.match:
        return AppColors.error;
      case SessionType.gearTest:
        return AppColors.chartTertiary;
    }
  }

  IconData _getSessionIcon(SessionType type) {
    switch (type) {
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
    final color = _getSessionColor(session.type);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(_getSessionIcon(session.type), size: 16, color: color),
      ),
    );
  }
}

class _TableHeader extends StatelessWidget {
  final ShadThemeData theme;
  final String text;

  const _TableHeader({required this.theme, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      child: Text(
        text,
        style: theme.textTheme.small.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.mutedForeground,
          letterSpacing: 0.5,
          fontSize: 11,
        ),
      ),
    );
  }
}

class _TableCell extends StatelessWidget {
  final ShadThemeData theme;
  final String text;
  final int maxLines;

  const _TableCell({required this.theme, required this.text, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      child: Text(
        text,
        style: theme.textTheme.p.copyWith(fontSize: 14),
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
