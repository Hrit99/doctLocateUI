import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

Future<bool> checkFilterStatus(String key, String filttype) async {
  print("dssd");
  print(key);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String s;
  switch (filttype) {
    case "days":
      {
        s = prefs.getString('dayfilterString');
        break;
      }
    case "gender":
      {
        s = prefs.getString('genderfilterString');
        break;
      }
    case "range":
      {
        s = prefs.getString('rangefilterString');
        break;
      }
    case "time":
      {
        s = prefs.getString('timefilterString');
        print("dfddaaa");
        print(s);
        break;
      }
  }
  print("hola");
  print(s);
  if (s != null) {
    if (json.decode(s)[key] == true) {
      return Future.value(true);
    } else
      return Future.value(false);
  } else
    return Future.value(true);
}
