import 'package:bookme/core/presentation/utitls/app_assets.dart';
import 'package:bookme/features/bookme/data/models/response/favorite/favorite_model.dart';
import 'package:bookme/features/bookme/presentation/favorites/getx/favorites_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/theme/hint_color.dart';
import '../../../../../core/presentation/theme/primary_color.dart';
import '../../../../../core/presentation/utitls/app_padding.dart';
import '../../../../../core/presentation/utitls/app_spacing.dart';
import '../../../../../core/presentation/widgets/app_custom_listview.dart';
import '../../../../../core/presentation/widgets/app_loading_box.dart';
import '../../../../../core/presentation/widgets/exception_indicators/empty_list_indicator.dart';
import '../../../../../core/presentation/widgets/exception_indicators/error_indicator.dart';
import '../../../../../core/presentation/widgets/location_icon.dart';
import '../../../data/models/response/service/service_model.dart';

class FavoriteScreen extends GetView<FavoritesController> {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: AppLoadingBox(
        loading: controller.isLoading.value,
        child: _buildServiceListTile(
          context,
        ),
      ),
    );
  }

  Widget _buildServiceListTile(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Obx(
      () => AppLoadingBox(
        loading: controller.isLoading.value,
        child: AppCustomListView<Favorite>(
          items: controller.favorites,
          onRefresh: () => controller.getFavorites(),
          errorIndicatorBuilder: ErrorIndicator(
            error: controller.error.value,
            onTryAgain: () => controller.getFavorites(),
          ),
          failure: controller.error.value,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: ValueKey<int>(index),
              onDismissed: (DismissDirection direction) {
                //todo confirm dismissal
                controller.deleteFav(controller.favorites[index].id);
                controller.favorites.removeAt(index);
              },
              child: _buildServiceCard(
                controller.favorites[index].service!,
                index,
                width,
                context,
              ),
            );
          },
          emptyListIndicatorBuilder: const EmptyListIndicator(),
        ),
      ),
    );
  }

  Padding _buildServiceCard(
      Service service, int index, double width, BuildContext context) {
    final String image = service.coverImage ?? '';
    return Padding(
      padding: AppPaddings.mA,
      child: GestureDetector(
        onTap: () {
          controller.navigateToServiceDetailsScreen(service);
        },
        child: Container(
          decoration: BoxDecoration(
            color: PrimaryColor.backgroundColor,
            borderRadius: BorderRadius.circular(15),
            //  border: Border.all(color: Colors.red),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                offset: Offset(3, 3),
                spreadRadius: -8,
                blurRadius: 10,
                color: Color.fromRGBO(137, 137, 137, 1),
              ),
            ],
          ),
          height: 100,
          width: width,
          child: Padding(
            padding: AppPaddings.mA,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Hero(
                    tag: 'service${service.id}',
                    child: image.isEmpty
                        ? Image.asset(AppImageAssets.noImage)
                        : CachedNetworkImage(
                            imageUrl: image,
                            placeholder: (BuildContext context, String url) =>
                                Image.asset(AppImageAssets.noServiceImage),
                            errorWidget: (BuildContext context, String url,
                                    dynamic error) =>
                                const Icon(Icons.error),
                          ),
                  ),
                ),
                const AppSpacing(
                  h: 10,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        service.title ?? '',
                        style: context.textTheme.bodyMedium?.copyWith(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      IconText(text: service.location ?? ''),
                      SizedBox(
                        child: Text(
                          service.description ?? '',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 12.sp, color: HintColor.color.shade400),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
