import 'package:do_an_2/res/values/color_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final bool loading;

  const LoadingWidget({super.key, required this.loading});

  @override
  Widget build(BuildContext context) {
    return loading ? const SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        color: Color(0x3204070E),
        strokeWidth: 2,
      ),
    ): Container();
  }
}
