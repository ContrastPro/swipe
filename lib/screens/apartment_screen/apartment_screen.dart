import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipe/custom_app_widget/app_bars/app_bar_style_2.dart';
import 'package:swipe/custom_app_widget/fab/apartment_fab_call.dart';
import 'package:swipe/custom_app_widget/fab/apartment_fab_edit.dart';
import 'package:swipe/custom_app_widget/page_indicator.dart';
import 'package:swipe/model/apartment.dart';
import 'package:swipe/network_connectivity/network_connectivity.dart';
import 'package:swipe/screens/auth_screen/api/firebase_auth_api.dart';

class ApartmentScreen extends StatefulWidget {
  final ApartmentBuilder apartmentBuilder;

  const ApartmentScreen({
    Key key,
    @required this.apartmentBuilder,
  }) : super(key: key);

  @override
  _ApartmentScreenState createState() => _ApartmentScreenState();
}

class _ApartmentScreenState extends State<ApartmentScreen> {
  int _currentIndex = 0;
  User _user;

  @override
  void initState() {
    _user = AuthFirebaseAPI.getCurrentUser();
    super.initState();
  }

  bool _isOwner(){
    return _user.uid == widget.apartmentBuilder.ownerUID;
  }

  Widget _buildImageList() {
    return Container(
      height: 280,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            itemCount: widget.apartmentBuilder.images.length,
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
                  imageBuilder: (context, imageProvider) => Container(
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

  Widget _buildScreen() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          _buildImageList(),
        ],
      ),
    );
  }

  Widget _buildFAB() {
    if (_isOwner() == true) {
      return ApartmentFABEdit(
        title: "Редактировать",
        onTap: () {},
      );
    } else {
      return ApartmentFABCall(
        onLeftTap: () {},
        onRightTap: () {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarStyle2(
        backgroundColor: Colors.white,
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45.0),
              ),
              child: Icon(
                Icons.radio_button_off,
                color: Colors.black26,
                size: 25.0,
              ),
            ),
          ),
        ],
      ),
      body: NetworkConnectivity(
        child: _buildScreen(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildFAB(),
    );
  }
}
