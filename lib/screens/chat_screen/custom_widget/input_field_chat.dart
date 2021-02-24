import 'package:flutter/material.dart';
import 'package:swipe/global/app_colors.dart';

class InputFieldChat extends StatelessWidget {
  final VoidCallback onAttach;
  final ValueChanged<String> onChanged;
  final VoidCallback onSend;
  static TextEditingController controller = TextEditingController();

  const InputFieldChat({
    Key key,
    @required this.onAttach,
    @required this.onChanged,
    @required this.onSend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(45.0),
      borderSide: BorderSide(color: Colors.transparent),
    );

    return Container(
      color: AppColors.primaryColor,
      child: Row(
        children: [
          IconButton(
            icon: Transform.rotate(
              angle: 3 / 4,
              child: Icon(
                Icons.attach_file_rounded,
                color: Colors.black54,
                size: 30.0,
              ),
            ),
            onPressed: () => onAttach(),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white,
              ),
              margin: const EdgeInsets.symmetric(vertical: 14.0),
              child: TextFormField(
                style: TextStyle(
                  color: Colors.black.withAlpha(150),
                  fontWeight: FontWeight.w600,
                ),
                controller: controller,
                minLines: 1,
                maxLines: 5,
                maxLength: 650,
                scrollPhysics: BouncingScrollPhysics(),
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 8.0,
                  ),
                  counterText: "",
                  enabledBorder: border,
                  disabledBorder: border,
                  focusedBorder: border,
                  errorBorder: border,
                  border: border,
                  hintText: "Собщение",
                  hintStyle: TextStyle(
                    color: Colors.black26,
                    fontWeight: FontWeight.w500,
                  ),
                  errorStyle: TextStyle(height: 0),
                ),
                onChanged: (String massage) => onChanged(massage),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              onSend();
              controller.clear();
              await Future.delayed(Duration(milliseconds: 180));
              FocusScope.of(context).unfocus();
            },
            child: Container(
              width: 48,
              height: 48,
              margin: const EdgeInsets.fromLTRB(12.0, 8.0, 8.0, 8.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45.0),
                  gradient: AppColors.buttonGradient),
              child: Icon(
                Icons.send_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
