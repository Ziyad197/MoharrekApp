import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moharrek/app_pages.dart';
import 'package:moharrek/pages/auth/controller/auth_controller.dart';
import 'package:moharrek/components/auth_button.dart';
import 'package:moharrek/components/text_form_field.dart';

class RegisterPage extends GetWidget<AuthController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: controller.formState,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            Container(
              height: 200,
              width: 200,
              child: Image.asset("images/register.jpg"),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text("التسجيل",
                  style: Theme.of(context).textTheme.titleLarge),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                "أدخل رقم الهاتف للمتابعة",
                style: TextStyle(fontSize: 16, color: Colors.grey[500]),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomePhoneNumberTextFormField(
              hint: "5xxxxxxxx",
              myController: controller.phoneNumberController,
              suffixIcon: Container(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "${controller.country.flagEmoji} +${controller.country.phoneCode}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomeAuthButton(
                text: "متابعة",
                color: Colors.blue,
                isLoading: controller.isLoading.value,
                onPressed: ()async {
                  if (controller.formState.currentState!.validate()) {
                    Get.toNamed(AppPages.otpPage,arguments: controller.phoneNumberController.text);
                  }
                }),
          ],
        ),
      ),
    );
  }
}
