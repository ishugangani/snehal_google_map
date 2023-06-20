import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';

class Homecontroller extends GetxController
{
  RxDouble lat = 0.0.obs;
  RxDouble lon = 0.0.obs;
  RxList<Placemark> placeList = <Placemark>[].obs;

}