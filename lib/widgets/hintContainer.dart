import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:upcloud/controllers/carouselcontroller.dart';
import 'package:upcloud/controllers/mapController.dart';
import 'package:upcloud/providers/hintProvider.dart';
import 'package:upcloud/widgets/upFilterBar.dart';

class HintContainer extends StatelessWidget {
  final GlobalKey<UpFilterBarState> upfk = GlobalKey();
  final VoidCallback onCloseSelected;
  HintContainer(this.onCloseSelected);
  @override
  Widget build(BuildContext context) {
    var hp = Provider.of<HintProvider>(context);
    print("jjj");
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: ListView.separated(
          itemBuilder: (context, index) {
            return (index == hp.hintl.length)
                ? ListTile(
                    tileColor: Theme.of(context).backgroundColor,
                    onTap: () {
                      onCloseSelected();
                    },
                    title: Container(
                        child: Center(
                            child: Icon(Icons.arrow_drop_up,
                                color: Theme.of(context).primaryColor))))
                : ListTile(
                    onTap: () {
                      outmcontroller.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                              target: LatLng(
                                  hp.hintl[index].lat, hp.hintl[index].long),
                              zoom: 14.4678),
                        ),
                      );
                      carouselController.animateToPage(index,
                          duration: Duration(seconds: 1),
                          curve: Curves.easeInOut);
                    },
                    leading: Container(
                      height: (MediaQuery.of(context).size.width / 10),
                      width: (MediaQuery.of(context).size.width / 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey[400]),
                      child: Image.asset(hp.hintl[index].photo),
                    ),
                    trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.thumb_up),
                          Text(hp.hintl[index].likes.toString()),
                        ]),
                    tileColor: Theme.of(context).backgroundColor,
                    title: Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(hp.hintl[index].name,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                            Text(hp.hintl[index].speciality,
                                style: TextStyle(fontSize: 10)),
                          ],
                        ),
                        Text(
                            "~ ${double.parse((hp.hintl[index].distFrom / 1000).toStringAsFixed(2))} Km ~",
                            style: TextStyle(
                                color: Colors.green[300],
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                      ],
                    )),
                  );
          },
          separatorBuilder: (context, index) {
            return Container(
              color: Colors.grey[400],
              height: 1,
            );
          },
          itemCount: hp.hintl.length + 1),
    );
  }
}
