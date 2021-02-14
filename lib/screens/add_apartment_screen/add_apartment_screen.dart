import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swipe/custom_app_widget/app_bars/app_bar_style_1.dart';
import 'package:swipe/custom_app_widget/gradient_button.dart';
import 'package:swipe/global/app_colors.dart';
import 'package:swipe/model/apartment.dart';
import 'package:swipe/screens/add_apartment_screen/custom_widget/expandable_card_add_apartment.dart';
import 'package:swipe/screens/add_apartment_screen/custom_widget/info_field_add_apartment.dart';

class AddApartmentScreen extends StatefulWidget {
  @override
  _AddApartmentScreenState createState() => _AddApartmentScreenState();
}

class _AddApartmentScreenState extends State<AddApartmentScreen> {
  ApartmentBuilder _apartmentBuilder;
  TextEditingController _addressController;

  @override
  void initState() {
    _apartmentBuilder = ApartmentBuilder();
    _addressController = TextEditingController();
    super.initState();
  }


  Widget _buildAddress() {
    return Stack(
      children: [
        InfoFieldAddApartment(
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
                Icons.map,
                color: AppColors.accentColor,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildApartmentComplex(){
    return ExpandableCardAddApartment(
      title: "ЖК",
      hintText: "Выбрать ЖК",
      children: ["ЖК Радужный", "ЖК Острова"],
      onChange: (String value) {
        _apartmentBuilder.apartmentComplex = value;
      },
    );
  }

  Widget _buildFoundingDocument(){
    return ExpandableCardAddApartment(
      title: "Документ основания",
      hintText: "Выбрать документ",
      children: ["Собственность"],
      onChange: (String value) {
        _apartmentBuilder.foundingDocument = value;
      },
    );
  }

  Widget _buildAppointmentApartment(){
    return ExpandableCardAddApartment(
      title: "Назначение",
      hintText: "Выбрать назначение",
      children: ["Апартаменты"],
      onChange: (String value) {
        _apartmentBuilder.appointmentApartment = value;
      },
    );
  }

  Widget _buildNumberOfRooms(){
    return ExpandableCardAddApartment(
      title: "Количество комнат",
      hintText: "Выбрать количество комнат",
      children: ["1 комнатная", "2 комнатная"],
      onChange: (String value) {
        _apartmentBuilder.numberOfRooms = value;
      },
    );
  }

  Widget _buildApartmentLayout(){
    return ExpandableCardAddApartment(
      title: "Планировка",
      hintText: "Выбрать планировку",
      children: ["Студия, санузел"],
      onChange: (String value) {
        _apartmentBuilder.apartmentLayout = value;
      },
    );
  }

  Widget _buildApartmentCondition(){
    return ExpandableCardAddApartment(
      title: "Жилое состояние",
      hintText: "Выбрать жилое состояние",
      children: ["Требует ремонта"],
      onChange: (String value) {
        _apartmentBuilder.apartmentCondition = value;
      },
    );
  }

  Widget _buildTotalArea() {
    return InfoFieldAddApartment(
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
    return InfoFieldAddApartment(
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

  Widget _buildBalconyLoggia(){
    return ExpandableCardAddApartment(
      title: "Балкон/лоджия",
      hintText: "Присутствует балкон/лоджия",
      children: ["Да", "Нет"],
      onChange: (String value) {
        _apartmentBuilder.balconyLoggia = value;
      },
    );
  }

  Widget _buildHeatingType(){
    return ExpandableCardAddApartment(
      title: "Тип отопления",
      hintText: "Выбрать тип отопления",
      children: ["Газовое отопление"],
      onChange: (String value) {
        _apartmentBuilder.heatingType = value;
      },
    );
  }

  Widget _buildTypeOfPayment(){
    return ExpandableCardAddApartment(
      title: "Варианты расчёта",
      hintText: "Выбрать варианты расчёта",
      children: ["Мат. капитал"],
      onChange: (String value) {
        _apartmentBuilder.typeOfPayment = value;
      },
    );
  }

  Widget _buildAgentCommission(){
    return ExpandableCardAddApartment(
      title: "Коммисия агенту",
      hintText: "Выбрать коммисию агенту",
      children: ["100 000 ₽"],
      onChange: (String value) {
        _apartmentBuilder.agentCommission = value;
      },
    );
  }

  Widget _buildCommunicationMethod(){
    return ExpandableCardAddApartment(
      title: "Способ связи",
      hintText: "Выбрать способ связи",
      children: ["Звонок + сообщение"],
      onChange: (String value) {
        _apartmentBuilder.communicationMethod = value;
      },
    );
  }

  Widget _buildDescription() {
    return InfoFieldAddApartment(
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
    return InfoFieldAddApartment(
      title: "Цена (₽)",
      hintText: "Цена",
      keyboardType: TextInputType.number,
      formatter: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      onChanged: (String value){
        _apartmentBuilder.price = value;
      },
      validator: (String value) {
        if (value.isEmpty) return '';
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarStyle1(
        title: "Новое объявление",
        onTapLeading: () => Navigator.pop(context),
        onTapAction: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 30.0, bottom: 60.0),
        physics: BouncingScrollPhysics(),
        child: Column(
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
                onTap: () {
                  print(_apartmentBuilder);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
