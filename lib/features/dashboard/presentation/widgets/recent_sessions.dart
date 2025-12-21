import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../../sessions/domain/entities/session.dart';

class RecentSessions extends StatelessWidget {
  const RecentSessions({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data - TODO: Get from state management
    final sessions = [
      Session(
        type: SessionType.practice,
        location: 'SM Table Tennis Academy - Marilao, Bulacan, Philippines',
        startTime: DateTime(2025, 11, 10, 10, 0),
        endTime: DateTime(2025, 11, 10, 12, 0),
        duration: const Duration(hours: 2),
        technicalRating: 8,
        tacticalRating: 7,
        mentalRating: 9,
        notes: 'Отличная тренировка, работал над подачами',
      ),
    ];

    final theme = ShadTheme.of(context);

    return ShadCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Sessions',
            style: theme.textTheme.h3,
          ),
          const SizedBox(height: 20),
          
          // Table
          Table(
            columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(3),
            },
            border: TableBorder(
              horizontalInside: BorderSide(
                color: theme.colorScheme.border,
                width: 1,
              ),
            ),
            children: [
              // Header
              TableRow(
                children: [
                  _TableHeader(theme: theme, text: 'Date'),
                  _TableHeader(theme: theme, text: 'Duration'),
                  _TableHeader(theme: theme, text: 'Location'),
                ],
              ),
              
              // Data rows
              ...sessions.map((session) => TableRow(
                children: [
                  _TableCell(
                    theme: theme,
                    text: _formatDate(session.startTime),
                  ),
                  _TableCell(
                    theme: theme,
                    text: _formatDuration(session.duration),
                  ),
                  _TableCell(
                    theme: theme,
                    text: session.location,
                  ),
                ],
              )),
            ],
          ),
        ],
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

class _TableHeader extends StatelessWidget {
  final ShadThemeData theme;
  final String text;
  
  const _TableHeader({
    required this.theme,
    required this.text,
  });
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Text(
        text,
        style: theme.textTheme.small.copyWith(
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.mutedForeground,
        ),
      ),
    );
  }
}

class _TableCell extends StatelessWidget {
  final ShadThemeData theme;
  final String text;
  
  const _TableCell({
    required this.theme,
    required this.text,
  });
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Text(
        text,
        style: theme.textTheme.p,
      ),
    );
  }
}
