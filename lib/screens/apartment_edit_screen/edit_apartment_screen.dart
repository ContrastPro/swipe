import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:swipe/custom_app_widget/fade_route.dart';
import 'package:swipe/custom_app_widget/loading_indicator.dart';
import 'package:swipe/custom_app_widget/modal_bottom_sheet.dart';
import 'package:swipe/format/price_format.dart';
import 'package:swipe/model/apartment.dart';
import 'package:swipe/network_connectivity/network_connectivity.dart';
import 'package:swipe/custom_app_widget/app_bars/app_bar_style_1.dart';
import 'package:swipe/custom_app_widget/gradient_button.dart';
import 'package:swipe/screens/apartment_edit_screen/custom_widget/image_slider.dart';
import 'package:swipe/screens/home_screen/home_screen.dart';

import 'api/apartment_edit_cloudstore_api.dart';
import 'api/apartment_edit_firestore_api.dart';
import 'api/apartment_edit_image_picker.dart';
import 'custom_widget/expandable_card_apartment_edit.dart';
import 'custom_widget/info_field_apartment_edit.dart';

class ApartmentEditScreen extends StatefulWidget {
  final ApartmentBuilder apartmentBuilder;

  const ApartmentEditScreen({
    Key key,
    @required this.apartmentBuilder,
  }) : super(key: key);

  @override
  _ApartmentEditScreenState createState() => _ApartmentEditScreenState();
}

class _ApartmentEditScreenState extends State<ApartmentEditScreen> {
  bool _startLoading = false;

  ApartmentBuilder _apartmentBuilder;
  GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _apartmentBuilder = ApartmentBuilder();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  void _goToHomeScreen() {
    Navigator.pushAndRemoveUntil(
        context, FadeRoute(page: HomeScreen()), (route) => false);
  }

  void _saveApartment(ApartmentEditImagePicker imagePicker) {
    if (_formKey.currentState.validate() &&
        _apartmentBuilder.numberOfRooms != null) {}
    //_goToHomeScreen();
  }

  void _deleteApartment() async {
    setState(() => _startLoading = true);
    // Удаляем все фото
    await Future.wait(widget.apartmentBuilder.images.map((imageURL) {
      return ApartmentEditCloudstoreAPI.deleteApartmentImages(
        imageURL: imageURL,
      );
    }));

    // Удаляем всю информацию
    await ApartmentEditFirestoreAPI.deleteApartment(
      apartment: Apartment(apartmentBuilder: widget.apartmentBuilder),
    );
    _goToHomeScreen();
  }

  Widget _buildAddress() {
    return InfoFieldApartmentEdit(
      title: "Адрес",
      hintText: widget.apartmentBuilder.address,
      readOnly: true,
      validator: (String value) {
        if (value.isEmpty) return '';
        return null;
      },
    );
  }

  Widget _buildFoundingDocument() {
    return ExpandableCardApartmentEdit(
      title: "Документ основания",
      hintText: widget.apartmentBuilder.foundingDocument ??
          "Выбрать документ основания",
      children: ["Собственность"],
      onChange: (String value) {
        _apartmentBuilder.foundingDocument = value;
      },
    );
  }

  Widget _buildAppointmentApartment() {
    return ExpandableCardApartmentEdit(
      title: "Назначение",
      hintText:
          widget.apartmentBuilder.appointmentApartment ?? "Выбрать назначение",
      children: ["Апартаменты"],
      onChange: (String value) {
        _apartmentBuilder.appointmentApartment = value;
      },
    );
  }

  Widget _buildNumberOfRooms() {
    return ExpandableCardApartmentEdit(
      title: "Количество комнат",
      hintText:
          widget.apartmentBuilder.numberOfRooms ?? "Выбрать количество комнат",
      children: ["1-комнатная", "2-комнатная"],
      onChange: (String value) {
        _apartmentBuilder.numberOfRooms = value;
      },
    );
  }

  Widget _buildApartmentLayout() {
    return ExpandableCardApartmentEdit(
      title: "Планировка",
      hintText: widget.apartmentBuilder.apartmentLayout ?? "Выбрать планировку",
      children: ["Студия, санузел"],
      onChange: (String value) {
        _apartmentBuilder.apartmentLayout = value;
      },
    );
  }

  Widget _buildApartmentCondition() {
    return ExpandableCardApartmentEdit(
      title: "Жилое состояние",
      hintText: widget.apartmentBuilder.apartmentCondition ??
          "Выбрать жилое состояние",
      children: ["Требует ремонта"],
      onChange: (String value) {
        _apartmentBuilder.apartmentCondition = value;
      },
    );
  }

  Widget _buildTotalArea() {
    return InfoFieldApartmentEdit(
      title: "Общая площадь (м²)",
      hintText: "Общая площадь",
      initialValue: widget.apartmentBuilder.totalArea,
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
    return InfoFieldApartmentEdit(
      title: "Площадь кухни (м²)",
      hintText: "Площадь кухни",
      initialValue: widget.apartmentBuilder.kitchenArea,
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
    return ExpandableCardApartmentEdit(
      title: "Балкон/лоджия",
      hintText:
          widget.apartmentBuilder.balconyLoggia ?? "Присутствует балкон/лоджия",
      children: ["Да", "Нет"],
      onChange: (String value) {
        _apartmentBuilder.balconyLoggia = value;
      },
    );
  }

  Widget _buildHeatingType() {
    return ExpandableCardApartmentEdit(
      title: "Тип отопления",
      hintText: widget.apartmentBuilder.heatingType ?? "Выбрать тип отопления",
      children: ["Газовое отопление"],
      onChange: (String value) {
        _apartmentBuilder.heatingType = value;
      },
    );
  }

  Widget _buildTypeOfPayment() {
    return ExpandableCardApartmentEdit(
      title: "Варианты расчёта",
      hintText:
          widget.apartmentBuilder.typeOfPayment ?? "Выбрать варианты расчёта",
      children: ["Мат. капитал"],
      onChange: (String value) {
        _apartmentBuilder.typeOfPayment = value;
      },
    );
  }

  Widget _buildAgentCommission() {
    return ExpandableCardApartmentEdit(
      title: "Коммисия агенту (₽)",
      hintText:
          widget.apartmentBuilder.agentCommission ?? "Выбрать коммисию агенту",
      children: ["100 000"],
      onChange: (String value) {
        _apartmentBuilder.agentCommission = value;
      },
    );
  }

  Widget _buildCommunicationMethod() {
    return ExpandableCardApartmentEdit(
      title: "Способ связи",
      hintText:
          widget.apartmentBuilder.communicationMethod ?? "Выбрать способ связи",
      children: ["Звонок + сообщение"],
      onChange: (String value) {
        _apartmentBuilder.communicationMethod = value;
      },
    );
  }

  Widget _buildDescription() {
    return InfoFieldApartmentEdit(
      title: "Описание",
      hintText: "Описание",
      initialValue: widget.apartmentBuilder.description,
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
    return InfoFieldApartmentEdit(
      title: "Цена (₽)",
      hintText: "Цена",
      initialValue: widget.apartmentBuilder.price,
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

  Widget _buildImagePicker(ApartmentEditImagePicker imagePicker) {
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
          itemCount: imagePicker.imageUrlList.length,
          padding: const EdgeInsets.fromLTRB(16.0, 28.0, 16.0, 16.0),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  FadeRoute(
                    page: ImageSlider(
                      imageList: imagePicker.imageUrlList,
                    ),
                  ),
                );
              },
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: CachedNetworkImage(
                  imageUrl: imagePicker.imageUrlList[index],
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ApartmentEditImagePicker>(
      create: (_) => ApartmentEditImagePicker(
        imageUrlList: widget.apartmentBuilder.images,
      ),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBarStyle1(
              title: "Редактирование",
              onTapLeading: () => Navigator.pop(context),
              onTapAction: () => Navigator.pop(context),
            ),
            body: NetworkConnectivity(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: 30.0, bottom: 60.0),
                  physics: BouncingScrollPhysics(),
                  child: Consumer<ApartmentEditImagePicker>(
                    builder: (context, imagePicker, child) {
                      return Column(
                        children: [
                          _buildAddress(),
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
                              title: "Сохранить",
                              maxWidth: double.infinity,
                              minHeight: 50.0,
                              borderRadius: 10.0,
                              onTap: () => _saveApartment(imagePicker),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return ModalBottomSheet(
                                    title: "Удалить объявление",
                                    subtitle: "Действие нельзя будет отменить. "
                                        "Продолжить?",
                                    onAccept: () => _deleteApartment(),
                                  );
                                },
                              );
                            },
                            highlightColor: Colors.transparent,
                            child: Text(
                              "Удалить объявление",
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 15.0,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          if (_startLoading == true) WaveIndicator(),
        ],
      ),
    );
  }
}
