class Player {
  final String id;
  final String teamId;
  final String name;
  final String role;

  const Player({
    required this.id,
    required this.teamId,
    required this.name,
    required this.role,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'team_id': teamId,
        'name': name,
        'role': role,
      };

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['id'] as String,
      teamId: json['team_id'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
    );
  }
}
