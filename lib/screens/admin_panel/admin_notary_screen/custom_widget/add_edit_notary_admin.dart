import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:swipe/custom_app_widget/gradient_button.dart';
import 'package:swipe/custom_app_widget/loading_indicator.dart';
import 'package:swipe/global/app_colors.dart';
import 'package:swipe/model/notary.dart';
import 'package:swipe/screens/admin_panel/admin_notary_screen/api/avatar_image_picker_admin.dart';

import 'avatar_picker_admin.dart';

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

  void _getLocalImage() async {
    File imageFile = await AvatarImagePickerAdmin.getLocalImage();
    setState(() => _imageFile = imageFile);
  }

  void _addEditNotary() async {
    setState(() => _startLoading = true);
    await Future.delayed(Duration(seconds: 5));
    setState(() => _startLoading = false);
    _imageFile = null;
    widget.switchState();
    log("${widget.notaryBuilder}");
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildContent() {
      return Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          AvatarPickerAdmin(
            imageFile: _imageFile,
            photoURL: widget.notaryBuilder.photoURL,
            onTap: () => _getLocalImage(),
          ),
          Container(),
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
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                AnimatedOpacity(
                  opacity: widget.isOpen ? 1.0 : 0.0,
                  duration: Duration(
                    milliseconds: widget.isOpen ? 1500 : 400,
                  ),
                  curve: Curves.easeInBack,
                  child: Column(
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
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          top: 45.0,
                          right: 16.0,
                        ),
                        child: GradientButton(
                          title: "Подтвердить",
                          maxWidth: double.infinity,
                          minHeight: 50.0,
                          borderRadius: 10.0,
                          onTap: () => _addEditNotary(),
                        ),
                      ),
                    ],
                  ),
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
                    onPressed: () {
                      _imageFile = null;
                      widget.switchState();
                    },
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
    );
  }
}
