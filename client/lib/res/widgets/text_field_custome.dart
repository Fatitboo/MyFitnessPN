import 'package:do_an_2/res/values/color_extension.dart';
import 'package:flutter/material.dart';

class TextFieldCustome extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String hintText;
  final String title;
  final String? errorText;
  final VoidCallback onChange;
  const TextFieldCustome(
      {super.key,
      required this.hintText,
      required this.controller,
      required this.keyboardType,
      required this.onChange,
      required this.title,
      required this.errorText});

  @override
  State<TextFieldCustome> createState() => _TextFieldCustomeState();
}

class _TextFieldCustomeState extends State<TextFieldCustome> {
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
          child: IntrinsicWidth(
            child: TextField(
              controller: widget.controller,
              onChanged: (item) {
                widget.onChange();
              },
              textAlign: TextAlign.right,
              keyboardType: widget.keyboardType,
              maxLines: null,
              decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  errorText: widget.errorText,
                  focusedBorder: InputBorder.none,
                  hintText: widget.hintText),
            ),
          ),
        ),
      ],
    );
  }
}
