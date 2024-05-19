import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moharrek/components/button.dart';
import 'package:moharrek/pages/home/controller/carController.dart';
import 'package:moharrek/pages/home/model/car.dart';
import 'package:moharrek/widget/home_widget.dart';

class NewCarDetailsPage extends GetWidget<CarController> {
   NewCarDetailsPage({super.key});

  Car car = Get.arguments;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // title: Text('Title'),
          ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          const SizedBox(
            height: 5,
          ),
          NewCarDetailHeder(
              model: car.model,
              make: car.make,
              year: car.year,
              carPrice: car.price,
              carLocation: car.location,
              carImage: List<Widget>.generate(car.images.length, (index) => CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl:car.images[index],
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ))),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 50),
            child: CustomeButtonIcon(
              text: "تواصل مع المعرض",
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
          const SizedBox(
            height: 20,
          ),
          const Text(
            "خصائص السيارة",
            style: TextStyle(
                fontSize: 22, fontFamily: "Rubik", fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 5,
          ),
           NewCarDetailCard(
              model: car.model, make: car.make, year: car.year, isManualGear: car.transmissionType=='عادي'?true:false),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "مقترحة",
            style: TextStyle(
                fontSize: 22, fontFamily: "Rubik", fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 290,
            child:
            StreamBuilder<List<Car>>(
              stream: controller.getCarsByType(car.type),
              builder: (context, snapshot) {
                return snapshot.hasData? ListView.separated(
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 20,
                    );
                  },
                  itemBuilder: (context, index) {

                   return CustomVerticalCarCard(car: snapshot.data![index],);
                  },
                  // shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                ):const Center(child: CircularProgressIndicator());
              }
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
