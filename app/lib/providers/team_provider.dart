import 'package:cricstatz/models/team.dart';
import 'package:flutter/foundation.dart';

class TeamProvider extends ChangeNotifier {
  final List<Team> _teams = [];

  List<Team> get teams => List.unmodifiable(_teams);

  void addTeam(Team team) {
    _teams.add(team);
    notifyListeners();
  }
}
