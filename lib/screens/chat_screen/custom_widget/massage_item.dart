import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swipe/format/time_format.dart';
import 'package:swipe/model/custom_user.dart';
import 'package:swipe/model/message.dart';

class MassageItem extends StatelessWidget {
  final UserBuilder userBuilder;
  final MessageBuilder messageBuilder;
  final VoidCallback onLongPress;

  const MassageItem({
    Key key,
    @required this.messageBuilder,
    @required this.userBuilder,
    @required this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isNotOwnerMassage() {
      return userBuilder.uid != messageBuilder.ownerUID;
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
                maxWidth: MediaQuery.of(context).size.width * 0.80,
              ),
              child: Container(
                padding: const EdgeInsets.only(left: 8.0, top: 8.0),
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: "${messageBuilder.message}     ",
                              style: TextStyle(
                                color: _isNotOwnerMassage()
                                    ? Colors.white
                                    : Colors.black.withAlpha(180),
                                fontWeight: FontWeight.w500,
                                fontSize: 15.0,
                              ),
                            ),
                            TextSpan(
                              text: TimeFormat.formatTimeMessage(
                                messageBuilder.createAt,
                              ),
                              style: TextStyle(
                                color: Colors.transparent,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 8.0,
                      bottom: 4.0,
                      child: Text(
                        TimeFormat.formatTimeMessage(
                          messageBuilder.createAt,
                        ),
                        style: TextStyle(
                          color: _isNotOwnerMassage()
                              ? Colors.white
                              : Colors.black.withAlpha(100),
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0,
                        ),
                      ),
                    )
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
