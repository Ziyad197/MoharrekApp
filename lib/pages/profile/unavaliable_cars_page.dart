import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moharrek/pages/home/controller/carController.dart';
import 'package:moharrek/pages/home/model/car.dart';

import '../../app_pages.dart';

class UnAvailableCarsPage extends GetWidget<CarController> {
   UnAvailableCarsPage({super.key});

  final Color primaryColor = Colors.teal; // Adjust to your preference
  final Color backgroundColor = Colors.white!; // Adjust to your preference

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: backgroundColor,
      body: StreamBuilder<List<Car>>(
        stream: controller.getCarsUnAvailable(), // Assuming the function exists
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<Car> unavailableCars = snapshot.data ?? [];
          final Color primaryColor = Colors.teal; // Adjust to your preference
          final Color backgroundColor = Colors.white; // Adjust to your preference
          final Color textColor = Colors.black87; // Text color
          final double borderRadius = 16.0; //
          return ListView.builder(
            itemCount: unavailableCars.length,
            itemBuilder: (context, index) {
              final car = unavailableCars[index];
              return Card(
                elevation: 1, // Add some elevation for a subtle shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16), // Adjust corner radius
                ),
                color: Colors.blue[100], // Card background color
                child: ExpansionTile(
                  shape: ShapeBorder.lerp(const StarBorder(), const StarBorder(),0),
                  title: Padding(
                    padding: const EdgeInsets.all(16.0), // Adjust padding
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: car.images.isNotEmpty ? car.images[0] : '',
                            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                            height: 80, // Adjust image height
                            width: 80, // Adjust image width
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                car.model,
                                style: const TextStyle(
                                  fontSize: 18, // Adjust font size
                                  fontWeight: FontWeight.bold, // Adjust font weight
                                  color: Colors.white, // Use primary color for title
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${car.year} - ${car.make}',
                                style: TextStyle(
                                  color: Colors.grey[600], // Consider using a grey shade for subtitle
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  children:  [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Divider(color: Colors.grey), // Optional: Add a divider

                        SizedBox(height: 200,
                        child: PageView.builder(
                          itemCount: car.images.length,
                          itemBuilder: (context, index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: car.images.isNotEmpty ? car.images[index] : '',
                              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                              height: 80, // Adjust image height
                              width: 80, // Adjust image width
                            ),
                          );
                        },),),
                        const SizedBox(height: 9,),
                        // Car make and model (bold for emphasis)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'الشركة:',
                              style: TextStyle(
                                fontSize: 16,
                                color: textColor,
                              ),
                            ),
                            Text(
                              car.make,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Car details (year, transmission, location, etc.)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'الموديل:',
                              style: TextStyle(
                                fontSize: 16,
                                color: textColor,
                              ),
                            ),
                            Text(
                              car.model,
                              style: TextStyle(
                                fontSize: 16,
                                color: textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'سنة الصنع:',
                              style: TextStyle(
                                fontSize: 16,
                                color: textColor,
                              ),
                            ),
                            Text(
                              car.year.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color: textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment:MainAxisAlignment.spaceAround ,
                        children: [
                        const Text('نوع القير'),
                        Text(car.transmissionType=='Manual'?'عادي':'أوتوماتيك',style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),),
                      ],),
                        const SizedBox(height: 8),

                        Row(
                        mainAxisAlignment:MainAxisAlignment.spaceAround ,
                        children: [
                        const Text('المدينة'),
                          Text(
                            car.location.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      ],),
                        const SizedBox(height: 8),

                        Row(
                        mainAxisAlignment:MainAxisAlignment.spaceAround ,
                        children: [
                        const Text('البائع'),
                          Text(
                            car.seller.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],),
                        const SizedBox(height: 8),
                        Row(
                        mainAxisAlignment:MainAxisAlignment.spaceAround ,
                        children: [
                        const Text('الفحص الدوري'),
                        ElevatedButton(onPressed: () {
                          Get.toNamed(AppPages.pdfViewer,arguments: car.uploadDate);
                          //here i have a pdf url from firebase storage car.car.uploadDate so need to open it
                        }, child: const Text('فتح')),

                      ],),
                        Center(
                          child: ElevatedButton(onPressed: () async{
                            await controller.updateAvailable(car.carId, true);
                            Get.snackbar(
                              'نجاح', // Title in Arabic: "Success"
                              'تم تحديث حالة السيارة إلى متاحة', // Message in Arabic: "Car availability updated to available"
                              snackPosition: SnackPosition.TOP, // Display at the bottom
                            );
                            }, child: const Center(child: Text('نشر'))),
                        ),
                    ],)
                  ],
                ),
              );
            },
          );
        },

      ),
    );

  }

}
