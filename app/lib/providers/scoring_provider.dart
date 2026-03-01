import 'package:cricstatz/models/scoreboard.dart';
import 'package:flutter/foundation.dart';

class ScoringProvider extends ChangeNotifier {
  Scoreboard _scoreboard = const Scoreboard(runs: 0, wickets: 0, overs: 0.0);

  Scoreboard get scoreboard => _scoreboard;

  void addDelivery({required int runs, bool wicket = false}) {
    final int updatedRuns = _scoreboard.runs + runs;
    final int updatedWickets = _scoreboard.wickets + (wicket ? 1 : 0);
    final double updatedOvers = _scoreboard.overs + 0.1;

    _scoreboard = Scoreboard(
      runs: updatedRuns,
      wickets: updatedWickets,
      overs: double.parse(updatedOvers.toStringAsFixed(1)),
    );
    notifyListeners();
  }

  void reset() {
    _scoreboard = const Scoreboard(runs: 0, wickets: 0, overs: 0.0);
    notifyListeners();
  }
}
