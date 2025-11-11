import 'package:flutter/material.dart';

class RecentSessions extends StatelessWidget {
  const RecentSessions({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data - TODO: Get from state management
    final sessions = [
      {
        'type': 'Practice',
        'icon': Icons.sports,
        'color': Colors.blue,
        'date': '10 ноября, 18:30',
        'duration': '1.5 ч',
        'location': 'Спорткомплекс "Олимп"',
      },
      {
        'type': 'Match',
        'icon': Icons.emoji_events,
        'color': Colors.amber,
        'date': '9 ноября, 20:00',
        'duration': '2.0 ч',
        'location': 'Клуб "Мастер"',
      },
      {
        'type': 'Practice',
        'icon': Icons.sports,
        'color': Colors.blue,
        'date': '7 ноября, 19:00',
        'duration': '1.0 ч',
        'location': 'Спорткомплекс "Олимп"',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Последние тренировки',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              TextButton(
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
              color: session['color'] as Color,
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
  final Color color;
  final String date;
  final String duration;
  final String location;

  const _SessionCard({
    required this.type,
    required this.icon,
    required this.color,
    required this.date,
    required this.duration,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to session detail
        },
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        type,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          duration,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 14,
                        color: Colors.grey.shade500,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          location,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
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
              Icons.chevron_right,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}

