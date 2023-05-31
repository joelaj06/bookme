import 'package:bookme/core/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/theme/hint_color.dart';
import '../../../../../core/presentation/theme/primary_color.dart';
import '../../../../../core/presentation/utitls/app_padding.dart';
import '../../../../../core/presentation/utitls/app_spacing.dart';
import '../../../../../core/presentation/widgets/app_text_input_field.dart';
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
            Expanded(
              child: _buildTabPage(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabPage(BuildContext context) {
    return PageView(
      controller: controller.pageController,
      onPageChanged: controller.onPageChanged,
      children: <Widget>[
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: _buildPersonalProfilePage(context),
        ),
        _buildJobsHistoryPage(context),
        _buildJobsReviewPage(context),
      ],
    );
  }

  Widget _buildPersonalProfilePage(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          AppTextInputField(
            labelText: 'First Name',
          ),
          const AppSpacing(
            v: 10,
          ),
          AppTextInputField(
            labelText: 'Last Name',
          ),
          const AppSpacing(
            v: 10,
          ),
          AppTextInputField(
            labelText: 'Email',
            hintText: 'user@mail.com',
          ),
          const AppSpacing(
            v: 10,
          ),
          AppTextInputField(
            labelText: 'Phone number',
            hintText: '024XXXXXXX',
          ),
          const AppSpacing(
            v: 10,
          ),
          AppTextInputField(
            labelText: 'Address',
          ),
          const AppSpacing(
            v: 10,
          ),
          AppTextInputField(
            labelText: 'Job Tittle',
          ),
          const AppSpacing(
            v: 10,
          ),
          AppTextInputField(
            labelText: 'Job Description',
            maxLines: 3,
          ),
          const AppSpacing(
            v: 10,
          ),
          AppTextInputField(
            labelText: 'Organization / Company',
            // infoText: 'Use your name if you don\'t belong to any company',
          ),
          const AppSpacing(
            v: 10,
          ),
          _buildSkillsContainer(width),
          const AppSpacing(
            v: 20,
          ),
          SizedBox(
            height: 60,
            child: AppButton(
              onPressed: () {},
              text: 'Update Profile',
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }

  Column _buildSkillsContainer(double width) {
    return Column(
      children: <Widget>[
        Obx(
          () => AppTextInputField(
            controller: controller.skillTextEditingController.value,
            labelText: 'Skills',
            onChanged: (String value) {
              controller.skill(value);
            },
            suffixIcon: controller.skill.value.length < 2
                ? null
                : IconButton(
                    onPressed: () {
                      controller.onSkillInputChanged();
                    },
                    icon: const Icon(Icons.add),
                  ),
          ),
        ),
        const AppSpacing(
          v: 10,
        ),
        Obx(
          () => controller.skills.isEmpty
              ? const SizedBox.shrink()
              : Container(
                  width: width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: HintColor.color.shade50,
                    ),
                  ),
                  child: Obx(
                    () => Wrap(
                      children: List<Widget>.generate(
                        controller.skills.length,
                        (int index) => Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Chip(
                            label: Text(controller.skills[index]),
                            onDeleted: () {
                              controller.onChipDeleted(index);
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        )
      ],
    );
  }

  Widget _buildJobsHistoryPage(BuildContext context) {
    return Container();
  }

  Widget _buildJobsReviewPage(BuildContext context) {
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
