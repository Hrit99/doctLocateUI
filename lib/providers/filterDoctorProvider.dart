import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upcloud/models/doctor.dart';
import 'package:upcloud/models/filterOptions.dart';
import 'dart:async';
import 'dart:convert';

import 'package:upcloud/models/listOfDoctors.dart';
import 'package:upcloud/models/markersSet.dart';

Future<List<Doctor>> getFilteredDoc() async {
  Map dayfiltermap = {};
  Map genderfiltermap = {};
  Map rangefiltermap = {};
  Map timefiltermap = {};
  List<String> timetruekeys = new List<String>();
  List<String> daytruekeys = new List<String>();
  List<String> gendertruekeys = new List<String>();
  List<String> rangetruekeys = new List<String>();
  print("herrrr");
  var pref = await SharedPreferences.getInstance();
  print("huihui");
  String sday = pref.getString("dayfilterString");
  if (sday != null) dayfiltermap = json.decode(sday);
  String sgender = pref.getString("genderfilterString");
  if (sgender != null) genderfiltermap = json.decode(sgender);
  String srange = pref.getString("rangefilterString");
  if (srange != null) rangefiltermap = json.decode(srange);
  String stime = pref.getString("timefilterString");
  if (stime != null) timefiltermap = json.decode(stime);
  print("huehue");
  print(dayfiltermap);
  print(genderfiltermap);
  print(rangefiltermap);
  print(timefiltermap);

  if (sday != null)
    daytruekeys = dayfiltermap.keys.toList().where((key) {
      print("buddy");
      return (dayfiltermap['$key'] == true);
    }).toList();
  print("1");
  if (sgender != null)
    gendertruekeys = genderfiltermap.keys
        .toList()
        .where((key) => (genderfiltermap['$key'] == true))
        .toList();
  print("2");
  if (srange != null)
    rangetruekeys = rangefiltermap.keys
        .toList()
        .where((key) => (rangefiltermap['$key'] == true))
        .toList();
  if (stime != null)
    timetruekeys = timefiltermap.keys
        .toList()
        .where((key) => (timefiltermap['$key'] == true))
        .toList();

  List<Doctor> dfiltered = doctors.where((d) {
    bool dayAv = false;
    bool genderAv = false;
    bool rangeAv = false;
    bool timeAv = false;
    print(d.name);
    print(d.daysAvailable.toString());

    if (daytruekeys.isNotEmpty) {
      print("jack");
      for (var day in d.daysAvailable) {
        if (daytruekeys.contains(day.substring(day.indexOf('.') + 1))) {
          dayAv = true;
          break;
        }
      }
    } else
      dayAv = true;
    print("dav$dayAv");
    if (gendertruekeys.isNotEmpty) {
      if (gendertruekeys.contains(
          d.gender.substring(d.gender.indexOf('.') + 1))) genderAv = true;
    } else
      genderAv = true;

    if (rangetruekeys.isNotEmpty) {
      for (var range in rangetruekeys) {
        List rr = rateRangeVal[rateRangeName.indexOf(range)];
        if ((d.price >= rr[0]) && (d.price <= rr[1])) {
          rangeAv = true;
          break;
        }
      }
    } else
      rangeAv = true;

    if (timetruekeys.isNotEmpty) {
      for (var time in d.timingsAvailable) {
        if (timetruekeys.contains(time.substring(time.indexOf('.') + 1))) {
          timeAv = true;
          break;
        }
      }
    } else
      timeAv = true;

    if (dayAv && genderAv && rangeAv && timeAv)
      return true;
    else
      return false;
  }).toList();
  print("hehehe");
  print(dfiltered);
  return Future.value(dfiltered);
}
