
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:moharrek/components/text_form_field.dart';
import 'package:moharrek/components/dropdown_menu_button.dart';
import 'package:moharrek/components/year_picker.dart';
import 'package:moharrek/pages/home/controller/carController.dart';
import 'package:moharrek/shared_pref.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:uuid/uuid.dart';
import '../home/model/car.dart';

class EditCarPage extends GetWidget<CarController> {

  String model = "";
  int year = 2024;
  TextEditingController mileage = TextEditingController();

  final transmissionTypes = ['Automatic', 'Manual'];

  String transmissionType = 'أوتوماتيك';

  String? selectedModel;
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController bisPriceController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  final Car car;


  EditCarPage(this.car, {super.key});

  String getCarType(){
    if(car.type == Type.USED){
      return 'مستخدمة';
    }
    if(car.type == Type.AUCTION){
      return 'مزايدة';
    }
    if(car.type == Type.NEW){
      return 'وكالة';
    }

    return '';
  }
  @override
  Widget build(BuildContext context) {

    mileage.text = '${car.mileage}';
    controller.selectedCity(car.location);
    bisPriceController.text = ('${car.bidPrice}');
    priceController.text = ('${car.price}');
    descriptionController.text = (car.description);
    controller.addedImageList.value = car.images;
    controller.expireDate(DateTime.parse(car.expireDate));
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          "تعديل مركبة (${getCarType()})",
          style: const TextStyle(fontSize: 24),
        ),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          children: [
            CustomDropdownMenuButton(
                hint: "اختر الشركة",
                hintSearch: "ابحث عن الشركة...",
                list: controller.manufacturers,
                selectedValue: car.company,
                onChanged: (value) {
                  car.company = value;
                  selectedModel = null;
                  // setState(() {});
                }),
            const SizedBox(height: 20),

          CustomDropdownMenuButton(
                  hint: "اختر المودل",
                  hintSearch: "ابحث عن المودل...",
                  list: controller.models[car.company] ?? ['تويوتا'],
                  selectedValue: car.model,
                  onChanged: (value) {
                    car.model = value;
                    // setState(() {});
                  }),
            const SizedBox(height: 20),
            // Text("اختر سنة التصنيع"),
            CustomYearPicker(
                selectedValue:  car.year,
                selectedYear: (value) {
              year = year;
            }),
            const SizedBox(height: 30),

            CustomNumberTextFormField(
                hint: "أدخل مقدار الممشى...",
                prefixIcon:
                Container(
                    padding: const EdgeInsets.all(13), child: const Text("km")),
                myController: mileage),
            const SizedBox(height: 20),
            const Text("حدد نظام القير"),
            const SizedBox(height: 5),
            ToggleSwitch(
              initialLabelIndex: car.transmissionType=='أوتوماتيك'?0:1,
              animate: true,
              animationDuration: 400,
              curve: Easing.legacy,
              minWidth: double.infinity,
              customWidths: const [double.infinity, double.infinity],
              dividerColor: Colors.white,
              inactiveBgColor: Colors.white,
              borderColor: const [Colors.blue],
              borderWidth: 1,
              cornerRadius: 0,
              totalSwitches: 2,
              activeBgColor: const [Colors.blue],
              labels: ['أوتوماتيك', 'عادي'],
              onToggle: (index) {
                Logger().d(index);
                transmissionType = transmissionTypes[index!];
              },
            ),
            const SizedBox(height: 25),

            InkWell(
              onTap: () {
                controller.addImage();
              },
              child: DottedBorder(
                color: Colors.blue,
                strokeWidth: 1,
                child: Obx(() {
                  return Container(
                      decoration: BoxDecoration(
                        color: controller.addedImageList.value.isEmpty
                            ? Colors.grey[200]
                            : Colors.blue[200],
                      ),
                      height: 100,
                      width: double.infinity,
                      child: controller.addedImageList.value.isEmpty
                          ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_outlined,
                            size: 25,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "ارفع صورة أو أكثر للمركبة",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      )
                          : controller.imageList.value.isNotEmpty?
                      ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.imageList.value.length,
                        itemBuilder: (context, index) {
                          return Image.file(
                            controller.imageList.value[index],
                            height: 100,
                            width: 100,
                          );
                        },
                      )
                          :
                      ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.addedImageList.value.length,
                        itemBuilder: (context, index) {
                          return Image.network(
                            controller.addedImageList.value[index],
                            height: 100,
                            width: 100,
                          );
                        },
                      ));
                }),
              ),
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: InkWell(
                onTap: () {
                  controller.addPDFFile();
                },
                child: DottedBorder(
                  color: Colors.blue,
                  strokeWidth: 1,
                  child: Container(
                      decoration: BoxDecoration(
                        color: car.addDate
                            .isEmpty
                            ? Colors.grey[200]
                            : Colors.blue[200],
                      ),
                      height: 80,
                      width: double.infinity,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.file_copy_outlined,
                            size: 25,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "ارفع ملف الفحص الدوري للمركبة",
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ))

                ),
              ),
            ),
            const SizedBox(height: 25),
            Visibility(
              visible: car.type == Type.AUCTION?true:false,
              child: Column(
                children: [
                  CustomTextField(
                    isEnable: car.type==Type.AUCTION?true:false,
                    isValidate: car.type==Type.AUCTION?true:false,
                    inputType: TextInputType.number,
                    maxLines: 1,
                      maxLength: 10,
                      hint: "${car.type == Type.AUCTION?'الزيادة في السوم':'السعر'} (إلزامي)",
                      controller: bisPriceController),

                ],
              ),
            ),
            Visibility(
              visible: car.type == Type.AUCTION ? true : false,
              child: Obx(() {
                return Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        // Handle date and time picker selection
                        final DateTime? selectedDateTime = await DatePicker
                            .showDateTimePicker(
                          showTitleActions: true,
                          onConfirm: (time) {
                            controller.expireDate!.value = time;
                          },
                          context,
                          // This argument is missing in your original code
                          currentTime: DateTime.now(),
                          locale: LocaleType.ar,
                          // Set locale to Arabic
                          maxTime: DateTime.now().add(const Duration(days: 10)),
                          minTime: DateTime.now(),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black)
                        ),
                        child: Center(
                            child: Column(
                              children: [
                                const Text('اختر تاريخ ووقت انتهاء المزاد'),
                                Text(DateFormat('yyyy-MM-dd hh:mm a').format(controller.expireDate!.value)
                                ),
                              ],
                            )
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),

            const SizedBox(height: 20),
            Column(
              children: [
                CustomTextField(
                  isEnable:  true,
                  isValidate: true,
                  inputType: TextInputType.number,
                  maxLines: 1,
                    maxLength: 10,
                    hint: "${car.type == Type.AUCTION?'بداية السوم':'السعر'} (إلزامي)", controller: priceController),

              ],
            ),
            CustomTextField(
              isEnable: true,
              isValidate: false,
              inputType: TextInputType.text,
              maxLength: 100,
                maxLines: 3,
                hint: "الوصف (اختياري)", controller: descriptionController),
            const SizedBox(height: 20),


            CustomDropdownMenuButton(
                hint:'اختر المدينة',
                list: controller.cites,
                selectedValue:  car.location,
                onChanged: (city){
                  controller.selectedCity(city);
                },
                hintSearch: 'ابحث عن مدينتك'),


            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                if (!formKey.currentState!.validate()) {
                  return;
                }

                if (controller.imageList.value.isEmpty&& car.images.isEmpty) {
                  AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      title: 'خطأ',
                      desc: 'يجب رفع صورة واحدة على الأقل',
                      titleTextStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      descTextStyle: const TextStyle(fontSize: 14),
                      btnOkColor: Colors.blue,
                      btnOkText: "إغلاق",
                      btnOkOnPress: () {})
                      .show();
                  return;
                }
                if (controller.periodicInspection == null) {
                  AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      animType: AnimType.rightSlide,
                      title: 'خطأ',
                      desc: 'يجب رفع ملف الفحص الدوري',
                      titleTextStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                      descTextStyle: const TextStyle(fontSize: 14),
                      btnOkColor: Colors.blue,
                      btnOkText: "إغلاق",
                      btnOkOnPress: () {})
                      .show();
                  return;
                }
                AwesomeDialog(
                    context: context,
                    dialogType: DialogType.warning,
                    animType: AnimType.rightSlide,
                    title: 'تنبيه',
                    desc: 'رجاء تأكد من عدم وجود أي معلومات خاطئة.',
                    titleTextStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    descTextStyle: const TextStyle(fontSize: 14),
                    btnOkColor: Colors.blue,
                    btnOkText: "استمرار",
                    btnCancelText: "إلغاء",
                    btnOkOnPress: () async {
                      Car editedCar = Car(
                        bidPrice: bisPriceController.text.isEmpty?0:double.parse(bisPriceController.text),
                        carId: car.carId,
                        model:car.model,
                        paidBy: car.paidBy,
                        make: controller.selectedManufacturer!.value,
                        year: year,
                        paid: false,
                        available: false,
                        seller: Preference.shared.getUserName()!,
                        sellerId: Preference.shared.getUserId()!,
                        sellerPhone: Preference.shared.getUserPhone()!,
                        type: car.type,
                        price: double.parse(priceController.text.trim()),
                        location: controller.selectedCity.value,
                        mileage:int.parse(mileage.text),
                        uploadDate: car.uploadDate,
                        expireDate:car.expireDate,
                        addDate: car.addDate,
                        transmissionType: transmissionType,
                        description: descriptionController.text.trim(),
                        company: car.company,
                        images: car.images,
                        // Example
                        auctions: car.auctions, // Example
                      );
                      await controller.updateCar(editedCar);
                      Get.back();
                      Get.snackbar(
                          "تمت تحديث السيارة!",
                          "تمت تحديث سيارتك بنجاح.",
                          snackPosition: SnackPosition.TOP);

                    },
                    btnCancelOnPress: () {})
                    .show();
              },
              child: Obx(() {
                return controller.isLoading.isTrue?const Center(child: CircularProgressIndicator()):Text(
                  controller.isLoading.isTrue
                      ? '${controller.currentOp}'
                      : 'نحديث',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
