import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:turf_project/models/player.dart';

class PlayersData extends ChangeNotifier {
  List<Player> _players = [
    Player("Hinata", false),
    Player("Shouyou", false),
    Player("Kageyama", false),
    // Task(name: "Buy Milk", isDone: false),
  ];

  UnmodifiableListView<Player> get players {
    return UnmodifiableListView(_players);
  }

  int get taskCount {
    return _players.length;
  }

  void addPlayers(name) {
    final task = Player(name, false);
    _players.add(task);
    // Provider.of<TaskData>(context).tasks.add(task);
    notifyListeners();
  }

  void checkboxCallback(Player player) {
    player.toggleCheck();
    notifyListeners();
  }

  void deleteTask(Player task) {
    _players.remove(task);
    notifyListeners();
  }
}
