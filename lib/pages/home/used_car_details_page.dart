import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moharrek/pages/home/controller/carController.dart';
import 'package:moharrek/pages/home/model/car.dart';
import 'package:moharrek/widget/home_widget.dart';
import 'package:moharrek/components/button.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../widget/zoom_image.dart';

class UsedCarDetailsPage extends GetWidget<CarController> {
  UsedCarDetailsPage({Key? key}) : super(key: key);

  final Car car = Get.arguments;

  String timeAgo = timeago.format(
    DateTime.parse(Get.arguments.addDate).subtract(DateTime.now().difference(DateTime.now().toUtc())),
    locale: 'en',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          const SizedBox(height: 5),
          UsedCarDetailHeder(
            model: car.model,
            make: car.make,
            year: car.year,
            carPrice: car.price,
            carLocation: car.location,
            uploadDate: timeAgo,
            carImage: List<Widget>.generate(
              car.images.length,
                  (index) => ZoomableCachedNetworkImage(imageUrl: car.images[index]),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 50),
            child: CustomeButtonIcon(
              text: "تواصل مع البائع",
              textColor: Colors.white,
              buttonColor: Colors.blue,
              onPressed: () {
                controller.openWhatsAppChat(car.sellerPhone);
              },
              isLoading: false,
              width: 30,
              icon: Icons.call,
              iconColor: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "خصائص السيارة",
            style: TextStyle(fontSize: 22, fontFamily: "Rubik", fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 5),
          UsedCarDetailCard(car: car),
          const SizedBox(height: 20),
          const Text(
            "الوصف",
            style: TextStyle(fontSize: 22, fontFamily: "Rubik", fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 5),
          CarDesc(desc: car.description),
          const SizedBox(height: 20),
          const Text(
            "مقترحة",
            style: TextStyle(fontSize: 22, fontFamily: "Rubik", fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 290,
            child: StreamBuilder<List<Car>>(
              stream: controller.getCarsStream(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? ListView.separated(
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 20);
                  },
                  itemBuilder: (context, index) {
                    final _car = snapshot.data![index];
                    return CustomVerticalCarCard(car: _car);
                  },
                  scrollDirection: Axis.horizontal,
                )
                    : const Center(child: CircularProgressIndicator());
              },
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
