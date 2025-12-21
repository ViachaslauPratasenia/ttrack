import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
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
  String _location = '';
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay(hour: TimeOfDay.now().hour + 1, minute: TimeOfDay.now().minute);
  String _notes = '';
  String? _selectedPaddleSetup;

  // Practice fields
  double _technicalRating = 5.0;
  double _tacticalRating = 5.0;
  double _mentalRating = 5.0;

  // Match fields
  String _opponentName = '';
  int? _playerScore;
  int? _opponentScore;
  OpponentLevel _opponentLevel = OpponentLevel.similar;

  // Gear Test fields
  double _sgc = 50.0;
  double _spn = 50.0;
  double _pwr = 50.0;
  double _stb = 50.0;
  double _sns = 50.0;

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

    final session = Session(
      type: _sessionType,
      location: _location,
      startTime: startDateTime,
      endTime: endDateTime,
      duration: duration,
      notes: _notes.isEmpty ? null : _notes,
      paddleSetupId: _selectedPaddleSetup,
      technicalRating: _sessionType == SessionType.practice ? _technicalRating.round() : null,
      tacticalRating: _sessionType == SessionType.practice ? _tacticalRating.round() : null,
      mentalRating: _sessionType == SessionType.practice ? _mentalRating.round() : null,
      playerScore: _sessionType == SessionType.match ? _playerScore : null,
      opponentName: _sessionType == SessionType.match ? _opponentName : null,
      opponentScore: _sessionType == SessionType.match ? _opponentScore : null,
      opponentLevel: _sessionType == SessionType.match ? _opponentLevel : null,
      sgc: _sessionType == SessionType.gearTest ? _sgc.round() : null,
      spn: _sessionType == SessionType.gearTest ? _spn.round() : null,
      pwr: _sessionType == SessionType.gearTest ? _pwr.round() : null,
      stb: _sessionType == SessionType.gearTest ? _stb.round() : null,
      sns: _sessionType == SessionType.gearTest ? _sns.round() : null,
    );

    widget.onSessionSaved(session);

    ShadToaster.of(context).show(const ShadToast(description: Text('✓ Сессия сохранена!')));

    // Clear form
    setState(() {
      _location = '';
      _selectedDate = DateTime.now();
      _startTime = TimeOfDay.now();
      _endTime = TimeOfDay(hour: TimeOfDay.now().hour + 1, minute: TimeOfDay.now().minute);
      _notes = '';
      _selectedPaddleSetup = null;
      _opponentName = '';
      _playerScore = null;
      _opponentScore = null;
      _technicalRating = 5.0;
      _tacticalRating = 5.0;
      _mentalRating = 5.0;
      _sgc = 50.0;
      _spn = 50.0;
      _pwr = 50.0;
      _stb = 50.0;
      _sns = 50.0;
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

          // Location
          ShadInputFormField(
            id: 'location',
            label: const Text('Локация'),
            placeholder: const Text('Введите место тренировки'),
            initialValue: _location,
            onChanged: (value) => _location = value,
            validator: (value) {
              if (value.isEmpty) return 'Введите локацию';
              return null;
            },
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
          if (_sessionType == SessionType.practice)
            _buildPracticeFields()
          else if (_sessionType == SessionType.match)
            _buildMatchFields()
          else if (_sessionType == SessionType.gearTest)
            _buildGearTestFields(),

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

          // Notes
          ShadInputFormField(
            id: 'notes',
            label: const Text('Заметки'),
            placeholder: const Text('Добавьте заметки (опционально)'),
            maxLines: 3,
            initialValue: _notes,
            onChanged: (value) => _notes = value,
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

  Widget _buildPracticeFields() {
    return ShadCard(
      title: const Text('Оценки (1-10)'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRatingSlider(
            label: 'Техника',
            icon: LucideIcons.lightbulb,
            value: _technicalRating,
            onChanged: (value) => setState(() => _technicalRating = value),
          ),
          const SizedBox(height: 16),
          _buildRatingSlider(
            label: 'Тактика',
            icon: LucideIcons.brain,
            value: _tacticalRating,
            onChanged: (value) => setState(() => _tacticalRating = value),
          ),
          const SizedBox(height: 16),
          _buildRatingSlider(
            label: 'Ментальность',
            icon: LucideIcons.heart,
            value: _mentalRating,
            onChanged: (value) => setState(() => _mentalRating = value),
          ),
        ],
      ),
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
              if (constraints.maxWidth < 400) {
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

  Widget _buildGearTestFields() {
    return ShadCard(
      title: const Text('KPI показатели (0-100)'),
      child: Column(
        children: [
          _buildKPISlider('Контроль короткой игры', _sgc, (v) => setState(() => _sgc = v)),
          const SizedBox(height: 12),
          _buildKPISlider('Потенциал вращения', _spn, (v) => setState(() => _spn = v)),
          const SizedBox(height: 12),
          _buildKPISlider('Мощность', _pwr, (v) => setState(() => _pwr = v)),
          const SizedBox(height: 12),
          _buildKPISlider('Стабильность', _stb, (v) => setState(() => _stb = v)),
          const SizedBox(height: 12),
          _buildKPISlider('Чувствительность', _sns, (v) => setState(() => _sns = v)),
        ],
      ),
    );
  }

  Widget _buildRatingSlider({
    required String label,
    required IconData icon,
    required double value,
    required Function(double) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 16),
                const SizedBox(width: 8),
                Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
              ],
            ),
            ShadBadge(child: Text(value.round().toString())),
          ],
        ),
        const SizedBox(height: 8),
        ShadSlider(min: 1, max: 10, initialValue: value, onChanged: onChanged),
      ],
    );
  }

  Widget _buildKPISlider(String label, double value, Function(double) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                label,
                style: const TextStyle(fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            ShadBadge(child: Text(value.round().toString())),
          ],
        ),
        const SizedBox(height: 8),
        ShadSlider(min: 0, max: 100, initialValue: value, onChanged: onChanged),
      ],
    );
  }
}
