import 'dart:async';
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upcloud/apis/locationApi.dart';
import 'package:upcloud/controllers/carouselcontroller.dart';
import 'package:upcloud/controllers/mapController.dart';
import 'package:upcloud/models/doctor.dart';
import 'package:upcloud/models/filterOptions.dart';
import 'package:upcloud/models/listFDoc.dart';
import 'package:upcloud/models/markersSet.dart';
import 'package:upcloud/providers/filterDoctorProvider.dart';
import 'package:upcloud/providers/filterProvider.dart';
import 'package:upcloud/providers/myLocationProvider.dart';
import 'package:upcloud/models/listOfDoctors.dart';
import 'package:upcloud/providers/themeProvider.dart';
import 'package:upcloud/widgets/carouselWidget.dart';
import 'package:upcloud/widgets/sideDrawer.dart';
import 'package:upcloud/controllers/key.dart';
import 'package:upcloud/widgets/upFilterBar.dart';
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   Completer<GoogleMapController> _controller = Completer();
// GlobalKey<SliderMenuContainerState> _key =
//     new GlobalKey<SliderMenuContainerState>();
// @override
// void initState() {
//   // TODO: implement initState
//   super.initState();
//   var myLocationProvider =
//       Provider.of<MyLocationProvider>(context, listen: false);
//   myLocationProvider.setMyPosition = Position(
//       longitude: 0,
//       latitude: 0,
//       timestamp: DateTime.now(),
//       accuracy: 0,
//       altitude: 0,
//       heading: 0,
//       speed: 0,
//       speedAccuracy: 0);
//   determinePosition().then((position) {
//     myLocationProvider.setMyPosition = position;
//     myLocationProvider.moveToMyLocation();
//   });
// }

//   @override
//   Widget build(BuildContext context) {
//     // var myLocationProvider =
//     //     Provider.of<MyLocationProvider>(context, listen: false);
//     // print(myLocationProvider.getMyPosition);

//     // determinePosition().then((position) {
//     //   myLocationProvider.setMyLocation = CameraPosition(
//     //       target: LatLng(position.latitude, position.longitude), zoom: 14.4746);
//     // });
//     return Scaffold(
//       backgroundColor: Colors.white,
// body: SliderMenuContainer(
//   key: _key,
//   slideDirection: SlideDirection.RIGHT_TO_LEFT,
//   sliderMenu: SideDrawer(),
//   hasAppBar: false,
//   isDraggable: false,
//   isShadow: false,
//   sliderMenuOpenSize: 265,
//   sliderMenuCloseSize: 0,
//   sliderMain: Container(
//     child: Stack(children: [
//       body: GoogleMap(
//         onTap: (_) {
//           if (_key.currentState.isDrawerOpen) _key.currentState.closeDrawer();
//         },
//         // markers: {
//         //   Marker(
//         //     markerId: MarkerId("My Location"),
//         //     position: LatLng(myLocationProvider.getMyPosition.latitude,
//         //         myLocationProvider.getMyPosition.longitude),
//         //   ),
//         // },
//         mapType: MapType.terrain,
//         initialCameraPosition:
//             CameraPosition(target: LatLng(0, 0), zoom: 14.4746),
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
// Positioned(
//     top: MediaQuery.of(context).size.height / 15,
//     child: Container(
//       height: MediaQuery.of(context).size.height / 20,
//       width: MediaQuery.of(context).size.width,
//       child: Row(
//         children: [
//           Container(
//               height: MediaQuery.of(context).size.height / 20,
//               width: MediaQuery.of(context).size.width / 1.4,
//               child: Center(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(Icons.gps_fixed),
//                     Container(
//                       padding: EdgeInsets.only(
//                         bottom:
//                             MediaQuery.of(context).size.height / 60,
//                       ),
//                       width:
//                           MediaQuery.of(context).size.width / 2.5,
//                       height:
//                           MediaQuery.of(context).size.height / 20,
//                       child: TextFormField(),
//                     ),
//                     Icon(Icons.arrow_drop_down),
//                   ],
//                 ),
//               )),
//           Container(
//               height: MediaQuery.of(context).size.height / 20,
//               width: MediaQuery.of(context).size.width / 3.5,
//               child: Row(children: [
//                 IconButton(
//                     icon: Icon(Icons.sort), onPressed: () {}),
//                 IconButton(
//                     icon: Icon(Icons.filter_alt),
//                     onPressed: () {
//                       _key.currentState.toggle();
//                     })
//               ]))
//         ],
//       ),
//     )),
// Positioned(
//   bottom: 5,
//   child: CarouselWidget(),
// ),
//       // ]),
//       // ),
//       // ),
//     );
//   }
// }

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);
  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  Completer<GoogleMapController> _controller = Completer();
  int j;
  String _darkMapStyle;
  String _lightMapStyle;

  LocationData _currentPosition;

  Location location = Location();

  // Future<void> goToThePoint(LatLng pos, controller) async {

  // }
  Future _loadMapStyles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('dayfilterString') == null) {
      Map m = {};
      for (var k in EnumToString.toList(days.values)) {
        m.putIfAbsent(k, () => true);
      }
      prefs.setString("dayfilterString", json.encode(m));
    }
    if (prefs.getString('genderfilterString') == null) {
      Map m = {};
      for (var k in EnumToString.toList(genders.values)) {
        m.putIfAbsent(k, () => true);
      }
      prefs.setString("genderfilterString", json.encode(m));
    }
    if (prefs.getString('rangefilterString') == null) {
      Map m = {};
      for (var k in rateRangeName) {
        m.putIfAbsent(k, () => true);
      }
      prefs.setString("rangefilterString", json.encode(m));
    }
    if (prefs.getString('timefilterString') == null) {
      Map m = {};
      for (var k in timingName) {
        m.putIfAbsent(k, () => true);
      }
      prefs.setString("timefilterString", json.encode(m));
    }

    _darkMapStyle = await rootBundle.loadString('assets/map_styles/dark.json');
    _lightMapStyle =
        await rootBundle.loadString('assets/map_styles/light.json');
  }

  // Future _setMapStyle() async {

  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadMapStyles();
    var myLocationPro = Provider.of<MyLocationProvider>(context, listen: false);
    // getFilteredDoc().then((value) => setfd(value));
    myLocationPro.setMyPosition =
        LocationData.fromMap({"latitude": 0, "longitude": 0});
    // GoogleMapController gc;
    // gc.setMapStyle(_darkMapStyle);
  }

  // @override
  // void didChangePlatformBrightness() {
  //   print("bchanged");
  //   setState(() {
  //     _setMapStyle();
  //   });
  // }

  @override
  void dispose() {
    _controller.complete();
    super.dispose();
  }

  bool colorWhite = true;
  Key k;
  @override
  Widget build(BuildContext context) {
    print("sscaleed${Theme.of(context).brightness}");
    var filtPro = Provider.of<FilterProvider>(context);
    var themePro = Provider.of<ThemePro>(context, listen: false);
    final GlobalKey<SideDrawerState> drawerk = GlobalKey();
    final GlobalKey<UpFilterBarState> upfk = GlobalKey();
    var myLocationPro = Provider.of<MyLocationProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawerEnableOpenDragGesture: false,
      endDrawer: Drawer(
        child: SideDrawer(
            key: drawerk,
            toggleMode: () async {
              print("saaaa");
              final theme = Theme.of(context).brightness;
              print(theme);
              if (theme == Brightness.dark)
                outmcontroller.setMapStyle(_lightMapStyle);
              else
                outmcontroller.setMapStyle(_darkMapStyle);
              // await Future.delayed(Duration(seconds: 5));
              print("f");
              themePro.switchTheme();
              // await Future.delayed(Duration(seconds: 2));
              // themePro.switchTheme();}
            }),
      ),
      body: FutureBuilder(
        future: determinePosition(),
        builder: (context, snapshot) {
          LocationData pos = snapshot.data;
          if (snapshot.hasData) {
            print(
                "position determined going to set position and move to point");
            myLocationPro.setMyPosition = pos;
            // goToThePoint(LatLng(pos.latitude, pos.longitude));
            return FutureBuilder(
              future: getFilteredDoc(),
              builder: (context, snapshot) {
                print("q1");
                if (snapshot.hasData) {
                  print("q4");
                  print("filtered doc data recieved");
                  List<Doctor> dlist = List.from(snapshot.data);
                  for (var d in dlist) {
                    d.distFrom = Geolocator.distanceBetween(
                        pos.latitude, pos.longitude, d.lat, d.long);
                  }
                  Set<Marker> markers = Set.from(dlist.map((e) {
                    return Marker(
                        markerId: MarkerId(e.name),
                        position: LatLng(e.lat, e.long),
                        icon: BitmapDescriptor.defaultMarkerWithHue(100));
                  }).toSet());
                  markers.add(Marker(
                      markerId: MarkerId("MyLocation"),
                      position: LatLng(myLocationPro.getMyPosition.latitude,
                          myLocationPro.getMyPosition.longitude)));
                  setmarker(markers);
                  setfd(dlist);
                  print("bg here i am");
                  return Stack(children: [
                    new GoogleMap(
                      onTap: (_) {
                        print("uuuuuuu");
                        if (Scaffold.of(context).isDrawerOpen) {
                          print("jjj");
                          Navigator.of(drawerk.currentContext).pop();
                        }
                        upfk.currentState.closeExt();
                      },
                      markers: markerset,
                      // mapType: MapType.terrain,
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: false,
                      // initialCameraPosition: myLocationPro.getMyCameraPosition,
                      onMapCreated: (GoogleMapController controller) async {
                        print("iiii");
                        // location.onLocationChanged.listen((l) {
                        //   print("ddssdddss");
                        //   controller.animateCamera(
                        // CameraUpdate.newCameraPosition(
                        //   CameraPosition(
                        //       target: LatLng(l.latitude, l.longitude),
                        //       zoom: 15),
                        // ),
                        //   );
                        // });

                        setgcontroller = controller;

                        // if(colorWhite){
                        //   final theme = Theme.of(context).brightness;
                        //   if (theme == Brightness.dark)
                        //   outmcontroller.setMapStyle(_darkMapStyle);

                        // print("qpqpqpqppqpqppq");
                        // final theme = Theme.of(context).brightness;
                        // print("aasddaaas");
                        // print(theme);
                        // if (theme == Brightness.dark)
                        //   outmcontroller.setMapStyle(_darkMapStyle);
                        // else
                        //   outmcontroller.setMapStyle(_lightMapStyle);
                        // _controller.complete(controller);
                      },
                      initialCameraPosition: CameraPosition(
                          target: LatLng(pos.latitude, pos.longitude),
                          zoom: 14.4678),
                    ),
                    Positioned(
                      height: MediaQuery.of(context).size.height / 2.8,
                      width: MediaQuery.of(context).size.width,
                      bottom: 5,
                      child: CarouselWidget(fd),
                    ),
                    UpFilterBar(key: upfk),
                  ]);
                } else {
                  print("q2");
                  return Container();
                }
              },
            );
          } else {
            print("q3");
            return Container();
          }
        },
      ),
    );
  }

  Future<LocationData> determinePosition() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {}
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {}
    }

    _currentPosition = await location.getLocation();
    // location.onLocationChanged.listen((LocationData currentLocation) {
    //   print("${currentLocation.longitude} : ${currentLocation.longitude}");
    //   setState(() {
    //     _currentPosition = currentLocation;
    //     // _initialcameraposition =
    //     //     LatLng(_currentPosition.latitude, _currentPosition.longitude);
    //   });
    // });
    return _currentPosition;
  }
}

// var myLocationPro = Provider.of<MyLocationProvider>(context, listen: false);
//     var mPro = Provider.of<Setmarker>(context, listen: false);
//     var filtPro = Provider.of<FilterProvider>(context);
// determinePosition().then((pos) {
// print("position determined going to set position and move to point");
// myLocationPro.setMyPosition = pos;
// goToThePoint(LatLng(pos.latitude, pos.longitude));
// });
//     print("below pos determin-()");
//     return new Scaffold(
// drawerEnableOpenDragGesture: false,
// endDrawer: Drawer(
//   child: SideDrawer(),
// ),
//       body: Stack(children: [
//         FutureBuilder(
//           future: getFilteredDoc(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
// print("filtered doc data recieved");
// List<Doctor> dlist = List.from(snapshot.data);
// Set<Marker> markers = Set.from(dlist.map((e) {
//   return Marker(
//       markerId: MarkerId(e.name),
//       position: LatLng(e.lat, e.long),
//       icon: BitmapDescriptor.defaultMarker);
// }).toSet());
// mPro.setmarker(markers);
// mPro.markerset.add(Marker(
//     markerId: MarkerId("MyLocation"),
//     position: LatLng(myLocationPro.getMyPosition.latitude,
//         myLocationPro.getMyPosition.longitude)));
// setfd(dlist);
// return GoogleMap(
//   onTap: (_) {
//     if (Scaffold.of(context).isDrawerOpen) {
//       print("jjj");
//       Navigator.of(getKey.currentContext).pop();
//     }
//   },
//   markers: mPro.markerset,
//   mapType: MapType.normal,
//   initialCameraPosition: myLocationPro.getMyCameraPosition,
//   onMapCreated: (GoogleMapController controller) {
//     _controller.complete(controller);
//   },
// );
//             } else {
//               print("havent got filterd doc data");
// return GoogleMap(
//   onTap: (_) {
//     if (Scaffold.of(context).isDrawerOpen) {
//       print("jjj");
//       Navigator.of(getKey.currentContext).pop();
//     }
//   },
// markers: {
//   Marker(
//       markerId: MarkerId("MyLocation"),
//       position: LatLng(myLocationPro.getMyPosition.latitude,
//           myLocationPro.getMyPosition.longitude))
// },
//   mapType: MapType.normal,
//   initialCameraPosition: myLocationPro.getMyCameraPosition,
//   onMapCreated: (GoogleMapController controller) {
//     _controller.complete(controller);
//   },
// );
//             }
//           },
//         ),
//         UpFilterBar(widget.key),
// Positioned(
//   height: MediaQuery.of(context).size.height / 2.8,
//   width: MediaQuery.of(context).size.width,
//   bottom: 5,
//   child: CarouselWidget(fd),
// ),
//       ]),
