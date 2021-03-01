import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipe/custom_app_widget/app_bars/app_bar_style_2.dart';
import 'package:swipe/custom_app_widget/fab/apartment_fab_call.dart';
import 'package:swipe/custom_app_widget/fab/apartment_fab_edit.dart';
import 'package:swipe/custom_app_widget/fade_route.dart';
import 'package:swipe/custom_app_widget/gradient_button.dart';
import 'package:swipe/custom_app_widget/image_slider.dart';
import 'package:swipe/custom_app_widget/page_indicator.dart';
import 'package:swipe/global/app_colors.dart';
import 'package:swipe/model/apartment.dart';
import 'package:swipe/model/custom_user.dart';
import 'package:swipe/network_connectivity/network_connectivity.dart';
import 'package:swipe/screens/apartment_edit_screen/edit_apartment_screen.dart';
import 'package:swipe/screens/auth_screen/api/firebase_auth_api.dart';
import 'package:swipe/screens/chat_screen/chat_screen.dart';

import 'package:swipe/screens/promotion_screen/promotion_screen.dart';
import 'package:swipe/screens/show_on_map_screen/show_on_map_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'apartment_detail.dart';
import 'owner_field.dart';

class ApartmentWidget extends StatefulWidget {
  final ApartmentBuilder apartmentBuilder;
  final UserBuilder userBuilder;

  const ApartmentWidget({
    Key key,
    @required this.apartmentBuilder,
    @required this.userBuilder,
  }) : super(key: key);

  @override
  _ApartmentWidgetState createState() => _ApartmentWidgetState();
}

class _ApartmentWidgetState extends State<ApartmentWidget> {
  int _currentIndex = 0;
  User _user;

  @override
  void initState() {
    _user = AuthFirebaseAPI.getCurrentUser();
    super.initState();
  }

  bool _isOwner() {
    return _user.uid == widget.apartmentBuilder.ownerUID;
  }

  void _showOnMapScreen() {
    Navigator.push(
      context,
      FadeRoute(
        page: ShowOnMapScreen(
          apartmentBuilder: widget.apartmentBuilder,
        ),
      ),
    );
  }

  void _makePhoneCall() async {
    String phone = "tel:${widget.userBuilder.phone}";
    if (await canLaunch(phone)) {
      await launch(phone);
    } else {
      throw 'Could not launch $phone';
    }
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
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    FadeRoute(
                      page: ImageSlider(
                        imageList: widget.apartmentBuilder.images,
                        initialPage: _currentIndex,
                      ),
                    ),
                  );
                },
                child: Container(
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

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 22.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.apartmentBuilder.price} ₽",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 5.0),
                Text(
                  "${widget.apartmentBuilder.numberOfRooms}, "
                  "${widget.apartmentBuilder.totalArea} м², "
                  "1/8 эт.",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 15.0),
                Text(
                  "${widget.apartmentBuilder.address}",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: InkWell(
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: () => _showOnMapScreen(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.map_outlined,
                    color: AppColors.accentColor,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "На карте",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.accentColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_isOwner() == true) ...[
            GradientButton(
              title: "Подтвердить актуальность",
              maxWidth: double.infinity,
              minHeight: 50.0,
              borderRadius: 10.0,
              elevation: 0,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ),
              onTap: () {},
            ),
            SizedBox(height: 30.0),
          ],
          ApartmentDetail(
            title: "Вид недвижимости",
            description: "Вторичный рынок",
          ),
          ApartmentDetail(
            title: "Статус дома",
            description: "Сдан",
          ),
          ApartmentDetail(
            title: "Тип дома",
            description: "Панельный",
          ),
          ApartmentDetail(
            title: "Количество комнат",
            description: widget.apartmentBuilder.numberOfRooms,
          ),
          if (widget.apartmentBuilder.appointmentApartment != null)
            ApartmentDetail(
              title: "Назначение",
              description: widget.apartmentBuilder.appointmentApartment,
            ),
          if (widget.apartmentBuilder.apartmentCondition != null)
            ApartmentDetail(
              title: "Жилое состояние",
              description: widget.apartmentBuilder.apartmentCondition,
            ),
          if (widget.apartmentBuilder.apartmentLayout != null)
            ApartmentDetail(
              title: "Планировка",
              description: widget.apartmentBuilder.apartmentLayout,
            ),
          ApartmentDetail(
            title: "Общая площадь",
            description: "${widget.apartmentBuilder.totalArea} м²",
          ),
          ApartmentDetail(
            title: "Площадь кухни",
            description: "${widget.apartmentBuilder.kitchenArea} м²",
          ),
          if (widget.apartmentBuilder.balconyLoggia != null)
            ApartmentDetail(
              title: "Балкон/лоджия",
              description: widget.apartmentBuilder.balconyLoggia,
            ),
          if (widget.apartmentBuilder.heatingType != null)
            ApartmentDetail(
              title: "Отопление",
              description: widget.apartmentBuilder.heatingType,
            ),
          if (widget.apartmentBuilder.typeOfPayment != null)
            ApartmentDetail(
              title: "Варианты расчёта",
              description: widget.apartmentBuilder.typeOfPayment,
            ),
          if (widget.apartmentBuilder.agentCommission != null)
            ApartmentDetail(
              title: "Коммисия агенту",
              description: "${widget.apartmentBuilder.agentCommission} ₽",
            ),
          SizedBox(height: 35.0),
          Text(
            "${widget.apartmentBuilder.description}",
            softWrap: true,
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }

  Widget _buildButton() {
    if (_isOwner() == true) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            FadeRoute(
              page: PromotionScreen(
                apartmentBuilder: widget.apartmentBuilder,
              ),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          height: 50.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.transparent,
            border: Border.all(
              width: 1.5,
              color: AppColors.accentColor,
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            "Продвижение объявления",
            style: TextStyle(
              color: AppColors.accentColor,
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {},
        child: Container(
          width: double.infinity,
          height: 50.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.redAccent.withAlpha(50),
          ),
          alignment: Alignment.center,
          child: Text(
            "Пожаловаться на объявление",
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }
  }

  Widget _buildFAB() {
    if (_isOwner() == true) {
      return ApartmentFABEdit(
        title: "Редактировать",
        onTap: () {
          Navigator.push(
            context,
            FadeRoute(
              page: ApartmentEditScreen(
                apartmentBuilder: widget.apartmentBuilder,
              ),
            ),
          );
        },
      );
    } else {
      return ApartmentFABCall(
        onLeftTap: () => _makePhoneCall(),
        onRightTap: () {
          Navigator.push(
            context,
            FadeRoute(
              page: ChatScreen(
                userBuilder: widget.userBuilder,
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarStyle2(
        backgroundColor: Colors.white,
        actions: [
          if (_isOwner() == true) ...[
            Row(
              children: [
                Icon(
                  Icons.remove_red_eye_outlined,
                  color: Colors.black38,
                ),
                SizedBox(width: 5.0),
                Text(
                  "23",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(width: 20.0),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45.0),
                    ),
                    child: Icon(
                      Icons.radio_button_off,
                      color: Colors.black38,
                      size: 25.0,
                    ),
                  ),
                ),
                SizedBox(width: 5.0),
                Text(
                  "6",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ],
          if (_isOwner() == false) ...[
            GestureDetector(
              onTap: () {},
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45.0),
                ),
                child: Icon(
                  Icons.radio_button_off,
                  color: Colors.black38,
                  size: 25.0,
                ),
              ),
            ),
          ]
        ],
      ),
      body: NetworkConnectivity(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              _buildImageList(),
              _buildHeader(),
              _buildBody(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    OwnerInfoField(userBuilder: widget.userBuilder),
                    SizedBox(height: 35.0),
                    _buildButton(),
                  ],
                ),
              ),
              SizedBox(height: 120),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildFAB(),
    );
  }
}
