import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class PrivacyDialog extends StatelessWidget {
  final String textButton;
  final double radius;
  final String fileName;
  final VoidCallback onPressed;

  const PrivacyDialog({
    Key key,
    this.textButton,
    this.radius = 8,
    this.fileName = "privacy_policy.md",
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildPrivacy() {
      return FutureBuilder(
        future: Future.delayed(
          Duration(milliseconds: 250),
        ).then((value) {
          return DefaultAssetBundle.of(context)
              .loadString("assets/privacy/$fileName");
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
        borderRadius: BorderRadius.circular(radius),
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
                bottomLeft: Radius.circular(radius),
                bottomRight: Radius.circular(radius),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(radius),
                  bottomRight: Radius.circular(radius),
                ),
              ),
              alignment: Alignment.center,
              height: 50,
              width: double.infinity,
              child: Text(
                textButton?.toUpperCase() ?? "ПРИНЯТЬ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              if(onPressed != null){
                onPressed();
              }
            },
          ),
        ],
      ),
    );
  }
}
