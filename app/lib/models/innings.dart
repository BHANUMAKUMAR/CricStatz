class Innings {
  final String id;
  final String matchId;
  final int inningsNumber;
  final int runs;
  final int wickets;
  final double overs;

  const Innings({
    required this.id,
    required this.matchId,
    required this.inningsNumber,
    required this.runs,
    required this.wickets,
    required this.overs,
  });
}
