import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_map/home/view/map_screen.dart';

import 'home/view/home_screen.dart';

void main()
{
  runApp(
      GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: 'map',
        routes: {
          '/':(p0) => home(),
          'map':(p0) => MapScreen(),
        },
      )
  );
}