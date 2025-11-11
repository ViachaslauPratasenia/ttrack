import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class RecentSessions extends StatelessWidget {
  const RecentSessions({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data - TODO: Get from state management
    final sessions = [
      {
        'type': 'Practice',
        'icon': LucideIcons.activity,
        'date': '10 ноября, 18:30',
        'duration': '1.5 ч',
        'location': 'Спорткомплекс "Олимп"',
      },
      {
        'type': 'Match',
        'icon': LucideIcons.trophy,
        'date': '9 ноября, 20:00',
        'duration': '2.0 ч',
        'location': 'Клуб "Мастер"',
      },
      {
        'type': 'Practice',
        'icon': LucideIcons.activity,
        'date': '7 ноября, 19:00',
        'duration': '1.0 ч',
        'location': 'Спорткомплекс "Олимп"',
      },
    ];

    final theme = ShadTheme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Последние тренировки',
                style: theme.textTheme.h3,
              ),
              ShadButton.ghost(
                onPressed: () {
                  // TODO: Navigate to History
                },
                child: const Text('Все'),
              ),
            ],
          ),
          const SizedBox(height: 12),

          ...sessions.map((session) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _SessionCard(
              type: session['type'] as String,
              icon: session['icon'] as IconData,
              date: session['date'] as String,
              duration: session['duration'] as String,
              location: session['location'] as String,
            ),
          )),
        ],
      ),
    );
  }
}

class _SessionCard extends StatelessWidget {
  final String type;
  final IconData icon;
  final String date;
  final String duration;
  final String location;

  const _SessionCard({
    required this.type,
    required this.icon,
    required this.date,
    required this.duration,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);

    return ShadCard(
      padding: const EdgeInsets.all(16),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to session detail
        },
        borderRadius: BorderRadius.circular(12),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: theme.colorScheme.primary, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          type,
                          style: theme.textTheme.p.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      ShadBadge.secondary(
                        child: Text(duration),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: theme.textTheme.muted,
                  ),
                  const SizedBox(height: 2),
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
                          location,
                          style: theme.textTheme.small.copyWith(
                            color: theme.colorScheme.mutedForeground,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              LucideIcons.chevronRight,
              color: theme.colorScheme.mutedForeground,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
