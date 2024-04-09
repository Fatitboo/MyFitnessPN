import 'package:do_an_2/res/values/color_extension.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String hintText;
  final String icon;
  final bool isPass;

  final EdgeInsets? margin;
  final bool checkBlank;
  final bool checkEmail;
  final int checkLength;
  const MyTextField(
      {super.key,
      required this.hintText,
      this.icon = 'none',
      this.controller,
      this.margin,
      this.isPass = false,
      this.keyboardType,
      this.checkBlank = true,
      this.checkEmail = false,
      this.checkLength = 0});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(8)),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        validator: (value) {
          if (widget.checkBlank) {
            if (value!.isEmpty) {
              return "Please enter ${widget.hintText}!";
            }
          }
          if (widget.checkEmail) {
            bool emailValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value!);
            if (!emailValid) {
              return "Enter Valid email ";
            }
          }
          if (widget.checkLength != 0) {
            if (widget.controller!.text.length < widget.checkLength) {
              return "${widget.hintText} length not be less than ${widget.checkLength} characters.";
            }
          }
        },
        obscureText: widget.isPass ? !obscureText : false,
        decoration: InputDecoration(
          labelText: widget.hintText,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),


            ),
            hintText: widget.hintText,
            suffixIcon: widget.isPass
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          child: Icon(
                            obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          )),
                    ],
                  )
                : null,
            prefixIcon: widget.icon != 'none'
                ? Container(
                    alignment: Alignment.center,
                    width: 20,
                    height: 20,
                    child: Image.asset(
                      widget.icon,
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
