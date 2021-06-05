import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:upcloud/controllers/key.dart';
import 'package:upcloud/models/markersSet.dart';
import 'package:upcloud/providers/filterProvider.dart';
import 'package:upcloud/providers/hintProvider.dart';
import 'package:upcloud/providers/myLocationProvider.dart';
import 'package:upcloud/providers/themeProvider.dart';
import 'package:upcloud/screens/homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ThemePro(), child: MyAppState());
  }
}

class MyAppState extends StatefulWidget {
  @override
  _MyAppStateState createState() => _MyAppStateState();
}

class _MyAppStateState extends State<MyAppState> {
  GlobalKey<_MyAppStateState> _mk;

  @override
  Widget build(BuildContext context) {
    // countr = false;
    var tp = Provider.of<ThemePro>(context);
    return ChangeNotifierProvider(
      create: (_) => HintProvider(),
      child: ChangeNotifierProvider(
        create: (_) => FilterProvider(),
        child: ChangeNotifierProvider(
          create: (_) => MyLocationProvider(),
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: tp.currentTheme,
            // darkTheme: ThemeData.dark(),
            home: MyHomePage(
              key: _mk,
            ),
          ),
        ),
      ),
    );
  }
}
