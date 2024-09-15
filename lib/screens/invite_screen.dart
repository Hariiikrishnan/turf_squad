import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:share/share.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:turf_project/constants.dart';

class InvitePlayersScreen extends StatelessWidget {
  // const InvitePlayersScreen({super.key});
  InvitePlayersScreen(this.team_id, this.short_id);
  final String team_id;
  final int short_id;

  Future getDirection() async {
    http.Response response = await http.post(
        Uri.parse('https://api.tinyurl.com/create'),
        body: json.encode({
          "url": "myapp://home/${short_id}",
          "domain": "tinyurl.com",
          "alias": short_id
        }),
        headers: {
          "Authorization":
              "Bearer 0tdbloSH5VXCxxZSrSnbU87cej5ovRn9zjGgcd6621VJFKaC6rruIWmqO23Q",
          'Content-Type': 'application/json',
        });

    String data = response.body;
    print(data);
    var output = jsonDecode(data);
    // print(output);

    if (response.statusCode == 200) {
      return output;
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: secondaryColor,
        backgroundColor: primaryColor,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: primaryColor,
                radius: 100.0,
                child: Icon(
                  Icons.check,
                  size: 115.0,
                  color: secondaryColor,
                ),
              ),
              SizedBox(
                height: 70.0,
              ),
              Text(
                "Team Created Successfully!",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
              SizedBox(
                height: 70.0,
              ),
              TextButton(
                  onPressed: () async {
                    var linkOutput = await getDirection();
                    print(linkOutput['data']['tiny_url']);
                    Share.share(
                        'Join our awesome Turf Squad mate !' +
                            linkOutput['data']['tiny_url'],
                        subject: 'Look what I made!');
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: primaryColor,
                    fixedSize: Size.fromWidth(
                      200.0,
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
                    "Invite Friends",
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
