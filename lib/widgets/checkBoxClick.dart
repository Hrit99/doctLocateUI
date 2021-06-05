import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upcloud/models/filterOptions.dart';
import 'package:upcloud/providers/checkfilterStatus.dart';
import 'package:upcloud/providers/filterProvider.dart';

class CheckBoxClick extends StatefulWidget {
  String filtName;
  String filttype;
  bool st;
  CheckBoxClick(this.filtName, this.filttype, this.st);
  @override
  _CheckBoxClickState createState() => _CheckBoxClickState();
}

class _CheckBoxClickState extends State<CheckBoxClick> {
  bool selected;
  var filterProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected = widget.st;
  }

  @override
  Widget build(BuildContext context) {
    print("cbbbbbb");
    var filterProvider = Provider.of<FilterProvider>(context);
    // var filt = ;
    // print(filt);
    // print(enumFilter[widget.iocat].values[0]);
    // print(sfilt);
    return Checkbox(
        value: selected,
        onChanged: (_) {
          setState(() {
            selected = !selected;
            if (selected) {
              filterProvider.addFilter(widget.filtName, widget.filttype);
            } else {
              filterProvider.delFilter(widget.filtName, widget.filttype);
            }
          });
        });
  }
}
