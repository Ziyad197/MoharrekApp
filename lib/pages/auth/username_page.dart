import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moharrek/components/auth_button.dart';
import 'package:moharrek/components/text_form_field.dart';
import 'package:moharrek/pages/auth/controller/auth_controller.dart';

class UsernamePage extends GetWidget<AuthController> {
  const UsernamePage({super.key});


  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formState = GlobalKey();
    controller.getUsernameByUID();
    return Scaffold(
        appBar: AppBar(),
        body: Form(
          key: formState,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: Image.asset("images/register.jpg"),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text("إنشاء اسم التعريف",
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleSmall),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  "أدخل معرّف خاص بك للمتابعة ",
                  style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomeTextFormField(
                  hint: "أدخل اسمك", myController: controller.username),
              const SizedBox(
                height: 5,
              ),
              Text(
                "ملاحظة: سيكون اسم التعريف مرئي للجميع ",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              Obx(() {
                return CustomeAuthButton(
                    text: "متابعة",
                    color: Colors.blue,
                    isLoading: controller.isLoading.value,
                    onPressed: () async {
                      if (formState.currentState!.validate()) {
                        await controller.updateUsername();
                        // Navigator.of(context).pushAndRemoveUntil(
                        //   MaterialPageRoute(builder: (context) => BottomNavBar()),
                        //   (route) => false,
                        // );
                      }
                    });
              }),
            ],
          ),
        ));
  }
}
