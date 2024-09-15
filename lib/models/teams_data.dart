import 'package:flutter/material.dart';
import 'dart:collection';

// import 'package:flutter/material.dart';

// import 'package:todoey/models/task.dart';
class TeamsData extends ChangeNotifier {
  List<Team> _teams = [
    Team("Endra", ['hari', 'uzumaki']),
    // Team("Buy Bread", isDone: false),
    // Team("Buy Jam", isDone: false),
  ];

  UnmodifiableListView<Team> get teams {
    return UnmodifiableListView(_teams);
  }

  int get taskCount {
    return _teams.length;
  }

  void addTeam(team) {
    // final team = Team(teamName, players);
    _teams.add(team);
    // Provider.of<TaskData>(context).tasks.add(task);
    notifyListeners();
  }

  // void checkboxCallback(Team task) {
  //   task.toggleDone();
  //   notifyListeners();
  // }

  // void deleteTask(Team task) {
  //   _tasks.remove(task);
  //   notifyListeners();
  // }
}

class Team {
  final String name;
  final List players;

  Team(this.name, this.players);
}
