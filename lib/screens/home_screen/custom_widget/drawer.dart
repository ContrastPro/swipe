import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe/custom_app_widget/app_logo.dart';
import 'package:swipe/custom_app_widget/fade_route.dart';
import 'package:swipe/global/style/app_colors.dart';
import 'package:swipe/model/custom_user.dart';
import 'package:swipe/screens/admin_panel/admin_home_screen/admin_home_screen.dart';
import 'package:swipe/screens/apartment_add_screen/apartment_add_screen.dart';
import 'package:swipe/global/firebase_api.dart';
import 'package:swipe/screens/edit_profile_screen/edit_profile_screen.dart';
import 'package:swipe/screens/feedback_screen/feedback_screen.dart';
import 'package:swipe/screens/home_screen/api/home_firestore_api.dart';
import 'package:swipe/screens/home_screen/provider/user_provider.dart';
import 'package:swipe/screens/mfc_screen/mfc_screen.dart';
import 'package:swipe/screens/notary_screen/notary_screen.dart';

class GradientDrawer extends StatelessWidget {
  Widget _buildListTile({String title, GestureTapCallback onTap}) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage(UserBuilder userProfile) {
    String name = userProfile.name[0].toUpperCase();
    String lastName = userProfile.lastName[0].toUpperCase();

    CircleAvatar errorAvatar = CircleAvatar(
      backgroundColor: AppColors.accentColor,
      child: Text(
        "$name$lastName",
        style: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
        ),
      ),
    );

    if (userProfile.photoURL == null) {
      return errorAvatar;
    } else {
      return CachedNetworkImage(
        imageUrl: userProfile.photoURL,
        imageBuilder: (context, imageProvider) => CircleAvatar(
          backgroundColor: AppColors.accentColor,
          backgroundImage: imageProvider,
        ),
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) => errorAvatar,
      );
    }
  }

  Widget _buildAccess(UserNotifier userNotifier, BuildContext context) {
    String title;

    switch (userNotifier.userProfile.accessIsAllowed) {
      case true:
        title = "Доступ получен";
        break;
      case false:
        title = "Доступ запрошен";
        break;
      default:
        title = "Получить доступ";
    }

    return OutlinedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          EdgeInsets.all(20.0),
        ),
        side: MaterialStateProperty.all(
          BorderSide(color: Colors.white70),
        ),
        overlayColor: MaterialStateProperty.all(
          Colors.white12,
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      onPressed: () {
        if (userNotifier.userProfile.accessIsAllowed == null) {
          HomeFirestoreAPI.getAccess(
            userBuilder: userNotifier.userProfile,
          );
        } else if (userNotifier.userProfile.accessIsAllowed == true) {
          Navigator.push(context, FadeRoute(page: AdminHomeScreen()));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserNotifier>(
      builder: (context, userNotifier, child) {
        UserBuilder userBuilder = userNotifier.userProfile;

        return Drawer(
          elevation: 0,
          child: Container(
            decoration: BoxDecoration(
              gradient: AppColors.drawerGradient,
            ),
            child: SafeArea(
              child: ListView(
                padding: EdgeInsets.zero,
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 14.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppLogo(width: 40.0, height: 25.0, fontSize: 25.0),
                        IconButton(
                          icon: Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              FadeRoute(
                                page: EditProfileScreen(
                                  userProfile: userBuilder,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  UserAccountsDrawerHeader(
                    currentAccountPicture: _buildProfileImage(userBuilder),
                    arrowColor: Colors.white,
                    accountName: Text(
                      "${userBuilder.name} ${userBuilder.lastName}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    accountEmail: Text(
                      "${userBuilder.email}",
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    decoration: BoxDecoration(color: Colors.transparent),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 22.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 70,
                          child: _buildAccess(userNotifier, context),
                        ),
                        Expanded(
                          flex: 30,
                          child: SizedBox(),
                        ),
                      ],
                    ),
                  ),
                  _buildListTile(
                    title: "Лента объявлений",
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  _buildListTile(
                    title: "Личный кабинет",
                    onTap: () async {
                      await Navigator.push(
                        context,
                        FadeRoute(
                          page: EditProfileScreen(
                            userProfile: userBuilder,
                          ),
                        ),
                      );
                    },
                  ),
                  if (userBuilder.buildingBuilder == null)
                    _buildListTile(
                      title: "Мое объявление",
                      onTap: () {
                        Navigator.push(
                          context,
                          FadeRoute(
                            page: ApartmentAddScreen(),
                          ),
                        );
                      },
                    ),
                  _buildListTile(
                    title: "Избранное",
                    onTap: () {
                      //
                    },
                  ),
                  _buildListTile(
                    title: "Сохраненные фильтры",
                    onTap: () {
                      //
                    },
                  ),
                  _buildListTile(
                    title: "Нотариусы",
                    onTap: () {
                      Navigator.push(
                        context,
                        FadeRoute(
                          page: NotaryScreen(),
                        ),
                      );
                    },
                  ),
                  _buildListTile(
                    title: "МФЦ",
                    onTap: () {
                      Navigator.push(
                        context,
                        FadeRoute(
                          page: MFCScreen(),
                        ),
                      );
                    },
                  ),
                  _buildListTile(
                    title: "Обратная связь",
                    onTap: () {
                      Navigator.push(
                        context,
                        FadeRoute(
                          page: FeedbackScreen(),
                        ),
                      );
                    },
                  ),
                  _buildListTile(
                    title: "Выход",
                    onTap: () {
                      FirebaseAPI.signOut();
                    },
                  ),
                  SizedBox(height: 32.0),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
