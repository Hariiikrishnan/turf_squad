import 'package:flutter/material.dart';

import 'package:turf_project/constants.dart';
import 'package:turf_project/screens/app.dart';

import 'dart:async';

import 'package:turf_project/screens/login_screen.dart';
import 'package:http/http.dart' as http;
import "dart:convert";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late String username;
  late String password;
  late String mail;
  bool fieldMissing = false;

  final _namecontroller = TextEditingController();
  final _passcontroller = TextEditingController();
  final _mailcontroller = TextEditingController();

  late SharedPreferences prefs;
  bool isLoading = false;
  bool loggedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
    initOneSignal();
  }

  Future<void> initOneSignal() async {
    OneSignal.Debug.setLogLevel(
      OSLogLevel.verbose,
      // kDebugMode ? OSLogLevel.verbose : OSLogLevel.none,
    );

    OneSignal.initialize("7c2b79bc-bd2b-4600-b95e-f3a2efaa3d7e");

    // final id = OneSignal.User.pushSubscription.id;
    final id = OneSignal.User.pushSubscription.id;

    print(id);
    // print("Endraa");
    if (id != null) {
      prefs.setString("onesignal_id", id);
    }

    await OneSignal.Notifications.requestPermission(true);
  }

  Future handleLogin(email, username, password) async {
    setState(() {
      isLoading = true;
    });
    Map creds = {
      'email': email,
      'username': username,
      'password': password,
      'onesignal_id': prefs.getString('onesignal_id'),
    };
    // print()
    var body = json.encode(creds);
    http.Response response = await http.post(Uri.parse('${serverUrl}/register'),
        headers: {"Content-Type": "application/json"}, body: body);

    String data = response.body;
    print(response.statusCode);
    var output = jsonDecode(data);

    print(output);

    if (output['token'] != null) {
      var myToken = output['token'];
      var userData = output['user']['username'];
      var email = output['user']['email'];
      var uId = output['user']['u_id'];

      prefs.setString('token', myToken);

      prefs.setString('username', userData);
      prefs.setString('u_id', uId);
      prefs.setString('email', email);

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.red,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
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
                  Text(
                    "Transmo.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Container(
                    height: 400.0,
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(20.0)),
                    margin: EdgeInsets.all(40.0),
                    // width: MediaQuery.of(context).size.height / 1,
                    child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              "Register Here",
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
                              controller: _passcontroller,
                              obscureText: true,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
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
                            TextField(
                              controller: _mailcontroller,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  mail = value;
                                });
                              },
                              decoration: kTextFieldDecoration.copyWith(
                                hintText: "Email",
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: primaryActive,
                                fixedSize: Size.fromWidth(
                                  200.0,
                                ),
                                side: BorderSide(
                                  width: 2.0,
                                  color: Colors.white,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    10.0,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if (_namecontroller.text.isEmpty ||
                                    _passcontroller.text.isEmpty ||
                                    _mailcontroller.text.isEmpty) {
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
                                  // handleLogin(username, password);
                                  print("loading");
                                  handleLogin(mail, username, password);
                                }
                              },
                              child: Text(
                                "Create Account",
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
                                    return LoginScreen();
                                  }));
                                },
                                child: Text(
                                  "Already have an Account ?",
                                  style: TextStyle(
                                    // decoration: TextDecoration.underline,
                                    // decorationColor: Colors.blue,
                                    // decorationThickness: 2.0,
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                ))
                          ],
                        )),
                  ),
                  if (fieldMissing)
                    Text(
                      "Please Enter All Fields",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                      ),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
