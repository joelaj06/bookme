import 'package:bookme/core/presentation/theme/hint_color.dart';
import 'package:bookme/core/presentation/theme/primary_color.dart';
import 'package:bookme/core/presentation/theme/secondary_color.dart';
import 'package:bookme/core/presentation/utitls/app_padding.dart';
import 'package:bookme/core/presentation/utitls/app_spacing.dart';
import 'package:bookme/core/presentation/widgets/app_rating_widget.dart';
import 'package:bookme/core/presentation/widgets/location_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../getx/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppPaddings.mA,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Discover',
                    style: context.textTheme.headline2?.copyWith(
                        color: HintColor.color.shade800, fontSize: 40),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                     Ionicons.search_outline,
                    ),
                  )
                ],
              ),
              const AppSpacing(
                v: 10,
              ),
              Padding(
                padding: AppPaddings.mV,
                child: _buildServiceCategories(context),
              ),
              const AppSpacing(
                v: 10,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      _buildRowHeader(
                        context,
                        text: 'Popular',
                        onPressed: () {
                          controller.navigateToServicesPage();
                        },
                      ),
                      const AppSpacing(
                        v: 10,
                      ),
                      _buildPopularServices(context),
                      const AppSpacing(
                        v: 10,
                      ),
                      _buildRowHeader(
                        context,
                        text: 'Promotions',
                        onPressed: () {
                          controller.navigateToPromotionsPage();
                        },
                      ),
                      _buildPromotionServices(context),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row _buildRowHeader(
    BuildContext context, {
    required VoidCallback onPressed,
    required String text,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          text,
          style: context.textTheme.headline2?.copyWith(
            fontSize: 30,
            color: HintColor.color.shade800,
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: const Text(
            'See all',
          ),
        ),
      ],
    );
  }

  Widget _buildPromotionServices(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: AppPaddings.mA,
          child: Container(
            decoration: BoxDecoration(
              color: PrimaryColor.primaryAccent,
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
                      const AppSpacing(h: 10,),
                      Column(
                        children: <Widget>[
                          Text(
                            'Birthday Cake',
                            style: context.textTheme.bodyMedium?.copyWith(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          const Text('Floral\'s Bakery'),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 80,
                    padding: AppPaddings.mA,
                    decoration: BoxDecoration(
                        color: SecondaryColor.color,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            offset: Offset(3, 3),
                            spreadRadius: -8,
                            blurRadius: 10,
                            color: Color.fromRGBO(137, 137, 137, 1),
                          ),
                        ],),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:  <Widget>[
                        FittedBox(
                          fit: BoxFit.fill,
                          child: Text('10%',
                            style: context.textTheme.bodyLarge
                                ?.copyWith(fontSize: 30, fontWeight: FontWeight.w500,
                            color: Colors.white),),
                        ),
                        Text('Off',
                          style: context.textTheme.bodyMedium
                              ?.copyWith(fontSize: 15, fontWeight: FontWeight.w500,
                          color: Colors.white),),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPopularServices(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width,
      height: 300,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: false,
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            return _buildPopularServiceCard(context);
          }),
    );
  }

  Widget _buildPopularServiceCard(BuildContext context) {
    return Padding(
      padding: AppPaddings.mA,
      child: Container(
        width: 200,
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
              )
            ]),
        child: Padding(
          padding: AppPaddings.mA,
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'assets/images/photographer.png',
                    ),
                  ),
                  Positioned(
                    right: 4,
                    top: 4,
                    child: CircleAvatar(
                      radius: 17,
                      backgroundColor:
                          HintColor.color.shade300.withOpacity(0.5),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Ionicons.heart,
                          // Ionicons.heart_outline,
                          color: SecondaryColor.secondaryAccent,
                          // Colors.white,
                          size: 17,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Hermeland Studios',
                      style: context.textTheme.bodyMedium
                          ?.copyWith(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const AppRating(value: '4.7'),
                ],
              ),
              const AppSpacing(
                v: 5,
              ),
              LocationIcon(text: 'Kasoa, Ofankor'),
              const AppSpacing(
                v: 10,
              ),
              Text(
                'Book for all your creative photos, videos and '
                'studio shoots. I do door to door service. I do '
                'Birthday parties, engagements, funerals, picnics',
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                style: TextStyle(color: HintColor.color.shade400),
              ),
            ],
          ),
        ),
      ),
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
          itemCount: controller.categories.length,
          itemBuilder: (BuildContext context, int index) {
            final String category = controller.categories[index];
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: GestureDetector(
                onTap: () {
                  controller.selectedCategory(index);
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
                          category,
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
