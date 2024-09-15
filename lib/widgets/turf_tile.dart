import 'package:flutter/material.dart';
import 'package:turf_project/constants.dart';
import 'package:turf_project/screens/turf_booking.dart';

class TurfTile extends StatelessWidget {
  // const TurfTile({
  //   super.key,
  // });

  TurfTile(this.turfName, this.turfImg);
  final String turfName;
  final String turfImg;
  final FocusNode _focusNode = FocusNode();
  bool focus = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // focusNode:  widget.focusNode,
      // focusNode: _focusNode,

      // onDoubleTap: () {
      //   _focusNode.unfocus();
      // },
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return TurfBooking(
            turfTitle: turfName,
            turfImg: turfImg,
          );
        }));
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          // right: 10.0,
          horizontal: 4.0,
        ),
        // width: 220,
        height: 280.0,
        width: MediaQuery.of(context).size.width / 1.5,
        // color: Colors.red,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(6.0),
          ),
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 8.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Card(
                  shadowColor: primaryColor,
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        // "images/turf1.jpg",
                        turfImg,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                turfName,
                style: TextStyle(
                  color: scaffoldColor,
                  fontSize: 20.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
