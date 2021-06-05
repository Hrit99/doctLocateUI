import 'package:flutter/material.dart';
import 'package:upcloud/models/doctor.dart';
import 'package:upcloud/models/listFDoc.dart';

class HintProvider with ChangeNotifier {
  List<Doctor> hintl = List.from(fd);
  void update(List<Doctor> l) {
    hintl = l;
    notifyListeners();
  }
}
