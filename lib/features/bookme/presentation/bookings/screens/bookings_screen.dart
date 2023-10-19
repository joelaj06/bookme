import 'package:bookme/core/presentation/theme/hint_color.dart';
import 'package:bookme/core/presentation/theme/primary_color.dart';
import 'package:bookme/core/presentation/utitls/app_padding.dart';
import 'package:bookme/core/presentation/utitls/app_spacing.dart';
import 'package:bookme/features/bookme/presentation/bookings/getx/bookings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../authentication/data/models/response/user/user_model.dart';
import '../../../data/models/response/booking/booking_model.dart';

class BookingsScreen extends GetView<BookingsController> {
  const BookingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller.isAuthenticated.value) {
      return Builder(builder: (BuildContext context) {
        controller.navigateToLogin();
        return Container();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings'),
        actions: const <Widget>[
         /* IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.filter_list,
            ),
          ),*/
        ],
      ),
      body: Padding(
        padding: AppPaddings.mA,
        child: Column(
          children: <Widget>[
            _buildTabHeader(context),
            Expanded(
              child: FutureBuilder<User?>(
                  future: controller.getUser(),
                  builder:
                      (BuildContext context, AsyncSnapshot<User?> snapshot) {
                    final User user = snapshot.data ?? User.empty();
                    controller.getBookings(user.id);
                    return _buildPageView(context, user.id);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageView(BuildContext context, String userId) {
    return PageView(
      controller: controller.pageController,
      onPageChanged: controller.onPageChanged,
      children: <Widget>[
        _buildJobHistoryContainer(
            userId, context, 'pending', 'Fri 30th June, 2023'),
        _buildJobHistoryContainer(
            userId, context, 'completed', 'Sun 28th May, 2023')
      ],
    );
  }

  Widget _buildJobHistoryContainer(
    String userId,
    BuildContext context,
    String status,
    String date,
  ) {
    final double width = MediaQuery.of(context).size.width;
    return RefreshIndicator(
      onRefresh: () {
        return controller.getBookings(userId);
      },
      child: ListView.builder(
          itemCount: controller.bookings.length,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
        // shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            final bool isPending =
                controller.bookings[index].status == 'pending';
            return _buildPendingJobCard(
                index, controller.bookings[index], width, context, isPending);
          }),
    );
  }

  Padding _buildPendingJobCard(int index, Booking booking, double width,
      BuildContext context, bool isPending) {
    return Padding(
      padding: AppPaddings.mA,
      child: GestureDetector(
        onTap: () {
          controller.navigateToBookingDetailsScreen(index);
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
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Hero(
                    tag: 'service$index',
                    child: Image.asset('assets/images/photographer.png'),
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
                        booking.agent.firstName,
                        style: context.textTheme.bodyMedium?.copyWith(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Text(booking.service.title),
                      Expanded(
                        child: SizedBox(
                          child: Text(
                            'Ghc ${booking.preliminaryCost}',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: PrimaryColor.color),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            booking.endDate ?? '',
                          ),
                          Icon(
                            isPending
                                ? Icons.pending_actions_outlined
                                : Ionicons.checkmark_circle,
                            color: isPending
                                ? const Color(0xffbb8833)
                                : Colors.green,
                          )
                        ],
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

  Container _buildTabHeader(BuildContext context) {
    return Container(
      height: 60,
      padding: AppPaddings.mA,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: HintColor.color.shade50,
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                controller.onPageChanged(0);
                controller.navigatePages(0);
              },
              child: Obx(
                () => _buildTabHeaderContent(
                  context,
                  text: 'Upcoming',
                  isActive: controller.pageIndex.value == 0,
                ),
              ),
            ),
          ),
          const AppSpacing(
            h: 10,
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                controller.onPageChanged(1);
                controller.navigatePages(1);
              },
              child: Obx(
                () => _buildTabHeaderContent(
                  context,
                  text: 'History',
                  isActive: controller.pageIndex.value == 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildTabHeaderContent(
    BuildContext context, {
    required String text,
    required bool isActive,
  }) {
    return Container(
      // width: MediaQuery.of(context).size.width / 2,
      decoration: isActive
          ? BoxDecoration(
              color: PrimaryColor.backgroundColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  offset: Offset(0, 5),
                  spreadRadius: -16,
                  blurRadius: 20,
                  color: Color.fromRGBO(0, 0, 0, 1),
                )
              ],
            )
          : null,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: isActive ? PrimaryColor.color : HintColor.color.shade300,
          ),
        ),
      ),
    );
  }
}
