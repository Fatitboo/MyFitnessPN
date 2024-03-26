import 'package:flutter/material.dart';

import '../values/color_extension.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final Color bgColor;
  final Color textColor;
  final String textString;
  final double height;
  final double radius;
  final double elevation;
  final FontWeight fontWeight;
  final double fontSize;

  const MyButton(
      {super.key,
      required this.onTap,
      required this.bgColor,
      required this.textString,
      required this.textColor,
      this.height = 60,
      this.radius = 30,
      this.elevation = 1,
      this.fontWeight = FontWeight.w700,
      this.fontSize = 16});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(radius),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26, blurRadius: 0.5, offset: Offset(0, 0.5))
          ]),
      child: MaterialButton(
          onPressed: onTap,
          height: height,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius)),
          textColor: textColor,
          minWidth: double.maxFinite,
          elevation: elevation,
          color: bgColor,
          child: Text(textString,
              style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                  fontWeight: fontWeight))),
    );
  }
}
