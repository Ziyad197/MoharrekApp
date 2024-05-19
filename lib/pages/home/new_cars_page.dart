import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/brand_widget.dart';
import '../../components/dropdown_menu_button.dart';
import '../../components/year_picker.dart';
import '../../widget/home_widget.dart';
import 'controller/carController.dart';
import 'model/car.dart';

class NewCarTabView extends StatefulWidget {
  const NewCarTabView({Key? key}) : super(key: key);

  @override
  _NewCarTabViewState createState() => _NewCarTabViewState();
}

class _NewCarTabViewState extends State<NewCarTabView> {
  final CarController controller = Get.find<CarController>();

  @override
  void initState() {
    super.initState();
    // controller.clearFilters();
  }

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
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.brands.length,
            itemBuilder: (context, index) {
              return InkWell(
                splashColor: Colors.white,
                onTap: () {
                  controller.selectBrand(index);
                },
                child: BrandWidget(controller: controller, index: index, list: controller.brands),
              );
            },
          ),
        ),
        Obx(() {
          return Visibility(
            visible: controller.selectedBrand.value != 0,
            child: Container(
              margin: const EdgeInsets.only(bottom: 30),
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.models[controller.selectedManufacturer!.value]!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    splashColor: Colors.white,
                    onTap: () {
                      controller.selectBrandChild(index);
                    },
                    child: BrandChildWidget(
                      controller: controller,
                      index: index,
                      list: controller.models[controller.selectedManufacturer!.value] ?? ["تويوتا"],
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
        const SizedBox(height: 10),
        SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<List<Car>>(
                stream: controller.getCarsByType(Type.NEW),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
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

                        final bool cityMatch = selectedCity == 'الكل' || element.location == selectedCity;
                        final bool gair = selectedGair == 'الكل' || element.transmissionType == selectedGair;
                        final bool year = selectedYear == 0 || element.year == selectedYear;
                        final bool brandMatch = selectedBrand == 'الكل' || selectedBrand == element.company;
                        final bool modelMatch = selectedMod == 0 || selectedModel == element.model;
                        final bool textMatch = element.model.toLowerCase().contains(searchText) ||
                            element.make.toLowerCase().contains(searchText) ||
                            element.seller.toLowerCase().contains(searchText) ||
                            element.sellerPhone.toLowerCase().contains(searchText) ||
                            element.company.toLowerCase().contains(searchText) ||
                            element.location.toLowerCase().contains(searchText);

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
        ),
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
                  controller.selectGearFilter('الكل');
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: controller.selectedGear.value == 'الكل'
                          ? Colors.blue
                          : Colors.grey,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'الكل',
                    style: TextStyle(
                      color: controller.selectedGear.value == "الكل"
                          ? Colors.blue
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  controller.selectGearFilter('عادي');
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: controller.selectedGear.value == 'عادي'
                          ? Colors.blue
                          : Colors.grey,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'عادي',
                    style: TextStyle(
                      color: controller.selectedGear.value == 'عادي'
                          ? Colors.blue
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.selectGearFilter('أوتوماتيك');
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: controller.selectedGear.value == 'أوتوماتيك'
                        ? Colors.blue
                        : Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'أوتوماتيك',
                  style: TextStyle(
                    color: controller.selectedGear.value == 'أوتوماتيك'
                        ? Colors.blue
                        : Colors.black,
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
