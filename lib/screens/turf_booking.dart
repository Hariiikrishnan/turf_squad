import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:turf_project/constants.dart';

import 'package:intl/intl.dart';
import 'package:turf_project/screens/map_screen.dart';
import 'package:turf_project/screens/select_players.dart';

class TurfBooking extends StatefulWidget {
  // const TurfBooking({super.key});

  TurfBooking({
    required this.turfTitle,
    required this.turfImg,
  });
  final String turfTitle;
  final String turfImg;

  @override
  State<TurfBooking> createState() => _TurfBookingState();
}

class _TurfBookingState extends State<TurfBooking> {
  double _sheetPosition = 0.5;
  DraggableScrollableController scrollController =
      DraggableScrollableController();
  late double drag;
  late double xSt;
  late double ySt;

  double _scaleFactor = 1.0;
  double _translateY = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   show(context);
    // });
    scrollController.addListener(scrollListener);
  }

  // void show(context){
  //   showModalBottomSheet(context: context, builder: (BuildContext cont){
  //     return
  //   })
  // }

  void scrollListener() {
    print('Scrolled');
    // print(scrollController.size);
    double extent = scrollController.size;
    setState(() {
      _scaleFactor = 0.8 + (extent * 0.5);
      _translateY = extent * 0.8;
    });
    // print(_translateY);
    // print(_scaleFactor);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book Turf"),
        backgroundColor: primaryColor,
      ),
      body: Container(
        child: Stack(
          children: [
            Transform(
              transform: Matrix4.identity()
                ..scale(_scaleFactor, _scaleFactor)
                ..translate(0.0, _translateY),
              child: Container(
                child: Stack(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 1.9,
                      fit: BoxFit.cover,
                      image: AssetImage(
                        // "images/turf1.jpg",
                        widget.turfImg,
                      ),
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).size.height / 10,
                      child: Container(
                        height: MediaQuery.of(context).size.height / 10,
                        width: 500.0,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black,
                                blurRadius: 250,
                                // offset: Offset(-5.5, 0.0),
                                spreadRadius: 42),
                            // BoxShadow(
                            //   color: scaffoldColor,
                            //   blurRadius: 150,
                            //   spreadRadius: 15,
                            //   offset: Offset(-5.5, 0.0),
                            // ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 25.0,
                          ),
                          child: Text(
                            widget.turfTitle,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            DraggableScrollableSheet(
                // controller: DraggableScrollableController(

                // ).animateTo(size, duration: duration, curve: curve),
                initialChildSize: _sheetPosition,
                maxChildSize: 0.53,
                minChildSize: 0.48,
                controller: scrollController,
                expand: true,
                builder: (BuildContext context, ScrollController contr) {
                  return Container(
                    height: MediaQuery.of(context).size.height / 1.9,
                    decoration: BoxDecoration(
                        color: textColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                            40.0,
                          ),
                          topRight: Radius.circular(
                            40.0,
                          ),
                        )),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                        left: 20.0,
                        right: 20.0,
                      ),
                      child: ListView(
                        controller: contr,
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Book Your Slots Soon",
                            style: TextStyle(
                              color: scaffoldColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              DateTile(
                                  widget.turfTitle,
                                  DateFormat("d - MMM").format(DateTime.now()),
                                  DateFormat("d").format(DateTime.now())),
                              DateTile(
                                  widget.turfTitle,
                                  DateFormat("d - MMM").format(
                                      DateTime.now().add(Duration(days: 1))),
                                  DateFormat("d").format(
                                      DateTime.now().add(Duration(days: 1)))),
                              DateTile(
                                  widget.turfTitle,
                                  DateFormat("d - MMM").format(
                                      DateTime.now().add(Duration(days: 2))),
                                  DateFormat("d").format(DateTime.now()
                                      .subtract(Duration(days: 2)))),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris ornare libero sit amet dolor faucibus, id fringilla lorem cursus. Morbi tincidunt placerat volutpat. Fusce mollis sit amet eros eu fermentum. Ut volutpat eget leo sit amet dictum. Ut hendrerit porttitor massa eu tincidunt. ",
                            style: TextStyle(
                              color: scaffoldColor,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                              height: 1.2,
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          10.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return MapScreen();
                                    }));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                    ),
                                    child: Text(
                                      "Show in Map",
                                      style: TextStyle(
                                        color: textColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: scaffoldColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        10.0,
                                      ),
                                    ),
                                  ),
                                ),
                                onPressed: () {},
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0,
                                  ),
                                  child: Text(
                                    "Share",
                                    style: TextStyle(
                                      color: textColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}

// Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 height: MediaQuery.of(context).size.height / 2,
//                 decoration: BoxDecoration(
//                     color: textColor,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(
//                         40.0,
//                       ),
//                       topRight: Radius.circular(
//                         40.0,
//                       ),
//                     )),
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Text(
//                         "Book Your Slots Soon",
//                         style: TextStyle(
//                           color: scaffoldColor,
//                           fontSize: 18.0,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           DateTile(
//                               DateFormat("d - MMM").format(DateTime.now())),
//                           DateTile(
//                             DateFormat("d - MMM")
//                                 .format(DateTime.now().add(Duration(days: 1))),
//                           ),
//                           DateTile(
//                             DateFormat("d - MMM")
//                                 .format(DateTime.now().add(Duration(days: 2))),
//                           ),
//                         ],
//                       ),
//                       Text(
//                         "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris ornare libero sit amet dolor faucibus, id fringilla lorem cursus. Morbi tincidunt placerat volutpat. Fusce mollis sit amet eros eu fermentum. Ut volutpat eget leo sit amet dictum. Ut hendrerit porttitor massa eu tincidunt. ",
//                         style: TextStyle(
//                           color: scaffoldColor,
//                           fontSize: 18.0,
//                           fontWeight: FontWeight.w400,
//                           height: 1.2,
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.bottomRight,
//                         child: TextButton(
//                           style: TextButton.styleFrom(
//                             backgroundColor: scaffoldColor,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(
//                                   10.0,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           onPressed: () {},
//                           child: Padding(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 10.0,
//                             ),
//                             child: Text(
//                               "Share",
//                               style: TextStyle(
//                                 color: textColor,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),

// Date Button Widget !!!

class DateTile extends StatelessWidget {
  DateTile(this.turfName, this.date, this.onlyDate);
  final String date;
  final String onlyDate;
  final String turfName;
  String currentDate = DateFormat("d").format(DateTime.now());
  String currentTime = DateFormat().add_H().format(DateTime.now().toLocal());

  List<Padding> loadButtons(j, context) {
    // print(date.substring(0, 2));
    List<Padding> buttonList = [];
    print(int.parse(currentTime) - 12);
    for (int i = 9; i < j; i++) {
      // print(currentDate);
      // print(onlyDate);
      if (currentDate == onlyDate) {
        // print(i > (int.parse(currentTime) - 12));
        if (i > (int.parse(currentTime))) {
          buttonList.add(Padding(
            padding: EdgeInsets.all(10.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: primaryActive,
                // backgroundColor: Colors.deepPurple,
                fixedSize: Size(
                  80.0,
                  25.0,
                ),
              ),
              onPressed: () {
                print(i < 13
                    ? i.toString() + (i < 12 ? " AM" : " PM")
                    : (i - 12).toString() + " PM");
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SelectPlayers(
                      i < 13
                          ? i.toString() + (i < 12 ? " AM" : " PM")
                          : (i - 12).toString() + " PM",
                      date,
                      turfName);
                }));
              },
              child: Text(
                (i < 13
                    ? i.toString() + (i < 12 ? " AM" : " PM")
                    : (i - 12).toString() + " PM"),
                // i.toString(),
                style: TextStyle(
                  color: textColor,
                  fontSize: 19.0,
                ),
              ),
            ),
          ));
        } else {
          buttonList.add(Padding(
            padding: EdgeInsets.all(10.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: textColor,
                // backgroundColor: Colors.deepPurple,
                fixedSize: Size(
                  80.0,
                  25.0,
                ),
              ),
              onPressed: () {
                print(i < 13
                    ? i.toString() + (i < 12 ? " AM" : " PM")
                    : (i - 12).toString() + " PM");
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return SelectPlayers(
                //       i < 13
                //           ? i.toString() + (i < 12 ? " AM" : " PM")
                //           : (i - 12).toString() + " PM",
                //       date,
                //       turfName);
                // }));
              },
              child: Text(
                (i < 13
                    ? i.toString() + (i < 12 ? " AM" : " PM")
                    : (i - 12).toString() + " PM"),
                // i.toString(),
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 19.0,
                ),
              ),
            ),
          ));
        }
      } else {
        buttonList.add(Padding(
          padding: EdgeInsets.all(10.0),
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor: primaryActive,
              // backgroundColor: Colors.deepPurple,
              fixedSize: Size(
                80.0,
                25.0,
              ),
            ),
            onPressed: () {
              print(i < 13
                  ? i.toString() + (i < 12 ? " AM" : " PM")
                  : (i - 12).toString() + " PM");
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SelectPlayers(
                    i < 13
                        ? i.toString() + (i < 12 ? " AM" : " PM")
                        : (i - 12).toString() + " PM",
                    date,
                    turfName);
              }));
            },
            child: Text(
              (i < 13
                  ? i.toString() + (i < 12 ? " AM" : " PM")
                  : (i - 12).toString() + " PM"),
              // i.toString(),
              style: TextStyle(
                color: textColor,
                fontSize: 19.0,
              ),
            ),
          ),
        ));
      }
    }
    return buttonList;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: primaryActive,
        // side: BorderSide(
        //   width: 2.0,
        //   color: scaffoldColor,
        // ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            16.0,
          ),
        ),
      ),
      onPressed: () {
        showModalBottomSheet<void>(
            // context and builder are
            // required properties in this widget
            context: context,
            enableDrag: true,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (BuildContext context) {
              // we set up a container inside which
              // we create center column and display text

              // Returning SizedBox instead of a Container
              return Container(
                color: Colors.white,
                height: 450.0,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                    right: 20.0,
                    left: 20.0,
                  ),
                  child: ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        child: Text(
                          "Select your slot for " + date + "!",
                          style: TextStyle(
                            color: secondaryColor,
                            fontSize: 21.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        // color: Colors.red,
                        // height: 25.0,
                        child: Center(
                          child: Wrap(
                            spacing: 1.0, // Horizontal spacing between buttons
                            runSpacing: 0.5, // Vertical Spacing
                            // scrollDirection: Axis.horizontal,
                            children: loadButtons(23, context),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 8.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              date.substring(0, 2),
              // DateFormat("d - MMM")
              // .format(DateTime.now().subtract(Duration(days: 1))),
              // DateTime.now().toString(),
              style: TextStyle(
                color: primaryColor,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              date.substring(5, 8),
              // DateFormat("d - MMM")
              // .format(DateTime.now().subtract(Duration(days: 1))),
              // DateTime.now().toString(),
              style: TextStyle(
                color: primaryColor,
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// Container(
//         child: Padding(
//           padding: const EdgeInsets.only(
//             left: 20.0,
//             right: 20.0,
//             bottom: 20.0,
//             top: 30.0,
//           ),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Text(
//                 widget.turfTitle,
//                 style: TextStyle(
//                   color: textColor,
//                   fontSize: 22.0,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               Card(
//                 shadowColor: primaryColor,
//                 elevation: 5.0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(6.0),
//                   ),
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(6.0),
//                   child: Image(
//                     width: double.infinity,
//                     height: 250.0,
//                     fit: BoxFit.cover,
//                     image: AssetImage(
//                       // "images/turf1.jpg",
//                       widget.turfImg,
//                     ),
//                   ),
//                 ),
//               ),
//               // SizedBox(
//               // height: 20.0,
//               // ),
//               Text(
//                 "Book Your Slots Soon",
//                 style: TextStyle(
//                   color: textColor,
//                   fontSize: 18.0,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   DateTile(DateFormat("d - MMM").format(DateTime.now())),
//                   DateTile(
//                     DateFormat("d - MMM")
//                         .format(DateTime.now().add(Duration(days: 1))),
//                   ),
//                   DateTile(
//                     DateFormat("d - MMM")
//                         .format(DateTime.now().add(Duration(days: 2))),
//                   ),
//                 ],
//               ),
//               Text(
//                 "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris ornare libero sit amet dolor faucibus, id fringilla lorem cursus. Morbi tincidunt placerat volutpat. Fusce mollis sit amet eros eu fermentum. Ut volutpat eget leo sit amet dictum. Ut hendrerit porttitor massa eu tincidunt. ",
//                 style: TextStyle(
//                   color: textColor,
//                   fontSize: 18.0,
//                   fontWeight: FontWeight.w400,
//                   height: 1.2,
//                 ),
//               ),

//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: TextButton(
//                   style: TextButton.styleFrom(
//                     backgroundColor: textColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(
//                           10.0,
//                         ),
//                       ),
//                     ),
//                   ),
//                   onPressed: () {},
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 10.0,
//                     ),
//                     child: Text(
//                       "Share",
//                       style: TextStyle(
//                         color: secondaryColor,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),