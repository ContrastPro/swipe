import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swipe/custom_app_widget/gradient_switch.dart';
import 'package:swipe/custom_app_widget/privacy_dialog.dart';
import 'package:swipe/global/app_colors.dart';
import 'package:swipe/model/custom_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swipe/custom_app_widget/app_bars/app_bar_style_1.dart';
import 'package:swipe/custom_app_widget/gradient_button.dart';
import 'package:swipe/custom_app_widget/loading_indicator.dart';
import 'package:swipe/screens/edit_profile_screen/api/edit_profile_cloudstore_api.dart';
import 'package:swipe/screens/edit_profile_screen/api/edit_profile_firestore_api.dart';
import 'package:swipe/screens/edit_profile_screen/custom_widget/avatar_picker.dart';
import 'package:swipe/screens/edit_profile_screen/custom_widget/expandable_card_edit_profile.dart';
import 'package:swipe/screens/edit_profile_screen/custom_widget/info_field_edit_profile.dart';
import 'package:swipe/screens/edit_profile_screen/avatar_image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  final UserBuilder userProfile;

  const EditProfileScreen({Key key, this.userProfile}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _startLoading = false;
  bool _isOpened = false;
  File _imageFile;

  UserBuilder _userBuilder;
  AvatarImagePicker _imagePicker;
  GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _userBuilder = widget.userProfile;
    _formKey = GlobalKey<FormState>();
    _imagePicker = AvatarImagePicker();
    super.initState();
  }

  void _editProfile() async {
    if (_formKey.currentState.validate()) {
      setState(() => _startLoading = true);
      if (_userBuilder.phone != widget.userProfile.phone) {
        // Обновить телефон в профиле FirebaseAuth
        // и проверить зарегистрирован ли он в БД
      }
      if (_imageFile != null) {
        // Загрузить/Обновить изображение и вернуть ссылку
        _userBuilder.photoURL =
            await EditProfileCloudstoreAPI.uploadProfileImage(
          userProfile: widget.userProfile,
          imageFile: _imageFile,
          photoURL: widget.userProfile.photoURL,
        );
      }
      _userBuilder.updatedAt = Timestamp.now();
      await EditProfileFirestoreAPI.editUserProfile(
        customUser: CustomUser(builder: _userBuilder),
      );
      Navigator.pop(context);
    }
  }

  void _changeNotification(int newIndex) {
    int oldIndex = _userBuilder.notification.indexWhere(
      (element) => element == true,
    );
    if (oldIndex != newIndex) {
      setState(() {
        // Меняем старое значение
        if (_userBuilder.notification[oldIndex] == true) {
          _userBuilder.notification[oldIndex] = false;
        } else {
          _userBuilder.notification[oldIndex] = true;
        }
        // Устанавливаем новое значение
        if (_userBuilder.notification[newIndex] == true) {
          _userBuilder.notification[newIndex] = false;
        } else {
          _userBuilder.notification[newIndex] = true;
        }
      });
      print(_userBuilder.notification);
    }
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 30.0, 22.0, 35.0),
      child: Row(
        children: [
          AvatarPicker(
            photoURL: widget.userProfile.photoURL,
            imageFile: _imageFile,
            onTap: () async {
              await _imagePicker.getLocalImage();
              setState(() {
                _imageFile = _imagePicker.imageFile;
              });
            },
          ),
          SizedBox(width: 22.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.userProfile.name} ${widget.userProfile.lastName}",
                  style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 5.0),
                Text(
                  widget.userProfile.email,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMyContact() {
    return ExpandableCardEditProfile(
      title: "Мои контакты",
      margin: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        bottom: 15.0,
      ),
      children: [
        SizedBox(height: 20.0),
        InfoFieldEditProfile(
          title: "Имя",
          hintText: "Имя",
          initialValue: _userBuilder.name,
          keyboardType: TextInputType.name,
          onChanged: (String value) {
            _userBuilder.name = value;
          },
          validator: (String value) {
            if (value.isEmpty) return '';
            return null;
          },
        ),
        InfoFieldEditProfile(
          title: "Фамилия",
          hintText: "Фамилия",
          initialValue: _userBuilder.lastName,
          keyboardType: TextInputType.name,
          onChanged: (String value) {
            _userBuilder.lastName = value;
          },
          validator: (String value) {
            if (value.isEmpty) return '';
            return null;
          },
        ),
        InfoFieldEditProfile(
          title: "Телефон",
          hintText: "+7 928 245 20 20",
          initialValue: _userBuilder.phone,
          keyboardType: TextInputType.phone,
          formatter: [
            FilteringTextInputFormatter.allow(RegExp(r'[+0-9]')),
          ],
          onChanged: (String value) {
            //_userBuilder.phone = value;
          },
          validator: (String value) {
            if (value.isEmpty) return '';
            return null;
          },
        ),
        InfoFieldEditProfile(
          title: "Email",
          hintText: "email@gmail.com",
          initialValue: _userBuilder.email,
          keyboardType: TextInputType.emailAddress,
          onChanged: (String value) {
            _userBuilder.email = value;
          },
          validator: (value) {
            if (value.isEmpty ||
                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value)) {
              return '';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildAgentContact() {
    return ExpandableCardEditProfile(
      title: "Контакты агента",
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 15.0,
      ),
      children: [
        SizedBox(height: 20.0),
        InfoFieldEditProfile(
          title: "Имя",
          hintText: "Имя",
          initialValue: _userBuilder.agentName,
          keyboardType: TextInputType.name,
          onChanged: (String value) {
            _userBuilder.agentName = value;
          },
          validator: (String value) {
            if (value.isEmpty) return '';
            return null;
          },
        ),
        InfoFieldEditProfile(
          title: "Фамилия",
          hintText: "Фамилия",
          initialValue: _userBuilder.agentLastName,
          keyboardType: TextInputType.name,
          onChanged: (String value) {
            _userBuilder.agentLastName = value;
          },
          validator: (String value) {
            if (value.isEmpty) return '';
            return null;
          },
        ),
        InfoFieldEditProfile(
          title: "Телефон",
          hintText: "+7 949 397 68 73",
          initialValue: _userBuilder.agentPhone,
          keyboardType: TextInputType.phone,
          formatter: [
            FilteringTextInputFormatter.allow(RegExp(r'[+0-9]')),
          ],
          onChanged: (String value) {
            _userBuilder.agentPhone = value;
          },
          validator: (String value) {
            if (value.isEmpty) return '';
            return null;
          },
        ),
        InfoFieldEditProfile(
          title: "Email",
          hintText: "email@gmail.com",
          initialValue: _userBuilder.agentEmail,
          keyboardType: TextInputType.emailAddress,
          onChanged: (String value) {
            _userBuilder.agentEmail = value;
          },
          validator: (value) {
            if (value.isEmpty ||
                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value)) {
              return '';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSubscriptionManagement() {
    return ExpandableCardEditProfile(
      title: "Управление подпиской",
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 15.0,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 25.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Оплачено до",
                    style: TextStyle(
                      color: Colors.black.withAlpha(165),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "${_userBuilder.subscription.isActiveUntil}",
                    style: TextStyle(
                      color: AppColors.accentColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 35.0),
              GradientButton(
                maxWidth: double.infinity,
                minHeight: 50.0,
                borderRadius: 10.0,
                elevation: 0,
                highlightElevation: 0,
                title: "Продлить",
                onTap: () {},
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Отменить автопродление",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildNotification() {
    List<String> title = ["Мне", "Мне и агенту", "Агенту", "Отключить"];

    return ExpandableCardEditProfile(
      title: "Уведомления",
      margin: const EdgeInsets.only(
        left: 8.0,
        top: 15.0,
        right: 8.0,
      ),
      onExpansionChanged: (bool value) {
        setState(() => _isOpened = value);
      },
      children: [
        ListView.builder(
          itemCount: widget.userProfile.notification.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 16.0),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _changeNotification(index),
              child: Container(
                width: double.infinity,
                height: 50.0,
                margin: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(10),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title[index],
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black.withAlpha(165),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Container(
                      width: 18.0,
                      height: 18.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(90.0)),
                        color: _userBuilder.notification[index] == true
                            ? AppColors.accentColor
                            : Colors.black.withAlpha(40),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCallSwitcher() {
    return AnimatedContainer(
      height: _isOpened ? 0.0 : 100.0,
      duration: Duration(milliseconds: 800),
      curve: Curves.fastLinearToSlowEaseIn,
      margin: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Переключить звонки и сообщения на агента",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black.withAlpha(165),
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(width: 30.0),
          GradientSwitch(
            value: _userBuilder.notification[2] == true ? true : false,
            onChanged: (bool value) {
              if (value = true) {
                _changeNotification(2);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyPolicy() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 22.0, 16.0, 45.0),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return PrivacyDialog(
                textButton: "ЗАКРЫТЬ",
              );
            },
          );
        },
        child: Text(
          "Политика конфеденциальности",
          style: TextStyle(
            color: AppColors.accentColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBarStyle1(
            title: "Личный кабинет",
            onTapLeading: () => _editProfile(),
            onTapAction: () => Navigator.pop(context),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              autovalidate: true,
              child: Column(
                children: [
                  _buildHeader(),
                  _buildMyContact(),
                  _buildAgentContact(),
                  _buildSubscriptionManagement(),
                  _buildNotification(),
                  _buildCallSwitcher(),
                  _buildPrivacyPolicy(),
                ],
              ),
            ),
          ),
        ),
        if (_startLoading == true) WaveIndicator(),
      ],
    );
  }
}
