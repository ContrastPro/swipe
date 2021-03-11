import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swipe/global/style/app_colors.dart';
import 'package:swipe/model/building.dart';
import 'package:swipe/model/custom_user.dart';
import 'package:swipe/custom_app_widget/app_bars/app_bar_style_1.dart';
import 'package:swipe/custom_app_widget/gradient_button.dart';
import 'package:swipe/custom_app_widget/gradient_switch.dart';
import 'package:swipe/custom_app_widget/loading_indicator.dart';
import 'package:swipe/custom_app_widget/privacy_dialog.dart';
import 'package:swipe/model/news.dart';

import 'api/avatar_image_picker.dart';
import 'api/edit_profile_firestore_api.dart';
import 'custom_widget/avatar_picker.dart';
import 'custom_widget/expandable_card_edit_profile.dart';
import 'custom_widget/expandable_card_options_edit_profile.dart';
import 'custom_widget/info_field_edit_profile.dart';

class EditProfileScreen extends StatefulWidget {
  final UserBuilder userProfile;

  const EditProfileScreen({
    Key key,
    this.userProfile,
  }) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _startLoading = false;
  bool _isOpened = false;
  File _imageFile;

  UserBuilder _userBuilder;
  BuildingBuilder _buildingBuilder;
  GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _userBuilder = widget.userProfile.clone();
    _buildingBuilder = _userBuilder.buildingBuilder;
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  void _getLocalImage() async {
    File imageFile = await AvatarImagePicker.getLocalImage();
    setState(() => _imageFile = imageFile);
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
      log("${_userBuilder.notification}");
    }
  }

  void _updateProfile() async {
    if (_formKey.currentState.validate() &&
        _userBuilder.name.isNotEmpty &&
        _userBuilder.lastName.isNotEmpty &&
        _userBuilder.email.isNotEmpty) {
      //
      setState(() => _startLoading = true);
      _userBuilder.buildingBuilder = _buildingBuilder;
      //
      await EditProfileFirestoreAPI.updateUserProfile(
        userBuilder: _userBuilder,
        imageFile: _imageFile,
      );

      //
      if (_buildingBuilder != null && _buildingBuilder.id != null) {
        await EditProfileFirestoreAPI.updateBuilding(
          buildingBuilder: _buildingBuilder,
        );
      }
      Navigator.pop(context);
    }
  }

  void _uploadBuilding() async {
    setState(() => _startLoading = true);
    await EditProfileFirestoreAPI.uploadBuilding(
      buildingBuilder: _buildingBuilder,
    );
    Navigator.pop(context);
  }

  void _uploadNews(NewsBuilder newsBuilder) async {
    if (newsBuilder.title.isNotEmpty && newsBuilder.description.isNotEmpty) {
      setState(() => _startLoading = true);
      await EditProfileFirestoreAPI.uploadNews(
        newsBuilder: newsBuilder,
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
            onTap: () => _getLocalImage(),
          ),
          SizedBox(width: 22.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${_userBuilder.name} "
                  "${_userBuilder.lastName}",
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  _userBuilder.email,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
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
          formatter: [
            FilteringTextInputFormatter.deny(RegExp(' ')),
          ],
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
          formatter: [
            FilteringTextInputFormatter.deny(RegExp(' ')),
          ],
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
          readOnly: true,
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
        InfoFieldEditProfile(
          title: "Email",
          hintText: "email@gmail.com",
          initialValue: _userBuilder.email,
          keyboardType: TextInputType.emailAddress,
          onChanged: (String value) {
            _userBuilder.email = value;
          },
          formatter: [
            FilteringTextInputFormatter.deny(RegExp(' ')),
          ],
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

  Widget _buildAgentContact(String title) {
    return ExpandableCardEditProfile(
      title: title,
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
          formatter: [
            FilteringTextInputFormatter.deny(RegExp(' ')),
          ],
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
          formatter: [
            FilteringTextInputFormatter.deny(RegExp(' ')),
          ],
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
          formatter: [
            FilteringTextInputFormatter.deny(RegExp(' ')),
          ],
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

  // Custom
  Widget _buildSubscriptionManagement() {
    return ExpandableCardEditProfile(
      title: "Управление подпиской",
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
                    "13.12.2021",
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
      onExpansionChanged: (bool value) {
        setState(() => _isOpened = value);
      },
      children: [
        ListView.builder(
          itemCount: _userBuilder.notification.length,
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
                  borderRadius: BorderRadius.circular(10.0),
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
                        borderRadius: BorderRadius.circular(45.0),
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

  // Developer
  Widget _buildBookApartment() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
      child: Column(
        children: [
          GradientButton(
            maxWidth: double.infinity,
            minHeight: 55.0,
            borderRadius: 10.0,
            elevation: 0,
            title: _buildingBuilder.id != null
                ? "Забронировать квартиру"
                : "Опубликовать ЖК",
            onTap: () {
              if (_buildingBuilder.id == null) {
                _uploadBuilding();
              } else {
                //
              }
            },
          ),
          if (_buildingBuilder.id != null) ...[
            SizedBox(height: 32.0),
            OutlinedButton(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  Size(double.infinity, 55),
                ),
                padding: MaterialStateProperty.all(
                  EdgeInsets.all(20.0),
                ),
                side: MaterialStateProperty.all(
                  BorderSide(color: Colors.black45),
                ),
                overlayColor: MaterialStateProperty.all(
                  Colors.black12,
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              child: Text(
                "Запросы на добавление в шахматку",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {},
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildUpdateApartmentComplexInfo() {
    return ExpandableCardEditProfile(
      title: "Обновить информацию о ЖК",
      children: [
        SizedBox(height: 20.0),
        InfoFieldEditProfile(
          title: "Описание",
          hintText: "Описание",
          initialValue: _buildingBuilder.description,
          maxLines: 8,
          keyboardType: TextInputType.multiline,
          onChanged: (String value) {
            _buildingBuilder.description = value;
          },
          validator: (String value) {
            if (value.isEmpty) return '';
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildInfrastructureApartmentComplex() {
    return ExpandableCardEditProfile(
      title: "Инфраструктура ЖК",
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 22.0, 12.0, 42.0),
          child: GradientButton(
            maxWidth: double.infinity,
            minHeight: 55.0,
            borderRadius: 10.0,
            elevation: 0,
            title: "Преимущества ЖК",
            onTap: () {
              // Открываем окно с выбором преимущества передаём список
              // преимуществ, ждём выбора, возвращаем и присваиваем этот
              // список в билдер
            },
          ),
        ),
        ExpandableCardOptionsEditProfile(
          title: "Статус ЖК",
          hintText: "Выбрать статус ЖК",
          children: ["Квартиры"],
          onChange: (String value) {
            //_apartmentBuilder.numberOfRooms = value;
          },
        ),
        ExpandableCardOptionsEditProfile(
          title: "Вид дома",
          hintText: "Выбрать вид дома",
          children: ["Многоквартирный"],
          onChange: (String value) {
            //_apartmentBuilder.numberOfRooms = value;
          },
        ),
        ExpandableCardOptionsEditProfile(
          title: "Класс дома",
          hintText: "Выбрать класс дома",
          children: ["Элитный"],
          onChange: (String value) {
            //_apartmentBuilder.numberOfRooms = value;
          },
        ),
        ExpandableCardOptionsEditProfile(
          title: "Технология строительства",
          hintText: "Выбрать технологию строительства",
          children: ["Монолитный каркас с керомзитным утеплением"],
          onChange: (String value) {
            //_apartmentBuilder.numberOfRooms = value;
          },
        ),
        ExpandableCardOptionsEditProfile(
          title: "Территория",
          hintText: "Выбрать территорию",
          children: ["Закрытая, охраняемая"],
          onChange: (String value) {
            //_apartmentBuilder.numberOfRooms = value;
          },
        ),
        InfoFieldEditProfile(
          title: "Растояние до моря (м)",
          hintText: "2 000",
          //initialValue: _userBuilder.agentPhone,
          keyboardType: TextInputType.number,
          formatter: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          ],
          onChanged: (String value) {
            //_userBuilder.agentPhone = value;
          },
          validator: (String value) {
            if (value.isEmpty) return '';
            return null;
          },
        ),
        ExpandableCardOptionsEditProfile(
          title: "Коммунальные платежи",
          hintText: "Выбрать платежи",
          children: ["Платежи"],
          onChange: (String value) {
            //_apartmentBuilder.numberOfRooms = value;
          },
        ),
        InfoFieldEditProfile(
          title: "Высота потолков (м)",
          hintText: "3.5",
          //initialValue: _userBuilder.agentPhone,
          keyboardType: TextInputType.number,
          formatter: [
            FilteringTextInputFormatter.allow(RegExp(r'[.0-9]')),
          ],
          onChanged: (String value) {
            //_userBuilder.agentPhone = value;
          },
          validator: (String value) {
            if (value.isEmpty) return '';
            return null;
          },
        ),
        ExpandableCardOptionsEditProfile(
          title: "Газ",
          hintText: "Присутствует газ",
          children: ["Нет", "Да"],
          onChange: (String value) {
            //_apartmentBuilder.numberOfRooms = value;
          },
        ),
        ExpandableCardOptionsEditProfile(
          title: "Отопление",
          hintText: "Выбрать тип отопления",
          children: ["Центральное"],
          onChange: (String value) {
            //_apartmentBuilder.numberOfRooms = value;
          },
        ),
        ExpandableCardOptionsEditProfile(
          title: "Канализация",
          hintText: "Выбрать тип канализации",
          children: ["Центральная"],
          onChange: (String value) {
            //_apartmentBuilder.numberOfRooms = value;
          },
        ),
        ExpandableCardOptionsEditProfile(
          title: "Водоснабжение",
          hintText: "Выбрать тип водоснабжения",
          children: ["Центральное"],
          onChange: (String value) {
            //_apartmentBuilder.numberOfRooms = value;
          },
        ),
      ],
    );
  }

  Widget _buildTypeOfPayment() {
    return ExpandableCardEditProfile(
      title: "Оформление и оплата",
      children: [
        SizedBox(height: 20.0),
        ExpandableCardOptionsEditProfile(
          title: "Оформление",
          hintText: "Выбрать тип оформления",
          children: ["Юстиция"],
          onChange: (String value) {
            //_apartmentBuilder.numberOfRooms = value;
          },
        ),
        ExpandableCardOptionsEditProfile(
          title: "Варианты расчета",
          hintText: "Выбрать тип расчета",
          children: ["Ипотека"],
          onChange: (String value) {
            //_apartmentBuilder.numberOfRooms = value;
          },
        ),
        ExpandableCardOptionsEditProfile(
          title: "Назначение",
          hintText: "Выбрать назначение",
          children: ["Жилое помещение"],
          onChange: (String value) {
            //_apartmentBuilder.numberOfRooms = value;
          },
        ),
        ExpandableCardOptionsEditProfile(
          title: "Сумма в договоре",
          hintText: "Выбрать сумму",
          children: ["Неполная"],
          onChange: (String value) {
            //_apartmentBuilder.numberOfRooms = value;
          },
        ),
      ],
    );
  }

  Widget _buildAddNews() {
    NewsBuilder newsBuilder = NewsBuilder();

    return ExpandableCardEditProfile(
      title: "Добавить новость",
      children: [
        InfoFieldEditProfile(
          title: "Заголовок",
          hintText: "Заголовок",
          onChanged: (String value) {
            newsBuilder.title = value;
          },
          validator: (String value) {
            if (value.isEmpty) return '';
            return null;
          },
        ),
        InfoFieldEditProfile(
          title: "Описание",
          hintText: "Описание",
          maxLines: 8,
          keyboardType: TextInputType.multiline,
          onChanged: (String value) {
            newsBuilder.description = value;
          },
          validator: (String value) {
            if (value.isEmpty) return '';
            return null;
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 16.0,
          ),
          child: GradientButton(
            maxWidth: double.infinity,
            minHeight: 55.0,
            borderRadius: 10.0,
            elevation: 0,
            title: "Опубликовать",
            onTap: () => _uploadNews(newsBuilder),
          ),
        ),
      ],
    );
  }

  Widget _buildPrivacyPolicy() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 22.0, 16.0, 45.0),
      child: GestureDetector(
        onTap: () => PrivacyDialog.showPrivacyDialog(context: context),
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
            onTapLeading: () => _updateProfile(),
            onTapAction: () => Navigator.pop(context),
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                _buildHeader(),
                if (_buildingBuilder == null) ...[
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        _buildMyContact(),
                        _buildAgentContact("Контакты агента"),
                        _buildSubscriptionManagement(),
                        _buildNotification(),
                        _buildCallSwitcher(),
                      ],
                    ),
                  ),
                ],
                if (_buildingBuilder != null) ...[
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      children: [
                        _buildBookApartment(),
                        _buildMyContact(),
                        _buildUpdateApartmentComplexInfo(),
                        _buildInfrastructureApartmentComplex(),
                        _buildTypeOfPayment(),
                        _buildAgentContact("Отдел продаж"),
                      ],
                    ),
                  ),
                  _buildAddNews(),
                ],
                _buildPrivacyPolicy(),
              ],
            ),
          ),
        ),
        if (_startLoading == true) WaveIndicator(),
      ],
    );
  }
}
