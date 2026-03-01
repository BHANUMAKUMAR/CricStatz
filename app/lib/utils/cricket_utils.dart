class CricketUtils {
  static double strikeRate({required int runs, required int balls}) {
    if (balls == 0) return 0;
    return (runs / balls) * 100;
  }

  static double economy({required int runsConceded, required double overs}) {
    if (overs == 0) return 0;
    return runsConceded / overs;
  }

  const CricketUtils._();
}
