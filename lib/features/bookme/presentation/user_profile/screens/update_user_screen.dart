import 'package:bookme/core/presentation/theme/primary_color.dart';
import 'package:bookme/core/presentation/utitls/app_padding.dart';
import 'package:bookme/core/presentation/widgets/animated_column.dart';
import 'package:bookme/features/bookme/presentation/user_profile/getx/user_profile_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';

import '../../../../../core/presentation/theme/hint_color.dart';
import '../../../../../core/presentation/utitls/app_assets.dart';
import '../../../../../core/presentation/utitls/app_spacing.dart';
import '../../../../../core/presentation/widgets/app_button.dart';
import '../../../../../core/presentation/widgets/app_text_input_field.dart';
import '../../../../../core/utitls/base_64.dart';
import '../../../../authentication/data/models/response/user/user_model.dart';

class UpdateUserScreen extends GetView<UserProfileController> {
  const UpdateUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.loadProfileImage();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: AppButton(
            onPressed: () {
              controller.updateTheUser();
            },
            text: 'Update Profile',
            fontSize: 18,
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Obx(
              () => _buildPersonalProfilePage(context, controller.user.value)),
        ));
  }

  Widget _buildPersonalProfilePage(BuildContext context, User user) {
    final bool isAgent = user.isAgent;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppAnimatedColumn(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CircleAvatar(
                      radius: 70,
                      child: controller.userProfileImage.value.isEmpty
                          ? Image.asset(AppImageAssets.blankProfilePicture)
                          : controller.userProfileImage.value.contains('http')
                              ? CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  height: 200,
                                  imageUrl: controller.userProfileImage.value,
                                  placeholder: (BuildContext context,
                                          String url) =>
                                      Image.asset(
                                          AppImageAssets.blankProfilePicture),
                                  errorWidget: (BuildContext context,
                                          String url, dynamic error) =>
                                      const Icon(Icons.error),
                                )
                              : Image.memory(
                                  height: 200,
                                  fit: BoxFit.cover,
                                  Base64Convertor().base64toImage(
                                    controller.userProfileImage.value,
                                  ),
                                ),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 1,
                    right: 1,
                    child: IconButton(
                      onPressed: () {
                        showModalBottomSheet<dynamic>(
                          context: context,
                          builder: (BuildContext context) => SizedBox(
                            height: 150,
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: AppPaddings.mA,
                                child: _buildImageOptions(context),
                              ),
                            ),
                          ),
                        );
                      },
                      icon: const CircleAvatar(
                        child: Icon(
                          IconlyBroken.edit,
                          color: Colors.white,
                        ),
                      ),
                    ))
              ],
            ),
          ),
          AppTextInputField(
            labelText: 'First Name',
            initialValue: user.firstName,
            onChanged: controller.onFirstNameInputChanged,
          ),
          const AppSpacing(
            v: 10,
          ),
          AppTextInputField(
              labelText: 'Last Name',
              initialValue: user.lastName,
              onChanged: controller.onLastNameInputChanged),
          const AppSpacing(
            v: 10,
          ),
          AppTextInputField(
              labelText: 'Email',
              initialValue: user.email,
              onChanged: controller.onEmailInputChanged),
          const AppSpacing(
            v: 10,
          ),
          AppTextInputField(
              labelText: 'Phone number',
              initialValue: user.phone,
              onChanged: controller.onPhoneInputChanged),
          const AppSpacing(
            v: 10,
          ),
          AppTextInputField(
              labelText: 'Address',
              initialValue: user.address,
              onChanged: controller.onAddressInputChanged),
          const AppSpacing(
            v: 10,
          ),
          Builder(
            builder: (BuildContext context) => isAgent
                ? _buildAgentForm(context, user)
                : const SizedBox.shrink(),
          )
        ],
      ),
    );
  }

  Widget _buildImageOptions(BuildContext context) {
    return Column(
      children: <Widget>[
        const Align(
          alignment: Alignment.center,
          child: Text(
            'Choose an option',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
        const AppSpacing(
          v: 10,
        ),
        _buildModalListCard(
          onTap: () {
            controller.addImage();
            Navigator.pop(context);
          },
          title: 'Upload Image',
          icon: IconlyBold.paper_upload,
        ),
        _buildModalListCard(
          onTap: () {
            controller.removeProfileImage();
            Navigator.pop(context);
          },
          title: 'Remove',
          icon: IconlyBold.delete,
        ),
      ],
    );
  }

  Widget _buildModalListCard(
      {required VoidCallback onTap,
      required String title,
      required IconData icon}) {
    return InkWell(
      onTap: onTap,
      splashColor: PrimaryColor.color.withOpacity(0.2),
      child: SizedBox(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Icon(icon),
              ],
            ),
            const AppSpacing(
              v: 8,
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }

  Widget _buildAgentForm(BuildContext context, User user) {
    final double width = MediaQuery.of(context).size.width;
    return AppAnimatedColumn(children: <Widget>[
      AppTextInputField(
          labelText: 'Agent\'s Job Tittle',
          initialValue: user.jobTitle,
          onChanged: controller.onJobTitleInputChanged),
      const AppSpacing(
        v: 10,
      ),
      AppTextInputField(
        labelText: 'Agent\'s Job Description',
        initialValue: user.jobDescription,
        onChanged: controller.onJobDescriptionInputChanged,
        maxLines: 3,
      ),
      const AppSpacing(
        v: 10,
      ),
      AppTextInputField(
        labelText: 'Organization / Company',
        initialValue: user.company,
        onChanged: controller.onCompanyInputChanged,
        // infoText: 'Use your name if you don\'t belong to any company',
      ),
      const AppSpacing(
        v: 10,
      ),
      _buildSkillsContainer(
        width,
      ),
      const AppSpacing(
        v: 20,
      ),
    ]);
  }

  Column _buildSkillsContainer(
    double width,
  ) {
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
}
