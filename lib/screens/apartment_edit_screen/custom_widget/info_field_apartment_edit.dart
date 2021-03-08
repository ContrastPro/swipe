import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swipe/global/style/app_colors.dart';

class InfoFieldApartmentEdit extends StatelessWidget {
  final String initialValue;
  final String title;
  final String hintText;
  final int maxLines;
  final bool readOnly;
  final TextInputType keyboardType;
  final List<TextInputFormatter> formatter;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String> validator;

  const InfoFieldApartmentEdit({
    Key key,
    this.initialValue,
    this.title,
    this.hintText,
    this.maxLines,
    this.readOnly,
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

    final InputBorder errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: AppColors.accentColor),
    );

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.black87,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(10),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextFormField(
              readOnly: readOnly ?? false,
              maxLines: maxLines ?? 1,
              scrollPhysics: BouncingScrollPhysics(),
              style: TextStyle(
                color: Colors.black.withAlpha(165),
                fontWeight: FontWeight.w500,
              ),
              initialValue: initialValue,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15.0,
                  vertical: 16.0
                ),
                enabledBorder: border,
                disabledBorder: border,
                focusedBorder: border,
                errorBorder: errorBorder,
                border: border,
                hintText: hintText ?? "TextField",
                hintStyle: TextStyle(color: Colors.black38),
                errorStyle: TextStyle(height: 0),
              ),
              keyboardType: keyboardType ?? TextInputType.text,
              inputFormatters: formatter ?? <TextInputFormatter>[],
              controller: controller,
              onChanged: (String value) => onChanged(value),
              validator: (String value) => validator(value),
            ),
          ),
        ],
      ),
    );
  }
}
