import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:upcloud/models/filterOptions.dart';
import 'package:upcloud/providers/checkfilterStatus.dart';
import 'package:upcloud/widgets/checkBoxClick.dart';
import 'package:upcloud/widgets/timingBox.dart';

class DropDownWidget extends StatefulWidget {
  String filter;
  DropDownWidget(this.filter);
  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  bool extend = false;
  List filterOpt;
  String filttype;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("hiiiiii");
    switch (widget.filter) {
      case "Availability":
        {
          filttype = "days";
          filterOpt = EnumToString.toList(days.values);
          break;
        }
      case "Gender":
        {
          filttype = "gender";
          filterOpt = EnumToString.toList(genders.values);
          break;
        }
      case "Price":
        {
          filttype = "range";
          filterOpt = rateRangeName;
          break;
        }
      default:
        filterOpt = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    print("guys");
    return Column(
      children: [
        ListTile(
          onTap: () {
            setState(() {
              extend = true;
            });
          },
          contentPadding: EdgeInsets.all(5),
          title: Text(widget.filter),
          trailing: IconButton(
              icon: extend
                  ? Icon(Icons.arrow_drop_up,
                      color: Theme.of(context).primaryColor)
                  : Icon(Icons.arrow_drop_down,
                      color: Theme.of(context).primaryColor),
              onPressed: () {
                setState(() {
                  extend = !extend;
                });
              }),
        ),
        Container(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width / 20),
            child: extend
                ? Column(
                    children: filterOpt.map((e) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                width: MediaQuery.of(context).size.width / 2.5,
                                height: MediaQuery.of(context).size.height / 20,
                                child: Text(e,
                                    style: TextStyle(
                                        fontSize: 15,
                                        color:
                                            Theme.of(context).primaryColor))),
                            Container(
                              width: MediaQuery.of(context).size.width / 10,
                              height: MediaQuery.of(context).size.height / 20,
                              child: Center(
                                child: FutureBuilder(
                                  future: checkFilterStatus(e, filttype),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      print("rr${snapshot.data}");
                                      return CheckBoxClick(
                                          e, filttype, snapshot.data);
                                    } else
                                      return Container();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        ((filterOpt.length - 1) == filterOpt.indexOf(e))
                            ? ((widget.filter == "Availability")
                                ? Column(
                                    children: [
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.5,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              20,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: timingName.map((e) {
                                                return FutureBuilder(
                                                  future: checkFilterStatus(
                                                      e, "time"),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      print(
                                                          "rrs${snapshot.data}");
                                                      return TimingBox(
                                                          e,
                                                          "time",
                                                          snapshot.data);
                                                    } else
                                                      return Container();
                                                  },
                                                );
                                              }).toList())),
                                      SizedBox(
                                        height: 2,
                                      )
                                    ],
                                  )
                                : Container())
                            : Container(
                                color: Theme.of(context).primaryColor,
                                height: 1,
                              )
                      ],
                    );
                  }).toList())
                : Container()),
      ],
    );
  }
}
