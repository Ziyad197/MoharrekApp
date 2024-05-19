import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moharrek/app_pages.dart';
import 'package:moharrek/pages/home/controller/carController.dart';
import 'package:moharrek/widget/home_widget.dart';

import '../home/model/car.dart';

class MyListingPage extends GetWidget<CarController> {
  const MyListingPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "إعلاناتي",
            style: TextStyle(fontSize: 24),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 30),
          child: StreamBuilder<List<Car>>(
            stream: controller.getMyCarsStream(),
            builder: (context, snapshot) {
              return snapshot.hasData?ListView.separated(
                itemBuilder: (context, index) {
                  return MyListingCarCard(
                      car: snapshot.data![index],);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 20,
                  );
                }, itemCount: snapshot.data!.length,
              ):const Center(child: CircularProgressIndicator());
            }
          ),
        ));
  }
}
