import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:turf_project/models/teams_data.dart';
// import 'package:fl_chart/fl_chart.dart';

import 'package:turf_project/screens/create_team_screen.dart';
import 'package:turf_project/screens/login_screen.dart';
import 'package:turf_project/screens/players_screen.dart';

import 'package:turf_project/constants.dart';

import 'package:provider/provider.dart';
import 'package:turf_project/widgets/players_list.dart';
import "dart:convert";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:turf_project/widgets/players_list.dart';
import 'package:turf_project/widgets/teams_list.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
    // getSearchHistory();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    getTeams();
  }

  late var teamsData;
  bool loadedData = false;
  late String? u_id;
  Future getTeams() async {
    // Map creds = {
    //   'teams': prefs.getStringList('teams'),
    // };
    // print(creds);
    // var body = json.encode(creds);
    // var url = '${serverUrl}/login';
    // print(url);
    print(prefs.getString('u_id'));
    setState(() {
      u_id = prefs.getString("u_id");
    });
    http.Response response = await http.get(
      Uri.parse('$serverUrl/teams/${u_id}'),
      headers: {"Content-Type": "application/json"},
    );
    // print("here 2");

    print(response.statusCode);
    String output = response.body;
    if (response.statusCode == 200) {
      var data = jsonDecode(output);

      print(data);
      if (data['msg'] == 'Success') {
        // for (int i = 0; i < data['data'].length; i++) {
        // print(data['data'][i]);
        // Provider.of<TeamsData>(context, listen: false).addTeam(
        //   Team(data['data'][i]['name'], data['data'][i]['players']),
        // );
        setState(() {
          teamsData = data['data'];
          loadedData = true;
        });
        // }
      }
    } else {
      print(response.statusCode);
    }
  }

  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 70.0,
              // bottom: 20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  radius: 70.0,
                  backgroundColor: Colors.red,
                ),
                Column(
                  children: [
                    Text(
                      "User",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                    ),
                    Text(
                      "User@gmail.com",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: primaryColor,
                      ),
                      onPressed: () {
                        prefs.remove('token');
                        prefs.remove('username');
                        prefs.remove('email');
                        prefs.remove('u_id');

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LoginScreen();
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        child: Text(
                          "Edit Profile",
                          style: TextStyle(
                            color: secondaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: DefaultTabController(
              initialIndex: 0,
              length: 2,
              child: Scaffold(
                // extendBody: true,
                // extendBodyBehindAppBar: true,

                appBar: AppBar(
                  // title: Text("Title"),
                  // automaticallyImplyLeading: true,
                  // titleSpacing: 20.0,
                  // bottom: Null,
                  // flexibleSpace: Padding(
                  //   padding: const EdgeInsets.all(0.0),
                  //   child:
                  backgroundColor: scaffoldColor,
                  toolbarHeight: 0.0,
                  bottom:
                      // Column(
                      // children: [
                      TabBar(
                    // in
                    // indicatorColor: Colors.red,
                    indicatorColor: Colors.transparent,
                    dividerColor: primaryColor,
                    labelColor: secondaryColor,
                    unselectedLabelColor: Colors.grey,
                    labelStyle: TextStyle(
                      fontSize: 16,
                    ),
                    unselectedLabelStyle: TextStyle(
                      fontSize: 16,
                    ),
                    indicator: BoxDecoration(
                      color: primaryColor,
                    ),
                    labelPadding: const EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 0.0,
                    ),
                    // overlayColor: ,
                    tabs: <Widget>[
                      Tab(
                        // text: "STATS",
                        icon: Container(
                          width: double.infinity,
                          child: Text(
                            "STATS",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Tab(
                        // text: "TEAMS",
                        icon: Container(
                          width: double.infinity,
                          child: Text(
                            "TEAMS",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                    // ),
                    // ],
                    // ),
                  ),
                  // bottom: const TabBar(
                  //   // in
                  //   // indicatorColor: Colors.red,
                  //   tabs: <Widget>[
                  //     Tab(
                  //       icon: Text("STATS"),
                  //     ),
                  //     Tab(
                  //       icon: Text("TEAMS"),
                  //     ),
                  //   ],
                  // ),
                ),
                body: TabBarView(
                  children: <Widget>[
                    // TimeSpentChart(),
                    Center(
                      child: Container(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(6.0),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return CreateTeamScreen();
                            }));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Create Team",
                                style: TextStyle(
                                  color: secondaryColor,
                                  fontSize: 20.0,
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Icon(
                                Icons.add,
                                size: 20.0,
                                color: secondaryColor,
                                // weight: 1.2,
                              ),
                            ],
                          ),
                        ),
                        // child: PlayersList(),
                      ),
                    ),
                    Container(
                      // color: Colors.yellow,
                      child: loadedData
                          ? TeamsList(teamsData, u_id!)
                          : Text(
                              "Loading",
                              style: TextStyle(
                                color: textColor,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TeamsList extends StatelessWidget {
  const TeamsList(this.teamsData, this.u_id);

  final teamsData;
  final String u_id;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final team = teamsData[index];
        print(team);
        return TeamContainer(
          teamsData[index]['name'],
          teamsData[index]['short_id'],
          // teamsData[index]['players'],
          teamsData[index]['team_id'],
          u_id,
        );
      },
      itemCount: teamsData.length,
    );
  }
}

class TeamContainer extends StatelessWidget {
  final String name;
  // final List players;
  final String team_id;
  final int short_id;
  final String u_id;

  TeamContainer(this.name, this.short_id, this.team_id, this.u_id);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 8.0,
      ),
      child: Container(
        height: 160.0,
        width: double.infinity,
        color: Colors.red,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(0.0),
              ),
            ),
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return PlayersScreen(
                // players,
                team_id,
                short_id,
                u_id,
                name,
              );
            }));
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    name,
                    softWrap: true,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundColor: Colors.white,
                      child: Text("12"),
                    ),
                    CircleAvatar(
                      radius: 25.0,
                      backgroundColor: Colors.yellow,
                      child: Text("25"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class TimeSpentChart extends StatelessWidget {
//   final List<int> timeSpent = [1, 3, 5, 2, 4, 6, 3];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Time Spent in Turf'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: LineChart(
//           LineChartData(
//             borderData: FlBorderData(
//               show: true,
//               border: Border.all(color: Colors.black, width: 1),
//             ),
//             titlesData: FlTitlesData(
//               leftTitles: SideTitles(showTitles: true),
//               bottomTitles: SideTitles(
//                 showTitles: true,
//                 getTitles: (value) {
//                   switch (value.toInt()) {
//                     case 0:
//                       return 'Mon';
//                     case 1:
//                       return 'Tue';
//                     case 2:
//                       return 'Wed';
//                     case 3:
//                       return 'Thu';
//                     case 4:
//                       return 'Fri';
//                     case 5:
//                       return 'Sat';
//                     case 6:
//                       return 'Sun';
//                     default:
//                       return '';
//                   }
//                 },
//               ),
//             ),
//             gridData: FlGridData(show: true),
//             lineBarsData: [
//               LineChartBarData(
//                 spots: List.generate(
//                     timeSpent.length,
//                     (index) =>
//                         FlSpot(index.toDouble(), timeSpent[index].toDouble())),
//                 isCurved: true,
//                 barWidth: 2,
//                 colors: [Colors.blue],
//                 belowBarData: BarAreaData(
//                     show: true, colors: [Colors.blue.withOpacity(0.3)]),
//                 dotData: FlDotData(show: false),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//  Container(
//                       // color: Colors.yellow,
//                       child: ListView(
//                         scrollDirection: Axis.vertical,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(
//                               bottom: 5.0,
//                               top: 20.0,
//                               left: 15.0,
//                               right: 15.0,
//                             ),
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: primaryColor,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.all(
//                                     Radius.circular(6.0),
//                                   ),
//                                 ),
//                               ),
//                               onPressed: () {
//                                 Navigator.push(context,
//                                     MaterialPageRoute(builder: (context) {
//                                   return CreateTeamScreen();
//                                 }));
//                               },
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     "Create Team",
//                                     style: TextStyle(
//                                       color: secondaryColor,
//                                       fontSize: 20.0,
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 10.0,
//                                   ),
//                                   Icon(
//                                     Icons.add,
//                                     size: 20.0,
//                                     color: secondaryColor,
//                                     // weight: 1.2,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           // Teams List
//                           TeamsList(),
//                           // TeamContainer(),
//                           // TeamContainer(),
//                           // TeamContainer(),
//                         ],
//                       ),
//                     ),




// class ProfileScreen extends StatelessWidget {
//   // const ProfileScreen({super.key});

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     initSharedPref();
//     // getSearchHistory();
//   }

//   void initSharedPref() async {
//     prefs = await SharedPreferences.getInstance();
//     var bus;
//   }

//   late SharedPreferences prefs;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(
//               top: 70.0,
//               // bottom: 20.0,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 CircleAvatar(
//                   radius: 70.0,
//                   backgroundColor: Colors.red,
//                 ),
//                 Column(
//                   children: [
//                     Text(
//                       "User",
//                       style: TextStyle(
//                         fontSize: 25.0,
//                         fontWeight: FontWeight.w700,
//                         color: textColor,
//                       ),
//                     ),
//                     Text(
//                       "User@gmail.com",
//                       style: TextStyle(
//                         fontSize: 15.0,
//                         fontWeight: FontWeight.w500,
//                         color: textColor,
//                       ),
//                     ),
//                     TextButton(
//                       style: TextButton.styleFrom(
//                         backgroundColor: primaryColor,
//                       ),
//                       onPressed: () {
//                         prefs.remove('token');
//                         prefs.remove('username');
//                         prefs.remove('email');
//                         prefs.remove('u_id');
//                         prefs.remove('last_searched');
//                         prefs.remove('avatarId');

//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) {
//                           return LoginScreen();
//                         }));
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 10.0,
//                         ),
//                         child: Text(
//                           "Edit Profile",
//                           style: TextStyle(
//                             color: secondaryColor,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: DefaultTabController(
//               initialIndex: 0,
//               length: 2,
//               child: Scaffold(
//                 // extendBody: true,
//                 // extendBodyBehindAppBar: true,

//                 appBar: AppBar(
//                   // title: Text("Title"),
//                   // automaticallyImplyLeading: true,
//                   // titleSpacing: 20.0,
//                   // bottom: Null,
//                   // flexibleSpace: Padding(
//                   //   padding: const EdgeInsets.all(0.0),
//                   //   child:
//                   backgroundColor: scaffoldColor,
//                   toolbarHeight: 0.0,
//                   bottom:
//                       // Column(
//                       // children: [
//                       TabBar(
//                     // in
//                     // indicatorColor: Colors.red,
//                     indicatorColor: Colors.transparent,
//                     dividerColor: primaryColor,
//                     labelColor: secondaryColor,
//                     unselectedLabelColor: Colors.grey,
//                     labelStyle: TextStyle(
//                       fontSize: 16,
//                     ),
//                     unselectedLabelStyle: TextStyle(
//                       fontSize: 16,
//                     ),
//                     indicator: BoxDecoration(
//                       color: primaryColor,
//                     ),
//                     labelPadding: const EdgeInsets.symmetric(
//                       horizontal: 0,
//                       vertical: 0.0,
//                     ),
//                     // overlayColor: ,
//                     tabs: <Widget>[
//                       Tab(
//                         // text: "STATS",
//                         icon: Container(
//                           width: double.infinity,
//                           child: Text(
//                             "STATS",
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                       Tab(
//                         // text: "TEAMS",
//                         icon: Container(
//                           width: double.infinity,
//                           child: Text(
//                             "TEAMS",
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                     ],
//                     // ),
//                     // ],
//                     // ),
//                   ),
//                   // bottom: const TabBar(
//                   //   // in
//                   //   // indicatorColor: Colors.red,
//                   //   tabs: <Widget>[
//                   //     Tab(
//                   //       icon: Text("STATS"),
//                   //     ),
//                   //     Tab(
//                   //       icon: Text("TEAMS"),
//                   //     ),
//                   //   ],
//                   // ),
//                 ),
//                 body: TabBarView(
//                   children: <Widget>[
//                     Center(
//                       child: Container(
//                         child: Text("Graphs and Stats"),
//                         // child: PlayersList(),
//                       ),
//                     ),
//                     Container(
//                       // color: Colors.yellow,
//                       child: ListView(
//                         scrollDirection: Axis.vertical,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(
//                               bottom: 5.0,
//                               top: 20.0,
//                               left: 15.0,
//                               right: 15.0,
//                             ),
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: primaryColor,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.all(
//                                     Radius.circular(6.0),
//                                   ),
//                                 ),
//                               ),
//                               onPressed: () {
//                                 Navigator.push(context,
//                                     MaterialPageRoute(builder: (context) {
//                                   return CreateTeamScreen();
//                                 }));
//                               },
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text(
//                                     "Create Team",
//                                     style: TextStyle(
//                                       color: secondaryColor,
//                                       fontSize: 20.0,
//                                     ),
//                                   ),
//                                   SizedBox(
//                                     width: 10.0,
//                                   ),
//                                   Icon(
//                                     Icons.add,
//                                     size: 20.0,
//                                     color: secondaryColor,
//                                     // weight: 1.2,
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           // Teams List

//                           TeamContainer(),
//                           TeamContainer(),
//                           TeamContainer(),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
