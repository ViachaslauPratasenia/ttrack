import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/equipment.dart';

class AddEquipmentDialog extends StatefulWidget {
  final PaddleSetup? paddleSetup;
  final Function(PaddleSetup) onSave;

  const AddEquipmentDialog({
    super.key,
    this.paddleSetup,
    required this.onSave,
  });

  @override
  State<AddEquipmentDialog> createState() => _AddEquipmentDialogState();
}

class _AddEquipmentDialogState extends State<AddEquipmentDialog> {
  final _formKey = GlobalKey<FormState>();
  
  // Paddle Setup
  late TextEditingController _setupNameController;
  
  // Blade
  late TextEditingController _bladeNameController;
  EquipmentCondition _bladeCondition = EquipmentCondition.brandNew;
  
  // Forehand Rubber
  late TextEditingController _fhRubberNameController;
  EquipmentCondition _fhRubberCondition = EquipmentCondition.brandNew;
  late TextEditingController _fhLifespanController;
  late TextEditingController _fhUsedHoursController;
  
  // Backhand Rubber
  late TextEditingController _bhRubberNameController;
  EquipmentCondition _bhRubberCondition = EquipmentCondition.brandNew;
  late TextEditingController _bhLifespanController;
  late TextEditingController _bhUsedHoursController;

  @override
  void initState() {
    super.initState();
    
    final setup = widget.paddleSetup;
    
    _setupNameController = TextEditingController(text: setup?.name ?? '');
    
    // Blade
    _bladeNameController = TextEditingController(text: setup?.blade.name ?? '');
    _bladeCondition = setup?.blade.condition ?? EquipmentCondition.brandNew;
    
    // Forehand
    _fhRubberNameController = TextEditingController(text: setup?.forehandRubber.name ?? '');
    _fhRubberCondition = setup?.forehandRubber.initialCondition ?? EquipmentCondition.brandNew;
    _fhLifespanController = TextEditingController(
      text: setup?.forehandRubber.lifespanHours.toString() ?? '200',
    );
    _fhUsedHoursController = TextEditingController(
      text: setup?.forehandRubber.usedHours.toString() ?? '0',
    );
    
    // Backhand
    _bhRubberNameController = TextEditingController(text: setup?.backhandRubber.name ?? '');
    _bhRubberCondition = setup?.backhandRubber.initialCondition ?? EquipmentCondition.brandNew;
    _bhLifespanController = TextEditingController(
      text: setup?.backhandRubber.lifespanHours.toString() ?? '200',
    );
    _bhUsedHoursController = TextEditingController(
      text: setup?.backhandRubber.usedHours.toString() ?? '0',
    );
  }

  @override
  void dispose() {
    _setupNameController.dispose();
    _bladeNameController.dispose();
    _fhRubberNameController.dispose();
    _fhLifespanController.dispose();
    _fhUsedHoursController.dispose();
    _bhRubberNameController.dispose();
    _bhLifespanController.dispose();
    _bhUsedHoursController.dispose();
    super.dispose();
  }

  void _handleSave() {
    if (_formKey.currentState?.validate() ?? false) {
      final blade = Blade(
        id: widget.paddleSetup?.blade.id,
        name: _bladeNameController.text.trim(),
        brand: null,
        condition: _bladeCondition,
        purchaseDate: widget.paddleSetup?.blade.purchaseDate ?? DateTime.now(),
      );

      final forehandRubber = Rubber(
        id: widget.paddleSetup?.forehandRubber.id,
        name: _fhRubberNameController.text.trim(),
        brand: null,
        side: RubberSide.forehand,
        initialCondition: _fhRubberCondition,
        lifespanHours: double.tryParse(_fhLifespanController.text) ?? 200,
        usedHours: double.tryParse(_fhUsedHoursController.text) ?? 0,
        installDate: widget.paddleSetup?.forehandRubber.installDate ?? DateTime.now(),
      );

      final backhandRubber = Rubber(
        id: widget.paddleSetup?.backhandRubber.id,
        name: _bhRubberNameController.text.trim(),
        brand: null,
        side: RubberSide.backhand,
        initialCondition: _bhRubberCondition,
        lifespanHours: double.tryParse(_bhLifespanController.text) ?? 200,
        usedHours: double.tryParse(_bhUsedHoursController.text) ?? 0,
        installDate: widget.paddleSetup?.backhandRubber.installDate ?? DateTime.now(),
      );

      final paddleSetup = PaddleSetup(
        id: widget.paddleSetup?.id,
        name: _setupNameController.text.trim(),
        blade: blade,
        forehandRubber: forehandRubber,
        backhandRubber: backhandRubber,
        isActive: widget.paddleSetup?.isActive ?? true,
        createdAt: widget.paddleSetup?.createdAt ?? DateTime.now(),
      );

      widget.onSave(paddleSetup);
      Navigator.of(context).pop();
    }
  }

  void _getAILifespanSuggestion(TextEditingController controller, String rubberName) {
    // TODO: Replace with actual AI API call
    // For now, return test data based on rubber type
    
    final name = rubberName.toLowerCase();
    double suggestedLifespan = 200; // default
    
    if (name.contains('tenergy') || name.contains('dignics')) {
      suggestedLifespan = 150; // Premium rubbers wear faster
    } else if (name.contains('evo') || name.contains('rasant')) {
      suggestedLifespan = 180;
    } else if (name.contains('mark v') || name.contains('sriver')) {
      suggestedLifespan = 250; // Classic rubbers last longer
    }
    
    setState(() {
      controller.text = suggestedLifespan.toString();
    });
    
    // Show a snackbar with info
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('AI рекомендует: ${suggestedLifespan.toInt()} часов для новой накладки'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.colorScheme.muted.withOpacity(0.05),
            border: Border(
              bottom: BorderSide(color: theme.colorScheme.border.withOpacity(0.5)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    LucideIcons.target,
                    size: 22,
                    color: theme.colorScheme.mutedForeground,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.paddleSetup == null 
                      ? 'Добавить ракетку' 
                      : 'Редактировать ракетку',
                    style: theme.textTheme.h3.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: isMobile ? 18 : 20,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(LucideIcons.x, size: 20),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),

        // Form
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Setup Name
                  _buildSectionTitle(theme, 'Название ракетки'),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: _setupNameController,
                    label: 'Название',
                    hint: 'Например: Основная ракетка',
                    required: true,
                  ),
                  const SizedBox(height: 24),

                  // Blade Section
                  _buildSectionTitle(theme, 'Основание'),
                  const SizedBox(height: 8),
                  _buildTextField(
                    controller: _bladeNameController,
                    label: 'Название',
                    hint: 'Например: Butterfly Viscaria',
                    required: true,
                  ),
                  const SizedBox(height: 12),
                  _buildConditionSelector(
                    'Состояние',
                    _bladeCondition,
                    (value) => setState(() => _bladeCondition = value),
                  ),
                  const SizedBox(height: 24),

                  // Forehand Rubber Section
                  _buildSectionTitle(theme, 'Накладка форхенда'),
                  const SizedBox(height: 8),
                  _buildRubberSection(
                    nameController: _fhRubberNameController,
                    condition: _fhRubberCondition,
                    onConditionChanged: (value) => setState(() => _fhRubberCondition = value),
                    lifespanController: _fhLifespanController,
                    usedHoursController: _fhUsedHoursController,
                  ),
                  const SizedBox(height: 24),

                  // Backhand Rubber Section
                  _buildSectionTitle(theme, 'Накладка бэкхенда'),
                  const SizedBox(height: 8),
                  _buildRubberSection(
                    nameController: _bhRubberNameController,
                    condition: _bhRubberCondition,
                    onConditionChanged: (value) => setState(() => _bhRubberCondition = value),
                    lifespanController: _bhLifespanController,
                    usedHoursController: _bhUsedHoursController,
                  ),
                ],
              ),
            ),
          ),
        ),

        // Footer
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.colorScheme.muted.withOpacity(0.05),
            border: Border(
              top: BorderSide(color: theme.colorScheme.border.withOpacity(0.5)),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ShadButton.outline(
                onPressed: () => Navigator.of(context).pop(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(LucideIcons.x, size: 16),
                    SizedBox(width: 6),
                    Text('Отмена'),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ShadButton(
                onPressed: _handleSave,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(LucideIcons.check, size: 16),
                    SizedBox(width: 6),
                    Text('Сохранить'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );

    // Full-screen for mobile, dialog for desktop
    if (isMobile) {
      return Scaffold(
        backgroundColor: AppColors.dialogBackground,
        body: SafeArea(child: content),
      );
    }

    return Dialog(
      backgroundColor: AppColors.background.withOpacity(0.8),
      child: Container(
        width: 600,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        decoration: BoxDecoration(
          color: AppColors.dialogBackground,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: theme.colorScheme.border.withOpacity(0.5),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: content,
      ),
    );
  }

  Widget _buildSectionTitle(ShadThemeData theme, String title) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 20,
          decoration: BoxDecoration(
            color: theme.colorScheme.mutedForeground.withOpacity(0.4),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: theme.textTheme.large.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: theme.colorScheme.foreground.withOpacity(0.85),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    bool required = false,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label + (required ? ' *' : ''),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
          ),
          validator: required
            ? (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Поле обязательно для заполнения';
                }
                return null;
              }
            : null,
        ),
      ],
    );
  }

  Widget _buildConditionSelector(
    String label,
    EquipmentCondition value,
    Function(EquipmentCondition) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<EquipmentCondition>(
          value: value,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
          ),
          items: EquipmentCondition.values.map((condition) {
            return DropdownMenuItem(
              value: condition,
              child: Text(condition.displayName),
            );
          }).toList(),
          onChanged: (newValue) {
            if (newValue != null) {
              onChanged(newValue);
            }
          },
        ),
      ],
    );
  }

  Widget _buildRubberSection({
    required TextEditingController nameController,
    required EquipmentCondition condition,
    required Function(EquipmentCondition) onConditionChanged,
    required TextEditingController lifespanController,
    required TextEditingController usedHoursController,
  }) {
    return Column(
      children: [
        _buildTextField(
          controller: nameController,
          label: 'Название',
          hint: 'Например: Butterfly Tenergy 05',
          required: true,
        ),
        const SizedBox(height: 12),
        _buildConditionSelector(
          'Состояние при установке',
          condition,
          onConditionChanged,
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: _buildTextField(
                controller: lifespanController,
                label: 'Срок жизни (новая, часы)',
                hint: '200',
                required: true,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: SizedBox(
                height: 40,
                child: ShadButton.outline(
                  onPressed: () => _getAILifespanSuggestion(
                    lifespanController, 
                    nameController.text,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(LucideIcons.sparkles, size: 16),
                      SizedBox(width: 6),
                      Text('AI', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildTextField(
          controller: usedHoursController,
          label: 'Уже использовано (часы)',
          hint: '0',
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}

