import 'package:flutter/material.dart';
import 'package:turf_project/constants.dart';
import 'package:turf_project/models/players_data.dart';
import 'package:provider/provider.dart';
import 'package:turf_project/widgets/players_list.dart';
import 'package:turf_project/widgets/teams_list.dart';
import "dart:convert";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SelectPlayers extends StatefulWidget {
  // const SelectPlayers({super.key});

  SelectPlayers(this.time, this.date, this.turfName);
  final String time;
  final String date;
  final String turfName;

  @override
  State<SelectPlayers> createState() => _SelectPlayersState();
}

class _SelectPlayersState extends State<SelectPlayers> {
  // bool firstValue = 0;
  // bool secValue = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
    // getSearchHistory();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    // getTeams();
    getTeamPlayers();
  }

  late SharedPreferences prefs;

  late var playersData;
  late var teamWithPlayers;
  var selectedPlayers = [];
  bool loadedData = false;
  late String? u_id;
  late List<String>? teams_id;
  Future getTeamPlayers() async {
    setState(() {
      u_id = prefs.getString("u_id");
      teams_id = prefs.getStringList('teams');
    });

    Map creds = {
      'teams': teams_id,
    };
    // print(creds);
    var body = json.encode(creds);

    // print(prefs.getString('u_id'));
    // print(prefs.getStringList('teams'));

    http.Response response = await http.post(
      Uri.parse('$serverUrl/allTeamPlayers/${u_id}'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    // print(response.statusCode);
    String output = response.body;
    if (response.statusCode == 200) {
      var data = jsonDecode(output);

      // print(data);
      if (data['msg'] == 'Success') {
        setState(() {
          playersData = data['data'];
        });
        chkboxState = List<bool>.filled(playersData.length, false);
        for (int i = 0; i < data['data'].length; i++) {
          var newMap = {
            'team_name': data['data'][i]['name'],
            'players': data['data'][i]['players'],
          };

          setState(() {
            // teams.length = data['data'].length;
            // teams[i]['team_name'] = data['data'][i]['name'];
            // teams = List<Map>.filled(i, newMap, growable: true);
            teams.add(newMap);
            // loadedData = true;
          });
          // print(newMap);
        }

        print(teams);
        List names = [];
        List teamAndPlay = [];

        // for (final (index, t) in teams.indexed) {
        //   t['players'].forEach((player) {
        //     // print(player['name']);

        //     print(player.containsValue('hk'));
        //   });

        // print(names);

        // Map to store players and the teams they joined
        Map<String, Map<String, dynamic>> playersMap = {};

        // Populate the map
        for (var team in teams) {
          String teamName = team['team_name'];
          List<dynamic> players = team['players'];

          for (var player in players) {
            print(player);
            String playerName = player['name'];
            String playerId = player['id'];
            String playerOnesignal_id = player['onesignal_id'];

            if (playersMap.containsKey(playerName)) {
              playersMap[playerName]?['teams_joined'].add(teamName);
            } else {
              playersMap[playerName] = {
                'name': playerName,
                'id': playerId,
                'onesignal_id': playerOnesignal_id,
                'teams_joined': [teamName],
              };
            }
          }
        }

        // Convert map to list
        List<Map<String, dynamic>> playersList = playersMap.values.toList();
        print(playersList);
        setState(() {
          teamWithPlayers = playersList;
          loadedData = true;
        });
        chkboxState = List<bool>.filled(2, false);
        // teams.forEach((t) {

        // });
        // }
      }
    } else {
      print(response.statusCode);
    }
  }

  List<bool> chkboxState = [];

  // List<Widget> playersList() {
  //   List<Widget> list = [];
  //   for (int i = 0; i < Provider.of<PlayersData>(context).taskCount; i++) {
  //     list.add(
  //       CheckBoxTile(
  //         Provider.of<PlayersData>(context).players[i].name,
  //         Provider.of<PlayersData>(context).players[i].onesignal_id,
  //         (value) {
  //           Provider.of<PlayersData>(context, listen: false).checkboxCallback(
  //               Provider.of<PlayersData>(context, listen: false).players[i]);
  //         },
  //         Provider.of<PlayersData>(context).players[i].state,
  //       ),
  //     );
  //   }
  //   return list;
  // }

  List<Widget> playersListIn(teamPlayers) {
    List<Widget> list = [];
    for (int i = 0; i < teamPlayers['players'].length; i++) {
      list.add(CheckBoxTile(teamPlayers['teams_joined'][i], (value) {
        setState(() {
          chkboxState[i] = value;
        });
      }, chkboxState[i]));
    }
    return list;
  }

  var teams = [];

  Future handleNext() async {
    Map creds = {
      'players': selectedPlayers,
    };
    var body = json.encode(creds);
    var url = '${serverUrl}/booking/${widget.turfName}/${u_id}';
    print(url);
    http.Response response = await http.post(
        Uri.parse('${serverUrl}/booking/${widget.turfName}/${u_id}'),
        headers: {"Content-Type": "application/json"},
        body: body);

    print(response.statusCode);
    String data = response.body;

    if (response.statusCode == 200) {
      var output = jsonDecode(data);
      if (output?['msg'] == "Success") {
        setState(() {});
      } else {
        print("Something went wrong!!");
      }
    } else if (response.statusCode == 401) {
      print("Something Wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.time),
        backgroundColor: primaryColor,
      ),
      body: Container(
        // color: Colors.white,
        // height: 400.0,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "Select your friends whom you gonna play with " +
                    widget.date +
                    " at " +
                    widget.time,
                style: TextStyle(
                  color: textColor,
                  fontSize: 18.0,
                ),
              ),
            ),
            loadedData
                ? ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    // itemCount: 1,
                    itemCount: teamWithPlayers.length,
                    itemBuilder: (context, i) {
                      return ExpansionContainer(
                        teamWithPlayers[i]['name'],
                        teamWithPlayers[i]['onesignal_id'],
                        (value, player) {
                          setState(() {
                            chkboxState[i] = value;
                          });
                          if (value == true) {
                            print(player.playerOnesignal_id);
                            selectedPlayers.add(player.playerOnesignal_id);
                          } else {
                            selectedPlayers.remove(player.playerOnesignal_id);
                          }
                          print(selectedPlayers);
                        },
                        chkboxState[i],
                        teamWithPlayers[i]['teams_joined'],
                        teamWithPlayers[i]['id'],
                        u_id!,
                      );
                    },
                  )
                : Text(
                    "Loading....",
                    style: TextStyle(
                      color: textColor,
                    ),
                  ),
            Spacer(),
            TextButton(
              onPressed: () {
                handleNext();
              },
              style: TextButton.styleFrom(
                fixedSize: Size(double.infinity, 60.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(0.0),
                  ),
                ),
                backgroundColor: primaryColor,
              ),
              child: Text(
                "Next",
                style: TextStyle(
                  fontSize: 22.0,
                  color: secondaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

class ExpansionContainer extends StatelessWidget {
  ExpansionContainer(
      this.playerName,
      // this.addPlayer,
      this.playerOnesignal_id,
      this.callBack,
      this.chkboxState,
      this.teams,
      this.playerId,
      this.activeId);

  final String playerName;
  final String playerId;
  final String playerOnesignal_id;
  final String activeId;
  bool chkboxState;
  var callBack;
  // var addPlayer;

  final List teams;

  List<Text> teamsList() {
    List<Text> list = [];
    for (int i = 0; i < teams.length; i++) {
      list.add(
        Text(
          "• " + teams[i].toString().capitalize(),
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 10.0,
        left: 20.0,
        right: 20.0,
      ),
      decoration: BoxDecoration(
        color: primaryActive,
        borderRadius: BorderRadius.circular(
          6.0,
        ),
      ),
      child: Column(
        children: [
          CheckBoxTile(
              playerId == activeId ? playerName + " (You)" : playerName,
              (value) {
            callBack(value, this);
          }, playerId == activeId ? true : chkboxState),
          ExpansionTile(
            backgroundColor: primaryColor,
            collapsedTextColor: textColor,
            collapsedIconColor: textColor,

            // collapsedBackgroundColor: primaryColor,
            tilePadding: EdgeInsets.symmetric(
              horizontal: 60.0,
              // vertical: -10.0,
            ),

            title: Text(
              playerId == activeId
                  ? "Teams you joined"
                  : "Teams you both joined",
              // vehicles[i].title,

              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: teamsList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CheckBoxTile extends StatelessWidget {
  CheckBoxTile(this.name, this.callback, this.state);

  final String name;
  bool state;
  final callback;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      selectedTileColor: textColor,
      activeColor: Colors.deepPurpleAccent,
      checkColor: textColor,
      side: BorderSide(
        width: 2.0,
        color: textColor,
      ),
      title: Text(
        name.capitalize(),
        style: TextStyle(
          color: textColor,
        ),
      ),
      // value: isChecked,
      value: state,
      onChanged: callback,
    );
  }
}
