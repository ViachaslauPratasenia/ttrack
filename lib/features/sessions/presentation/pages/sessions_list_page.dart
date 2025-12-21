import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../domain/entities/session.dart';
import '../widgets/session_detail_dialog.dart';

class SessionsListPage extends StatefulWidget {
  const SessionsListPage({super.key});

  @override
  State<SessionsListPage> createState() => _SessionsListPageState();
}

class _SessionsListPageState extends State<SessionsListPage> {
  // TODO: Заменить на реальный источник данных (state management)
  List<Session> _sessions = [];

  @override
  void initState() {
    super.initState();
    _loadMockSessions();
  }

  void _loadMockSessions() {
    // Mock данные для демонстрации
    _sessions = [
      Session(
        type: SessionType.practice,
        location: 'Спорткомплекс "Олимп"',
        startTime: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
        endTime: DateTime.now().subtract(const Duration(days: 1)),
        duration: const Duration(hours: 2),
        technicalRating: 8,
        tacticalRating: 7,
        mentalRating: 9,
        notes: 'Отличная тренировка, работал над подачами',
      ),
      Session(
        type: SessionType.match,
        location: 'Клуб "Мастер"',
        startTime: DateTime.now().subtract(const Duration(days: 3, hours: 1, minutes: 30)),
        endTime: DateTime.now().subtract(const Duration(days: 3)),
        duration: const Duration(hours: 1, minutes: 30),
        opponentName: 'Иван Петров',
        opponentLevel: OpponentLevel.higher,
        playerScore: 3,
        opponentScore: 2,
        notes: 'Напряженный матч, победа в 5 сетах',
      ),
      Session(
        type: SessionType.gearTest,
        location: 'Тренировочный зал',
        startTime: DateTime.now().subtract(const Duration(days: 7, hours: 1)),
        endTime: DateTime.now().subtract(const Duration(days: 7)),
        duration: const Duration(hours: 1),
        sgc: 85,
        spn: 75,
        pwr: 90,
        stb: 80,
        sns: 70,
        notes: 'Тестирование новой ракетки Hurricane 3',
      ),
    ];
  }

  void _deleteSession(int index) {
    setState(() {
      _sessions.removeAt(index);
    });
    ShadToaster.of(context).show(
      const ShadToast(description: Text('Сессия удалена')),
    );
  }

  void _editSession(int index) {
    // TODO: Открыть форму редактирования
    showDialog(
      context: context,
      builder: (context) => ShadDialog(
        title: const Text('Редактирование'),
        description: const Text('Функция редактирования будет добавлена'),
        child: ShadButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ),
    );
  }

  void _showSessionDetail(Session session, int index) {
    showDialog(
      context: context,
      builder: (context) => SessionDetailDialog(
        session: session,
        onEdit: () {
          Navigator.pop(context);
          _editSession(index);
        },
        onDelete: () {
          Navigator.pop(context);
          _showDeleteConfirmation(index);
        },
      ),
    );
  }

  void _showDeleteConfirmation(int index) {
    showDialog(
      context: context,
      builder: (context) => ShadDialog(
        title: const Text('Удалить сессию?'),
        description: const Text('Это действие нельзя отменить'),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ShadButton.outline(
              onPressed: () => Navigator.pop(context),
              child: const Text('Отмена'),
            ),
            const SizedBox(width: 8),
            ShadButton.destructive(
              onPressed: () {
                Navigator.pop(context);
                _deleteSession(index);
              },
              child: const Text('Удалить'),
            ),
          ],
        ),
      ),
    );
  }

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

  IconData _getSessionIcon(SessionType type) {
    switch (type) {
      case SessionType.practice:
        return LucideIcons.activity;
      case SessionType.match:
        return LucideIcons.trophy;
      case SessionType.gearTest:
        return LucideIcons.beaker;
    }
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

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: const Text('История тренировок'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _sessions.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    LucideIcons.calendar,
                    size: 64,
                    color: theme.colorScheme.mutedForeground,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Нет записей',
                    style: theme.textTheme.h3,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Добавьте первую тренировку',
                    style: theme.textTheme.muted,
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _sessions.length,
              itemBuilder: (context, index) {
                final session = _sessions[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ShadCard(
                    child: InkWell(
                      onTap: () => _showSessionDetail(session, index),
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    _getSessionIcon(session.type),
                                    color: theme.colorScheme.primary,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _getSessionTypeLabel(session.type),
                                        style: theme.textTheme.p.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        _formatDateTime(session.startTime),
                                        style: theme.textTheme.small.copyWith(
                                          color: theme.colorScheme.mutedForeground,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ShadBadge.secondary(
                                  child: Text(_formatDuration(session.duration)),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 12),
                            
                            // Location
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  LucideIcons.mapPin,
                                  size: 14,
                                  color: theme.colorScheme.mutedForeground,
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    session.location,
                                    style: theme.textTheme.small.copyWith(
                                      color: theme.colorScheme.mutedForeground,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),

                            // Type-specific info
                            if (session.type == SessionType.match) ...[
                              const SizedBox(height: 8),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    LucideIcons.user,
                                    size: 14,
                                    color: theme.colorScheme.mutedForeground,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${session.opponentName} (${session.playerScore}:${session.opponentScore})',
                                    style: theme.textTheme.small.copyWith(
                                      color: theme.colorScheme.mutedForeground,
                                    ),
                                  ),
                                ],
                              ),
                            ],

                            if (session.notes != null && session.notes!.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(
                                session.notes!,
                                style: theme.textTheme.small,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],

                            // Actions
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ShadButton.ghost(
                                  onPressed: () => _editSession(index),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(LucideIcons.pencil, size: 16),
                                      SizedBox(width: 4),
                                      Text('Изменить'),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ShadButton.ghost(
                                  onPressed: () => _showDeleteConfirmation(index),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(LucideIcons.trash2, size: 16),
                                      SizedBox(width: 4),
                                      Text('Удалить'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

