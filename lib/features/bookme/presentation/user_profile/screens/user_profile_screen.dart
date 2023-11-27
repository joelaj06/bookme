import 'package:bookme/core/presentation/routes/app_routes.dart';
import 'package:bookme/core/presentation/utitls/app_assets.dart';
import 'package:bookme/core/presentation/widgets/app_loading_box.dart';
import 'package:bookme/core/presentation/widgets/custom_tile.dart';
import 'package:bookme/core/presentation/widgets/exception_indicators/auth_navigation.dart';
import 'package:bookme/core/utitls/string_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/utitls/app_padding.dart';
import '../../../../../core/presentation/utitls/app_spacing.dart';
import '../../../../../core/presentation/widgets/animated_column.dart';
import '../../../../../core/presentation/widgets/app_dialog.dart';
import '../../../../authentication/data/models/response/user/user_model.dart';
import '../getx/user_profile_controller.dart';

class UserProfileScreen extends GetView<UserProfileController> {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => AppLoadingBox(
            loading: controller.isLoading.value,
            child: AuthNavigation(
                future: controller.isAuthenticated,
                child: _buildProfileList(context)),
          ),
        ),
      ),
    );
  }

  Column _buildProfileList(BuildContext context) {
    return Column(
      children: <Widget>[
        FutureBuilder<void>(
            future: controller.getUser(),
            builder: (BuildContext context, _) {
              //Todo implement loading skeleton before widget builds
              return Padding(
                padding: AppPaddings.mA,
                child: Obx(
                  () => _buildUserProfile(context, controller.user.value),
                ),
              );
            }),
        const Divider(
          height: 0,
        ),
        const AppSpacing(
          v: 10,
        ),
        FutureBuilder<bool>(
            future: controller.isAgent(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              final bool isAgent = snapshot.data ?? false;
              return AppAnimatedColumn(
                children: <Widget>[
                  CustomTile(
                    text: 'Update Profile',
                    onPressed: () {
                      controller.navigateToUpdateProfileScreen();
                    },
                    showDivider: true,
                    hideMoreIcon: true,
                  ),
                  if (isAgent)
                    AppAnimatedColumn(children: <Widget>[
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
                    ])
                  else
                    const SizedBox.shrink(),
                  CustomTile(
                    text: 'Logout',
                    textColor: Colors.redAccent,
                    onPressed: () {
                      AppDialog().showConfirmationDialog(
                        context,
                        'Logout',
                        'Are you sure you want to logout?',
                        onTapConfirm: () {
                          Navigator.pop(context);
                          controller.userLogout();
                        },
                      );
                    },
                    showDivider: true,
                    hideMoreIcon: true,
                  ),
                ],
              );
            })
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
                ? Image.asset(AppImageAssets.blankProfilePicture)
                : CachedNetworkImage(
                    imageUrl: image,
                    placeholder: (BuildContext context, String url) =>
                        Image.asset(AppImageAssets.blankProfilePicture),
                    errorWidget:
                        (BuildContext context, String url, dynamic error) =>
                            const Icon(Icons.error),
                  ),
          ),
        ),
        const AppSpacing(
          h: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
