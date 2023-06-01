import 'dart:io';

import 'package:bookme/core/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../core/presentation/theme/hint_color.dart';
import '../../../../../core/presentation/theme/primary_color.dart';
import '../../../../../core/presentation/utitls/app_padding.dart';
import '../../../../../core/presentation/utitls/app_spacing.dart';
import '../../../../../core/presentation/widgets/app_ratings_icon.dart';
import '../../../../../core/presentation/widgets/app_text_input_field.dart';
import '../../../../../core/utitls/base_64.dart';
import '../getx/user_profile_controller.dart';

class UserProfileScreen extends GetView<UserProfileController> {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _buildUserProfile(
              context,
            ),
            const AppSpacing(
              v: 10,
            ),
            Container(
              //color: Colors.red,
              height: 100,
              child: _buildSubMenus(
                context,
              ),
            ),
            const AppSpacing(
              v: 20,
            ),
            _buildTabHeader(context),
            Expanded(
              child: _buildTabPage(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubMenus(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildSubMenuCard(context, 'touch', 'Favorites', onTap: () {}),
        const AppSpacing(
          h: 20,
        ),
        _buildSubMenuCard(
          context,
          'prioritize',
          'Tasks',
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildSubMenuCard(BuildContext context, String image, String title,
      {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        //height: 50,
        padding: AppPaddings.mA,
        decoration: BoxDecoration(
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
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                'assets/images/$image.png',
                scale: 10,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfile(BuildContext context) {
    return Container(
      // color: PrimaryColor.primaryAccent.withOpacity(0.2),
      child: Padding(
        padding: AppPaddings.mA,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset('assets/images/user.jpg'),
            ),
            const Text(
              'John Doe',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Text('example@gmail.com'),
            const AppSpacing(
              v: 10,
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
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: _buildJobPage(
            context,
          ),
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: _buildJobsReviewPage(context),
        ),
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
            labelText: 'Agent\'s Job Tittle',
          ),
          const AppSpacing(
            v: 10,
          ),
          AppTextInputField(
            labelText: 'Agent\'s Job Description',
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
          ),
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

  Widget _buildJobPage(BuildContext context) {
    return Padding(
      padding: AppPaddings.mA,
      child: Column(
        children: <Widget>[
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
          Row(
            children: <Widget>[
              const Text(
                'Apply Discount',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const AppSpacing(
                h: 10,
              ),
              Obx(
                () => Checkbox(
                  value: controller.applyDiscount.value,
                  onChanged: controller.onApplyDiscountInputChanged,
                  fillColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled)) {
                        return Colors.transparent;
                      }
                      return PrimaryColor.color;
                    },
                  ),
                ),
              ),
            ],
          ),
          Obx(
            () => AppTextInputField(
              labelText: 'Discount',
              enabled: controller.applyDiscount.value,
              readOnly: !controller.applyDiscount.value,
              textInputType: Platform.isAndroid
                  ? TextInputType.number
                  : const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                FilteringTextInputFormatter.allow(
                  RegExp(r'^\d+\.?\d{0,2}'),
                ),
              ],
              suffixIcon: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Container(
                  width: 80,
                  color: HintColor.color.shade50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      PopupMenuButton<String>(
                        onSelected: (String value) {
                          controller.discountType(value);
                        },
                        itemBuilder: (BuildContext context) =>
                            controller.discountValues
                                .map<PopupMenuEntry<String>>(
                                  (dynamic value) => PopupMenuItem<String>(
                                    value: value.toString(),
                                    child: Text(value.toString()),
                                  ),
                                )
                                .toList(),
                        child: Padding(
                          padding: const EdgeInsets.all(
                            15.0,
                          ),
                          child: Text(
                            controller.discountType.value,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const AppSpacing(
            v: 10,
          ),
          AppTextInputField(
            labelText: 'Least Price',
            textInputType: Platform.isAndroid
                ? TextInputType.number
                : const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
              FilteringTextInputFormatter.allow(
                RegExp(r'^\d+\.?\d{0,2}'),
              ),
            ],
          ),
          const AppSpacing(
            v: 10,
          ),
          _buildImageUploadContainer(),
          const AppSpacing(
            v: 20,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 60,
              child: AppButton(
                onPressed: () {},
                text: 'Update Job',
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column _buildImageUploadContainer() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: const <Widget>[
                Text(
                  'Upload Images',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                AppSpacing(
                  h: 10,
                ),
                Icon(Ionicons.image)
              ],
            ),
            IconButton(
              onPressed: () {
                controller.addImage();
              },
              icon: const Icon(
                Ionicons.add_circle,
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: _buildHorizontalImageList(),
        ),
      ],
    );
  }

  Widget _buildHorizontalImageList() {
    return SizedBox(
      height: 100,
      child: Obx(
        () => ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: controller.base64Images.length,
          itemBuilder: (BuildContext context, int index) {
            final String image = controller.base64Images[index];
            return Stack(
              children: <Widget>[
                Padding(
                  padding: AppPaddings.mA,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 120,
                      color: HintColor.color.shade50,
                      child: FullScreenWidget(
                        disposeLevel: DisposeLevel.Medium,
                        child: Hero(
                          tag: 'image$index',
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.memory(
                                fit: BoxFit.cover,
                                Base64Convertor().base64toImage(
                                  image,
                                ),
                              )),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: -10,
                  top: -10,
                  child: IconButton(
                    onPressed: () {
                      controller.removeImage(index);
                    },
                    icon: const Icon(Icons.remove_circle),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildJobsReviewPage(BuildContext context) {
    return Padding(
      padding: AppPaddings.mA,
      child: Column(
        children: <Widget>[
          _buildTotalRatingCard(context),
          _buildUserReviewsTile(context),
        ],
      ),
    );
  }

  Widget _buildUserReviewsTile(BuildContext context) {
    return Container(
      padding: AppPaddings.mA,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                Padding(
                  padding: AppPaddings.mA,
                  child: _buildUserReviewCard(context),
                ),
                const Divider(
                  height: 1,
                ),
              ],
            );
          }),
    );
  }

  Widget _buildUserReviewCard(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CircleAvatar(
                child: Image.asset('assets/images/user2.jpg'),
              ),
            ),
            const AppSpacing(
              h: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text('Efya Adepa'),
                AppRatingsIcon(ratings: 4),
              ],
            )
          ],
        ),
        const AppSpacing(
          v: 10,
        ),
        const Text('Wow such an amazing guy, he is always on time and '
            'serious when working. Thanks John 😊😊')
      ],
    );
  }

  Widget _buildTotalRatingCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Text(
                '4.7',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
              AppRatingsIcon(ratings: 5),
            ],
          ),
          const Text('(223) Reviews'),
        ],
      ),
    );
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
