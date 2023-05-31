import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/theme/hint_color.dart';
import '../../../../../core/presentation/theme/primary_color.dart';
import '../../../../../core/presentation/utitls/app_padding.dart';
import '../../../../../core/presentation/utitls/app_spacing.dart';
import '../getx/user_profile_controller.dart';
class UserProfileScreen extends GetView<UserProfileController> {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _buildTabHeader(context),
            Expanded(child: _buildTabPage(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabPage(BuildContext context){
    return PageView(
      controller: controller.pageController,
      onPageChanged: controller.onPageChanged,
      children: <Widget>[
        _buildPersonalProfilePage(context),
        _buildJobsHistoryPage(context),
        _buildJobsReviewPage(context),
      ],
    );
  }

  Widget _buildPersonalProfilePage(BuildContext context){
    return Container();
  }

  Widget _buildJobsHistoryPage(BuildContext context){
    return Container();
  }
  Widget _buildJobsReviewPage(BuildContext context){
    return Container();
  }

  Container _buildTabHeader(BuildContext context) {
    return Container(
      height: 60,
      padding: AppPaddings.mA,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: HintColor.color.shade50,
          ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                controller.onPageChanged(0);
                controller.navigatePages(0);
              },
              child: Obx(
                    () => _buildTabHeaderContent(
                  context,
                  text: 'Personal',
                  isActive: controller.pageIndex.value == 0,
                ),
              ),
            ),
          ),
          const AppSpacing(
            h: 10,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                controller.onPageChanged(1);
                controller.navigatePages(1);
              },
              child: Obx(
                    () => _buildTabHeaderContent(
                  context,
                  text: 'Job',
                  isActive: controller.pageIndex.value == 1,
                ),
              ),
            ),
          ),
          const AppSpacing(
            h: 10,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                controller.onPageChanged(2);
                controller.navigatePages(2);
              },
              child: Obx(
                    () => _buildTabHeaderContent(
                  context,
                  text: 'Reviews',
                  isActive: controller.pageIndex.value == 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildTabHeaderContent(
      BuildContext context, {
        required String text,
        required bool isActive,
      }) {
    return Container(
      // width: MediaQuery.of(context).size.width / 2,
      decoration: isActive
          ? BoxDecoration(
        color: PrimaryColor.backgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            offset: Offset(0, 5),
            spreadRadius: -16,
            blurRadius: 20,
            color: Color.fromRGBO(0, 0, 0, 1),
          )
        ],
      )
          : null,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: isActive ? PrimaryColor.color : HintColor.color.shade300,
          ),
        ),
      ),
    );
  }
}
