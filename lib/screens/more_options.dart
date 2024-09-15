import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:turf_project/constants.dart';
import 'package:turf_project/screens/my_bookings.dart';

class MoreOptions extends StatelessWidget {
  const MoreOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "More Info",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
        ),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
            ),
            child: Column(
              children: [
                OptionTile(
                  "My Bookings",
                ),
                // OptionTile(
                //   "My Bookings",
                // ),
                // OptionTile(
                //   "My Bookings",
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OptionTile extends StatelessWidget {
  final String title;

  OptionTile(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 2.0,
      ),
      child: TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return MyBookings();
          }));
        },
        style: TextButton.styleFrom(
            // side: BorderSide(
            //   width: 1.0,
            //   color: textColor,
            // ),
            backgroundColor: primaryActive,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
              0.0,
            ))),
        child: Container(
          margin: EdgeInsets.all(
            15.0,
          ),
          width: double.infinity,
          child: Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }
}
