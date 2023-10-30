import 'package:bookme/core/presentation/theme/primary_color.dart';
import 'package:bookme/core/presentation/utitls/app_padding.dart';
import 'package:bookme/core/utitls/date_formatter.dart';
import 'package:bookme/core/utitls/string_utils.dart';
import 'package:bookme/features/bookme/data/models/response/discount/discount_model.dart';
import 'package:bookme/features/bookme/presentation/promotions/getx/promotions_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/presentation/utitls/app_spacing.dart';
import '../../../../../core/presentation/widgets/exception_indicators/empty_list_indicator.dart';
import '../../../../../core/presentation/widgets/exception_indicators/error_indicator.dart';
import '../../../data/models/response/service/service_model.dart';

class PromotionsScreen extends GetView<PromotionsController> {
  const PromotionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Promotions'),
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
            const AppSpacing(
              v: 10,
            ),
            Container(
              height: 120,
              width: width,
              padding: AppPaddings.mA,
              decoration:  BoxDecoration(
              color: Colors.red,
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                    Colors.red,
                    Colors.white.withOpacity(0.5),
                  ],
                  stops: const <double>[0.0, 1.0],
                ),
              ),
              child: Stack(
                children:  <Widget>[

                  Positioned(
                    top: 0,
                    left: 0,
                    right: width * 0.3,
                    bottom: 0,
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Enjoy Cool Discounts From Your Favorite Service Providers',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),),
                    ),
                  ),
                  Positioned(
                    bottom: -60,
                    left: width * 0.25, // Adjust this value to position the image
                   // width: width * 0.5,
                    child: Image.asset('assets/images/new-year.png',
                      scale: 5,
                    fit: BoxFit.cover,),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    top: 0,
                    width: width*0.3,
                    child: Image.asset('assets/images/megaphone.png',
                    scale: 5,),
                  ),
                ],
              ),
            ),
            const AppSpacing(
              v: 10,
            ),
            Expanded(child: _buildPromotionListTile(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromotionListTile(BuildContext context){
   // final double width = MediaQuery.of(context).size.width;
    return RefreshIndicator(
      onRefresh: () => Future<void>.sync(
            () {
             controller.promotedServicesPagingController.refresh();
        },
      ),
      child: PagedListView<int, Service>.separated(
        pagingController: controller.promotedServicesPagingController,
        builderDelegate: PagedChildBuilderDelegate<Service>(
          itemBuilder: (BuildContext context, Service service, int index) {
            return Dismissible(
              key: Key(service.id.toString()),
              onDismissed: (DismissDirection direction) {
                //  controller.deleteTheService(context, index);
              },
              child: _buildPromotionServiceCard(context,index,service),
            );
          },
          firstPageErrorIndicatorBuilder: (BuildContext context) =>
              ErrorIndicator(
                error: controller.promotedServicesPagingController.value.error as Failure,
                onTryAgain: () => controller.promotedServicesPagingController.refresh(),
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

  GestureDetector _buildPromotionServiceCard(BuildContext context,int index, Service service) {
   final String title = service.discount!.title ?? service.title;
    return GestureDetector(
      onTap: () => controller.navigateToServiceDetailsScreen(index,),
      child: Padding(
        padding: AppPaddings.mV,
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
          child: Padding(
            padding: AppPaddings.mA,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset('assets/images/cake.png'),
                    ),
                    const AppSpacing(
                      h: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title.toTitleCase(),
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                         Text(service.title.toTitleCase()),
                        const Expanded(child: Text('Valid up to')),
                        Text(
                          DataFormatter.dateToString(service.discount!.endDate ?? ''),
                          style: context.textTheme.bodyMedium?.copyWith(
                            //fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: PrimaryColor.color,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                _buildDiscountBanner(context,service.discount!)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildDiscountBanner(BuildContext context, Discount discount) {
    final double value = discount.value;
    return Container(
      width: 60,
      height: 60,
      padding: AppPaddings.mA,
      decoration:  BoxDecoration(
        color: Colors.red.shade700,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            offset: Offset(3, 3),
            spreadRadius: -8,
            blurRadius: 10,
            color: Color.fromRGBO(137, 137, 137, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: FittedBox(
              fit: BoxFit.fill,
              child: Text(
                discount.type == 'amount' ? 'GHS $value' : '$value%',
                style: context.textTheme.bodyLarge?.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child: Text(
              'OFF',
              style: context.textTheme.bodyMedium?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: PrimaryColor.color.shade400,
            ),
          ),
          ),
        ],
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
        hintText: 'Search Promotions',
        hintStyle: TextStyle(color: hintColor),
      ),
    );
  }
}
