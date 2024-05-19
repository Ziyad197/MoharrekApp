import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moharrek/app_pages.dart';
import 'package:moharrek/pages/auth/controller/auth_controller.dart';
import 'package:moharrek/pages/profile/my_listing.dart';
import '../home/model/car.dart';

class ProfilePage extends GetWidget<AuthController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      child: ListView(
        children: [
          UnconstrainedBox(
            child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(width: 2, color: Colors.blue),
                    borderRadius: BorderRadius.circular(60)),
                child: const Icon(
                  Icons.person,
                  size: 40,
                  color: Colors.blue,
                )),
          ),
          const SizedBox(
            height: 5,
          ),
          Center(
            child: StreamBuilder(
              builder: (context, snapshot) {
                return  snapshot.hasData?Column(
                  children: [
                    Text(snapshot.data!.userName, style: Theme.of(context).textTheme.titleMedium),
                     const SizedBox(height: 10,),
                    Text(snapshot.data!.admin?'أدمن':'مستخدم', style: Theme.of(context).textTheme.titleMedium),

                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 2,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const MyListingPage()));
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.cases_rounded),
                          SizedBox(
                            width: 10,
                          ),
                          Text("إعلاناتي",
                              style:
                              TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),

                    Visibility(
                      visible: snapshot.data!.admin,
                      child:
                      Column(children: [
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(AppPages.unAvailableCarsPage);
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.local_offer),
                              SizedBox(
                                width: 10,
                              ),
                              Text("عروض المزايدة",
                                  style:
                                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed(AppPages.addCarPage,arguments:Type.USED);
                        },
                        child: const Row(
                          children: [
                            Icon(Icons.add_box_sharp),
                            SizedBox(
                              width: 10,
                            ),
                            Text("إضافة سيارة مستعملة",
                                style:
                                TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],),
                    Visibility(
                      visible: snapshot.data!.admin,
                      child: Column(children: [
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(AppPages.addCarPage,arguments:Type.NEW);
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.add_box_sharp),
                              SizedBox(
                                width: 10,
                              ),
                              Text("إضافة سيارة معرض",
                                  style:
                                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],),
                    ),
                    Visibility(
                      visible: true,
                      child: Column(children: [
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(AppPages.addCarPage,arguments:Type.AUCTION);
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.add_box_sharp),
                              SizedBox(
                                width: 10,
                              ),
                              Text("إضافة سيارة في المزاد",
                                  style:
                                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Row(
                        children: [
                          Icon(Icons.settings),
                          SizedBox(
                            width: 10,
                          ),
                          Text("الإعدادات",
                              style:
                              TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: ()async {
                        await controller.signOut();
                        Get.offAllNamed(AppPages.registerPage);
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.logout_rounded),
                          SizedBox(
                            width: 10,
                          ),
                          Text("تسجيل الخروج",
                              style:
                              TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                ):const Center(child: CircularProgressIndicator());
              },
              stream: controller.getUserDataStream(),
            ),
          ),

        ],
      ),
    ));
  }
}
