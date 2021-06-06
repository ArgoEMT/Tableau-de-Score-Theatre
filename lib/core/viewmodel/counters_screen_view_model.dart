import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:timer_count_down/timer_controller.dart';

class CountersSreenViewModel with ChangeNotifier {
  var scoreTeamOne = 0;
  var scoreTeamTwo = 0;

  var fautesTeamOne = 0;
  var fautesTeamTwo = 0;

  var temps = 120;

  int formMinutes = 2;
  int formSeconds = 0;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  StreamController<int> _tempsController = StreamController<int>();
  final CountdownController controller = CountdownController();

  Stream<int> get tempsStream {
    return _tempsController.stream;
  }

  void saveTimer() {
    formKey.currentState?.save();
    temps = formMinutes * 60 + formSeconds;
    _tempsController.add(temps);
    notifyListeners();
  }

  int getTeamFautes({required int team}) {
    return team == 1 ? fautesTeamOne : fautesTeamTwo;
  }

  void incrementTeamFautes({required int team}) {
    switch (team) {
      case 1:
        if (fautesTeamOne < 2) {
          fautesTeamOne += 1;
        } else {
          fautesTeamOne = 0;
          incrementOtherTeamScore(team: team);
        }
        notifyListeners();
        return;
      case 2:
        if (fautesTeamTwo < 2) {
          fautesTeamTwo += 1;
        } else {
          fautesTeamTwo = 0;
          incrementOtherTeamScore(team: team);
        }
        notifyListeners();
        return;
      default:
    }
  }

  int getScoreByTeam({required int team}) {
    return team == 1 ? scoreTeamOne : scoreTeamTwo;
  }

  void incrementTeamScore({required int team}) {
    team == 1 ? scoreTeamOne += 1 : scoreTeamTwo += 1;
  }

  void decrementTeamScore({required int team}) {
    switch (team) {
      case 1:
        if (scoreTeamOne != 0) {
          scoreTeamOne -= 1;
        }
        return;
      case 2:
        if (scoreTeamTwo != 0) {
          scoreTeamTwo -= 1;
        }
        return;

      default:
    }
  }

  void incrementOtherTeamScore({required int team}) {
    team == 2 ? scoreTeamOne += 1 : scoreTeamTwo += 1;
    notifyListeners();
  }

  bool isAbleToDecrement({required int team}) {
    return team == 1 ? scoreTeamOne != 0 : scoreTeamTwo != 0;
  }
}
