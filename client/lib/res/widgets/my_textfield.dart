import 'package:do_an_2/res/values/color_extension.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String hintText;
  final String icon;
  final Widget? rigtIcon;
  final bool obscureText;
  final EdgeInsets? margin;
  const MyTextField(
      {super.key,
      required this.hintText,
      this.icon = 'none',
      this.controller,
      this.margin,
      this.keyboardType,
      this.obscureText = false,
      this.rigtIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
          color: AppColor.lightGray, borderRadius: BorderRadius.circular(15)),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            hintText: hintText,
            suffixIcon: rigtIcon,
            prefixIcon: icon != 'none'
                ? Container(
                    alignment: Alignment.center,
                    width: 20,
                    height: 20,
                    child: Image.asset(
                      icon,
                      width: 20,
                      height: 20,
                      fit: BoxFit.contain,
                      color: AppColor.gray,
                    ))
                : null,
            hintStyle: TextStyle(color: AppColor.gray, fontSize: 14)),
      ),
    );
  }
}
