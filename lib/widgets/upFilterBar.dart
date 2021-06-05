import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:upcloud/controllers/key.dart';
import 'package:upcloud/main.dart';
import 'package:upcloud/models/doctor.dart';
import 'package:upcloud/models/listFDoc.dart';
import 'package:upcloud/providers/hintProvider.dart';
import 'package:upcloud/screens/homepage.dart';
import 'package:upcloud/widgets/hintContainer.dart';

class UpFilterBar extends StatefulWidget {
  const UpFilterBar({Key key}) : super(key: key);

  @override
  UpFilterBarState createState() => UpFilterBarState();
}

class UpFilterBarState extends State<UpFilterBar> {
  TextEditingController te = new TextEditingController();
  bool extended = false;

  void closeExt() {
    if (extended)
      setState(() {
        extended = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    var hintpro = Provider.of<HintProvider>(context, listen: false);
    te.buildTextSpan(
        withComposing: true, style: TextStyle(decoration: TextDecoration.none));
    if (!extended) hintpro.hintl = List.from(fd);
    return extended
        ? Positioned(
            top: 0,
            width: MediaQuery.of(context).size.width,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: Theme.of(context).backgroundColor,
                    height: MediaQuery.of(context).size.height / 8,
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(bottom: 5),
                    child: ListTile(
                      title: TextField(
                        decoration: InputDecoration(hintText: "Search"),
                        controller: te,
                        onChanged: (nv) {
                          List<Doctor> hintstr = List.from(fd
                              .where((element) => (element.name.contains(nv)))
                              .toList());
                          print(hintstr);
                          hintpro.update(hintstr);
                        },
                      ),
                    ),
                  ),
                  HintContainer(() {
                    closeExt();
                  }),
                ],
              ),
            ),
          )
        : Positioned(
            top: MediaQuery.of(context).size.height / 15,
            height: MediaQuery.of(context).size.height / 20,
            width: MediaQuery.of(context).size.width,
            child: Container(
              child: Row(
                children: [
                  Container(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 10),
                      height: MediaQuery.of(context).size.height / 20,
                      width: MediaQuery.of(context).size.width / 1.4,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: Icon(Icons.gps_fixed),
                              onPressed: () {
                                setState(() {
                                  extended = true;
                                });
                              },
                            ),
                          ],
                        ),
                      )),
                  Container(
                      height: MediaQuery.of(context).size.height / 20,
                      width: MediaQuery.of(context).size.width / 3.5,
                      child: Row(children: [
                        IconButton(
                            icon: Icon(Icons.sort),
                            onPressed: () {
                              // print(hintpro.hintl[0].name);
                              // print(hintpro.hintl[1].name);
                              // print(((hintpro.hintl[0].name
                              //             .compareTo(hintpro.hintl[1].name) >
                              //         0)
                              // .toString()));
                              if (hintpro.hintl[0].name
                                      .compareTo(hintpro.hintl[1].name) >
                                  0)
                                hintpro.hintl
                                    .sort((a, b) => a.name.compareTo(b.name));
                              else
                                hintpro.hintl
                                    .sort((b, a) => a.name.compareTo(b.name));

                              hintpro.update(hintpro.hintl);
                            }),
                        Builder(
                          builder: (context) {
                            return IconButton(
                                icon: Icon(Icons.filter_alt),
                                onPressed: () {
                                  print("here");
                                  // _key.currentState.toggle();
                                  Scaffold.of(context).openEndDrawer();
                                });
                          },
                        )
                      ]))
                ],
              ),
            ));
  }
}
