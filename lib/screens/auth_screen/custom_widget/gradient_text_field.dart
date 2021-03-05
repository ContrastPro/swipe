import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swipe/global/app_colors.dart';

class GradientTextField extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final List<TextInputFormatter> formatter;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String> validator;

  const GradientTextField({
    Key key,
    this.hintText,
    this.keyboardType,
    this.formatter,
    this.controller,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: Colors.transparent),
    );

    final InputBorder focusedErrorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: Colors.red),
    );

    return Container(
      width: 280.0,
      height: 48.0,
      decoration: BoxDecoration(
        gradient: AppColors.textFieldGradient,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Center(
        child: TextFormField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            enabledBorder: border,
            disabledBorder: border,
            focusedBorder: border,
            focusedErrorBorder: focusedErrorBorder,
            border: border,
            hintText: hintText ?? "TextField",
            hintStyle: TextStyle(color: Colors.white54),
            errorStyle: TextStyle(height: 0),
          ),
          keyboardType: keyboardType ?? TextInputType.phone,
          inputFormatters: formatter ?? <TextInputFormatter>[],
          controller: controller,
          onChanged: (String value) => onChanged(value),
          validator: (String value) => validator(value),
        ),
      ),
    );
  }
}
