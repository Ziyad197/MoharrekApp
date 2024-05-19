


import 'dart:math';

import 'package:get/get.dart';
import 'package:moharrek/pages/home/model/bidding.dart';
import 'package:moharrek/pages/home/model/car.dart';

import '../controller/carController.dart';

class CarBinding extends Bindings {
  @override
  void dependencies() {
    String cardId = 'carId${Random.secure().nextInt(10)}';
    Get.lazyPut(() => CarController());
  }
}