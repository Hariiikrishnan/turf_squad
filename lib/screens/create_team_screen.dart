import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:share/share.dart';
import 'package:turf_project/constants.dart';

import 'package:uni_links/uni_links.dart';
import 'package:flutter/services.dart' show PlatformException;

import 'package:turf_project/screens/invite_screen.dart';
import "dart:convert";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CreateTeamScreen extends StatefulWidget {
  const CreateTeamScreen({super.key});

  @override
  State<CreateTeamScreen> createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
    // getSearchHistory();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future handleCreateTeam(teamName) async {
    Map creds = {
      'team_name': teamName,
    };
    var body = json.encode(creds);
    // var url = '${serverUrl}/login';
    // print(url);
    print(prefs.getString('u_id'));
    http.Response response = await http.post(
        Uri.parse('$serverUrl/addteam/${prefs.getString('u_id')}'),
        headers: {"Content-Type": "application/json"},
        body: body);
    // print("here 2");

    String data = response.body;

    if (response.statusCode == 200) {
      var output = jsonDecode(data);
      print(output);
      print(output['msg']);
      if (output?['msg'] == 'Success') {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return InvitePlayersScreen(
              output['team']['team_id'], output['team']['short_id']);
        }));
        // setState(() {
        //   isLoading = false;
        //   loggedIn = true;
        // });
      } else {
        print("Something went wrong!!");
      }
    } else {
      print(response.statusCode);
    }
  }

  late SharedPreferences prefs;

  late var teamName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("Create Team"),
        backgroundColor: primaryColor,
        foregroundColor: secondaryColor,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 45.0,
            horizontal: 25.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text(
              //   "Enter Team Name",
              //    textAlign: TextAlign.left,
              // ),

              TextField(
                onChanged: (value) {
                  setState(() {
                    teamName = value;
                  });
                },
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  hintStyle: TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                  ),
                  filled: true,
                  // labelText: "Hello",
                  hintText: 'Enter Team Name',
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextButton(
                  onPressed: () {
                    print(teamName);
                    // Share.share('check out my website https://example.com',
                    //     subject: 'Look what I made!');
                    handleCreateTeam(teamName);

                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) {
                    //   return InvitePlayersScreen();
                    // }));
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: primaryColor,
                    fixedSize: Size.fromWidth(
                      100.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          12.0,
                        ),
                      ),
                    ),
                  ),
                  child: Text(
                    "Create",
                    style: TextStyle(
                      color: secondaryColor,
                      fontSize: 18.0,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
