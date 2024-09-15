import 'package:flutter/material.dart';
import 'package:turf_project/constants.dart';

class MyBookings extends StatelessWidget {
  const MyBookings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Bookings",
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 25.0,
          ),
          child: Column(
            children: [
              BookingWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class BookingWidget extends StatelessWidget {
  const BookingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      decoration: BoxDecoration(
          color: textColor,
          borderRadius: BorderRadius.circular(
            8.0,
          )),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 25.0,
                width: 15.0,
                decoration: BoxDecoration(
                    color: scaffoldColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50.0),
                      bottomRight: Radius.circular(50.0),
                    )),
              ),
              Container(
                height: 25.0,
                width: 15.0,
                decoration: BoxDecoration(
                    color: scaffoldColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50.0),
                      bottomRight: Radius.circular(50.0),
                    )),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Turf Booked : Power Smack",
                    style: TextStyle(
                      color: scaffoldColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "To Play at : 8 - Jul",
                    style: TextStyle(
                      color: scaffoldColor,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    "Booked at : 7/7/2024, 11:42:52 pm",
                    style: TextStyle(
                      color: scaffoldColor,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    "Amount Paid : Rs.1200",
                    style: TextStyle(
                      color: scaffoldColor,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 25.0,
                width: 15.0,
                decoration: BoxDecoration(
                    color: scaffoldColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      bottomLeft: Radius.circular(50.0),
                    )),
              ),
              Container(
                height: 25.0,
                width: 15.0,
                decoration: BoxDecoration(
                    color: scaffoldColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      bottomLeft: Radius.circular(50.0),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
