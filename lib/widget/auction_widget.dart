import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:moharrek/app_pages.dart';
import 'package:moharrek/components/button.dart';
import 'package:moharrek/pages/auction/car_details_page.dart';
import 'package:moharrek/pages/home/controller/carController.dart';
import 'package:moharrek/pages/home/model/car.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
class CustomAuctionCarCard extends StatelessWidget {
  final Car car;

   CustomAuctionCarCard({super.key, required this.car});

String formattedDate(String dateTime) {
  var format = DateFormat.yMMMd('en_US');
  return format.format(DateTime.parse(dateTime));
}

  var formatter = NumberFormat();
  @override
  Widget build(BuildContext context) {
    car.auctions.sort((a, b) => b.amount.compareTo(a.amount),);
    return InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          // height: 120,
          width: 210,
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
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              height: 150,
              width: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child:  CachedNetworkImage(

                  fit: BoxFit.cover,
                  imageUrl:car.images[0],
                  placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "${car.make} ${car.model} ${car.year}",
              style: const TextStyle(
                  fontSize: 20,
                  fontFamily: "Rubik",
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 5,
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.watch_later_outlined,
                  size: 20,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "ينتهي: ${formattedDate(car.expireDate)}",
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
             Text(
              "وصل السوم:  ${car.auctions.isEmpty?0:car.auctions[0].amount} ر.س",
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            CustomeButton(
                text: "التفاصيل",
                color: Colors.blue,
                height: 0,
                onPressed: () {
                  Get.toNamed(
                    AppPages.auctionDetailsPage,
                    arguments: car,);
                },
                isLoading: false),
            const SizedBox(
              height: 10,
            )
          ]),
        ));
  }
}

class CustomAuctionInfoCard extends StatelessWidget {

  final Stream<Car> stream;
  CustomAuctionInfoCard({super.key,required this.stream});

  var formatter = NumberFormat();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Car>(
      stream: stream,
      builder: (context, snapshot) {
        snapshot.data?.auctions?.sort((a, b) => b.amount.compareTo(a.amount));

        final carController = Get.find<CarController>();
        if (snapshot.data != null && snapshot.data!.auctions.isNotEmpty) {
          carController.limitAuctionPrice(snapshot.data!.auctions[0].amount);
        }

        final highestAmount = snapshot.data?.auctions?.isNotEmpty ?? false ? snapshot.data!.auctions[0].amount : 0;


        final auctions = snapshot.data?.auctions??[];

        Get.find<CarController>().limitAuctionPrice(auctions.isNotEmpty?auctions[0].amount:0);
        return snapshot.hasData?Container(

          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.blue),
              borderRadius: BorderRadius.circular(30)),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("وصل السوم",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text("$highestAmount ر.س",
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(
              height: 10,
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "ينتهي المزاد",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    Text(
                      DateFormat('dd/MM/yyyy hh:mm a').format(
                        DateTime.parse(snapshot.data!.expireDate),
                      ),
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),

                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: TimerCountdown(
                colonsTextStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                descriptionTextStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                format: CountDownTimerFormat.daysHoursMinutesSeconds,
                endTime: DateTime.parse(snapshot.data!.expireDate),
                onEnd: () {
                },
                daysDescription: "أيام",
                hoursDescription: "ساعات",
                minutesDescription: "دقائق",
                secondsDescription: "ثواني",
              ),
            ),

            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("تبدأ المزايدة من",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                Text("${formatter.format(snapshot.data!.price)} ر.س",
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ]),
        ):const Center(child: CircularProgressIndicator());
      }
    );
  }
}

class CustomAuctionCarDetailHeader extends StatefulWidget {
  final String make;
  final String model;
  final int year;
  final List<String> carImages;
  const CustomAuctionCarDetailHeader(
      {super.key,
      required this.make,
      required this.model,
      required this.year,
      required this.carImages});

  @override
  State<CustomAuctionCarDetailHeader> createState() =>
      _CustomAuctionCarDetailHeaderState();
}

class _CustomAuctionCarDetailHeaderState
    extends State<CustomAuctionCarDetailHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        height: 290,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(width: 1, color: Colors.blue),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                // color: Colors.grey,
                height: 190,
                child: Column(
                  children: [
                    SizedBox(
                      height: 160,
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        // reverse: true,
                        onPageChanged: (value) {
                          setState(() {});
                        },
                        itemCount: widget.carImages.length,
                        itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: widget.carImages[index],
                              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          );
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
          
              Text(
                "${widget.make} ${widget.model} ${widget.year}",
                style: const TextStyle(
                    fontSize: 24,
                    fontFamily: "Rubik",
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ));
  }
}
