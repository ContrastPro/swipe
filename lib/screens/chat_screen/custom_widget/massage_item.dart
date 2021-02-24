import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swipe/format/time_format.dart';
import 'package:swipe/model/custom_user.dart';

class MassageItem extends StatelessWidget {
  final UserBuilder userBuilder;
  final DocumentSnapshot document;
  final VoidCallback onLongPress;

  const MassageItem({
    Key key,
    @required this.document,
    @required this.userBuilder,
    @required this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isNotOwnerMassage() {
      return userBuilder.uid != document["ownerUID"];
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: _isNotOwnerMassage()
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onLongPress: () => onLongPress(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 70.0,
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: _isNotOwnerMassage()
                      ? Color(0xFF41BFB5)
                      : Color(0xFFECECEC),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Text(
                        "${TimeFormat.formatTimeMessage(document["createAt"])}",
                        style: TextStyle(
                          color: _isNotOwnerMassage()
                              ? Colors.white
                              : Colors.black.withAlpha(100),
                          fontWeight: FontWeight.w500,
                          fontSize: 11.0,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 15.0),
                      child: Text(
                        "${document["message"]}",
                        style: TextStyle(
                          color: _isNotOwnerMassage()
                              ? Colors.white
                              : Colors.black.withAlpha(180),
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
