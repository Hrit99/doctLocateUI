import 'package:flutter/material.dart';
import 'package:upcloud/models/doctor.dart';

class CarouselCard extends StatelessWidget {
  Doctor e;
  CarouselCard(this.e);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned(
            bottom: ((MediaQuery.of(context).size.height / 2.7) -
                    (MediaQuery.of(context).size.height / 3.7)) /
                2,
            left: ((MediaQuery.of(context).size.width) -
                    (MediaQuery.of(context).size.width / 1.3)) /
                2,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              width: MediaQuery.of(context).size.width / 1.3,
              height: MediaQuery.of(context).size.height / 3.7,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                  ),
                  Text(e.name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("${e.speciality}  |  ${e.likes.toString()}",
                          style: TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 17)),
                      SizedBox(
                        width: 5,
                        height: 2,
                      ),
                      Icon(Icons.thumb_up, color: Colors.blue),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  Text(e.hospitalName,
                      style: TextStyle(
                          color: Colors.purple[200],
                          fontWeight: FontWeight.bold,
                          fontSize: 17)),
                ],
              ),
            ),
          ),
          Positioned(
              right: 20,
              top: 50,
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 25,
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Text(
                      "~ ${double.parse((e.distFrom / 1000).toStringAsFixed(2))} Km ~",
                      style: TextStyle(
                          color: Colors.green[300],
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                  e.bookmark
                      ? Icon(Icons.bookmark, color: Colors.red)
                      : Icon(Icons.bookmark_border, color: Colors.red),
                ]),
              )),
          Positioned(
            bottom: ((MediaQuery.of(context).size.height / 2.7) -
                    (MediaQuery.of(context).size.height / 3.7)) /
                2,
            left: ((MediaQuery.of(context).size.width) -
                    (MediaQuery.of(context).size.width / 1.3)) /
                2,
            child: Container(
              padding: EdgeInsets.only(right: 20),
              height: MediaQuery.of(context).size.height / 20,
              width: MediaQuery.of(context).size.width / 1.3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(20), top: Radius.circular(0))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 6,
                    // color: Colors.green,
                    child: Center(
                      child: Icon(Icons.message),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 6,
                    child: Center(
                      child: Icon(Icons.video_call),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 6,
                    child: Center(
                      child: Icon(Icons.call),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 4.7,
                    height: MediaQuery.of(context).size.height / 25,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black,
                              blurRadius: 5,
                              // spreadRadius: 2,
                              offset:
                                  Offset.lerp(Offset(1, 11), Offset(1, 10), 10))
                        ]),
                    child: Center(
                      child: Text("₹ ${e.price}",
                          style: TextStyle(
                              color: Colors.green[300],
                              fontWeight: FontWeight.bold,
                              fontSize: 17)),
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            left: (((MediaQuery.of(context).size.width) -
                        (MediaQuery.of(context).size.width / 1.3)) /
                    2) +
                30,
            child: Container(
              child: Image.asset("assets/icons/picon.png"),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(50)),
              width: MediaQuery.of(context).size.height / 11,
              height: MediaQuery.of(context).size.height / 11,
            ),
          )
        ],
      ),
    );
  }
}
