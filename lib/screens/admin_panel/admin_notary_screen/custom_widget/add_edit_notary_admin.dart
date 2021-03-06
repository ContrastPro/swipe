import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swipe/custom_app_widget/gradient_button.dart';
import 'package:swipe/custom_app_widget/loading_indicator.dart';
import 'package:swipe/format/phone_format.dart';
import 'package:swipe/global/style/app_colors.dart';
import 'package:swipe/model/notary.dart';
import 'package:swipe/screens/admin_panel/admin_notary_screen/api/avatar_image_picker_admin.dart';
import 'package:swipe/screens/admin_panel/admin_notary_screen/api/notary_firestore_admin_api.dart';

import 'avatar_picker_admin.dart';
import 'input_field_notary_admin.dart';

class AddEditNotaryAdmin extends StatefulWidget {
  final bool isOpen;
  final NotaryBuilder notaryBuilder;
  final VoidCallback switchState;

  const AddEditNotaryAdmin({
    Key key,
    @required this.isOpen,
    @required this.notaryBuilder,
    @required this.switchState,
  }) : super(key: key);

  @override
  _AddEditNotaryAdminState createState() => _AddEditNotaryAdminState();
}

class _AddEditNotaryAdminState extends State<AddEditNotaryAdmin> {
  File _imageFile;
  bool _startLoading = false;
  GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  void _getLocalImage() async {
    File imageFile = await AvatarImagePickerAdmin.getLocalImage();
    setState(() => _imageFile = imageFile);
  }

  void _addEditNotary() async {
    if (_formKey.currentState.validate()) {
      setState(() => _startLoading = true);
      widget.notaryBuilder.phone = PhoneFormat.formatPhone(
        phone: widget.notaryBuilder.phone,
      );
      if (widget.notaryBuilder.id == null) {
        await NotaryFirestoreAdminAPI.addNotary(
          notaryBuilder: widget.notaryBuilder,
          imageFile: _imageFile,
        );
      } else {
        await NotaryFirestoreAdminAPI.editNotary(
          notaryBuilder: widget.notaryBuilder,
          imageFile: _imageFile,
        );
      }
      setState(() => _startLoading = false);
      widget.switchState();
      log("${widget.notaryBuilder}");
    }
  }

  void _deleteNotary() {
    NotaryFirestoreAdminAPI.deleteNotary(
      notaryBuilder: widget.notaryBuilder,
    );
    widget.switchState();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildContent() {
      return Column(
        children: [
          AvatarPickerAdmin(
            imageFile: _imageFile,
            photoURL: widget.notaryBuilder.photoURL,
            onTap: () => _getLocalImage(),
          ),
          SizedBox(height: 20.0),
          InputFieldNotaryAdmin(
            hintText: "Имя",
            keyboardType: TextInputType.name,
            initialValue: widget.notaryBuilder.name,
            formatter: [
              FilteringTextInputFormatter.deny(RegExp(' ')),
            ],
            onChanged: (String value) {
              widget.notaryBuilder.name = value;
            },
            validator: (String value) {
              if (value.isEmpty) return '';
              return null;
            },
          ),
          InputFieldNotaryAdmin(
            hintText: "Фамилия",
            keyboardType: TextInputType.name,
            initialValue: widget.notaryBuilder.lastName,
            formatter: [
              FilteringTextInputFormatter.deny(RegExp(' ')),
            ],
            onChanged: (String value) {
              widget.notaryBuilder.lastName = value;
            },
            validator: (String value) {
              if (value.isEmpty) return '';
              return null;
            },
          ),
          InputFieldNotaryAdmin(
            hintText: "Телефон",
            keyboardType: TextInputType.phone,
            initialValue: widget.notaryBuilder.phone,
            formatter: [
              FilteringTextInputFormatter.allow(RegExp(r'[+0-9]')),
            ],
            onChanged: (String value) {
              widget.notaryBuilder.phone = value;
            },
            validator: (String value) {
              if (value.isEmpty) return '';
              return null;
            },
          ),
          InputFieldNotaryAdmin(
            hintText: "Email",
            keyboardType: TextInputType.emailAddress,
            initialValue: widget.notaryBuilder.email,
            formatter: [
              FilteringTextInputFormatter.deny(RegExp(' ')),
            ],
            onChanged: (String value) {
              widget.notaryBuilder.email = value;
            },
            validator: (value) {
              return null;
            },
          ),
        ],
      );
    }

    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: AppColors.promotionCardShadow,
        color: Colors.white,
      ),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 25.0),
                      Text(
                        widget.notaryBuilder.id == null
                            ? "Добавить нотариуса"
                            : "Редактировать нотариуса",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 35.0),
                      _buildContent(),
                      if (widget.notaryBuilder.id != null) ...[
                        TextButton(
                          onPressed: () => _deleteNotary(),
                          style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(
                              Colors.transparent,
                            ),
                          ),
                          child: Text(
                            "Удалить",
                            style: TextStyle(
                              color: Colors.redAccent,
                            ),
                          ),
                        )
                      ],
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: GradientButton(
                          title: "Подтвердить",
                          maxWidth: double.infinity,
                          minHeight: 50.0,
                          borderRadius: 10.0,
                          onTap: () => _addEditNotary(),
                        ),
                      ),
                      SizedBox(height: 25.0),
                    ],
                  ),
                  AnimatedOpacity(
                    opacity: widget.isOpen ? 1.0 : 0.0,
                    duration: Duration(milliseconds: 600),
                    curve: Curves.easeInBack,
                    child: IconButton(
                      padding: EdgeInsets.all(20.0),
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: Icon(Icons.close),
                      onPressed: () => widget.switchState(),
                    ),
                  ),
                ],
              ),
            ),
            if (_startLoading == true)
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: WaveIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
