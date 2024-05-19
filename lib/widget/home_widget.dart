import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:moharrek/app_pages.dart';
import 'package:moharrek/components/button.dart';
import 'package:moharrek/pages/home/controller/carController.dart';
import 'package:moharrek/pages/home/model/car.dart';
import 'package:moharrek/pages/home/new_car_details_page.dart';
import 'package:moharrek/pages/home/used_car_details_page.dart';
import 'package:moharrek/pages/profile/edit_car_page.dart';
import 'package:timeago/timeago.dart' as timeago;
class CarPrimarySpecific extends StatelessWidget {
  final String text;
  final String image;
  final double? imageWidth;
  final double? imageHeight;
  const CarPrimarySpecific(
      {super.key,
      required this.text,
      required this.image,
      this.imageHeight,
      this.imageWidth});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          image,
          width: imageHeight ?? 25,
          height: imageWidth ?? 25,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: const TextStyle(
              fontSize: 12,
              fontFamily: "NotoNaskhArabic",
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class CustomUsedCarCard extends StatefulWidget {
  final Car car;
  const CustomUsedCarCard(
      {super.key,
      required this.car});

  @override
  State<CustomUsedCarCard> createState() => _CustomUsedCarCardState();
}

class _CustomUsedCarCardState extends State<CustomUsedCarCard> {
  var formatter = NumberFormat();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

        Get.toNamed(AppPages.usedCarDetailsPage,arguments:widget.car);
        },
      child: Container(
          height: 140,
          // color: Colors.grey[200],
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 1, color: Colors.blue),
              // shape: BoxShape.circle,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 3),
                width: 120,
                height: double.infinity,
                // color: Colors.red,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: widget.car.images[0],
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  // width: 200,
                  // color: Colors.amber,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          margin: const EdgeInsets.only(right: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${widget.car.make} ${widget.car.model}",
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Rubik",
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                " سنة الصنع: ${widget.car.year}",
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Rubik",
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "البائع : ${widget.car.seller}",
                                style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Rubik",
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CarPrimarySpecific(
                                image: "images/car_card/dollar.png",
                                text: formatter.format(widget.car.price),
                              ),
                              CarPrimarySpecific(
                                image: "images/car_card/location.png",
                                text: widget.car.location,
                              ),
                              CarPrimarySpecific(
                                image: "images/car_card/speedometer.png",
                                text: "${widget.car.mileage}",
                              ),
                              const CarPrimarySpecific(
                                image: "images/car_card/upload.png",
                                text: "Pdf",
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

class CustomNewCarCard extends StatefulWidget {
  final Car car;
  const CustomNewCarCard(
      {super.key,
      required this.car});

  @override
  State<CustomNewCarCard> createState() => _CustomNewCarCardState();
}

class _CustomNewCarCardState extends State<CustomNewCarCard> {
  var formatter = NumberFormat('#,##,000');

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.toNamed(AppPages.newCarDetailsPage,arguments: widget.car);
          // Navigator.of(context).push(
          //     MaterialPageRoute(builder: (context) => const NewCarDetailsPage()));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          // height: 120,
          // width: 210,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)),
          child: Column(children: [
            Container(
              margin: const EdgeInsets.only(
                top: 15,
                left: 10,
                right: 10,
              ),
              // alignment: Alignment.topCenter,
              color: Colors.white,
              height: 150,
              width: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: widget.car.images[0],
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "${widget.car.make} ${widget.car.model} ${widget.car.year}",
              style: const TextStyle(
                  fontSize: 20,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              " ${formatter.format(widget.car.price)} ر.س",
              style: const TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 17, 138, 17),
                  // fontFamily: "Rubik",
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.location_pin),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  widget.car.location,
                  style: const TextStyle(
                      fontSize: 16,
                      fontFamily: "Rubik",
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            )
          ]),
        ));
  }
}

class MyListingCarCard extends GetWidget<CarController> {


  final Car car;

  const MyListingCarCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    DateTime uploadDateTime = DateTime.parse(car.addDate);

    // Calculate the time ago
    String timeAgo = timeago.format(
      uploadDateTime.subtract(DateTime.now().difference(DateTime.now().toUtc())),
      locale: 'en', // Use 'en_short' for short time ago format
    );
    return Container(
        height: 140,
        // color: Colors.grey[200],
        decoration: BoxDecoration(
            color: Colors.blue[100],
            // shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10,top: 10,right: 10),
              width: 120,
              height: double.infinity,
              // color: Colors.red,
              child:ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: car.images[0],
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Expanded(
              child: Container(
                // color: Colors.amber,

                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),

                // width: 200,
                // color: Colors.amber,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(right: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    car.model,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: "Rubik",
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    " السنة: ${car.year}",
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontFamily: "Rubik",
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.warning,
                                animType: AnimType.rightSlide,
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                title: 'حذف',
                                desc: "هل أنت متأكد من حذف هذا الإعلان؟",
                                titleTextStyle: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                descTextStyle: const TextStyle(fontSize: 14),
                                btnOkColor: Colors.blue,
                                btnOkText: "استمرار",
                                btnCancelText: "إلغاء",
                                btnOkOnPress: () async{
                                  await controller.deleteCar(car.carId);
                                },
                                btnCancelOnPress: () {},
                              ).show();
                            },
                            icon: const Icon(Icons.delete),
                          ),
                          IconButton(
                            onPressed: () {
                              Get.to(EditCarPage(car));
                            },
                            icon: const Icon(Icons.edit),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CarPrimarySpecific(
                            image: "images/car_card/upload.png",
                            text: timeAgo,
                            imageHeight: 25,
                            imageWidth: 25,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class CustomVerticalCarCard extends StatelessWidget {
  final Car car;
  const CustomVerticalCarCard(
      {super.key,
      required this.car});

  @override
  Widget build(BuildContext context) {
    String timeAgo = timeago.format(
      DateTime.parse(car.addDate).subtract(DateTime.now().difference(DateTime.now().toUtc())),
      locale: 'en', // Use 'en_short' for short time ago format
    );
    return InkWell(
        onTap: () {

            // Get.to(UsedCarDetailsPage(),arguments: car);
            //
          if(car.type == Type.NEW){
            Get.to(NewCarDetailsPage(),arguments: car);
          }else{
            Get.to(UsedCarDetailsPage(),arguments: car);

          }
            // Get.toNamed(car.type==Type.NEW?AppPages.newCarDetailsPage:AppPages.usedCarDetailsPage,arguments: car);

        },
        child: Container(
          // height: 120,
          width: 210,
          decoration: BoxDecoration(
              color: Colors.blue[500], borderRadius: BorderRadius.circular(20)),
          child: Column(children: [
            Container(
              margin: const EdgeInsets.only(
                top: 15,
                left: 10,
                right: 10,
              ),
              // alignment: Alignment.topCenter,
              color: Colors.grey[200],
              height: 100,
              width: 150,
              child:CachedNetworkImage(
                filterQuality: FilterQuality.low,
                fit: BoxFit.cover,
                imageUrl: car.images[0],
                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "${car.make} ${car.model}",
              style: const TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              width: 50,
              height: 18,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  borderRadius: BorderRadius.circular(7)),
              child: Center(
                child: car.type==Type.NEW.name
                    ? const Text("جديد",
                        style: TextStyle(
                            fontSize: 10,
                            fontFamily: "Rubik",
                            fontWeight: FontWeight.bold))
                    :  Text(car.type==Type.NEW?'جديد':'مستعمل',
                        style: const TextStyle(
                            fontSize: 10,
                            fontFamily: "Rubik",
                            fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              " السنة: ${car.year}",
              style: const TextStyle(
                  fontSize: 12,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "البائع : ${car.seller}",
              style: const TextStyle(
                  fontSize: 12,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CarPrimarySpecific(
                  image: "images/car_card/dollar.png",
                  text: "${car.price}",
                  imageHeight: 25,
                  imageWidth: 25,
                ),
                CarPrimarySpecific(
                  image: "images/car_card/location.png",
                  text: car.location,
                  imageHeight: 25,
                  imageWidth: 25,
                ),
                CarPrimarySpecific(
                  image: "images/car_card/speedometer.png",
                  text: "${car.mileage}",
                  imageHeight: 25,
                  imageWidth: 25,
                ),
                CarPrimarySpecific(
                  image: "images/car_card/upload.png",
                  text: timeAgo,
                  imageHeight: 25,
                  imageWidth: 25,
                ),
              ],
            )
          ]),
        ));
  }
}

class UsedCarDetailHeder extends StatefulWidget {
  final String model;
  final String make;
  final int year;
  final double carPrice;
  final String carLocation;
  final String uploadDate;
  final List<Widget> carImage;
  const UsedCarDetailHeder(
      {super.key,
      required this.model,
      required this.make,
      required this.year,
      required this.carPrice,
      required this.carLocation,
      required this.uploadDate,
      required this.carImage});

  @override
  State<UsedCarDetailHeder> createState() => _UsedCarDetailHederState();
}

class _UsedCarDetailHederState extends State<UsedCarDetailHeder> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        height: 370,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          // color: Colors.blue[300]
          border: Border.all(width: 1, color: Colors.blue),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              // color: Colors.grey,
              height: 200,
              child: Column(
                children: [
                  Container(
                    height: 180,
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      // reverse: true,
                      onPageChanged: (value) {
                        setState(() {});
                      },
                      itemCount: widget.carImage.length,
                      itemBuilder: (context, index) {
                        return widget.carImage[index];
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    "لرؤية المزيد من الصور اسحب لليمين",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontFamily: "Rubik",
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   height: 5,
            // ),

            Column(
              children: [
                Text(
                  "${widget.make} ${widget.model} ${widget.year}",
                  style: const TextStyle(
                      fontSize: 26,
                      fontFamily: "Rubik",
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "${widget.carPrice} ريال سعودي",
                  style: const TextStyle(
                      fontSize: 18,
                      fontFamily: "Rubik",
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "images/clock.png",
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.uploadDate,
                      style: const TextStyle(
                          fontSize: 18,
                          fontFamily: "Rubik",
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.location_pin),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.carLocation,
                      style: const TextStyle(
                          fontSize: 18,
                          fontFamily: "Rubik",
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            )
          ],
        ));
  }
}

class NewCarDetailHeder extends StatefulWidget {
  final String model;
  final String make;
  final int year;
  final double carPrice;
  final String carLocation;
  final List<Widget> carImage;
  const NewCarDetailHeder(
      {super.key,
      required this.model,
      required this.make,
      required this.year,
      required this.carPrice,
      required this.carLocation,
      required this.carImage});

  @override
  State<NewCarDetailHeder> createState() => _NewCarDetailHederState();
}

class _NewCarDetailHederState extends State<NewCarDetailHeder> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        height: 370,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(width: 1, color: Colors.blue),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 200,
              child: Column(
                children: [
                  Container(
                    height: 180,
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      // reverse: true,
                      onPageChanged: (value) {
                        setState(() {});
                      },
                      itemCount: widget.carImage.length,
                      itemBuilder: (context, index) {
                        return widget.carImage[index];
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    "لرؤية المزيد من الصور اسحب لليمين",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontFamily: "Rubik",
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(
                  "${widget.make} ${widget.model} ${widget.year}",
                  style: const TextStyle(
                      fontSize: 26,
                      fontFamily: "Rubik",
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "${widget.carPrice} ريال سعودي",
                  style: const TextStyle(
                      fontSize: 18,
                      fontFamily: "Rubik",
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.location_pin),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  widget.carLocation,
                  style: const TextStyle(
                      fontSize: 18,
                      fontFamily: "Rubik",
                      fontWeight: FontWeight.w500),
                ),
              ],
            )
          ],
        ));
  }
}

class UsedCarDetailCard extends StatefulWidget {
  final Car car;

  const UsedCarDetailCard(
      {super.key,
      required this.car});

  @override
  State<UsedCarDetailCard> createState() => _UsedCarDetailCardState();
}

class _UsedCarDetailCardState extends State<UsedCarDetailCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      height: 350,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.blue),
        borderRadius: BorderRadius.circular(30),
        // color: Colors.grey[300]
      ),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "الطراز",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
            Text(
              widget.car.model,
              style: const TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "الشركة المصنعة",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
            Text(
              widget.car.make,
              style: const TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "سنة التصنيع",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
            Text(
              "${widget.car.year}",
              style: const TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "الممشى",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
            Text(
              "${widget.car.mileage}km",
              style: const TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "القير",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
            Text(
              widget.car.transmissionType=='أوتوماتيك'? "اوتوماتيك" : "عادي",
              style: const TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "وثيقة الفحص الدوري",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
            IconButton(
              onPressed: () {
                Get.toNamed(AppPages.pdfViewer,arguments: widget.car.uploadDate);
              },
              color: Colors.blue,
              icon: const Icon(Icons.file_open_outlined),
            )
          ],
        ),
      ]),
    );
  }
}

class NewCarDetailCard extends StatefulWidget {
  final String model;
  final String make;
  final int year;
  final bool isManualGear;
  const NewCarDetailCard(
      {super.key,
      required this.model,
      required this.make,
      required this.year,
      required this.isManualGear});

  @override
  State<NewCarDetailCard> createState() => _NewCarDetailCardState();
}

class _NewCarDetailCardState extends State<NewCarDetailCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      height: 300,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.blue),
        borderRadius: BorderRadius.circular(30),
        // color: Colors.grey[300]
      ),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "الطراز",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
            Text(
              widget.model,
              style: const TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "الشركة المصنعة",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
            Text(
              widget.make,
              style: const TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "سنة التصنيع",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
            Text(
              "${widget.year}",
              style: const TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "القير",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
            Text(
              widget.isManualGear ? "عادي" : "اوتوماتيك",
              style: const TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "وثيقة الفحص الدوري",
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
            IconButton(
              onPressed: () {},
              color: Colors.blue,
              icon: const Icon(Icons.file_open_outlined),
            )
          ],
        ),
      ]),
    );
  }
}

class CarDesc extends StatelessWidget {
  final String desc;
  const CarDesc({super.key, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30), color: Colors.grey[300]),
      child: Text(
        desc,
        style: const TextStyle(
            fontSize: 16, fontFamily: "Rubik", fontWeight: FontWeight.w500),
      ),
    );
  }
}
