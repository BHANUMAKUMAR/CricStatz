class Match {
  final String id;
  final String teamAId;
  final String teamBId;
  final int oversLimit;
  final String status;

  const Match({
    required this.id,
    required this.teamAId,
    required this.teamBId,
    required this.oversLimit,
    required this.status,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'team_a_id': teamAId,
        'team_b_id': teamBId,
        'overs_limit': oversLimit,
        'status': status,
      };

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['id'] as String,
      teamAId: json['team_a_id'] as String,
      teamBId: json['team_b_id'] as String,
      oversLimit: json['overs_limit'] as int,
      status: json['status'] as String,
    );
  }
}
