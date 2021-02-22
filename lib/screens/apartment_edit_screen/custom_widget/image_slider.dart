import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  final List<String> imageList;

  const ImageSlider({
    Key key,
    @required this.imageList,
  }) : super(key: key);

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _currentIndex = 0;
  PageController _smallPageController;

  @override
  void initState() {
    _smallPageController = PageController(viewportFraction: 0.34);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            itemCount: widget.imageList.length,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return CachedNetworkImage(
                imageUrl: widget.imageList[_currentIndex],
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
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 75,
              margin: const EdgeInsets.only(bottom: 80.0),
              child: PageView.builder(
                controller: _smallPageController,
                itemCount: widget.imageList.length,
                itemBuilder: (context, index) {
                  return Transform.scale(
                    scale: _currentIndex == index ? 1.0 : 0.9,
                    child: GestureDetector(
                      onTap: () => setState(() => _currentIndex = index),
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
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) {
                          return Center(
                            child: CircularProgressIndicator(
                              value: downloadProgress.progress,
                              strokeWidth: 2,
                            ),
                          );
                        },
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  );
                },
              ),
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
    );
  }
}
