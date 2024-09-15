import 'package:flutter/material.dart';
import 'package:turf_project/constants.dart';
import 'package:turf_project/models/players_data.dart';
import 'package:provider/provider.dart';
import 'package:turf_project/models/teams_data.dart';
import 'package:turf_project/screens/players_screen.dart';

// class TeamsList {}

// class TeamsList extends StatelessWidget {
//   // const TeamsList({super.key});

//   // List<Widget> teamsList(context) {
//   //   List<Widget> list = [];
//   //   for (int i = 0; i < Provider.of<TeamsData>(context).taskCount; i++) {
//   //     list.add(
//   //       TeamContainer(
//   //         Provider.of<TeamsData>(context).teams[i].name,
//   //         // (value) {
//   //         //   Provider.of<TeamsData>(context, listen: false).checkboxCallback(
//   //         //       Provider.of<TeamsData>(context, listen: false).players[i]);
//   //         // },
//   //         // Provider.of<PlayersData>(context).players[i].state,
//   //       ),
//   //     );
//   //   }
//   //   return list;
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//           itemBuilder: (context, index) {
//             final team = teamsData.teams[index];
//             return TeamContainer(team.name, team.players);
//           },
//           itemCount: teamsData.taskCount,
//         );
//       };
// }

// class TeamContainer extends StatelessWidget {
//   final String name;
//   final List players;
//   TeamContainer(this.name, this.players);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 15.0,
//         vertical: 8.0,
//       ),
//       child: Container(
//         height: 160.0,
//         width: double.infinity,
//         color: Colors.red,
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.transparent,
//             shadowColor: Colors.transparent,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(
//                 Radius.circular(0.0),
//               ),
//             ),
//           ),
//           onPressed: () {
//             Navigator.push(context, MaterialPageRoute(builder: (context) {
//               return PlayersScreen(players);
//             }));
//           },
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     name,
//                     softWrap: true,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 25.0,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     CircleAvatar(
//                       radius: 25.0,
//                       backgroundColor: Colors.white,
//                       child: Text("12"),
//                     ),
//                     CircleAvatar(
//                       radius: 25.0,
//                       backgroundColor: Colors.yellow,
//                       child: Text("25"),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
