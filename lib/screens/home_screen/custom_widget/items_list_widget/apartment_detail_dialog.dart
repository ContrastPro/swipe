import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:swipe/custom_app_widget/page_indicator.dart';
import 'package:swipe/global/style/app_colors.dart';
import 'package:swipe/model/apartment.dart';

class ApartmentDetailDialog extends StatefulWidget {
  final ApartmentBuilder apartmentBuilder;
  final VoidCallback onTap;

  const ApartmentDetailDialog({
    Key key,
    @required this.apartmentBuilder,
    @required this.onTap,
  }) : super(key: key);

  @override
  _ApartmentDetailDialogState createState() => _ApartmentDetailDialogState();
}

class _ApartmentDetailDialogState extends State<ApartmentDetailDialog> {

  final Duration _duration = Duration(milliseconds: 400);
  final Curve _curves = Curves.easeIn;

  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextImage() {
    if(widget.apartmentBuilder.images.length > 1){
      _pageController.nextPage(
        duration: _duration,
        curve: _curves,
      );
    }
  }

  void _previousImage() {
    if(widget.apartmentBuilder.images.length > 1){
      _pageController.previousPage(
        duration: _duration,
        curve: _curves,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildImage() {
      return Flexible(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            PageView.builder(
              itemCount: widget.apartmentBuilder.images.length,
              controller: _pageController,
              physics: BouncingScrollPhysics(),
              onPageChanged: (int index) {
                setState(() => _currentIndex = index);
              },
              itemBuilder: (context, index) {
                return Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: widget.apartmentBuilder.images[index],
                    imageBuilder: (context, imageProvider) =>
                        Container(
                          decoration: BoxDecoration(
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
                        ),
                      );
                    },
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => _previousImage(),
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          color: Colors.black54,
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _nextImage(),
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          color: Colors.black54,
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 35.0),
                PageIndicator(
                  width: 6.5,
                  height: 6.5,
                  index: _currentIndex,
                  progressCount: widget.apartmentBuilder.images.length,
                  colorPrimary: Colors.grey.shade200,
                  colorSecondary: Colors.white,
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Dialog(
      backgroundColor: Colors.transparent,
      insetAnimationDuration: const Duration(milliseconds: 800),
      insetPadding: EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 300,
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              _buildImage(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.apartmentBuilder.numberOfRooms}, "
                                "${widget.apartmentBuilder.totalArea} м², "
                                "1/8 эт.",
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            "${widget.apartmentBuilder.address}",
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${widget.apartmentBuilder.price} ₽",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2.0),
                            GestureDetector(
                              onTap: () => widget.onTap(),
                              child: Text(
                                "смотреть объявление",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.accentColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
