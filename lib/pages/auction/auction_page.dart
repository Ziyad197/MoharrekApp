import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moharrek/pages/home/controller/carController.dart';
import 'package:moharrek/pages/home/model/car.dart';
import 'package:moharrek/widget/auction_widget.dart';

class AuctionPage extends GetWidget<CarController> {
  const AuctionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            // title: Text('المزاد'),
            ),
        body: StreamBuilder<List<Car>>(
          stream: controller.getCarsByType(Type.AUCTION),
          builder: (context, snapshot) {
            return ListView.separated(
              separatorBuilder: (context, index) {
                return const SizedBox(height: 20,);
              },
              itemCount: snapshot.data?.length ??0,
              itemBuilder: (context, index) {
                
                return CustomAuctionCarCard(car: snapshot.data![index]);
              },
              padding: const EdgeInsets.symmetric(horizontal: 30),

            );
          }
        ));
  }
}
