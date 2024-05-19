import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moharrek/app_pages.dart';
import 'package:moharrek/pages/home/used_cars_page.dart';
import 'package:moharrek/pages/home/new_cars_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController carController = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
          title: CupertinoSearchTextField(
            backgroundColor: Colors.white,
            placeholder: "بحث...",
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
            onChanged: (value) {
              carController.searchText.value = value;
            },
          ),
          backgroundColor: Colors.blue,
          bottom: TabBar(
            controller: carController.tabController,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            indicatorWeight: 4,
            unselectedLabelColor: Colors.black,
            labelColor: Colors.white,
            labelStyle: const TextStyle(
              fontSize: 16,
              fontFamily: "NotoKufiArabic",
              fontWeight: FontWeight.bold,
            ),
            tabs: const [
              Tab(text: "أفراد"),
              Tab(text: "معارض"),
            ],
          )),
      body: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: TabBarView(
          controller: carController.tabController,
          children: const [
            UsedCarTabBarView(),
            NewCarTabView()
          ],
        ),
      ),
    );
  }
}

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  late TabController tabController;
  var searchText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
