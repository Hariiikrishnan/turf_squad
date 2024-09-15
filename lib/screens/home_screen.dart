import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:turf_project/constants.dart';
import 'package:turf_project/screens/all_turfs.dart';
import 'package:turf_project/screens/more_options.dart';
import 'package:turf_project/screens/turf_booking.dart';
import "package:turf_project/widgets/turf_tile.dart";

class HomeScreen extends StatelessWidget {
  // const HomeScreen({super.key});
  HomeScreen(this.u_id);
  final String u_id;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(
          left: 25.0,
          right: 25.0,
          top: 50.0,
          bottom: 30.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Hello User",
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.notification_important_outlined,
                          color: textColor,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return MoreOptions();
                            }));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: primaryActive,
                                borderRadius: BorderRadius.circular(
                                  15.0,
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Icon(
                                Icons.lens_blur,
                                color: textColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                // TextField(
                //   textInputAction: TextInputAction.search,
                //   decoration: const InputDecoration(
                //     suffixIcon: Icon(
                //       Icons.search_rounded,
                //     ),
                //     suffixIconColor: Colors.black,
                //     fillColor: Colors.white,
                //     hintStyle: TextStyle(
                //       color: Colors.black54,
                //       fontSize: 19,
                //     ),
                //     filled: true,
                //     // labelText: "Hello",
                //     hintText: 'Search Turf',
                //     floatingLabelBehavior: FloatingLabelBehavior.always,
                //     contentPadding:
                //         EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.all(Radius.circular(10.0)),
                //     ),
                //     enabledBorder: OutlineInputBorder(
                //       borderSide: BorderSide(color: primaryColor, width: 0.0),
                //       borderRadius: BorderRadius.all(Radius.circular(10.0)),
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderSide: BorderSide(color: primaryColor, width: 0.0),
                //       borderRadius: BorderRadius.all(Radius.circular(10.0)),
                //     ),
                //   ),
                // ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Top Turfs",
                  // textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
                Text(
                  "See All",
                  // textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w400,
                    color: textColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: Container(
                // constraints: BoxConstraints(
                //   maxHeight: 200.0,
                //   minHeight: 180.0,
                // ),
                height: 180.0,
                // flex: 3,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    TurfTile("Power Smack Turf", "images/turf1.jpg"),
                    TurfTile("Thanjai Turf", "images/turf2.jpg"),
                    TurfTile("Comrades Turf", "images/turf4.jpg"),
                  ],
                ),
              ),
            ),

            // Games !-!-!-!-!-!-!-!-!-!
            SizedBox(
              height: 15.0,
            ),

            Expanded(
              child: Container(
                  // constraints: BoxConstraints(
                  //   maxHeight: 200.0,
                  //   minHeight: 180.0,
                  // ),
                  height: 180.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: primaryActive,
                      borderRadius: BorderRadius.circular(
                        15.0,
                      )),
                  // flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                        ),
                        child: Text(
                          "Games",
                          // textAlign: TextAlign.left,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            color: textColor,
                          ),
                        ),
                      ),
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Container(
                            height: 100.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                                color: Color(0XFFB6EEF5),
                                borderRadius: BorderRadius.circular(
                                  30.0,
                                )),
                            margin: EdgeInsets.all(5.0),
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  overlayColor: primaryActive,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                    30.0,
                                  )),
                                ),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return AllTurfs(
                                      "Cricket",
                                      u_id,
                                    );
                                  }));
                                },
                                child: Image.asset(
                                  "images/cricket_icon.png",
                                  height: 99.0,
                                )),
                          ),
                          Container(
                            height: 100.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                                color: Color(0XFFB2EBB8),
                                borderRadius: BorderRadius.circular(
                                  30.0,
                                )),
                            margin: EdgeInsets.all(5.0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                overlayColor: primaryActive,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                  30.0,
                                )),
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return AllTurfs(
                                    "Football",
                                    u_id,
                                  );
                                }));
                              },
                              child: Image.asset(
                                "images/football_icon.png",
                                height: 99.0,
                              ),
                            ),
                          ),
                          Container(
                            height: 100.0,
                            width: 150.0,
                            margin: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                color: Color(0XFFA8CBFF),
                                borderRadius: BorderRadius.circular(
                                  30.0,
                                )),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                overlayColor: primaryActive,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                  30.0,
                                )),
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return AllTurfs(
                                    "Shuttle",
                                    u_id,
                                  );
                                }));
                              },
                              child: Image.asset(
                                "images/shuttle_icon.png",
                                height: 99.0,
                              ),
                            ),
                          ),
                          Container(
                            height: 100.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                                color: Color(0XFFFEC774),
                                borderRadius: BorderRadius.circular(
                                  30.0,
                                )),
                            margin: EdgeInsets.all(5.0),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                overlayColor: primaryActive,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                  30.0,
                                )),
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return AllTurfs(
                                    "Tennis",
                                    u_id,
                                  );
                                }));
                              },
                              child: Image.asset(
                                "images/tennis_icon.png",
                                height: 99.0,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
