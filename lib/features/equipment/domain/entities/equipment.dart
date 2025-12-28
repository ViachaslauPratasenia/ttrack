enum EquipmentCondition {
  brandNew,      // Новое
  lightlyUsed,   // Слегка б/у (10-30% износа)
  moderatelyUsed, // Средне б/у (30-60% износа)
  heavilyUsed,   // Сильно б/у (60-90% износа)
}

extension EquipmentConditionExtension on EquipmentCondition {
  String get displayName {
    switch (this) {
      case EquipmentCondition.brandNew:
        return 'Новое';
      case EquipmentCondition.lightlyUsed:
        return 'Слегка б/у';
      case EquipmentCondition.moderatelyUsed:
        return 'Средне б/у';
      case EquipmentCondition.heavilyUsed:
        return 'Сильно б/у';
    }
  }

  double get wearPercentage {
    switch (this) {
      case EquipmentCondition.brandNew:
        return 0.0;
      case EquipmentCondition.lightlyUsed:
        return 0.2;
      case EquipmentCondition.moderatelyUsed:
        return 0.45;
      case EquipmentCondition.heavilyUsed:
        return 0.75;
    }
  }
}

class Blade {
  final String? id;
  final String name;
  final String? brand;
  final EquipmentCondition condition;
  final DateTime purchaseDate;
  final String? notes;

  Blade({
    this.id,
    required this.name,
    this.brand,
    required this.condition,
    required this.purchaseDate,
    this.notes,
  });

  Blade copyWith({
    String? id,
    String? name,
    String? brand,
    EquipmentCondition? condition,
    DateTime? purchaseDate,
    String? notes,
  }) {
    return Blade(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      condition: condition ?? this.condition,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      notes: notes ?? this.notes,
    );
  }
}

enum RubberSide {
  forehand,
  backhand,
}

extension RubberSideExtension on RubberSide {
  String get displayName {
    switch (this) {
      case RubberSide.forehand:
        return 'Форхенд';
      case RubberSide.backhand:
        return 'Бэкхенд';
    }
  }
}

class Rubber {
  final String? id;
  final String name;
  final String? brand;
  final RubberSide side;
  final EquipmentCondition initialCondition;
  final double lifespanHours; // Примерный срок жизни в часах
  final double usedHours; // Сколько часов уже использовано
  final DateTime installDate;
  final String? notes;

  Rubber({
    this.id,
    required this.name,
    this.brand,
    required this.side,
    required this.initialCondition,
    required this.lifespanHours,
    this.usedHours = 0.0,
    required this.installDate,
    this.notes,
  });

  // Процент износа (0-100%)
  double get wearPercentage {
    final initialWear = initialCondition.wearPercentage;
    final currentWear = usedHours / lifespanHours;
    final totalWear = initialWear + currentWear * (1 - initialWear);
    return (totalWear * 100).clamp(0, 100);
  }

  // Оставшийся срок службы в часах
  double get remainingHours {
    final availableLifespan = lifespanHours * (1 - initialCondition.wearPercentage);
    final remaining = availableLifespan - usedHours;
    return remaining.clamp(0, double.infinity);
  }

  // Состояние накладки (новое, хорошее, среднее, плохое, замена)
  String get conditionStatus {
    if (wearPercentage < 20) return 'Отличное';
    if (wearPercentage < 40) return 'Хорошее';
    if (wearPercentage < 60) return 'Среднее';
    if (wearPercentage < 80) return 'Изношенное';
    return 'Требует замены';
  }

  Rubber copyWith({
    String? id,
    String? name,
    String? brand,
    RubberSide? side,
    EquipmentCondition? initialCondition,
    double? lifespanHours,
    double? usedHours,
    DateTime? installDate,
    String? notes,
  }) {
    return Rubber(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      side: side ?? this.side,
      initialCondition: initialCondition ?? this.initialCondition,
      lifespanHours: lifespanHours ?? this.lifespanHours,
      usedHours: usedHours ?? this.usedHours,
      installDate: installDate ?? this.installDate,
      notes: notes ?? this.notes,
    );
  }
}

class PaddleSetup {
  final String? id;
  final String name;
  final Blade blade;
  final Rubber forehandRubber;
  final Rubber backhandRubber;
  final bool isActive; // Текущая используемая ракетка
  final DateTime createdAt;

  PaddleSetup({
    this.id,
    required this.name,
    required this.blade,
    required this.forehandRubber,
    required this.backhandRubber,
    this.isActive = false,
    required this.createdAt,
  });

  // Общий процент износа ракетки (среднее между накладками)
  double get overallWearPercentage {
    return (forehandRubber.wearPercentage + backhandRubber.wearPercentage) / 2;
  }

  // Нужна ли замена хотя бы одной накладки
  bool get needsRubberReplacement {
    return forehandRubber.wearPercentage >= 80 || 
           backhandRubber.wearPercentage >= 80;
  }

  // Ближайшая накладка, которую нужно заменить
  Rubber? get nextRubberToReplace {
    if (forehandRubber.wearPercentage > backhandRubber.wearPercentage) {
      return forehandRubber;
    } else {
      return backhandRubber;
    }
  }

  PaddleSetup copyWith({
    String? id,
    String? name,
    Blade? blade,
    Rubber? forehandRubber,
    Rubber? backhandRubber,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return PaddleSetup(
      id: id ?? this.id,
      name: name ?? this.name,
      blade: blade ?? this.blade,
      forehandRubber: forehandRubber ?? this.forehandRubber,
      backhandRubber: backhandRubber ?? this.backhandRubber,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}


