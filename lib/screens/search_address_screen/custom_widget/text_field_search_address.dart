import 'package:flutter/material.dart';
import 'package:swipe/global/app_colors.dart';

class TextFieldSearchAddress extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;

  const TextFieldSearchAddress({
    Key key,
    this.hintText,
    @required this.onChanged,
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(10),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            SizedBox(width: 12.0),
            Icon(
              Icons.search,
              color: Colors.black.withAlpha(160),
            ),
            Expanded(
              child: TextFormField(
                scrollPhysics: BouncingScrollPhysics(),
                style: TextStyle(
                  color: Colors.black.withAlpha(130),
                  fontWeight: FontWeight.w500,
                ),
                readOnly: true,
                initialValue: "р-н Центральный ул. Темерязева",
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.fromLTRB(
                    12.0,
                    16.0,
                    16.0,
                    16.0,
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
                onChanged: (String value) => onChanged(value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
