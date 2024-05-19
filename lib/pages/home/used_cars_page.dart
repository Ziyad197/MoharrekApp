import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import '../../components/brand_widget.dart';
import '../../components/dropdown_menu_button.dart';
import '../../components/year_picker.dart';
import '../../widget/home_widget.dart';
import 'controller/carController.dart';
import 'model/car.dart';

class UsedCarTabBarView extends GetWidget<CarController> {
  const UsedCarTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomDropdownMenuButton(
                  hint: 'المدينة',
                  list: controller.cites,
                  onChanged: (city) {
                    controller.selectUsedCity(city);
                  },
                  hintSearch: 'اختر المدينة'),
            ),
            const SizedBox(width: 10,),
            Expanded(
              child: CustomYearPicker(selectedYear: (value) {
                // year = value;
                controller.selectedYear(value);
              }),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: const Text(
            "نوع القير",
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
        ),
        _gearContainer(),
        Container(
          margin: const EdgeInsets.only(bottom: 2),
          child: const Text(
            "الشركات",
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
        ),

        SizedBox(
          height: 40,
          // color: Colors.amber,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.brands.length,
            itemBuilder: (context, index) {
              return InkWell(
                splashColor: Colors.white,
                onTap: () {
                  if(index==0){
                    controller.clearAllData();
                  }
                  controller.selectBrand(index);
                },
                child: BrandWidget(controller: controller,
                    index: index,
                    list: controller.brands),
              );
            },
          ),
        ),
        Obx(() {

          final String selectedBrand =controller.brands[controller.selectedBrand.value==0?1:controller.selectedBrand.value];
          Logger().d(selectedBrand);
          return Visibility(
            visible: controller.selectedBrand.value != 0,
            child: Container(
              margin: const EdgeInsets.only(bottom: 30),
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.models[selectedBrand]!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    splashColor: Colors.white,
                    onTap: () {
                      controller.selectBrandChild(index);
                    },
                    child: BrandChildWidget(
                      controller: controller,
                      index: index,
                      list: controller.models[selectedBrand] ?? ["تويوتا"],
                    ),
                  );
                },
              ),
            ),
          );
        }),
        Container(
          child: const Text(
            "استكشف",
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<List<Car>>(
                stream: controller.getCarsByType(Type.USED),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if(snapshot.data!.isEmpty){
                      return const Center(child: Text("لا توجد سيارات متوفرة"));
                    }
                    return Obx(() {
                      final filteredCars = snapshot.data!.where((element) {
                        final String searchText = controller.searchText!.value.toLowerCase();
                        final String selectedCity = controller.usedSelectedCity.value;
                        final String selectedGair = controller.selectedGear.value;
                        final int selectedYear = controller.selectedYear.value;
                        final int selectedMod = controller.selectedChildBrand.value;
                        final String selectedModel = controller.models[controller.selectedManufacturer!.value]![selectedMod];
                        final String selectedBrand = controller.brands[controller.selectedBrand.value];

                        // Check if the selected city is "الكل" or matches the car's location
                        final bool cityMatch = selectedCity == 'الكل' || element.location == selectedCity;
                        // Check if the selected gear is "الكل" or matches the car's transmission type
                        final bool gair = selectedGair == 'الكل' || element.transmissionType == selectedGair;
                        final bool year = selectedYear == 0 || element.year == selectedYear;

                        // Check if the selected brand is "الكل" or matches the car's brand
                        final bool brandMatch = selectedBrand == 'الكل' || selectedBrand == element.company;

                        // Check if the selected model is "الكل" or matches the car's model
                        final bool modelMatch = selectedMod == 0 || selectedModel == element.model;

                        // Check if the car's details contain the searchText
                        final bool textMatch = element.model.toLowerCase().contains(searchText) ||
                            element.make.toLowerCase().contains(searchText) ||
                            element.seller.toLowerCase().contains(searchText) ||
                            element.sellerPhone.toLowerCase().contains(searchText) ||
                            element.company.toLowerCase().contains(searchText) ||
                            element.location.toLowerCase().contains(searchText);

                        // Return true if all conditions match
                        return cityMatch && brandMatch && modelMatch && textMatch && gair && year;
                      });

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filteredCars.length,
                        itemBuilder: (context, index) {
                          Car car = filteredCars.elementAt(index);

                          return Column(
                            children: [
                              CustomUsedCarCard(car: car),
                              const SizedBox(height: 15),
                            ],
                          );
                        },
                      );
                    });
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ],
          ),
        )


        // BottomNavigationBar(items: items)
      ],
    );
  }

  Widget _gearContainer() {
    return Obx(() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // Handle selection of "الكل"
                  controller.selectGearFilter('الكل');
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: controller.selectedGear.value =='الكل'
                          ? Colors.blue // Selected border color
                          : Colors.grey, // Default border color
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'الكل',
                    style: TextStyle(
                      color: controller.selectedGear.value == "الكل"
                          ? Colors.blue // Selected text color
                          : Colors.black, // Default text color
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  // Handle selection of "عادي"
                  controller.selectGearFilter('عادي');
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: controller.selectedGear.value ==
                          'عادي'
                          ? Colors.blue // Selected border color
                          : Colors.grey, // Default border color
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'عادي',
                    style: TextStyle(
                      color: controller.selectedGear.value ==
                          'عادي'
                          ? Colors.blue // Selected text color
                          : Colors.black, // Default text color
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Handle selection of "أوتوماتيك"
                controller.selectGearFilter('أوتوماتيك');
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: controller.selectedGear.value ==
                        'أوتوماتيك'
                        ? Colors.blue // Selected border color
                        : Colors.grey, // Default border color
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'أوتوماتيك',
                  style: TextStyle(
                    color: controller.selectedGear.value ==
                        'أوتوماتيك'
                        ? Colors.blue // Selected text color
                        : Colors.black, // Default text color
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }


}