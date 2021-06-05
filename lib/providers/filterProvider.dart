import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upcloud/models/filterOptions.dart';
import 'package:upcloud/providers/filterDoctorProvider.dart';

class FilterProvider with ChangeNotifier {
  Map<String, bool> dayfilterMap = {};
  Map<String, bool> genderfilterMap = {};
  Map<String, bool> rangefilterMap = {};
  Map<String, bool> timefilterMap = {};

  void addFilter(String key, String filttype) {
    switch (filttype) {
      case "days":
        {
          dayfilterMap.putIfAbsent(key, () => true);
          dayfilterMap[key] = true;
          break;
        }
      case "gender":
        {
          genderfilterMap.putIfAbsent(key, () => true);
          genderfilterMap[key] = true;
          break;
        }
      case "range":
        {
          rangefilterMap.putIfAbsent(key, () => true);
          rangefilterMap[key] = true;
          break;
        }
      case "time":
        {
          timefilterMap.putIfAbsent(key, () => true);
          timefilterMap[key] = true;
          break;
        }
    }
  }

  void delFilter(String key, String filttype) {
    switch (filttype) {
      case "days":
        {
          dayfilterMap[key] = false;
          break;
        }
      case "gender":
        {
          genderfilterMap[key] = false;
          break;
        }
      case "range":
        {
          rangefilterMap[key] = false;
          break;
        }
      case "time":
        {
          timefilterMap[key] = false;
          break;
        }
    }
  }

  void saveMap() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("dayfilterString", json.encode(dayfilterMap));
    prefs.setString("genderfilterString", json.encode(genderfilterMap));
    prefs.setString("rangefilterString", json.encode(rangefilterMap));
    prefs.setString("timefilterString", json.encode(timefilterMap));
    print(prefs.getString("timefilterString"));
    getFilteredDoc();
    notifyListeners();
  }
}
