import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upcloud/models/filterOptions.dart';
import 'package:upcloud/providers/filterProvider.dart';
import 'package:upcloud/screens/homepage.dart';
import 'package:upcloud/widgets/dropDownWidget.dart';
import 'package:upcloud/controllers/key.dart';

class SideDrawer extends StatefulWidget {
  final VoidCallback toggleMode;
  const SideDrawer({this.toggleMode, Key key}) : super(key: key);
  @override
  SideDrawerState createState() => SideDrawerState();
}

class SideDrawerState extends State<SideDrawer> {
  GlobalKey<SideDrawerState> myKey = GlobalKey();
  // GlobalKey<MyHomePageState> hpk = GlobalKey();

  @override
  Widget build(BuildContext context) {
    setkey = myKey;
    var filterProvider = Provider.of<FilterProvider>(context, listen: false);
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          filterProvider.saveMap();
        },
        backgroundColor: Colors.grey[400],
        child: Icon(
          Icons.check,
          color: Theme.of(context).primaryColor,
        ),
      ),
      body: Drawer(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 20, vertical: 0),
          color: Theme.of(context).backgroundColor,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width / 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.filter_alt,
                    size: 40,
                  ),
                  Text(
                    "Filter",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 40),
                  ),
                  TextButton(
                    child: (Theme.of(context).brightness == Brightness.dark)
                        ? Text("awake")
                        : Text("sleep"),
                    onPressed: () {
                      widget.toggleMode();
                    },
                  )
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 1.2,
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 20),
                child: ListView(
                  children: [
                    DropDownWidget("Availability"),
                    Container(
                      color: Theme.of(context).primaryColor,
                      height: 2,
                    ),
                    DropDownWidget("Gender"),
                    Container(
                      color: Theme.of(context).primaryColor,
                      height: 2,
                    ),
                    DropDownWidget("Price"),
                    Container(
                      color: Theme.of(context).primaryColor,
                      height: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        elevation: 5,
      ),
    );
  }
}
