import 'package:bookme/core/presentation/theme/hint_color.dart';
import 'package:bookme/core/presentation/theme/primary_color.dart';
import 'package:bookme/core/presentation/theme/secondary_color.dart';
import 'package:bookme/core/presentation/utitls/app_assets.dart';
import 'package:bookme/core/presentation/utitls/app_padding.dart';
import 'package:bookme/core/presentation/utitls/app_spacing.dart';
import 'package:bookme/core/presentation/widgets/app_button.dart';
import 'package:bookme/core/presentation/widgets/app_loading_box.dart';
import 'package:bookme/core/presentation/widgets/location_icon.dart';
import 'package:bookme/features/bookme/presentation/services/arguments/service_arguments.dart';
import 'package:bookme/features/bookme/presentation/services/getx/services_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../core/utitls/base_64.dart';
import '../../../data/models/response/service/service_model.dart';

class ServiceDetailsScreen extends GetView<ServicesController> {
  const ServiceDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ServiceArgument? args =
        ModalRoute.of(context)?.settings.arguments as ServiceArgument?;

    final String coverImage = args?.service.coverImage ?? '';

    List<String?> images = <String>[];
    if (args != null) {
      if (args.service.images != null && args.service.images!.isNotEmpty) {
        images = <String?>[coverImage, ...args.service.images ?? <String>[]];
      }
    }

    print(images);
    return Scaffold(
      extendBodyBehindAppBar: true, // Extend the body behind the AppBar
      bottomNavigationBar: _buildBottomNavigationItems(args?.service),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: CircleAvatar(
            backgroundColor: HintColor.color.shade300.withOpacity(0.5),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: HintColor.color.shade50,
              ),
              onPressed: () {
                controller.imageIndex(0);
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: Obx(
        () => AppLoadingBox(
          loading: controller.isLoading.value,
          child: Column(
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                  child: Hero(
                    tag: 'service${args?.service.id}',
                    child: Obx(() {
                      final String image =
                          images[controller.imageIndex.value] ?? '';
                      return image.isEmpty
                          ? Image.asset(AppImageAssets.serviceSketches)
                          : Image.memory(
                              fit: BoxFit.cover,
                              Base64Convertor().base64toImage(
                                images[controller.imageIndex.value]!,
                              ),
                            );
                    }),
                  ),
                ),
              ),
              _buildHorizontalImageList(images),
              _buildServiceDetails(args, context)
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildServiceDetails(ServiceArgument? args, BuildContext context) {
    final String image = args?.service.user?.image ?? '';
    return Padding(
      padding: AppPaddings.mA,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text(
                    args?.service.title ?? '',
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: SecondaryColor.color,
                      fontSize: 30,
                    ),
                  ),
                ),
              ],
            ),
            IconText(
              text: args?.service.location ?? '',
              textColor: PrimaryColor.color,
              iconColor: PrimaryColor.color,
            ),
            const AppSpacing(
              v: 10,
            ),
            _buildProfileSection(image, args, context),
            const AppSpacing(
              v: 20,
            ),
            Text(
              'About Service',
              style: context.textTheme.bodyLarge?.copyWith(
                fontSize: 20,
              ),
            ),
            const AppSpacing(
              v: 10,
            ),
            Text(
              args?.service.description ?? '',
            )
          ],
        ),
      ),
    );
  }

  Row _buildProfileSection(
      String image, ServiceArgument? args, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CircleAvatar(
                radius: 25,
                child: image.isEmpty
                    ? Image.asset(AppImageAssets.blankProfilePicture)
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
              children: <Widget>[
                Text(
                  '${args?.service.user?.firstName ?? ''} ${args?.service.user?.lastName ?? ''}',
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontSize: 20,
                  ),
                ),
                Text(args?.service.user?.jobTitle ?? ''),
              ],
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            controller.navigateToServiceAgentScreen(args!.service);
          },
          child: const Text('See More'),
        ),
      ],
    );
  }

  SizedBox _buildHorizontalImageList(List<String?> images) {
    return SizedBox(
      height: 100,
      child: images.isEmpty
          ? const Text('No images found')
          : ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (BuildContext context, int index) {
                final String image = images[index] ?? '';
                return image.isEmpty
                    ? const SizedBox.shrink()
                    : GestureDetector(
                        onTap: () {
                          controller.onOtherImagesSelected(index);
                        },
                        child: Padding(
                          padding: AppPaddings.mA,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: 120,
                              color: HintColor.color.shade50,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: image.isEmpty
                                      ? Image.asset(AppImageAssets.noImage)
                                      : Image.memory(
                                          fit: BoxFit.cover,
                                          Base64Convertor().base64toImage(
                                            images[index]!,
                                          ),
                                        )),
                            ),
                          ),
                        ),
                      );
              },
            ),
    );
  }

  Widget _buildBottomNavigationItems(Service? service) {
    return Container(
      height: 80,
      padding: AppPaddings.mA,
      // color: Colors.red,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CircleAvatar(
            radius: 25,
            backgroundColor: HintColor.color.shade300.withOpacity(0.5),
            child: IconButton(
              onPressed: () {
                controller.checkAuth(service!.id);
              },
              icon: const Icon(
                Ionicons.heart,
                // Ionicons.heart_outline,
                color: SecondaryColor.secondaryAccent,
                // Colors.white,
                size: 25,
              ),
            ),
          ),
          Flexible(
            child: AppButton(
              onPressed: () {
                controller.navigateToChatsScreen();
              },
              text: 'Book Now',
            ),
          ),
        ],
      ),
    );
  }
}
