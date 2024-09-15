import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turf_project/models/players_data.dart';
import 'package:turf_project/models/teams_data.dart';

import 'package:turf_project/screens/app.dart';
import 'package:turf_project/constants.dart';
import 'package:turf_project/screens/login_screen.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PlayersData(),
      child: MaterialApp(
        title: 'Turf',
        theme: ThemeData(
          fontFamily: "WorkSans",
          primaryColor: primaryColor,
          scaffoldBackgroundColor: scaffoldColor,
          // scaffoldBackgroundColor: Color(0XFF000000),
          // colorScheme: ColorScheme.fromSeed(seedColor: Color(0XFF000000)),
          useMaterial3: true,
        ),
        home: LoginScreen(),
      ),
    );
  }
}
