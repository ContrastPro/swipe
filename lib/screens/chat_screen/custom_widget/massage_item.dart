import 'package:cached_network_image/cached_network_image.dart';
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
    @required this.userBuilder,
    @required this.messageBuilder,
    @required this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isNotOwnerMassage() {
      return userBuilder.uid != messageBuilder.ownerUID;
    }

    void showFullSizeImage() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Stack(
              children: [
                InteractiveViewer(
                  panEnabled: true,
                  child: CachedNetworkImage(
                    imageUrl: messageBuilder.attachFile,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                SafeArea(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.close_rounded),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    Widget buildAttachFile(double radius) {
      if (messageBuilder.attachFile == "loading") {
        return Container(
          width: double.infinity,
          height: 180,
          margin: const EdgeInsets.all(2.0),
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              backgroundColor: Colors.white,
            ),
          ),
        );
      } else {
        return GestureDetector(
          onTap: () => showFullSizeImage(),
          child: Container(
            width: double.infinity,
            height: 180,
            margin: const EdgeInsets.all(2.0),
            child: CachedNetworkImage(
              imageUrl: messageBuilder.attachFile,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                    bottomLeft: Radius.circular(radius),
                    bottomRight: Radius.circular(radius),
                  ),
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              progressIndicatorBuilder: (context, url, downloadProgress) {
                return Center(
                  child: CircularProgressIndicator(
                    value: downloadProgress.progress,
                    strokeWidth: 2,
                    backgroundColor: Colors.white,
                  ),
                );
              },
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        );
      }
    }

    Widget buildMessage() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
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
                  messageBuilder.createdAt,
                ),
                style: TextStyle(
                  color: Colors.transparent,
                  fontWeight: FontWeight.w500,
                  fontSize: 11.0,
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget buildMassageItem() {
      if (messageBuilder.attachFile != null && messageBuilder.message != null) {
        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildAttachFile(3.0),
                buildMessage(),
              ],
            ),
            Positioned(
              right: 8.0,
              bottom: 4.0,
              child: Text(
                TimeFormat.formatTimeMessage(
                  messageBuilder.createdAt,
                ),
                style: TextStyle(
                  color: _isNotOwnerMassage()
                      ? Colors.white
                      : Colors.black.withAlpha(100),
                  fontWeight: FontWeight.w500,
                  fontSize: 11.0,
                ),
              ),
            )
          ],
        );
      } else if (messageBuilder.attachFile != null &&
          messageBuilder.message == null) {
        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildAttachFile(8.0),
              ],
            ),
            Positioned(
              right: 8.0,
              bottom: 4.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6.0,
                  vertical: 1.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(3.0),
                ),
                child: Text(
                  TimeFormat.formatTimeMessage(
                    messageBuilder.createdAt,
                  ),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 11.0,
                  ),
                ),
              ),
            )
          ],
        );
      } else {
        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildMessage(),
              ],
            ),
            Positioned(
              right: 8.0,
              bottom: 4.0,
              child: Text(
                TimeFormat.formatTimeMessage(
                  messageBuilder.createdAt,
                ),
                style: TextStyle(
                  color: _isNotOwnerMassage()
                      ? Colors.white
                      : Colors.black.withAlpha(100),
                  fontWeight: FontWeight.w500,
                  fontSize: 11.0,
                ),
              ),
            )
          ],
        );
      }
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
                child: buildMassageItem(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
