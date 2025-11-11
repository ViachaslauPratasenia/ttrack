import 'package:flutter/material.dart';

class PerformanceChart extends StatelessWidget {
  const PerformanceChart({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data - TODO: Replace with real data and fl_chart
    final mockData = [
      {'date': '1 нояб', 'rating': 6.5},
      {'date': '2 нояб', 'rating': 6.8},
      {'date': '3 нояб', 'rating': 7.0},
      {'date': '4 нояб', 'rating': 6.9},
      {'date': '5 нояб', 'rating': 7.2},
      {'date': '6 нояб', 'rating': 7.5},
      {'date': '7 нояб', 'rating': 7.8},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'График прогресса',
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
                  child: const Text('Подробнее'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Средний рейтинг за последнюю неделю',
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 20),

            // Simplified chart visualization
            // TODO: Replace with fl_chart
            SizedBox(
              height: 180,
              child: CustomPaint(
                painter: _SimpleChartPainter(mockData),
                child: Container(),
              ),
            ),

            const SizedBox(height: 16),

            // Legend
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 16,
                  height: 3,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Рейтинг (1-10)',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SimpleChartPainter extends CustomPainter {
  final List<Map<String, dynamic>> data;

  _SimpleChartPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.deepPurple
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final pointPaint = Paint()
      ..color = Colors.deepPurple
      ..style = PaintingStyle.fill;

    final gridPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 1;

    // Draw grid lines
    for (int i = 0; i <= 4; i++) {
      final y = size.height * i / 4;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        gridPaint,
      );
    }

    if (data.isEmpty) return;

    final path = Path();
    final points = <Offset>[];

    for (int i = 0; i < data.length; i++) {
      final x = size.width * i / (data.length - 1);
      final rating = data[i]['rating'] as double;
      // Normalize rating (0-10) to chart height
      final y = size.height - (size.height * (rating / 10));

      points.add(Offset(x, y));

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    // Draw line
    canvas.drawPath(path, paint);

    // Draw points
    for (final point in points) {
      canvas.drawCircle(point, 5, pointPaint);
      canvas.drawCircle(point, 3, Paint()..color = Colors.white);
    }

    // Draw labels
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < data.length; i += 2) {
      final x = size.width * i / (data.length - 1);
      textPainter.text = TextSpan(
        text: data[i]['date'] as String,
        style: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 10,
        ),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, size.height + 8),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

