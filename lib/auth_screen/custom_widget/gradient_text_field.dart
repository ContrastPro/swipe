import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swipe/global/app_colors.dart';

class GradientTextField extends StatelessWidget {
  final double width;
  final double height;
  final String hintText;
  final TextInputType keyboardType;
  final List<TextInputFormatter> formatter;
  final TextEditingController controller;

  const GradientTextField({
    Key key,
    this.width,
    this.height,
    this.hintText,
    this.keyboardType,
    this.formatter,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: Colors.transparent),
    );

    return Container(
      width: width ?? 280.0,
      height: height ?? 50.0,
      decoration: BoxDecoration(
        gradient: AppColors.textFieldGradient,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Center(
        child: TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            enabledBorder: border,
            disabledBorder: border,
            focusedBorder: border,
            border: border,
            hintText: hintText ?? "TextField",
            hintStyle: TextStyle(color: Colors.white),
          ),
          keyboardType: keyboardType ?? TextInputType.phone,
          inputFormatters: formatter ?? <TextInputFormatter>[],
          controller: controller,
        ),
      ),
    );
  }
}
