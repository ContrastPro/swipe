import 'package:flutter/material.dart';
import 'package:swipe/global/style/app_colors.dart';

class ModalBottomSheet extends StatelessWidget {
  final String title;
  final String subtitle;
  final String accept;
  final String reject;

  final VoidCallback onAccept;

  const ModalBottomSheet({
    Key key,
    @required this.title,
    @required this.subtitle,
    @required this.onAccept,
    this.accept,
    this.reject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.black.withAlpha(140),
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 12.0),
          ButtonBar(
            children: [
              FlatButton(
                child: Text(
                  reject?.toUpperCase() ?? 'ОТМЕНА',
                  style: TextStyle(
                    color: AppColors.accentColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              ),
              FlatButton(
                child: Text(
                  accept?.toUpperCase() ?? 'ПРОДОЛЖИТЬ',
                  style: TextStyle(
                    color: AppColors.accentColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  onAccept();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
