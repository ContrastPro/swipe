import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swipe/model/custom_user.dart';
import 'package:swipe/screens/edit_profile/custom_widget/expandable_card.dart';
import 'package:swipe/screens/edit_profile/custom_widget/info_field.dart';

class EditProfile extends StatefulWidget {
  final UserBuilder userProfile;

  const EditProfile({Key key, this.userProfile}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  UserBuilder _userBuilder;
  GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _userBuilder = widget.userProfile;
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  Widget _buildHeader() {
    double radius = 80.0;
    double thickness = 30.0;
    Color color = Colors.black38;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 30.0, 22.0, 35.0),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: radius,
                height: radius,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: color),
                ),
              ),
              Container(width: thickness, height: 1.0, color: color),
              Container(width: 1.0, height: thickness, color: color),
            ],
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
          hintText: "Юля",
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
          hintText: "Туст",
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
          hintText: "Юля",
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
          hintText: "Туст",
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
      ),
      children: [
        SizedBox(height: 20.0),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Личный кабинет"),
        actions: [
          Transform.rotate(
            angle: -3 / 4,
            child: IconButton(
              icon: Icon(
                Icons.add_circle_outline,
                color: Colors.red,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
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
    );
  }
}
