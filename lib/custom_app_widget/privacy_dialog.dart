import 'package:flutter/material.dart';

class PrivacyDialog extends StatelessWidget {
  final double radius;
  final String fileName;
  final VoidCallback onPressed;

  const PrivacyDialog({
    Key key,
    this.radius = 8,
    this.fileName = "privacy_policy.txt",
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _buildPrivacy() {
      return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: FutureBuilder(
          future: DefaultAssetBundle.of(context)
              .loadString("assets/privacy/$fileName"),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22.0,
                  vertical: 32.0,
                ),
                child: Text(
                  snapshot.data,
                  softWrap: true,
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      );
    }

    return Dialog(
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
              onPressed();
            },
          ),
        ],
      ),
    );
  }
}
