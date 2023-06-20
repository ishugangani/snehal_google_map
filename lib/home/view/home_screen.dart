import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_map/home/controlller/home_controller.dart';
import 'package:permission_handler/permission_handler.dart';


class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  Homecontroller homecontroller = Get.put(Homecontroller(),);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple.shade400,
          title: Text(
            "Live Location",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () async {
                  var status = await Permission.location;
                  if (await status.isDenied) {
                    await Permission.location.request();
                  }
                },
                style:
                    ElevatedButton.styleFrom(primary: Colors.purple.shade300),
                child: Text("permission"),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  Position position = await Geolocator.getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.high);
                  homecontroller.lat.value = position.latitude;
                  homecontroller.lon.value = position.longitude;
                },
                style:
                    ElevatedButton.styleFrom(primary: Colors.purple.shade300),
                child: Text("Locate"),
              ),
              SizedBox(height: 20),
              Container(
                height: 70,
                width: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.purple.shade50,
                  border: Border.all(width: 1, color: Colors.black),
                ),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Obx(() => Text(
                            "${homecontroller.lat.value}",
                            style: TextStyle(color: Colors.black),
                          )),
                      SizedBox(
                        height: 5,
                      ),
                      Obx(() => Text(
                            "${homecontroller.lon.value}",
                            style: TextStyle(color: Colors.black),
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  List<Placemark> placemarkList =
                      await placemarkFromCoordinates(
                          homecontroller.lat.value, homecontroller.lon.value);
                  homecontroller.placeList.value = placemarkList;
                },
                style:
                    ElevatedButton.styleFrom(primary: Colors.purple.shade300),
                child: Text("Track"),
              ),
              SizedBox(height: 20),
              Container(
                height: 300,
                width: 230,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.purple.shade50,
                  border: Border.all(width: 1, color: Colors.black),
                ),
                child: Obx(() => Center(
                        child: Text(
                      homecontroller.placeList.isEmpty
                          ? " 0"
                          : "${homecontroller.placeList[0]}",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ))),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed('map');
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple.shade300),
                child: Text("Locate me"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
