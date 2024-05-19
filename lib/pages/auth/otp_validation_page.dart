import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moharrek/pages/auth/controller/auth_controller.dart';
import 'package:pinput/pinput.dart';

class OTPValidationPage extends GetWidget<AuthController> {
  OTPValidationPage({super.key});

  String number = Get.arguments;
  @override
  Widget build(BuildContext context) {
    controller.signInWithPhoneNumber(number);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.asset("images/otp_val.png"),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "رمز التفعيل",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "الرجاء إدخال رمز التفعيل المرسل إلى هاتفك",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Pinput(
                        length: 6,
                        showCursor: true,
                        onCompleted: (value)async =>
                        {

                          // await FirebaseAuthentication().authenticate(controller.temp,controller.otpController.text)
                          await controller.checkOTP(value)
                          //here shold check from otp and when ok go to UserNamePage
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => const UsernamePage()))
                        },
                        defaultPinTheme: PinTheme(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.blue)),
                            textStyle: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
