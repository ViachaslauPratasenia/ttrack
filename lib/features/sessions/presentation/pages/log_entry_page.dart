import 'package:flutter/material.dart';
import '../../../../core/constants/ui_constants.dart';
import '../../domain/entities/session.dart';
import '../widgets/manual_entry_form.dart';

class LogEntryPage extends StatefulWidget {
  const LogEntryPage({super.key});

  @override
  State<LogEntryPage> createState() => _LogEntryPageState();
}

class _LogEntryPageState extends State<LogEntryPage> {
  final List<Session> _sessions = [];

  void _handleSessionSaved(Session session) {
    setState(() {
      _sessions.add(session);
    });

    // TODO: Send to backend API
    debugPrint('Session saved: ${session.type} at ${session.location}');
    debugPrint('Duration: ${session.duration}');
    if (session.notes != null && session.notes!.isNotEmpty) {
      debugPrint('Notes: ${session.notes}');
    }
    if (session.type == SessionType.match) {
      debugPrint('Score: ${session.playerScore} - ${session.opponentScore}');
      debugPrint('Opponent: ${session.opponentName} (${session.opponentLevel})');
    } else if (session.type == SessionType.gearTest) {
      debugPrint('KPIs: SGC:${session.sgc}, SPN:${session.spn}, '
          'PWR:${session.pwr}, STB:${session.stb}, SNS:${session.sns}');
      debugPrint('GQS Score: ${session.gqsScore}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth.isMobile;
    
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Добавить тренировку'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: isMobile ? double.infinity : 800,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 24,
            vertical: 16,
          ),
          child: ManualEntryForm(
            onSessionSaved: _handleSessionSaved,
          ),
        ),
      ),
    );
  }
}

