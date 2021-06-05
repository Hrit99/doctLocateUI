import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/material.dart';

class Doctor {
  String name;
  String speciality;
  String hospitalName;
  int likes;
  double lat;
  double long;
  double price;
  bool bookmark;
  String photo;
  List<String> daysAvailable;
  List<String> timingsAvailable;
  String gender;
  double distFrom;

  Doctor(
      {@required this.name,
      @required this.hospitalName,
      @required this.lat,
      @required this.long,
      @required this.distFrom,
      @required this.speciality,
      @required this.bookmark,
      @required this.likes,
      @required this.photo,
      @required this.price,
      @required this.daysAvailable,
      @required this.timingsAvailable,
      @required this.gender});
}
