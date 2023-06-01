import 'package:bookme/core/presentation/theme/hint_color.dart';
import 'package:bookme/core/presentation/theme/primary_color.dart';
import 'package:bookme/core/presentation/utitls/app_padding.dart';
import 'package:bookme/core/presentation/utitls/app_spacing.dart';
import 'package:bookme/core/presentation/widgets/app_ratings_icon.dart';
import 'package:bookme/features/bookme/presentation/service_agent/getx/service_agent_controller.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:get/get.dart';

class ServiceAgentScreen extends GetView<ServiceAgentController> {
  const ServiceAgentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: PrimaryColor.primaryAccent.withOpacity(0.2),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              color: PrimaryColor.primaryAccent.withOpacity(0.2),
              child: Padding(
                padding: AppPaddings.mA,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset('assets/images/user.jpg'),
                    ),
                    const Text(
                      'John Doe',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text('Photographer @ Hermeland Studios'),
                    const Text(
                      ' I do door to door service. I do '
                      'Birthday parties, engagements, funerals, picnics',
                    ),
                    const AppSpacing(
                      v: 10,
                    ),
                  ],
                ),
              ),
            ),
            const AppSpacing(
              v: 10,
            ),
            Padding(
              padding: AppPaddings.mH,
              child: Column(
                children: <Widget>[
                  _buildSkillsList(context),
                  _buildJobImages(context),
                  _buildAgentReview(context,
                  ),
                ],
              ),
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
        const AppSpacing(v: 20,),
        _buildUserReviewsTile(context),
      ],
    );
  }

  Widget _buildUserReviewsTile(BuildContext context){
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
          itemBuilder: (BuildContext context, int index){
        return Column(
          children: <Widget>[
            Padding(
              padding: AppPaddings.mA,
              child: _buildUserReviewCard(context),
            ),
            const Divider(height: 1,),
          ],
        );
      },
      ),
    );
  }

  Widget _buildUserReviewCard(BuildContext context){
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
            const AppSpacing(h: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text('Efya Adepa'),
                AppRatingsIcon(ratings: 4),
              ],
            )
          ],
        ),
        const AppSpacing(v:10,),
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
              Text('4.7',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),),
              AppRatingsIcon(ratings: 5),
            ],
          ),
          const Text('(223) Reviews'),
        ],
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
          child: Wrap(
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
      ],
    );
  }
}
