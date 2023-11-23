import 'package:bookme/core/presentation/routes/app_routes.dart';
import 'package:bookme/core/presentation/theme/hint_color.dart';
import 'package:bookme/core/presentation/theme/primary_color.dart';
import 'package:bookme/core/presentation/utitls/app_assets.dart';
import 'package:bookme/core/presentation/utitls/app_padding.dart';
import 'package:bookme/core/presentation/utitls/app_spacing.dart';
import 'package:bookme/core/presentation/widgets/app_button.dart';
import 'package:bookme/core/presentation/widgets/app_ratings_icon.dart';
import 'package:bookme/features/bookme/data/models/response/review/review_model.dart';
import 'package:bookme/features/bookme/presentation/service_agent/getx/service_agent_controller.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:get/get.dart';

import '../../services/arguments/service_arguments.dart';

class ServiceAgentProfileScreen extends GetView<ServiceAgentProfileController> {
  const ServiceAgentProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ServiceArgument? args =
        ModalRoute.of(context)?.settings.arguments as ServiceArgument?;

    if (args != null) {
      controller.getAgentReviews(
        args.service.user?.id ?? args.service.userData!.id,
        null,
      );

      if(Get.previousRoute == AppRoutes.base){
        controller.getServiceByAgent(args.service.user!.id);
      }
    }

    return Scaffold(
      //  extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: PrimaryColor.primaryAccent.withOpacity(0.2),
      ),
      bottomNavigationBar: Get.previousRoute == AppRoutes.base ?
      SizedBox(
        height: 60,
        child: AppButton(
          onPressed: () {
            controller.navigateToServiceDetailsScreen();
          },
          text: 'Book Agent',
        ),
      ): const SizedBox.shrink(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            _buildProfile(context),
            const AppSpacing(
              v: 10,
            ),
            Padding(
              padding: AppPaddings.mH,
              child: Column(
                children: <Widget>[
                  _buildSkillsList(context),
                 const AppSpacing(v: 10,),
                 // _buildJobImages(context),
                  _buildAgentReview(
                    context,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildProfile(BuildContext context) {
    return Container(
            width: MediaQuery.of(context).size.width,
            color: PrimaryColor.primaryAccent.withOpacity(0.2),
            child: Padding(
              padding: AppPaddings.mA,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                /*  SizedBox(
                    height: 100,
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: image.isEmpty ?
                      Image.asset(AppImageAssets.blankProfilePicture)
                          :Image.memory(
                        fit: BoxFit.cover,
                        Base64Convertor().base64toImage(
                          image,
                        ),
                      ),
                    ),
                  ),*/
                  Obx(
                    () => Text(
                      '${controller.agent.value.firstName} ${controller.agent.value.lastName}',
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Obx(
                    () => RichText(
                      text: TextSpan(
                        children: <InlineSpan>[
                          TextSpan(
                            text: controller.agent.value.jobTitle ?? '',
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          const TextSpan(
                            text: ' @ ',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: controller.agent.value.company,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Obx(
                    () => Text(
                      controller.agent.value.jobDescription ?? '',
                    ),
                  ),
                  const AppSpacing(
                    v: 10,
                  ),
                ],
              ),
            ),
          );
  }

  Widget _buildAgentReview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Reviews',
          style: context.textTheme.headline6?.copyWith(
            // fontSize: 30,
            color: HintColor.color.shade800,
          ),
        ),
        _buildTotalRatingCard(context),
        const AppSpacing(
          v: 20,
        ),
        _buildUserReviewsTile(context),
      ],
    );
  }

  Widget _buildUserReviewsTile(BuildContext context) {
    return Container(
      padding: AppPaddings.mA,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Obx(
        () => ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.reviews.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                Padding(
                  padding: AppPaddings.mA,
                  child: _buildUserReviewCard(
                    context,
                    controller.reviews[index],
                  ),
                ),
                const Divider(
                  height: 1,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildUserReviewCard(BuildContext context, Review review) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CircleAvatar(
                child: Image.asset(AppImageAssets.blankProfilePicture),
              ),
            ),
            const AppSpacing(
              h: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(review.user?.firstName ?? ''),
                AppRatingsIcon(ratings: (review.rating)),
              ],
            )
          ],
        ),
        const AppSpacing(
          v: 10,
        ),
        Text(review.comment)
      ],
    );
  }

  Widget _buildTotalRatingCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Obx(
              () => Row(
                children: <Widget>[
                  Text(
                    controller.agentReview.value.averageRating
                        .toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  AppRatingsIcon(
                      ratings:
                          (controller.agentReview.value.averageRating)),
                ],
              ),
            ),
            Text('${controller.agentReview.value.reviews.length} Reviews'),
          ],
        ),
      ),
    );
  }

  Widget _buildJobImages(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Jobs',
          style: context.textTheme.headline6?.copyWith(
            // fontSize: 30,
            color: HintColor.color.shade800,
          ),
        ),
        _buildHorizontalImageList()
      ],
    );
  }

  Widget _buildHorizontalImageList() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          index += 1;
          return GestureDetector(
            onTap: () {},
            child: Padding(
              padding: AppPaddings.mA,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 120,
                  color: HintColor.color.shade50,
                  child: FullScreenWidget(
                    disposeLevel: DisposeLevel.Medium,
                    child: Hero(
                      tag: 'p$index',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          'assets/images/p$index.jpg',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSkillsList(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Skills',
          style: context.textTheme.headline6?.copyWith(
            // fontSize: 30,
            color: HintColor.color.shade800,
          ),
        ),
        Container(
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: HintColor.color.shade50,
            ),
          ),
          child: Obx(
            () => Wrap(
              children: controller.skills
                  .map((String skill) => Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Chip(
                          label: Text(skill),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
