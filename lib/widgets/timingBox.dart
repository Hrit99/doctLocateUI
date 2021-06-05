import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upcloud/providers/filterProvider.dart';

class TimingBox extends StatefulWidget {
  final String time;
  final String filttype;
  bool st;
  TimingBox(this.time, this.filttype, this.st);
  @override
  _TimingBoxState createState() => _TimingBoxState();
}

class _TimingBoxState extends State<TimingBox> {
  bool selected = false;
  var filterProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selected = widget.st;
  }

  @override
  Widget build(BuildContext context) {
    var filterProvider = Provider.of<FilterProvider>(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
          if (selected) {
            filterProvider.addFilter(widget.time, widget.filttype);
          } else {
            filterProvider.delFilter(widget.time, widget.filttype);
          }
        });
      },
      child: Container(
        height: MediaQuery.of(context).size.height / 20,
        width: MediaQuery.of(context).size.width / 6,
        child: Center(
            child: Text(
          widget.time,
          style: TextStyle(
              color: selected
                  ? Theme.of(context).accentColor
                  : Theme.of(context).primaryColor,
              fontSize: 9),
        )),
        decoration: BoxDecoration(
            color: selected
                ? Theme.of(context).primaryColor
                : Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

// GestureDetector(
//       onTap: () {
//         setState(() {
//           selected = !selected;
//         });
//       },
//       child: Container(
// height: MediaQuery.of(context).size.height / 20,
// width: MediaQuery.of(context).size.width / 6,
//         child: Center(
//           child: Text(
//             EnumToString.convertToString(widget.time),
//             style: TextStyle(fontSize: 9),
//           ),
//         ),
//         decoration: BoxDecoration(
//             color: selected ? Colors.grey[200] : Colors.grey[400],
//             borderRadius: BorderRadius.circular(10)),
//       ),
//     );
