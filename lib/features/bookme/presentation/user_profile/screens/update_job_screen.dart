import 'dart:io';

import 'package:bookme/core/presentation/widgets/animated_column.dart';
import 'package:bookme/core/presentation/widgets/app_loading_box.dart';
import 'package:bookme/features/bookme/data/models/response/category/category_model.dart';
import 'package:bookme/features/bookme/presentation/user_profile/getx/user_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../core/presentation/theme/hint_color.dart';
import '../../../../../core/presentation/theme/primary_color.dart';
import '../../../../../core/presentation/utitls/app_padding.dart';
import '../../../../../core/presentation/utitls/app_spacing.dart';
import '../../../../../core/presentation/widgets/app_button.dart';
import '../../../../../core/presentation/widgets/app_text_input_field.dart';
import '../../../../../core/utitls/base_64.dart';
import '../../../data/models/response/service/service_model.dart';

class UpdateJobScreen extends GetView<UserProfileController> {
  const UpdateJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job'),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: AppButton(
          onPressed: () {
            controller.updateTheService();
          },
          text: 'Update Job',
          fontSize: 18,
        ),
      ),
      body: FutureBuilder<void>(
          future: controller.getUserService(),
          builder: (BuildContext context, _) {
            return Obx(() => AppLoadingBox(
                loading: controller.isLoading.value,
                child: Obx(
                  () => SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: _buildJobPage(
                      context,
                      controller.service.value,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _buildJobPage(BuildContext context, Service service) {
    return Padding(
      padding: AppPaddings.mA,
      child: AppAnimatedColumn(
        children: <Widget>[
          AppTextInputField(
            labelText: 'Job Tittle',
            initialValue: service.title,
            onChanged: controller.onServiceTitleInputChanged,
          ),
          const AppSpacing(
            v: 10,
          ),
          AppTextInputField(
            labelText: 'Job Description',
            initialValue: service.description,
            maxLines: 3,
            onChanged: controller.onServiceDescriptionInputChanged,
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
              initialValue:
                  controller.discountValue.value.toStringAsFixed(2),
              enabled: controller.applyDiscount.value,
              readOnly: !controller.applyDiscount.value,
              onChanged: controller.onDiscountValueInputChanged,
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
          //TODO discount end date
          AppTextInputField(
            labelText: 'Least Price',
            onChanged: controller.onLeastPriceInputChanged,
            initialValue: service.price?.toStringAsFixed(2) ?? '0.0',
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
    );
  }

  Widget _buildCategoryList() {
    return Obx(() {
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
                      print('added to list');
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
}
