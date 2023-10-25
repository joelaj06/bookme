import 'package:bookme/core/presentation/routes/app_routes.dart';
import 'package:bookme/core/presentation/widgets/custom_tile.dart';
import 'package:bookme/core/presentation/widgets/exception_indicators/unauthorized_indicator.dart';
import 'package:bookme/core/utitls/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/utitls/app_padding.dart';
import '../../../../../core/presentation/utitls/app_spacing.dart';
import '../../../../../core/presentation/widgets/animated_column.dart';
import '../../../../../core/utitls/base_64.dart';
import '../../../../authentication/data/models/response/user/user_model.dart';
import '../getx/user_profile_controller.dart';

class UserProfileScreen extends GetView<UserProfileController> {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<bool>(
            future: controller.isAuthenticated,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.data == true) {
                return _buildProfileList(context);
              }
              return UnauthorizedIndicator(
                onPressed: () {
                  Get.toNamed<dynamic>(AppRoutes.login);
                },
              );
            }),
      ),
    );
  }

  Column _buildProfileList(BuildContext context) {
    return Column(
      children: <Widget>[
        FutureBuilder<void>(
          future: controller.getUser(),
          builder: (BuildContext context,_) {
            //Todo implement loading skeleton before widget builds
            return Padding(
              padding: AppPaddings.mA,
              child: Obx(() => _buildUserProfile(
                  context,
                  controller.user.value
                ),
              ),
            );
          }
        ),
        const Divider(
          height: 0,
        ),
        const AppSpacing(
          v: 10,
        ),
        AppAnimatedColumn(
          children: <Widget>[
            CustomTile(
              text: 'Update Profile',
              onPressed: () {
                controller.navigateToUpdateProfileScreen();
              },
              showDivider: true,
              hideMoreIcon: true,
            ),
            CustomTile(
              text: 'Update Job',
              onPressed: () {
                Get.toNamed<dynamic>(AppRoutes.updateJob);
              },
              showDivider: true,
              hideMoreIcon: true,
            ),
            CustomTile(
              text: 'Tasks',
              onPressed: () {
                Get.toNamed<dynamic>(AppRoutes.tasks);
              },
              showDivider: true,
              hideMoreIcon: true,
            ),
            CustomTile(
              text: 'Favorites',
              onPressed: () {
                Get.toNamed<dynamic>(AppRoutes.favorites);
              },
              showDivider: true,
              hideMoreIcon: true,
            ),
            CustomTile(
              text: 'Reviews',
              onPressed: () {
                Get.toNamed<dynamic>(AppRoutes.userReview);
              },
              showDivider: true,
              hideMoreIcon: true,
            ),
            CustomTile(
              text: 'Logout',
              textColor: Colors.redAccent,
              onPressed: () {},
              showDivider: true,
              hideMoreIcon: true,
            ),
          ],
        )
      ],
    );
  }

  Widget _buildUserProfile(BuildContext context, User user) {
    final String image = user.image ?? '';
    return Row(
      children: <Widget>[
        SizedBox(
          width: 80,
          height: 80,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: image.isEmpty
                ? Image.asset('assets/images/user.jpg')
                : Image.memory(
                    fit: BoxFit.cover,
                    Base64Convertor().base64toImage(
                      image,
                    ),
                  ),
          ),
        ),
        const AppSpacing(
          h: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  <Widget>[
            Text(
              '${user.firstName} ${user.lastName}'.toTitleCase(),
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(user.email),
          ],
        ),
      ],
    );
  }
}
