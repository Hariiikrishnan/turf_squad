import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turf_project/constants.dart';
import "dart:convert";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:turf_project/screens/invite_screen.dart';
import 'package:turf_project/widgets/players_list.dart';
import 'package:turf_project/widgets/teams_list.dart';

class PlayersScreen extends StatefulWidget {
  // const PlayersScreen({super.key});

  // final List players;
  final String team_id;
  final int short_id;
  final String u_id;
  final String name;
  PlayersScreen(this.team_id, this.short_id, this.u_id, this.name);

  @override
  State<PlayersScreen> createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // initSharedPref();
    getPlayers();
    // getSearchHistory();
  }

  // void initSharedPref() async {
  //   // prefs = await SharedPreferences.getInstance();
  //   getPlayers();
  // }

  late var playersData;
  bool loadedData = false;

  Future getPlayers() async {
    // Map creds = {
    // 'team_id': widget.team_id,
    // };
    // print(creds);
    // var body = json.encode(creds);
    // var url = '${serverUrl}/login';
    // print(url);
    // print(prefs.getString('u_id'));
    // u_id = prefs.getString("u_id");
    http.Response response = await http.get(
      Uri.parse('$serverUrl/teamPlayers/${widget.team_id}/${widget.u_id}'),
      headers: {"Content-Type": "application/json"},
    );
    // print("here 2");

    print(response.statusCode);
    String output = response.body;
    if (response.statusCode == 200) {
      var data = jsonDecode(output);

      print(data);
      if (data['msg'] == 'Success') {
        for (int i = 0; i < data['data'].length; i++) {
          print(data['data'][i]);
          // Provider.of<TeamsData>(context, listen: false).addTeam(
          //   Team(data['data'][i]['name'], data['data'][i]['players']),
          // );
          setState(() {
            playersData = data['data'];
            loadedData = true;
          });
        }
      }
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: secondaryColor,
        title: Text(
          'Players',
          style: TextStyle(
            color: secondaryColor,
          ),
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Team " + widget.name,
                    style: TextStyle(
                      fontSize: 27.0,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Players : " +
                            (loadedData
                                ? playersData.length.toString()
                                : "..."),
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: textColor,
                        ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            // shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return InvitePlayersScreen(
                                widget.team_id,
                                widget.short_id,
                              );
                            }));
                          },
                          child: Text(
                            "Invite",
                            style: TextStyle(
                              color: scaffoldColor,
                              fontSize: 17.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                color: primaryColor,
                child: loadedData
                    ? PlayersList(playersData)
                    : Center(
                        child: Text(
                          "Loading",
                          style: TextStyle(
                            color: scaffoldColor,
                            fontSize: 25.0,
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class PlayersScreen extends StatelessWidget {
//   // const PlayersScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: primaryColor,
//         foregroundColor: secondaryColor,
//         title: Text(
//           "Karasuno",
//           style: TextStyle(
//             color: secondaryColor,
//           ),
//         ),
//       ),
//       body: Container(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Team KARASUNO",
//                     style: TextStyle(
//                       fontSize: 27.0,
//                       fontWeight: FontWeight.bold,
//                       color: textColor,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   Text(
//                     "Total Players : 12",
//                     style: TextStyle(
//                       fontSize: 20.0,
//                       fontWeight: FontWeight.w500,
//                       color: textColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 color: primaryColor,
//                 child: PlayersList(playersData),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//  ListView(
//                   children: [
//                     PlayerTile(players[0], '12'),
//                     // PlayerTile("Hinata Shoyou", "12"),
//                     // PlayerTile("Hinata Shoyou", "12"),
//                     // PlayerTile("Hinata Shoyou", "12"),
//                     // PlayerTile("Hinata Shoyou", "12"),
//                     // PlayerTile("Hinata Shoyou", "12"),
//                     // PlayerTile("Hinata Shoyou", "12"),
//                     // PlayerTile("Hinata Shoyou", "12"),
//                     // PlayerTile("Hinata Shoyou", "12"),
//                     // PlayerTile("Hinata Shoyou", "12"),
//                     // PlayerTile("Hinata Shoyou", "12"),
//                     // PlayerTile("Hinata Shoyou", "12"),
//                     // PlayerTile("Hinata Shoyou", "12"),
//                     // PlayerTile("Hinata Shoyou", "12"),
//                     // PlayerTile("Hinata Shoyou", "12"),
//                   ],
//                 ),
class PlayersList extends StatelessWidget {
  const PlayersList(this.playersData);

  final playersData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final player = playersData[index];
        print(player);
        return PlayerTile(player['username'], player['timeSpent'].toString());
      },
      itemCount: playersData.length,
    );
  }
}

class PlayerTile extends StatelessWidget {
  PlayerTile(
    this.name,
    this.hours,
  );
  String name;
  String hours;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 4.0,
      ),
      child: Container(
        color: Colors.white,
        // decoration: BoxDecoration(
        //   border: Border(
        //     top: BorderSide(
        //       color: Colors.black,
        //       width: 2.0,
        //     ),
        //     bottom: BorderSide(
        //       color: Colors.black,
        //       width: 2.0,
        //     ),
        //   ),
        // ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  name,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              Text(
                hours,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
