import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turf_project/constants.dart';

import "dart:convert";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AcceptInviteScreen extends StatefulWidget {
  // const AcceptInviteScreen({super.key});
  AcceptInviteScreen(this.uri);
  final String uri;

  @override
  State<AcceptInviteScreen> createState() => _AcceptInviteScreenState();
}

Future<dynamic> alertDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(
                12.0,
              ),
            ),
          ),
          title: Text(
            'Done',
            style: TextStyle(
              color: secondaryColor,
            ),
          ),
          content: Text(
            'Add Success',
            style: TextStyle(
              color: secondaryColor,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      12.0,
                    ),
                  ),
                ),
              ),
              child: Text('Ok'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}

class _AcceptInviteScreenState extends State<AcceptInviteScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
    // getSearchHistory();
    // print(widget.uri.split("home/")[1]);
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    var bus;
  }

  Future handleAccept() async {
    // Map creds = {
    //   'team_name': teamName,
    // };
    // var body = json.encode(creds);
    // var url = '${serverUrl}/login';
    // print(url);
    print(prefs.getString('u_id'));
    http.Response response = await http.post(
      Uri.parse(
          '$serverUrl/addPlayer/${widget.uri.split("home/")[1]}/${prefs.getString('u_id')}'),
      headers: {"Content-Type": "application/json"},
    );
    // print("here 2");

    String data = response.body;

    if (response.statusCode == 200) {
      var output = jsonDecode(data);
      print(output);
      print(output['msg']);
      if (output?['msg'] == 'Success') {
        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   return InvitePlayersScreen();
        // }));
      } else {
        print("Something went wrong!!");
      }
    } else {
      print(response.statusCode);
    }
  }

  late SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // color: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 25.0,
            left: 25.0,
            right: 25.0,
            bottom: 15.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Mr. Hinata Sends you a invite to join Karasuno Team Squad .",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(6.0),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      //   content: Text("Sending Message"),
                      // ));
                      handleAccept();
                      await alertDialog(
                        context,
                      );
                    },
                    child: Text(
                      "Accept",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(6.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Decline",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
