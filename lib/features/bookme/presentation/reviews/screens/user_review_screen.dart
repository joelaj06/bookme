import 'package:bookme/core/presentation/widgets/app_loading_box.dart';
import 'package:bookme/features/bookme/data/models/response/review/agent_rating_model.dart';
import 'package:bookme/features/bookme/data/models/response/review/review_model.dart';
import 'package:bookme/features/bookme/presentation/reviews/getx/user_review_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/utitls/app_padding.dart';
import '../../../../../core/presentation/utitls/app_spacing.dart';
import '../../../../../core/presentation/widgets/app_ratings_icon.dart';
import '../../../../../core/utitls/base_64.dart';

class UserReviewScreen extends GetView<UserReviewController> {
  const UserReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reviews')),
      body: Obx(() => AppLoadingBox(
          loading: controller.isLoading.value,
          child: _buildJobsReviewPage(context),
        ),
      ),
    );
  }

  Widget _buildJobsReviewPage(BuildContext context) {
    return Padding(
      padding: AppPaddings.mA,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 100,
              child: _buildTotalRatingCard(context)),
          Expanded(
            child: Obx(() =>
                _buildUserReviewsTile(context, controller.agentRating.value)),
          ),
        ],
      ),
    );
  }

  Widget _buildUserReviewsTile(BuildContext context, AgentRating rating) {
    return Container(
      padding: AppPaddings.mA,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: RefreshIndicator(
        onRefresh: () {
          return controller.checkAgent();
        },
        child: ListView.builder(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            shrinkWrap: true,
            itemCount: controller.reviews.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  Padding(
                    padding: AppPaddings.mA,
                    child: _buildUserReviewCard(
                        context, controller.reviews[index]),
                  ),
                  const Divider(
                    height: 1,
                  ),
                ],
              );
            }),
      ),
    );
  }

  Widget _buildUserReviewCard(BuildContext context, Review review) {
    final String image = review.user?.image ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CircleAvatar(
                child: image.isEmpty
                    ? Image.asset('assets/images/user2.jpg')
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
                Text('${review.user?.firstName} ${review.user?.lastName}'),
                AppRatingsIcon(
                    ratings: controller.agentRating.value.averageRating),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Obx(
            () => Row(
              children: <Widget>[
                Text(
                  controller.agentRating.value.averageRating.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                AppRatingsIcon(
                    ratings: controller.agentRating.value.averageRating),
              ],
            ),
          ),
          Obx(() => Text('(${controller.reviews.length}) Review(s)')),
          const Divider(),
        ],
      ),
    );
  }
}
