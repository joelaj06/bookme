import 'package:bookme/core/presentation/theme/hint_color.dart';
import 'package:bookme/core/presentation/theme/primary_color.dart';
import 'package:bookme/core/presentation/theme/secondary_color.dart';
import 'package:bookme/core/presentation/utitls/app_padding.dart';
import 'package:bookme/core/presentation/utitls/app_spacing.dart';
import 'package:bookme/core/presentation/widgets/app_button.dart';
import 'package:bookme/core/presentation/widgets/app_rating_widget.dart';
import 'package:bookme/core/presentation/widgets/location_icon.dart';
import 'package:bookme/features/bookme/presentation/services/getx/services_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class ServiceDetailsScreen extends GetView<ServicesController> {
  const ServiceDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int? args = ModalRoute.of(context)?.settings.arguments as int?;

    return Scaffold(
      extendBodyBehindAppBar: true, // Extend the body behind the AppBar
      bottomNavigationBar: _buildBottomNavigationItems(),
      body: Column(
        children: <Widget>[
          Stack(
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
                    tag: 'service$args',
                    child: Obx(
                      () => Image.asset(
                        controller.imageIndex.value == 0
                            ? 'assets/images/photographer.png'
                            : 'assets/images/p${controller.imageIndex.value}.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 30,
                left: 16,
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
            ],
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (BuildContext context, int index) {
                index += 1;
                return GestureDetector(
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
                          child: Image.asset('assets/images/p$index.jpg'),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
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
                          controller.company,
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: SecondaryColor.color,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      const AppRating(value: '4.7'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children:  <Widget>[
                          const Icon(Ionicons.person_circle_outline),
                          const AppSpacing(h: 10,),
                          Text('John Doe',
                          style: context.textTheme.bodyLarge?.copyWith(
                            fontSize: 20,
                          ),),
                        ],
                      ),
                      TextButton(
                        onPressed: () {
                          controller.navigateToServiceAgentScreen();
                        },
                        child: const Text('View Profile'),
                      ),
                    ],
                  ),
                  const IconText(
                    text: 'Kasoa, Ofankor',
                    textColor: PrimaryColor.color,
                    iconColor: PrimaryColor.color,
                  ),
                  const AppSpacing(
                    v: 10,
                  ),
                  Text(
                    controller.description,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBottomNavigationItems() {
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
              onPressed: () {},
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
                print('Pressed');
              },
              text: 'Book Now',
            ),
          ),
        ],
      ),
    );
  }
}
