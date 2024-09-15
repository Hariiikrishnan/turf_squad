import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "dart:convert";
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:turf_project/constants.dart';
import 'package:turf_project/widgets/turf_tile.dart';

class AllTurfs extends StatefulWidget {
  // const AllTurfs({super.key});
  AllTurfs(this.name, this.u_id);
  final String name;
  final String u_id;

  @override
  State<AllTurfs> createState() => _AllTurfsState();
}

class _AllTurfsState extends State<AllTurfs> {
  var turfsData;
  bool loadedData = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPlayers();
  }

  Future getPlayers() async {
    http.Response response = await http.get(
      Uri.parse('$serverUrl/turfsByGame/${widget.u_id}/${widget.name}'),
      headers: {"Content-Type": "application/json"},
    );
    // print("here 2");

    // print(response.statusCode);
    String output = response.body;
    if (response.statusCode == 200) {
      var data = jsonDecode(output);

      // print(data);
      if (data['msg'] == 'Success') {
        // for (int i = 0; i < data['data'].length; i++) {
        //   print(data['data'][i]);
        // }
        setState(() {
          turfsData = data['data'];
          loadedData = true;
        });
        // return data['data'];
      }
    } else {
      print(response.statusCode);
    }
  }

  List<Widget> turfsList() {
    List<Widget> list = [];

    for (int i = 0; i < turfsData.length; i++) {
      print(turfsData[i]);
      list.add(
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
          ),
          child: TurfTile(turfsData[i]['name'], "images/turf1.jpg"),
        ),
      );
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 50.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Turfs which allows " + widget.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: loadedData
                        ? turfsList()
                        : [
                            Center(
                              child: Text(
                                'Loading',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            )
                          ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


// Container(
//           height: 150.0,
//           width: double.infinity,
//           color: Colors.red,
//           margin: EdgeInsets.symmetric(
//             vertical: 5.0,
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   turfsData[i]['name'],
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 24.0,
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),