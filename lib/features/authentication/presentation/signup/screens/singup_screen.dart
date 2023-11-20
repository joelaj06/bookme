import 'package:bookme/core/presentation/theme/primary_color.dart';
import 'package:bookme/core/presentation/utitls/app_assets.dart';
import 'package:bookme/core/presentation/utitls/app_padding.dart';
import 'package:bookme/core/presentation/utitls/app_spacing.dart';
import 'package:bookme/core/presentation/widgets/app_loading_box.dart';
import 'package:bookme/features/authentication/presentation/signup/getx/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../core/presentation/theme/hint_color.dart';
import '../../../../../core/presentation/widgets/animated_column.dart';
import '../../../../../core/presentation/widgets/app_button.dart';
import '../../../../../core/presentation/widgets/app_text_input_field.dart';
import '../../../../../core/utitls/base_64.dart';
import '../../../../bookme/data/models/response/category/category_model.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      // physics: const NeverScrollableScrollPhysics(),
      controller: controller.pageController,
      onPageChanged: controller.onPageChanged,
      children: <Widget>[
        _buildAccountTypePage(context),
        _buildSignUpFormPage(context),
        _buildJobFormPage(context)
      ],
    );
  }

  Scaffold _buildJobFormPage(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 60,
        child: Obx(
              () => AppButton(
                enabled: !controller.isLoading.value,
            onPressed: () {
              controller.addAService();
            },
            text: 'Done',
            fontSize: 18,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Obx(
          () => AppLoadingBox(
            loading: controller.isLoading.value,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: _buildJobPage(
                context,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildJobPage(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildJobCoverImageUpload(context),
        Padding(
          padding: AppPaddings.mA,
          child: AppAnimatedColumn(
            children: <Widget>[
              AppTextInputField(
                labelText: 'Job Tittle',
                onChanged: controller.onServiceTitleInputChanged,
              ),
              const AppSpacing(
                v: 10,
              ),
              AppTextInputField(
                labelText: 'Job Description',
                maxLines: 3,
                onChanged: controller.onServiceDescriptionInputChanged,
              ),
              const AppSpacing(
                v: 10,
              ),
              AppTextInputField(
                labelText: 'Least Price',
                onChanged: controller.onLeastPriceInputChanged,
                textInputType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: <TextInputFormatter>[
                  //  FilteringTextInputFormatter.,
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
                v: 10,
              ),
              const Text(
                'Select category',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const AppSpacing(
                v: 10,
              ),
              SizedBox(
                height: 500,
                child: _buildCategoryList(),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildJobCoverImageUpload(BuildContext context) {
    return Stack(
      children: <Widget>[
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.4,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30),
            ),
            child: controller.serviceCoverImage.value.isEmpty
                ? Image.asset(AppImageAssets.serviceSketches)
                : Image.memory(
                    // height: 200,
                    fit: BoxFit.cover,
                    Base64Convertor().base64toImage(
                      controller.serviceCoverImage.value,
                    ),
                  ),
          ),
        ),
         Positioned.fill(
          left: 0,
          right: 0,
          child: Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              radius: 50,
              child: GestureDetector(
                onTap: (){
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
                child: const Icon(IconlyBroken.camera,
                size: 50,
                color: Colors.white,
              ),),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryList() {
    return Obx(
      () {
        bool load = false;
        if (controller.selectedCategories.isEmpty) {
          load = true;
        }
        load = false;
        return AppLoadingBox(
          loading: load,
          child: ListView.builder(
              itemCount: controller.homeController.categories.length,
              itemBuilder: (BuildContext context, int index) {
                final Category category =
                    controller.homeController.categories[index];
                final bool isSelected =
                    controller.selectedCategories.contains(category.id);
                if (category.id == '') {
                  return const SizedBox.shrink();
                }
                return ListTile(
                  title: Text(category.name),
                  trailing: Checkbox(
                    fillColor: MaterialStateProperty.resolveWith((Set states) {
                      if (states.contains(MaterialState.disabled)) {
                        return Colors.orange.withOpacity(.32);
                      }
                      return PrimaryColor.color;
                    }),
                    value: isSelected,
                    onChanged: (bool? value) {
                      if (isSelected) {
                        controller.selectedCategories.remove(category.id);
                      } else {
                        controller.selectedCategories.add(category.id);
                      }
                    },
                  ),
                  subtitle: Text(category.description),
                );
              }),
        );
      },
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
                if (controller.base64Images.length == 4) {
                  return;
                }
                controller.addServiceImages();
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
        () => controller.base64Images.isEmpty
            ? const Center(
                child: Text('Use the ➕ button to add an image'),
              )
            : ListView.builder(
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
                                      fit: BoxFit.contain,
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
                          icon: const Icon(
                            Icons.remove_circle,
                            color: Colors.red,
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
      ),
    );
  }

  Scaffold _buildSignUpFormPage(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 60,
        child: Obx(
          () => AppButton(
            enabled: controller.isAgent.value
                ? controller.agentFormIsValid.value
                : controller.clientFormIsValid.value,
            onPressed: () {
              controller.signUp();
            },
            text: 'Continue',
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
        child: _buildPersonalProfilePage(context),
      ),
    );
  }

  Widget _buildPersonalProfilePage(
    BuildContext context,
  ) {
    return Obx(
      () => AppLoadingBox(
        loading: controller.isLoading.value,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppAnimatedColumn(
                children: <Widget>[
                  _buildImageUpload(context),
                  AppTextInputField(
                    labelText: 'First Name',
                    onChanged: controller.onFirstNameInputChanged,
                    validator: controller.validateName,
                  ),
                  const AppSpacing(
                    v: 10,
                  ),
                  AppTextInputField(
                    labelText: 'Last Name',
                    onChanged: controller.onLastNameInputChanged,
                    validator: controller.validateName,
                  ),
                  const AppSpacing(
                    v: 10,
                  ),
                  AppTextInputField(
                    labelText: 'Email',
                    onChanged: controller.onEmailInputChanged,
                    validator: controller.validateEmail,
                  ),
                  const AppSpacing(
                    v: 10,
                  ),
                  AppTextInputField(
                    labelText: 'Phone number',
                    onChanged: controller.onPhoneInputChanged,
                    textInputType: TextInputType.phone,
                  ),
                  const AppSpacing(
                    v: 10,
                  ),
                  AppTextInputField(
                      labelText: 'Address',
                      validator: controller.validateName,
                      onChanged: controller.onAddressInputChanged),
                  const AppSpacing(
                    v: 10,
                  ),
                  Builder(
                    builder: (BuildContext context) => controller.isAgent.value
                        ? _buildAgentForm(
                            context,
                          )
                        : const SizedBox.shrink(),
                  ),
                  Obx(
                    () => AppTextInputField(
                      maxLines: 1,
                      labelText: 'Password',
                      onChanged: controller.onPasswordInputChanged,
                      validator: controller.validatePassword,
                      obscureText: !controller.showPassword.value,
                      suffixIcon: AnimatedSwitcher(
                        reverseDuration: Duration.zero,
                        transitionBuilder:
                            (Widget? child, Animation<double> animation) {
                          final Animation<double> offset =
                              Tween<double>(begin: 0, end: 1.0)
                                  .animate(animation);
                          return ScaleTransition(scale: offset, child: child);
                        },
                        switchInCurve: Curves.elasticOut,
                        duration: const Duration(milliseconds: 700),
                        child: IconButton(
                          key: ValueKey<bool>(controller.showPassword.value),
                          onPressed: controller.togglePassword,
                          icon: Obx(
                            () => controller.showPassword.value
                                ? const Icon(
                                    Icons.visibility,
                                    size: 20,
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    size: 20,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => AppTextInputField(
                      maxLines: 1,
                      labelText: 'Confirm Password',
                      onChanged: controller.onPasswordConfirmationInputChanged,
                      validator: controller.validatePasswordConfirmation,
                      obscureText: !controller.showPassword.value,
                      suffixIcon: AnimatedSwitcher(
                        reverseDuration: Duration.zero,
                        transitionBuilder:
                            (Widget? child, Animation<double> animation) {
                          final Animation<double> offset =
                              Tween<double>(begin: 0, end: 1.0)
                                  .animate(animation);
                          return ScaleTransition(scale: offset, child: child);
                        },
                        switchInCurve: Curves.elasticOut,
                        duration: const Duration(milliseconds: 700),
                        child: IconButton(
                          key: ValueKey<bool>(controller.showPassword.value),
                          onPressed: controller.togglePassword,
                          icon: Obx(
                            () => controller.showPassword.value
                                ? const Icon(
                                    Icons.visibility,
                                    size: 20,
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    size: 20,
                                  ),
                          ),
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
    );
  }

  Align _buildImageUpload(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CircleAvatar(
                radius: 70,
                child: controller.userProfileImage.value.isEmpty
                    ? Image.asset(AppImageAssets.blankProfilePicture)
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
            controller.addSingleImage();
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

  Widget _buildAgentForm(
    BuildContext context,
  ) {
    final double width = MediaQuery.of(context).size.width;
    return AppAnimatedColumn(children: <Widget>[
      AppTextInputField(
          labelText: 'Agent\'s Job Tittle',
          validator: controller.validateName,
          onChanged: controller.onJobTitleInputChanged),
      const AppSpacing(
        v: 10,
      ),
      AppTextInputField(
        labelText: 'Agent\'s Job Description',
        validator: controller.validateName,
        onChanged: controller.onJobDescriptionInputChanged,
        maxLines: 3,
      ),
      const AppSpacing(
        v: 10,
      ),
      AppTextInputField(
        labelText: 'Organization / Company',
        validator: controller.validateName,
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

  Scaffold _buildAccountTypePage(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      backgroundColor: PrimaryColor.color,
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.white,
        child: const Center(
          child: Text('Choose an account to continue'),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  AppImageAssets.labourBg,
                ),
                fit: BoxFit.cover)),
        child: Padding(
          padding: AppPaddings.mA,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildUserTypeCard(context,
                  image: AppImageAssets.client, desc: 'Client', isAgent: false),
              const AppSpacing(
                v: 50,
              ),
              const Divider(
                height: 3,
                color: Colors.white,
                thickness: 5,
              ),
              const AppSpacing(
                v: 50,
              ),
              _buildUserTypeCard(context,
                  image: AppImageAssets.plumber, desc: 'Agent', isAgent: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserTypeCard(BuildContext context,
      {required String image, required String desc, required bool isAgent}) {
    return GestureDetector(
      onTap: () => controller.onAccountTypeSelected(context, isAgent),
      child: SizedBox(
        child: Padding(
          padding: AppPaddings.sA,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: AppPaddings.mA,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
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
                      radius: 80,
                      backgroundColor: Colors.white,
                      child: Image.asset(image, fit: BoxFit.contain),
                    ),
                  ),
                ),
              ),
              Container(
                padding: AppPaddings.mA,
                decoration: BoxDecoration(boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ], color: Colors.white, borderRadius: BorderRadius.circular(5)),
                child: Text(
                  desc.toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
