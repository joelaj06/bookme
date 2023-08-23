import 'package:bookme/core/errors/failure.dart';
import 'package:bookme/core/presentation/routes/app_routes.dart';
import 'package:bookme/core/presentation/theme/hint_color.dart';
import 'package:bookme/core/presentation/utitls/app_padding.dart';
import 'package:bookme/core/presentation/utitls/app_spacing.dart';
import 'package:bookme/core/presentation/widgets/location_icon.dart';
import 'package:bookme/features/bookme/data/models/response/category/category_model.dart';
import 'package:bookme/features/bookme/presentation/services/getx/services_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../core/presentation/theme/primary_color.dart';
import '../../../../../core/presentation/widgets/exception_indicators/empty_list_indicator.dart';
import '../../../../../core/presentation/widgets/exception_indicators/error_indicator.dart';
import '../../../../../core/utitls/base_64.dart';
import '../../../data/models/response/service/service_model.dart';

class ServicesScreen extends GetView<ServicesController> {
  const ServicesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services'),
        automaticallyImplyLeading: Get.previousRoute == AppRoutes.base,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.filter_list,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: AppPaddings.mA,
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      offset: Offset(0, 5),
                      spreadRadius: -16,
                      blurRadius: 20,
                      color: Color.fromRGBO(0, 0, 0, 1),
                    )
                  ]),
              child: _buildItemSearchField(
                color: Colors.black54,
                hintColor: Colors.black54,
                prefixIconColor: Colors.black54,
              ),
            ),
            const AppSpacing(v: 10,),
            _buildServiceCategories(context),
            Expanded(child: _buildServiceListTile(context),)
          ],
        ),
      ),
    );
  }

  Widget _buildServiceListTile(BuildContext context){
    final double width = MediaQuery.of(context).size.width;
    return RefreshIndicator(
      onRefresh: () => Future<void>.sync(
            () {
            controller.pagingController.refresh();
        },
      ),
      child: PagedListView<int, Service>.separated(
        pagingController: controller.pagingController,
        builderDelegate: PagedChildBuilderDelegate<Service>(
          itemBuilder: (BuildContext context, Service service, int index) {
            return Dismissible(
              key: Key(service.id.toString()),
              onDismissed: (DismissDirection direction) {
                //  controller.deleteTheService(context, index);
              },
              child: _buildServiceCard(service,index, width, context),
            );
          },
          firstPageErrorIndicatorBuilder: (BuildContext context) =>
              ErrorIndicator(
                error: controller.pagingController.value.error as Failure,
                onTryAgain: () => controller.pagingController.refresh(),
              ),
          noItemsFoundIndicatorBuilder: (BuildContext context) =>
          const EmptyListIndicator(),
          newPageProgressIndicatorBuilder: (BuildContext context) =>
          const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          firstPageProgressIndicatorBuilder: (BuildContext context) =>
          const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
        //padding: AppPaddings.lA,
        separatorBuilder: (BuildContext context, int index) =>
        const SizedBox.shrink(),
      ),
    );
  }



  Padding _buildServiceCard(Service service,int index, double width, BuildContext context) {
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
                    tag: 'service$index',
                      child: image.isEmpty ?
                          Image.asset('assets/images/no_image.png')
                      :Image.memory(
                        fit: BoxFit.cover,
                        Base64Convertor().base64toImage(
                          image,
                        ),
                      ),
                  ),
                ),
                const AppSpacing(h: 10,),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        service.title,
                        style: context.textTheme.bodyMedium?.copyWith(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      IconText(text: service.location ?? ''),
                      SizedBox(
                        child: Text(
                          service.description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 12.sp,
                              color: HintColor.color.shade400),
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


  TextFormField _buildItemSearchField({
    Color color = Colors.white,
    Color prefixIconColor = Colors.white,
    Color hintColor = Colors.white54,
  }) {
    return TextFormField(
      controller: controller.searchQueryTextEditingController.value,
      onFieldSubmitted: (String? value) {
        controller.onSearchServiceQuerySubmit(value);
      },
      style: TextStyle(
        color: color,
      ),
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white24,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          suffixIcon: IconButton(
            onPressed: () => controller.clearSearchField(),
            icon: const Icon(Icons.cancel_outlined),
          ),
          prefixIcon: Icon(
            Ionicons.search_outline,
            color: prefixIconColor,
          ),
          hintText: 'Search...',
          hintStyle: TextStyle(color: hintColor)),
    );
  }

  Widget _buildServiceCategories(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: false,
          itemCount: controller.homeController.categories.length,
          itemBuilder: (BuildContext context, int index) {
            final Category category = controller.homeController.categories[index];
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: GestureDetector(
                onTap: () {
                  controller.onCategorySelected(category.id,index);
                },
                child: Obx(
                  () => Container(
                    //width: width,
                    decoration: BoxDecoration(
                      color: controller.selectedCategory.value == index
                          ? PrimaryColor.color
                          : HintColor.color.shade50,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          category.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: controller.selectedCategory.value == index
                                ? Colors.white
                                : Colors.black54,
                            //fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
