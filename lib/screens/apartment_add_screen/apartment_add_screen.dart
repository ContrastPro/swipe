import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:swipe/format/price_format.dart';
import 'package:swipe/global/app_colors.dart';
import 'package:swipe/model/address.dart';
import 'package:swipe/model/apartment.dart';
import 'package:swipe/model/promotion.dart';
import 'package:swipe/screens/promotion_screen/promotion_screen.dart';
import 'package:swipe/custom_app_widget/app_bars/app_bar_style_1.dart';
import 'package:swipe/custom_app_widget/fade_route.dart';
import 'package:swipe/custom_app_widget/gradient_button.dart';
import 'package:swipe/screens/search_address_screen/search_address_screen.dart';

import 'api/apartment_add_image_picker.dart';
import 'custom_widget/expandable_card_apartment_add.dart';
import 'custom_widget/info_field_apartment_add.dart';

class ApartmentAddScreen extends StatefulWidget {
  @override
  _ApartmentAddScreenState createState() => _ApartmentAddScreenState();
}

class _ApartmentAddScreenState extends State<ApartmentAddScreen> {
  static const int _photoLength = 6;

  ApartmentBuilder _apartmentBuilder;
  GlobalKey<FormState> _formKey;

  TextEditingController _addressController;

  @override
  void initState() {
    _apartmentBuilder = ApartmentBuilder();
    _formKey = GlobalKey<FormState>();
    _addressController = TextEditingController();
    super.initState();
  }

  void _showFullSizeImage(int index, File image) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Stack(
            children: [
              Center(
                child: Hero(
                  tag: index,
                  child: InteractiveViewer(
                    panEnabled: true,
                    child: Image.file(image),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _goToPromotionScreen(ApartmentAddImagePicker imagePicker) {
    if (_formKey.currentState.validate() &&
        imagePicker.imageList.isNotEmpty &&
        _apartmentBuilder.numberOfRooms != null) {
      _apartmentBuilder.promotionBuilder = PromotionBuilder();
      Navigator.push(
        context,
        FadeRoute(
          page: PromotionScreen(
            apartmentBuilder: _apartmentBuilder,
            imageList: imagePicker.imageList,
          ),
        ),
      );
    }
  }

  void _searchAddress() async {
    AddressBuilder addressBuilder;

    addressBuilder = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchAddressScreen(),
      ),
    );
    if (addressBuilder != null && addressBuilder.address != null) {
      _addressController.text = addressBuilder.address;
      _apartmentBuilder.address = addressBuilder.address;
      _apartmentBuilder.geo = addressBuilder.geo;
      log("$addressBuilder");
    }
  }

  Widget _buildAddress() {
    return Stack(
      children: [
        InfoFieldApartmentAdd(
          title: "Адрес",
          hintText: "Адрес",
          readOnly: true,
          controller: _addressController,
          validator: (String value) {
            if (value.isEmpty) return '';
            return null;
          },
        ),
        Padding(
          padding: const EdgeInsets.only(right: 28.0),
          child: InkWell(
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => _searchAddress(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Указать на карте",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.accentColor,
                  ),
                ),
                SizedBox(width: 10.0),
                Icon(
                  Icons.map_outlined,
                  color: AppColors.accentColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildApartmentComplex() {
    return Stack(
      children: [
        ExpandableCardApartmentAdd(
          title: "ЖК",
          hintText: "Выбрать ЖК",
          children: ["ЖК Радужный", "ЖК Острова"],
          onChange: (String value) {
            _apartmentBuilder.apartmentComplex = value;
          },
        ),
        Padding(
          padding: const EdgeInsets.only(right: 28.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Добавиться в шахматку",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.accentColor,
                ),
              ),
              SizedBox(width: 10.0),
              Icon(
                Icons.playlist_add,
                color: AppColors.accentColor,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFoundingDocument() {
    return ExpandableCardApartmentAdd(
      title: "Документ основания",
      hintText: "Выбрать документ",
      children: ["Собственность"],
      onChange: (String value) {
        _apartmentBuilder.foundingDocument = value;
      },
    );
  }

  Widget _buildAppointmentApartment() {
    return ExpandableCardApartmentAdd(
      title: "Назначение",
      hintText: "Выбрать назначение",
      children: ["Апартаменты"],
      onChange: (String value) {
        _apartmentBuilder.appointmentApartment = value;
      },
    );
  }

  Widget _buildNumberOfRooms() {
    return ExpandableCardApartmentAdd(
      title: "Количество комнат",
      hintText: "Выбрать количество комнат",
      children: ["1-комнатная", "2-комнатная"],
      onChange: (String value) {
        _apartmentBuilder.numberOfRooms = value;
      },
    );
  }

  Widget _buildApartmentLayout() {
    return ExpandableCardApartmentAdd(
      title: "Планировка",
      hintText: "Выбрать планировку",
      children: ["Студия, санузел"],
      onChange: (String value) {
        _apartmentBuilder.apartmentLayout = value;
      },
    );
  }

  Widget _buildApartmentCondition() {
    return ExpandableCardApartmentAdd(
      title: "Жилое состояние",
      hintText: "Выбрать жилое состояние",
      children: ["Требует ремонта"],
      onChange: (String value) {
        _apartmentBuilder.apartmentCondition = value;
      },
    );
  }

  Widget _buildTotalArea() {
    return InfoFieldApartmentAdd(
      title: "Общая площадь (м²)",
      hintText: "Общая площадь",
      keyboardType: TextInputType.number,
      formatter: [
        FilteringTextInputFormatter.allow(RegExp(r'[.0-9]')),
      ],
      onChanged: (String value) {
        _apartmentBuilder.totalArea = value;
      },
      validator: (String value) {
        if (value.isEmpty) return '';
        return null;
      },
    );
  }

  Widget _buildKitchenArea() {
    return InfoFieldApartmentAdd(
      title: "Площадь кухни (м²)",
      hintText: "Площадь кухни",
      keyboardType: TextInputType.number,
      formatter: [
        FilteringTextInputFormatter.allow(RegExp(r'[.0-9]')),
      ],
      onChanged: (String value) {
        _apartmentBuilder.kitchenArea = value;
      },
      validator: (String value) {
        if (value.isEmpty) return '';
        return null;
      },
    );
  }

  Widget _buildBalconyLoggia() {
    return ExpandableCardApartmentAdd(
      title: "Балкон/лоджия",
      hintText: "Присутствует балкон/лоджия",
      children: ["Да", "Нет"],
      onChange: (String value) {
        _apartmentBuilder.balconyLoggia = value;
      },
    );
  }

  Widget _buildHeatingType() {
    return ExpandableCardApartmentAdd(
      title: "Тип отопления",
      hintText: "Выбрать тип отопления",
      children: ["Газовое отопление"],
      onChange: (String value) {
        _apartmentBuilder.heatingType = value;
      },
    );
  }

  Widget _buildTypeOfPayment() {
    return ExpandableCardApartmentAdd(
      title: "Варианты расчёта",
      hintText: "Выбрать варианты расчёта",
      children: ["Мат. капитал"],
      onChange: (String value) {
        _apartmentBuilder.typeOfPayment = value;
      },
    );
  }

  Widget _buildAgentCommission() {
    return ExpandableCardApartmentAdd(
      title: "Коммисия агенту (₽)",
      hintText: "Выбрать коммисию агенту",
      children: ["100 000"],
      onChange: (String value) {
        _apartmentBuilder.agentCommission = value;
      },
    );
  }

  Widget _buildCommunicationMethod() {
    return ExpandableCardApartmentAdd(
      title: "Способ связи",
      hintText: "Выбрать способ связи",
      children: ["Звонок + сообщение"],
      onChange: (String value) {
        _apartmentBuilder.communicationMethod = value;
      },
    );
  }

  Widget _buildDescription() {
    return InfoFieldApartmentAdd(
      title: "Описание",
      hintText: "Описание",
      keyboardType: TextInputType.multiline,
      maxLines: 8,
      onChanged: (String value) {
        _apartmentBuilder.description = value;
      },
      validator: (String value) {
        if (value.isEmpty) return '';
        return null;
      },
    );
  }

  Widget _buildPrice() {
    return InfoFieldApartmentAdd(
      title: "Цена (₽)",
      hintText: "Цена",
      keyboardType: TextInputType.number,
      formatter: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      onChanged: (String value) {
        _apartmentBuilder.price = PriceFormat.formatPrice(price: value);
      },
      validator: (String value) {
        if (value.isEmpty) return '';
        return null;
      },
    );
  }

  Widget _buildImagePicker(ApartmentAddImagePicker imagePicker) {
    double thickness = 30.0;

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 250,
            childAspectRatio: 1.5,
            crossAxisSpacing: 15,
            mainAxisSpacing: 20,
          ),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: imagePicker.imageList.length + 1,
          padding: const EdgeInsets.fromLTRB(16.0, 28.0, 16.0, 16.0),
          itemBuilder: (context, index) {
            if (index == imagePicker.imageList.length && index < _photoLength) {
              return GestureDetector(
                onTap: () => imagePicker.getLocalImage(),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(color: Colors.black38),
                      ),
                    ),
                    Container(
                      width: thickness,
                      height: 1.0,
                      color: Colors.black38,
                    ),
                    Container(
                      width: 1.0,
                      height: thickness,
                      color: Colors.black38,
                    ),
                  ],
                ),
              );
            } else if (index < _photoLength) {
              return Stack(
                children: [
                  GestureDetector(
                    onTap: () => _showFullSizeImage(
                      index,
                      imagePicker.imageList[index],
                    ),
                    child: Hero(
                      tag: index,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          image: DecorationImage(
                            image: FileImage(
                              imagePicker.imageList[index],
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: GestureDetector(
                      onTap: () => imagePicker.deleteImage(index),
                      child: Container(
                        width: 32.0,
                        height: 32.0,
                        padding: const EdgeInsets.only(
                          left: 3.0,
                          bottom: 3.0,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15.0),
                            bottomLeft: Radius.circular(30.0),
                          ),
                          color: Colors.red[900],
                        ),
                        child: Icon(
                          Icons.delete_forever,
                          color: Colors.white,
                          size: 18.0,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return SizedBox();
            }
          },
        ),
        if (imagePicker.imageList.isNotEmpty)
          Row(
            children: [
              Expanded(
                child: Text(
                  "Главное фото",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black54,
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
            ],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ApartmentAddImagePicker>(
      create: (_) => ApartmentAddImagePicker(),
      child: Scaffold(
        appBar: AppBarStyle1(
          title: "Новое объявление",
          onTapLeading: () => Navigator.pop(context),
          onTapAction: () => Navigator.pop(context),
        ),
        body: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 30.0, bottom: 60.0),
            physics: BouncingScrollPhysics(),
            child: Consumer<ApartmentAddImagePicker>(
              builder: (context, imagePicker, child) {
                return Column(
                  children: [
                    _buildAddress(),
                    _buildApartmentComplex(),
                    _buildFoundingDocument(),
                    _buildAppointmentApartment(),
                    _buildNumberOfRooms(),
                    _buildApartmentLayout(),
                    _buildApartmentCondition(),
                    _buildTotalArea(),
                    _buildKitchenArea(),
                    _buildBalconyLoggia(),
                    _buildHeatingType(),
                    _buildTypeOfPayment(),
                    _buildAgentCommission(),
                    _buildCommunicationMethod(),
                    _buildDescription(),
                    _buildPrice(),
                    _buildImagePicker(imagePicker),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 25.0,
                      ),
                      child: GradientButton(
                        title: "Продолжить",
                        maxWidth: double.infinity,
                        minHeight: 50.0,
                        borderRadius: 10.0,
                        onTap: () => _goToPromotionScreen(imagePicker),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
