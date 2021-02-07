import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swipe/custom_app_widget/app_bars/app_bar_style_1.dart';
import 'package:swipe/custom_app_widget/loading_indicator.dart';
import 'package:swipe/model/custom_user.dart';
import 'package:swipe/screens/edit_profile/api/edit_profile_cloudstore_api.dart';
import 'package:swipe/screens/edit_profile/api/edit_profile_firestore_api.dart';
import 'package:swipe/screens/edit_profile/custom_widget/avatar_picker.dart';
import 'package:swipe/screens/edit_profile/custom_widget/expandable_card.dart';
import 'package:swipe/screens/edit_profile/custom_widget/info_field.dart';
import 'package:swipe/screens/edit_profile/local_image_picker.dart';

class EditProfile extends StatefulWidget {
  final UserBuilder userProfile;

  const EditProfile({Key key, this.userProfile}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool startLoading = false;
  File _imageFile;

  UserBuilder _userBuilder;
  LocalImagePicker _imagePicker;
  GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _userBuilder = widget.userProfile;
    _formKey = GlobalKey<FormState>();
    _imagePicker = LocalImagePicker();
    super.initState();
  }

  void _editProfile() async {
    if (_formKey.currentState.validate()) {
      setState(() => startLoading = true);
      if (_userBuilder.phone != widget.userProfile.phone) {
        // Обновить телефон в профиле FirebaseAuth
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
    return ExpandableCard(
      title: "Мои контакты",
      margin: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        bottom: 15.0,
      ),
      children: [
        SizedBox(height: 20.0),
        InfoField(
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
        InfoField(
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
        InfoField(
          title: "Телефон",
          hintText: "+7 928 245 20 20",
          initialValue: _userBuilder.phone,
          keyboardType: TextInputType.phone,
          formatter: [
            FilteringTextInputFormatter.allow(RegExp(r'[+0-9]')),
          ],
          onChanged: (String value) {
            _userBuilder.phone = value;
          },
          validator: (String value) {
            if (value.isEmpty) return '';
            return null;
          },
        ),
        InfoField(
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
    return ExpandableCard(
      title: "Контакты агента",
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 15.0,
      ),
      children: [
        SizedBox(height: 20.0),
        InfoField(
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
        InfoField(
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
        InfoField(
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
        InfoField(
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
    return ExpandableCard(
      title: "Управление подпиской",
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 15.0,
      ),
      children: [
        SizedBox(height: 20.0),
      ],
    );
  }

  Widget _buildNotification() {
    return ExpandableCard(
      title: "Уведомления",
      margin: const EdgeInsets.only(
        left: 8.0,
        top: 15.0,
        right: 8.0,
        bottom: 35.0,
      ),
      children: [
        SizedBox(height: 20.0),
      ],
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
                ],
              ),
            ),
          ),
        ),
        if (startLoading == true) WaveIndicator(),
      ],
    );
  }
}
