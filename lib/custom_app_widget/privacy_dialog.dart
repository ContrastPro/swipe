import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
class PrivacyDialog {
  PrivacyDialog._();

  static showPrivacyDialog({
    @required BuildContext context,
    VoidCallback onPressed,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return _PrivacyDialog(
          onPressed: () {
            if (onPressed != null) {
              onPressed();
            }
          },
        );
      },
    );
  }
}

class _PrivacyDialog extends StatelessWidget {
  final VoidCallback onPressed;

  const _PrivacyDialog({
    Key key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildPrivacy() {
      return FutureBuilder(
        future: Future.delayed(
          Duration(milliseconds: 250),
        ).then((value) {
          return DefaultAssetBundle.of(context).loadString(
            "assets/privacy/privacy_policy.md",
          );
        }),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Markdown(
              physics: BouncingScrollPhysics(),
              data: snapshot.data,
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    }

    return Dialog(
      insetPadding: EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: _buildPrivacy(),
          ),
          FlatButton(
            padding: EdgeInsets.all(0),
            color: Colors.pink[600],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              alignment: Alignment.center,
              height: 50,
              width: double.infinity,
              child: Text(
                "ПРИНЯТЬ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              if (onPressed != null) {
                onPressed();
              }
            },
          ),
        ],
      ),
    );
  }
}
