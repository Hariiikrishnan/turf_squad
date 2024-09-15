import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:turf_project/constants.dart';
import 'package:turf_project/screens/app.dart';

import 'package:turf_project/screens/register_screen.dart';
import 'package:http/http.dart' as http;
import "dart:convert";
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:turf_project/constants.dart';
import 'package:turf_project/screens/home_screen.dart';
import 'package:turf_project/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // String serverUrl = 'http://$serverIp:3000';
  // String serverUrl = 'http://192.168.43.196:3000';
  // String serverUrl = 'http://192.168.140.196:3000';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
  }

  var u_id;

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  late String username;
  late String password;
  late SharedPreferences prefs;
  bool isLoading = false;
  bool loggedIn = false;
  bool isInvalid = false;
  bool fieldMissing = false;

  final _namecontroller = TextEditingController();
  final _passcontroller = TextEditingController();

  Future handleLogin(username, password) async {
    setState(() {
      isLoading = true;
    });
    Map creds = {
      'username': username,
      'password': password,
    };
    var body = json.encode(creds);
    var url = '${serverUrl}/login';
    print(url);
    http.Response response = await http.post(Uri.parse('$serverUrl/login'),
        headers: {"Content-Type": "application/json"}, body: body);
    // print("here 2");

    print(response.statusCode);
    String data = response.body;

    if (response.statusCode == 200) {
      var output = jsonDecode(data);
      if (output?['token'] != null) {
        print(output);
        var myToken = output['token'];
        var userData = output['user']['username'];
        var email = output['user']['email'];
        var uId = output['user']['u_id'];
        u_id = output['user']['u_id'];
        var teams = output['user']['teams'];
        List<String> teamList = [];

        for (int i = 0; i < teams.length; i++) {
          // print(teams[i] + "/....");
          // print(teams[i].runtimeType);
          // teamList[i] = teams[i];
          teamList.add(teams[i]);
          // print(teamList.runtimeType);
        }
        // var last_searched;
        // if (output['user']['last_searched'].length != 0) {
        //   last_searched = output['user']['last_searched'][0];
        // } else {
        //   last_searched = [];
        // }\

        prefs.setString('token', myToken);

        prefs.setString('username', userData);
        prefs.setString('u_id', uId);
        prefs.setString('email', email);
        prefs.setStringList('teams', teamList);

        // print(prefs.getStringList('teams').runtimeType);
        // print(prefs.getString('teams'));

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return App(uId);
        }));
        setState(() {
          isLoading = false;
          loggedIn = true;
        });
      } else {
        print("Something went wrong!!");
      }
    } else if (response.statusCode == 401) {
      setState(() {
        isInvalid = true;
        isLoading = false;
      });

      Timer timer = new Timer(new Duration(seconds: 3), () {
        // debugPrint("Print after 5 seconds");
        setState(() {
          isInvalid = false;
        });
      });
      print("Wrong Password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: scaffoldColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(75.0),
                    bottomRight: Radius.circular(75.0))),
            height: MediaQuery.of(context).size.height / 1.6,
            width: double.infinity,
          ),
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: Text(
          //     "Transmo.",
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontSize: 25.0,
          //       fontWeight: FontWeight.w800,
          //     ),
          //   ),
          // ),
          Align(
            alignment: Alignment.center,
            child: Material(
              color: scaffoldColor,
              // elevation: 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onDoubleTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return App(u_id);
                      }));
                    },
                    child: Text(
                      "Turf Squad",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 35.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Container(
                    height: 350.0,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0)),
                    margin: EdgeInsets.all(40.0),
                    // width: MediaQuery.of(context).size.height / 1,
                    child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Login Here",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextField(
                              controller: _namecontroller,
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  username = value;
                                });
                              },
                              decoration: kTextFieldDecoration.copyWith(
                                hintText: "Username",
                              ),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            TextField(
                              obscureText: true,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                              controller: _passcontroller,
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  password = value;
                                });
                              },
                              decoration: kTextFieldDecoration.copyWith(
                                hintText: "Password",
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.all(10.0),
                                  backgroundColor: primaryColor,
                                  fixedSize: Size.fromWidth(
                                    150.0,
                                  )),
                              onPressed: () {
                                if (_passcontroller.text.isEmpty ||
                                    _namecontroller.text.isEmpty) {
                                  setState(() {
                                    fieldMissing = true;
                                  });
                                  Timer timer =
                                      new Timer(new Duration(seconds: 3), () {
                                    // debugPrint("Print after 5 seconds");
                                    setState(() {
                                      fieldMissing = false;
                                    });
                                  });
                                } else {
                                  handleLogin(username, password);
                                }
                              },
                              child: isLoading
                                  ? Container(
                                      height: 25.0,
                                      width: 25.0,
                                      child: CircularProgressIndicator(
                                        backgroundColor: primaryColor,
                                        color: Colors.white,
                                      ),
                                    )
                                  : loggedIn
                                      ? Text(
                                          "Logged In",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        )
                                      : Text(
                                          "Login",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return RegisterScreen();
                                  }));
                                },
                                child: Text(
                                  "Don't have an Account ?",
                                  style: TextStyle(
                                    // decoration: TextDecoration.underline,
                                    // decorationColor: Colors.blue,
                                    // decorationThickness: 2.0,
                                    color: Colors.blue,
                                    fontSize: 18.0,
                                  ),
                                ))
                          ],
                        )),
                  ),
                  if (isInvalid || fieldMissing)
                    Text(
                      fieldMissing
                          ? "Please enter All fields"
                          : isInvalid
                              ? "Invalid Credentials"
                              : "",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.red,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
