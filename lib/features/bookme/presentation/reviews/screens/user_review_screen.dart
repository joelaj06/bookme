import 'package:bookme/features/bookme/presentation/reviews/getx/user_review_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/presentation/utitls/app_padding.dart';
import '../../../../../core/presentation/utitls/app_spacing.dart';
import '../../../../../core/presentation/widgets/app_ratings_icon.dart';
class UserReviewScreen extends GetView<UserReviewController> {
  const UserReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews')
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
          child: _buildJobsReviewPage(context)),
    );
  }



  Widget _buildJobsReviewPage(BuildContext context) {
    return Padding(
      padding: AppPaddings.mA,
      child: Column(
        children: <Widget>[
          _buildTotalRatingCard(context),
          _buildUserReviewsTile(context),
        ],
      ),
    );
  }

  Widget _buildUserReviewsTile(BuildContext context) {
    return Container(
      padding: AppPaddings.mA,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: <Widget>[
                Padding(
                  padding: AppPaddings.mA,
                  child: _buildUserReviewCard(context),
                ),
                const Divider(
                  height: 1,
                ),
              ],
            );
          }),
    );
  }

  Widget _buildUserReviewCard(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CircleAvatar(
                child: Image.asset('assets/images/user2.jpg'),
              ),
            ),
            const AppSpacing(
              h: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text('Efya Adepa'),
                AppRatingsIcon(ratings: 4),
              ],
            )
          ],
        ),
        const AppSpacing(
          v: 10,
        ),
        const Text('Wow such an amazing guy, he is always on time and '
            'serious when working. Thanks John 😊😊')
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
          Row(
            children: const <Widget>[
              Text(
                '4.7',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
              AppRatingsIcon(ratings: 5),
            ],
          ),
          const Text('(223) Reviews'),
        ],
      ),
    );
  }
}
