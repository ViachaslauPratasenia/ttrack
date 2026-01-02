import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../../../core/constants/ui_constants.dart';
import '../../domain/entities/session.dart';

class ManualEntryForm extends StatefulWidget {
  final Function(Session) onSessionSaved;

  const ManualEntryForm({super.key, required this.onSessionSaved});

  @override
  State<ManualEntryForm> createState() => _ManualEntryFormState();
}

class _ManualEntryFormState extends State<ManualEntryForm> {
  final _formKey = GlobalKey<ShadFormState>();

  SessionType _sessionType = SessionType.practice;

  // Common fields
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay(hour: TimeOfDay.now().hour + 1, minute: TimeOfDay.now().minute);
  String _whatWentWell = '';
  String _whatDidNotWork = '';
  String _whatToImprove = '';
  String _additionalNotes = '';
  String? _selectedPaddleSetup;

  // Match fields
  String _opponentName = '';
  int? _playerScore;
  int? _opponentScore;
  OpponentLevel _opponentLevel = OpponentLevel.similar;

  // Gear Test fields - using same text fields as practice

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (date != null && mounted) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  Future<void> _selectStartTime() async {
    final time = await showTimePicker(context: context, initialTime: _startTime);

    if (time != null && mounted) {
      setState(() {
        _startTime = time;
        // Автоматически устанавливаем время окончания на час позже
        final endHour = (time.hour + 1) % 24;
        _endTime = TimeOfDay(hour: endHour, minute: time.minute);
      });
    }
  }

  Future<void> _selectEndTime() async {
    final time = await showTimePicker(context: context, initialTime: _endTime);

    if (time != null && mounted) {
      setState(() {
        _endTime = time;
      });
    }
  }

  void _saveSession() {
    if (!_formKey.currentState!.saveAndValidate()) {
      return;
    }

    // Создаем DateTime из даты и времени начала
    final startDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _startTime.hour,
      _startTime.minute,
    );

    // Создаем DateTime из даты и времени окончания
    final endDateTime = DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _endTime.hour,
      _endTime.minute,
    );

    // Вычисляем продолжительность
    Duration duration = endDateTime.difference(startDateTime);

    // Если время окончания раньше начала, значит тренировка закончилась на следующий день
    if (duration.isNegative) {
      final nextDayEndTime = endDateTime.add(const Duration(days: 1));
      duration = nextDayEndTime.difference(startDateTime);
    }

    if (duration.inMinutes == 0) {
      ShadToaster.of(context).show(
        const ShadToast(description: Text('Время окончания должно быть позже времени начала')),
      );
      return;
    }

    // Combine text fields into notes
    final List<String> notesParts = [];
    if (_whatWentWell.isNotEmpty) {
      final label = _sessionType == SessionType.gearTest ? 'Что понравилось' : 'Что получалось';
      notesParts.add('$label:\n$_whatWentWell');
    }
    if (_whatDidNotWork.isNotEmpty) {
      final label = _sessionType == SessionType.gearTest
          ? 'Что не понравилось'
          : 'Что не получалось';
      notesParts.add('$label:\n$_whatDidNotWork');
    }
    if (_whatToImprove.isNotEmpty && _sessionType == SessionType.practice) {
      notesParts.add('Что нужно улучшить:\n$_whatToImprove');
    }
    if (_additionalNotes.isNotEmpty) {
      notesParts.add('Дополнительно:\n$_additionalNotes');
    }
    final combinedNotes = notesParts.isEmpty ? null : notesParts.join('\n\n');

    final session = Session(
      type: _sessionType,
      location: '', // Location removed for now
      startTime: startDateTime,
      endTime: endDateTime,
      duration: duration,
      notes: combinedNotes,
      paddleSetupId: _selectedPaddleSetup,
      playerScore: _sessionType == SessionType.match ? _playerScore : null,
      opponentName: _sessionType == SessionType.match ? _opponentName : null,
      opponentScore: _sessionType == SessionType.match ? _opponentScore : null,
      opponentLevel: _sessionType == SessionType.match ? _opponentLevel : null,
    );

    widget.onSessionSaved(session);

    ShadToaster.of(context).show(const ShadToast(description: Text('✓ Сессия сохранена!')));

    // Clear form
    setState(() {
      _selectedDate = DateTime.now();
      _startTime = TimeOfDay.now();
      _endTime = TimeOfDay(hour: TimeOfDay.now().hour + 1, minute: TimeOfDay.now().minute);
      _whatWentWell = '';
      _whatDidNotWork = '';
      _whatToImprove = '';
      _additionalNotes = '';
      _selectedPaddleSetup = null;
      _opponentName = '';
      _playerScore = null;
      _opponentScore = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ShadForm(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Session Type Selector
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Тип тренировки',
                style: ShadTheme.of(context).textTheme.small.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              ShadSelect<SessionType>(
                placeholder: const Text('Выберите тип тренировки'),
                initialValue: _sessionType,
                options: [
                  ShadOption(
                    value: SessionType.practice,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(LucideIcons.activity, size: 16),
                        const SizedBox(width: 8),
                        const Text('Тренировка'),
                      ],
                    ),
                  ),
                  ShadOption(
                    value: SessionType.match,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(LucideIcons.trophy, size: 16),
                        const SizedBox(width: 8),
                        const Text('Матч'),
                      ],
                    ),
                  ),
                  ShadOption(
                    value: SessionType.gearTest,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(LucideIcons.beaker, size: 16),
                        const SizedBox(width: 8),
                        const Text('Тест экипировки'),
                      ],
                    ),
                  ),
                ],
                selectedOptionBuilder: (context, value) {
                  final Map<SessionType, MapEntry<IconData, String>> typeInfo = {
                    SessionType.practice: const MapEntry(LucideIcons.activity, 'Тренировка'),
                    SessionType.match: const MapEntry(LucideIcons.trophy, 'Матч'),
                    SessionType.gearTest: const MapEntry(LucideIcons.beaker, 'Тест экипировки'),
                  };
                  final info = typeInfo[value]!;
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(info.key, size: 16),
                      const SizedBox(width: 8),
                      Text(info.value),
                    ],
                  );
                },
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _sessionType = value);
                  }
                },
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Date
          _buildDateTimeField(
            label: 'Дата',
            icon: LucideIcons.calendar,
            value:
                '${_selectedDate.day.toString().padLeft(2, '0')}.${_selectedDate.month.toString().padLeft(2, '0')}.${_selectedDate.year}',
            onTap: _selectDate,
          ),

          const SizedBox(height: 16),

          // Time Range
          Row(
            children: [
              Expanded(
                child: _buildDateTimeField(
                  label: 'Время начала',
                  icon: LucideIcons.clock,
                  value:
                      '${_startTime.hour.toString().padLeft(2, '0')}:${_startTime.minute.toString().padLeft(2, '0')}',
                  onTap: _selectStartTime,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildDateTimeField(
                  label: 'Время окончания',
                  icon: LucideIcons.clock,
                  value:
                      '${_endTime.hour.toString().padLeft(2, '0')}:${_endTime.minute.toString().padLeft(2, '0')}',
                  onTap: _selectEndTime,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Type-specific fields
          if (_sessionType == SessionType.match) _buildMatchFields(),

          const SizedBox(height: 24),

          // Paddle Setup
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Снаряжение',
                style: ShadTheme.of(context).textTheme.small.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              ShadSelect<String>(
                placeholder: const Text('Выберите снаряжение'),
                initialValue: _selectedPaddleSetup,
                options: [
                  ShadOption(value: 'setup1', child: const Text('Main Competition')),
                  ShadOption(value: 'setup2', child: const Text('Training Setup')),
                ],
                selectedOptionBuilder: (context, value) {
                  final labels = {'setup1': 'Main Competition', 'setup2': 'Training Setup'};
                  return Text(labels[value] ?? value);
                },
                onChanged: (value) => setState(() => _selectedPaddleSetup = value),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Text fields for training/gear test notes
          ShadInputFormField(
            id: 'what_went_well',
            label: Text(
              _sessionType == SessionType.gearTest ? 'Что понравилось' : 'Что получалось',
            ),
            placeholder: Text(
              _sessionType == SessionType.gearTest
                  ? 'Опишите, что понравилось в экипировке (опционально)'
                  : 'Опишите, что получалось хорошо (опционально)',
            ),
            maxLines: 4,
            initialValue: _whatWentWell,
            onChanged: (value) => _whatWentWell = value,
          ),

          const SizedBox(height: 16),

          ShadInputFormField(
            id: 'what_did_not_work',
            label: Text(
              _sessionType == SessionType.gearTest ? 'Что не понравилось' : 'Что не получалось',
            ),
            placeholder: Text(
              _sessionType == SessionType.gearTest
                  ? 'Опишите, что не понравилось в экипировке (опционально)'
                  : 'Опишите, что не получалось (опционально)',
            ),
            maxLines: 4,
            initialValue: _whatDidNotWork,
            onChanged: (value) => _whatDidNotWork = value,
          ),

          const SizedBox(height: 16),

          if (_sessionType == SessionType.practice) ...[
            ShadInputFormField(
              id: 'what_to_improve',
              label: const Text('Что нужно улучшить'),
              placeholder: const Text('Опишите, что нужно улучшить (опционально)'),
              maxLines: 4,
              initialValue: _whatToImprove,
              onChanged: (value) => _whatToImprove = value,
            ),
            const SizedBox(height: 16),
          ],

          ShadInputFormField(
            id: 'additional_notes',
            label: const Text('Дополнительные заметки'),
            placeholder: Text(
              _sessionType == SessionType.gearTest
                  ? 'Любые дополнительные заметки об экипировке (опционально)'
                  : 'Любые дополнительные заметки (опционально)',
            ),
            maxLines: 4,
            initialValue: _additionalNotes,
            onChanged: (value) => _additionalNotes = value,
          ),

          const SizedBox(height: 32),

          // Save Button
          ShadButton(
            onPressed: _saveSession,
            size: ShadButtonSize.lg,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Icon(LucideIcons.check, size: 20), SizedBox(width: 8), Text('Сохранить')],
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildDateTimeField({
    required String label,
    required IconData icon,
    required String value,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: ShadTheme.of(context).textTheme.small.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: ShadTheme.of(context).colorScheme.border),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(icon, size: 20, color: ShadTheme.of(context).colorScheme.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    value,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
                Icon(
                  LucideIcons.chevronDown,
                  size: 18,
                  color: ShadTheme.of(context).colorScheme.mutedForeground,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMatchFields() {
    return ShadCard(
      title: const Text('Детали матча'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShadInputFormField(
            id: 'opponent',
            label: const Text('Имя соперника'),
            placeholder: const Text('Введите имя'),
            initialValue: _opponentName,
            onChanged: (value) => _opponentName = value,
            validator: (value) {
              if (value.isEmpty) return 'Введите имя соперника';
              return null;
            },
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < UIConstants.breakpointXSmall) {
                return Column(
                  children: [
                    ShadInputFormField(
                      id: 'player_score',
                      label: const Text('Ваш счет'),
                      placeholder: const Text('0'),
                      keyboardType: TextInputType.number,
                      initialValue: _playerScore?.toString() ?? '',
                      onChanged: (value) => _playerScore = int.tryParse(value),
                      validator: (value) {
                        if (value.isEmpty) return 'Введите счет';
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),
                    ShadInputFormField(
                      id: 'opponent_score',
                      label: const Text('Счет соперника'),
                      placeholder: const Text('0'),
                      keyboardType: TextInputType.number,
                      initialValue: _opponentScore?.toString() ?? '',
                      onChanged: (value) => _opponentScore = int.tryParse(value),
                      validator: (value) {
                        if (value.isEmpty) return 'Введите счет';
                        return null;
                      },
                    ),
                  ],
                );
              }
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: ShadInputFormField(
                      id: 'player_score',
                      label: const Text('Ваш счет'),
                      placeholder: const Text('0'),
                      keyboardType: TextInputType.number,
                      initialValue: _playerScore?.toString() ?? '',
                      onChanged: (value) => _playerScore = int.tryParse(value),
                      validator: (value) {
                        if (value.isEmpty) return 'Введите счет';
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ShadInputFormField(
                      id: 'opponent_score',
                      label: const Text('Счет соперника'),
                      placeholder: const Text('0'),
                      keyboardType: TextInputType.number,
                      initialValue: _opponentScore?.toString() ?? '',
                      onChanged: (value) => _opponentScore = int.tryParse(value),
                      validator: (value) {
                        if (value.isEmpty) return 'Введите счет';
                        return null;
                      },
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          ShadSelect<OpponentLevel>(
            placeholder: const Text('Уровень соперника'),
            initialValue: _opponentLevel,
            options: [
              ShadOption(value: OpponentLevel.higher, child: const Text('Выше')),
              ShadOption(value: OpponentLevel.similar, child: const Text('Схожий')),
              ShadOption(value: OpponentLevel.lower, child: const Text('Ниже')),
            ],
            selectedOptionBuilder: (context, value) {
              final labels = {
                OpponentLevel.higher: 'Выше',
                OpponentLevel.similar: 'Схожий',
                OpponentLevel.lower: 'Ниже',
              };
              return Text(labels[value] ?? '');
            },
            onChanged: (value) {
              if (value != null) {
                setState(() => _opponentLevel = value);
              }
            },
          ),
        ],
      ),
    );
  }
}
