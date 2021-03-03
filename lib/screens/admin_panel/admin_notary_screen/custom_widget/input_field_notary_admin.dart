import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputFieldNotaryAdmin extends StatelessWidget {
  final String initialValue;
  final String hintText;
  final TextInputType keyboardType;
  final List<TextInputFormatter> formatter;
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String> validator;

  const InputFieldNotaryAdmin({
    Key key,
    this.initialValue,
    this.hintText,
    this.keyboardType,
    this.formatter,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: Colors.transparent),
    );

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(10),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: TextFormField(
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
            border: border,
            hintText: hintText ?? "TextField",
            hintStyle: TextStyle(color: Colors.black38),
            errorStyle: TextStyle(height: 0),
          ),
          keyboardType: keyboardType ?? TextInputType.text,
          inputFormatters: formatter ?? <TextInputFormatter>[],
          onChanged: (String value) => onChanged(value),
          validator: (String value) => validator(value),
        ),
      ),
    );
  }
}
