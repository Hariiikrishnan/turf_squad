// import 'package:flutter/material.dart';
// import 'package:turf_project/constants.dart';
// import 'package:turf_project/models/players_data.dart';
// import 'package:provider/provider.dart';

// class PlayersList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<PlayersData>(
//       builder: (context, playerData, child) {
//         return ListView.builder(
//           itemBuilder: (context, index) {
//             final task = playerData.players[index];
//             return PlayersTile(
//                 isChecked: task.state,
//                 taskTitle: task.name,
//                 checkboxCallback: (newValue) {
//                   playerData.checkboxCallback(task);
//                 },
//                 deleteCallback: () {
//                   playerData.deleteTask(task);
//                 });
//           },
//           itemCount: playerData.taskCount,
//         );
//       },
//     );
//   }
// }
