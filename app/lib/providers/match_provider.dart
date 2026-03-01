import 'package:cricstatz/models/match.dart';
import 'package:flutter/foundation.dart';

class MatchProvider extends ChangeNotifier {
  final List<Match> _matches = [];

  List<Match> get matches => List.unmodifiable(_matches);

  void addMatch(Match match) {
    _matches.add(match);
    notifyListeners();
  }
}
