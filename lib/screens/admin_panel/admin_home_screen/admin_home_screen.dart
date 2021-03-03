import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:swipe/custom_app_widget/fade_route.dart';
import 'package:swipe/global/app_colors.dart';
import 'package:swipe/model/custom_user.dart';
import 'package:swipe/screens/admin_panel/admin_home_screen/custom_widget/list_item_admin.dart';
import 'package:swipe/screens/admin_panel/admin_notary_screen/admin_notary_screen.dart';
import 'package:swipe/screens/home_screen/provider/user_provider.dart';

class AdminHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserNotifier>(
      builder: (context, userNotifier, child) {
        UserBuilder userProfile = userNotifier.userProfile;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark.copyWith(
            statusBarColor: Colors.transparent,
          ),
          child: Scaffold(
            backgroundColor: AppColors.primaryColor,
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                vertical: 60.0,
                horizontal: 8.0,
              ),
              physics: BouncingScrollPhysics(),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      "Администратор",
                      style: TextStyle(
                        color: Colors.black.withAlpha(130),
                        fontSize: 13.0,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      userProfile.name,
                      style: TextStyle(
                        color: Colors.black.withAlpha(200),
                        fontSize: 22.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 32.0),
                    ListItemAdmin(
                      title: "Модерация",
                      onTap: () {},
                    ),
                    ListItemAdmin(
                      title: "Пользователи",
                      onTap: () {},
                    ),
                    ListItemAdmin(
                      title: "Blacklist",
                      onTap: () {},
                    ),
                    ListItemAdmin(
                      title: "Управление Нотариусы",
                      onTap: () {
                        Navigator.push(
                          context,
                          FadeRoute(
                            page: AdminNotaryScreen(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 62.0),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: () => userNotifier.changeRegularScreen(
                        isRegularScreen: true,
                      ),
                      child: Text(
                        "обычная версия",
                        style: TextStyle(
                          color: Colors.black.withAlpha(200),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
