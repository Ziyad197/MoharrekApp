import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomeTextFormField extends StatelessWidget {
  final String hint;
  final TextEditingController myController;
  const CustomeTextFormField(
      {super.key, required this.hint, required this.myController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      cursorColor: Colors.blue,
      validator: (value) {
        if (value == "") {
          return "رجاء املأ الحقل";
        }
      },
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          hintText: hint,
          hintStyle: TextStyle(
              color: Colors.grey[500],
              fontSize: 16,
              fontWeight: FontWeight.normal),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)))),
    );
  }
}

class CustomTextField extends StatefulWidget {
  final String hint;
  final int maxLines;
  final bool isValidate;
  final bool isEnable;
  final TextInputType inputType;
  final int maxLength;
  final TextEditingController controller; // Added for state management

  const CustomTextField({super.key, required this.hint, required this.controller, required this.maxLines, required this.maxLength, required this.inputType, required this.isValidate, required this.isEnable});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
   // Use controller inside State


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if(value!.isEmpty && widget.isValidate){
          return 'حقل أجباري';
        }
      },
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      enabled: widget.isEnable,
      cursorColor: Colors.blue,
      keyboardType: widget.inputType,
      controller: widget.controller, // Use the stateful controller
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        hintText: widget.hint,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   widget.controller.dispose();
  //   super.dispose();
  // }
}

class CustomePhoneNumberTextFormField extends StatefulWidget {
  final String hint;
  final TextEditingController myController;
  final Widget suffixIcon;
  const CustomePhoneNumberTextFormField(
      {super.key,
      required this.hint,
      required this.myController,
      required this.suffixIcon});

  @override
  State<CustomePhoneNumberTextFormField> createState() =>
      _CustomePhoneNumberTextFormFieldState();
}


class _CustomePhoneNumberTextFormFieldState
    extends State<CustomePhoneNumberTextFormField> {

  @override
  void dispose() {
    super.dispose();
    widget.myController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType: TextInputType.number,
        cursorColor: Colors.blue,
        textAlign: TextAlign.left,
        controller: widget.myController,
        onChanged: (value) => setState(() {}),
        validator: (value) {
          if (value == "") {
            return "الرجاء إدخال رقم الهاتف";
          }
          if (value!.length != 9) {
            return "يجب أن يكون الرقم من 9 خانات";
          }
          final n = num.tryParse(value);
          if (n == null) {
            return 'رقم غير صالح';
          }
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            hintText: widget.hint,
            hintStyle: TextStyle(
                color: Colors.grey[500],
                fontSize: 18,
                fontWeight: FontWeight.normal),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            suffixIcon: widget.suffixIcon,
            prefix: widget.myController.text.length == 9
                ? Container(
                    // padding: EdgeInsets.all(10),
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.green),
                    child: const Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 15,
                    ),
                  )
                : null));
  }
}

class CustomNumberTextFormField extends StatefulWidget {
  final String hint;
  final TextEditingController myController;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? numLimit;
  final String? errorLimitText;
  const CustomNumberTextFormField(
      {super.key,
      required this.hint,
      required this.myController,
      this.suffixIcon,
      this.prefixIcon,
      this.numLimit,
      this.errorLimitText});

  @override
  State<CustomNumberTextFormField> createState() =>
      _CustomNumberTextFormFieldState();
}

class _CustomNumberTextFormFieldState extends State<CustomNumberTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        keyboardType: TextInputType.number,
        cursorColor: Colors.blue,
        // textAlign: TextAlign.left,
        controller: widget.myController,
        onChanged: (value) => setState(() {}),
        validator: (value) {
          if (value == "") {
            return "الحقل فارغ";
          }
          final n = num.tryParse(value!);
          if (n == null) {
            return 'رقم غير صالح';
          }
          if (widget.numLimit != null) {
            if (double.parse(value) < widget.numLimit!) {
              return widget.errorLimitText;
            }
          }
          return null;
        },
        decoration: InputDecoration(
          suffixIcon: widget.suffixIcon ?? null,
          prefixIcon: widget.prefixIcon ?? null,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          hintText: widget.hint,
          hintStyle: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
              fontWeight: FontWeight.normal),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.all(Radius.circular(40))),
          // suffixIcon: widget.suffixIcon,
        ));
  }
}

