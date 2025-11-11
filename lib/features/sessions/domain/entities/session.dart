enum SessionType {
  practice,
  match,
  gearTest,
}

enum OpponentLevel {
  higher,
  similar,
  lower,
}

class Session {
  final String? id;
  final SessionType type;
  final String location;
  final DateTime startTime;
  final DateTime endTime;
  final Duration duration;
  
  // Practice specific
  final int? technicalRating;
  final int? tacticalRating;
  final int? mentalRating;
  
  // Match specific
  final int? playerScore;
  final String? opponentName;
  final int? opponentScore;
  final OpponentLevel? opponentLevel;
  
  // Gear Test specific
  final String? paddleSetupId;
  final int? sgc; // Short-Game Control
  final int? spn; // Spin Potential
  final int? pwr; // Power
  final int? stb; // Stability
  final int? sns; // Spin Sensitivity
  
  // Common
  final String? notes;

  Session({
    this.id,
    required this.type,
    required this.location,
    required this.startTime,
    required this.endTime,
    required this.duration,
    this.technicalRating,
    this.tacticalRating,
    this.mentalRating,
    this.playerScore,
    this.opponentName,
    this.opponentScore,
    this.opponentLevel,
    this.paddleSetupId,
    this.sgc,
    this.spn,
    this.pwr,
    this.stb,
    this.sns,
    this.notes,
  });

  double? get averageRating {
    if (type == SessionType.practice &&
        technicalRating != null &&
        tacticalRating != null &&
        mentalRating != null) {
      return (technicalRating! + tacticalRating! + mentalRating!) / 3;
    }
    return null;
  }

  double? get gqsScore {
    if (type == SessionType.gearTest &&
        sgc != null &&
        spn != null &&
        pwr != null &&
        stb != null &&
        sns != null) {
      return (sgc! + spn! + pwr! + stb! + sns!) / 5;
    }
    return null;
  }

  bool get isWin {
    if (type == SessionType.match &&
        playerScore != null &&
        opponentScore != null) {
      return playerScore! > opponentScore!;
    }
    return false;
  }

  Session copyWith({
    String? id,
    SessionType? type,
    String? location,
    DateTime? startTime,
    DateTime? endTime,
    Duration? duration,
    int? technicalRating,
    int? tacticalRating,
    int? mentalRating,
    int? playerScore,
    String? opponentName,
    int? opponentScore,
    OpponentLevel? opponentLevel,
    String? paddleSetupId,
    int? sgc,
    int? spn,
    int? pwr,
    int? stb,
    int? sns,
    String? notes,
  }) {
    return Session(
      id: id ?? this.id,
      type: type ?? this.type,
      location: location ?? this.location,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      duration: duration ?? this.duration,
      technicalRating: technicalRating ?? this.technicalRating,
      tacticalRating: tacticalRating ?? this.tacticalRating,
      mentalRating: mentalRating ?? this.mentalRating,
      playerScore: playerScore ?? this.playerScore,
      opponentName: opponentName ?? this.opponentName,
      opponentScore: opponentScore ?? this.opponentScore,
      opponentLevel: opponentLevel ?? this.opponentLevel,
      paddleSetupId: paddleSetupId ?? this.paddleSetupId,
      sgc: sgc ?? this.sgc,
      spn: spn ?? this.spn,
      pwr: pwr ?? this.pwr,
      stb: stb ?? this.stb,
      sns: sns ?? this.sns,
      notes: notes ?? this.notes,
    );
  }
}

