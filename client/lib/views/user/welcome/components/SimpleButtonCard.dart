import 'package:flutter/material.dart';

class SimpleButtonCard extends StatelessWidget {
  SimpleButtonCard({
    super.key,
    required this.buttonText,
    required this.backgroundColor,
    required this.textColor,
    required this.iconAssets,
    required this.onTap,
    this.extraText,
  });
  final Color backgroundColor, textColor;
  final String iconAssets;
  final VoidCallback onTap;
  final String buttonText;
  late String? extraText = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Material(
            elevation: 5,
            shadowColor: const Color.fromARGB(80, 57, 57, 57),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: InkWell(
              onTap: () {
                onTap();
              },
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              child: Container(
                  height: 100,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              buttonText,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: textColor),
                            ),
                            Text(
                              extraText ?? "",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: textColor),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 48.0,
                        width: 48.0,
                        child: SizedBox(
                          width: 54,
                          height: 54,
                          child: Image.asset(iconAssets),
                        ),
                      ),
                    ],
                  )),
            )));
  }
}
