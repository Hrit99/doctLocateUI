import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:upcloud/controllers/carouselcontroller.dart';
import 'package:upcloud/models/doctor.dart';
import 'package:upcloud/models/listFDoc.dart';
import 'package:upcloud/models/listOfDoctors.dart';
import 'package:upcloud/models/markersSet.dart';
import 'package:upcloud/providers/filterDoctorProvider.dart';
import 'package:upcloud/providers/filterProvider.dart';
import 'package:upcloud/providers/myLocationProvider.dart';
import 'package:upcloud/widgets/CarouselWidgetCard.dart';

class CarouselWidget extends StatelessWidget {
  final List<Doctor> dlist;
  CarouselWidget(this.dlist);
  @override
  Widget build(BuildContext context) {
    print("eneter ccc");
    var mlProvider = Provider.of<MyLocationProvider>(context, listen: false);
    return Container(
      height: MediaQuery.of(context).size.height / 2.8,
      width: MediaQuery.of(context).size.width,
      child: CarouselSlider(
        carouselController: carouselController,
        options: CarouselOptions(
            autoPlay: false,
            enableInfiniteScroll: true,
            enlargeCenterPage: false,
            height: MediaQuery.of(context).size.height / 2.8,
            initialPage: 0,
            viewportFraction: 0.9),
        items: dlist.map((e) {
          return CarouselCard(e);
        }).toList(),
      ),
    );
  }
}
