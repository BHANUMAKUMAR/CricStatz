class Scoreboard {
  final int runs;
  final int wickets;
  final double overs;

  const Scoreboard({
    required this.runs,
    required this.wickets,
    required this.overs,
  });

  String get display => '$runs/$wickets ($overs ov)';
}
