import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  final List<String> imageList;
  final int initialPage;

  const ImageSlider({
    Key key,
    @required this.imageList,
    this.initialPage,
  }) : super(key: key);

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  bool _isSized = false;
  PageController _controller;
  TransformationController _transformationController;

  @override
  void initState() {
    _controller = PageController(initialPage: widget.initialPage ?? 0);
    _transformationController = TransformationController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.imageList.length,
            physics: _isSized
                ? NeverScrollableScrollPhysics()
                : BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return InteractiveViewer(
                transformationController: _transformationController,
                onInteractionStart: (ScaleStartDetails value) {
                  setState(() => _isSized = true);
                },
                onInteractionEnd: (ScaleEndDetails value) {
                  setState(() => _isSized = false);
                  _transformationController.value = Matrix4.identity();
                },
                child: CachedNetworkImage(
                  imageUrl: widget.imageList[index],
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  progressIndicatorBuilder: (context, url, downloadProgress) {
                    return Center(
                      child: CircularProgressIndicator(
                        value: downloadProgress.progress,
                        strokeWidth: 2,
                      ),
                    );
                  },
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              );
            },
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.close_rounded),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
