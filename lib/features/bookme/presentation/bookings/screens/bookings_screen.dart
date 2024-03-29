import 'package:bookme/core/presentation/theme/hint_color.dart';
import 'package:bookme/core/presentation/theme/primary_color.dart';
import 'package:bookme/core/presentation/utitls/app_assets.dart';
import 'package:bookme/core/presentation/utitls/app_padding.dart';
import 'package:bookme/core/presentation/utitls/app_spacing.dart';
import 'package:bookme/core/presentation/widgets/app_custom_listview.dart';
import 'package:bookme/core/presentation/widgets/app_loading_box.dart';
import 'package:bookme/core/presentation/widgets/exception_indicators/auth_navigation.dart';
import 'package:bookme/core/presentation/widgets/exception_indicators/empty_list_indicator.dart';
import 'package:bookme/core/presentation/widgets/exception_indicators/error_indicator.dart';
import 'package:bookme/core/utitls/date_formatter.dart';
import 'package:bookme/features/bookme/presentation/bookings/getx/bookings_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../authentication/data/models/response/user/user_model.dart';
import '../../../data/models/response/booking/booking_model.dart';

class BookingsScreen extends GetView<BookingsController> {
  const BookingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookings'),
      ),
      body: AuthNavigation(
        future: controller.isAuthenticated,
        child: _buildBookingPage(context),
      ),
    );
  }

  Padding _buildBookingPage(BuildContext context) {
    return Padding(
      padding: AppPaddings.mA,
      child: Column(
        children: <Widget>[
          _buildTabHeader(context),
          Expanded(
            child: FutureBuilder<User?>(
                future: controller.getUser(),
                builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
                  final User user = snapshot.data ?? User.empty();
                  if(user.id.isNotEmpty){
                  controller.getBookings(user.id);
                }
                  return _buildPageView(context, user.id);
                }),
          ),
        ],
      ),
    );
  }

  Widget _buildPageView(BuildContext context, String userId) {
    return Obx(
      () => AppLoadingBox(
        loading: controller.isLoading.value,
        child: PageView(
          controller: controller.pageController,
          onPageChanged: controller.onPageChanged,
          children: <Widget>[
            _buildUpcomingBookingsContainer(
                userId, context, 'pending', 'Fri 30th June, 2023'),
            _buildBookingHistoryContainer(
                userId, context, 'completed', 'Sun 28th May, 2023')
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingBookingsContainer(
    String userId,
    BuildContext context,
    String status,
    String date,
  ) {
    final double width = MediaQuery.of(context).size.width;
    return Obx(
      () => AppCustomListView<Booking>(
        items: controller.bookings,
        onRefresh: () => controller.getBookings(userId),
        errorIndicatorBuilder: ErrorIndicator(
          error: controller.error.value,
          onTryAgain: () => controller.getBookings(userId),
        ),
        failure: controller.error.value,
        itemBuilder: (BuildContext context, int index) {
          final BookingStatus status =
              convertToBookingStatus(controller.bookings[index].status!);
          if (controller.bookings[index].status == BookingStatus.pending.name ||
              controller.bookings[index].status == 'requested') {
            return _buildBookingsCard(
                index, controller.bookings[index], width, context, status);
          }
          return const SizedBox.shrink();
        },
        emptyListIndicatorBuilder: const EmptyListIndicator(),
      ),
    );
  }

  Widget _buildBookingHistoryContainer(
    String userId,
    BuildContext context,
    String status,
    String date,
  ) {
    final double width = MediaQuery.of(context).size.width;
    return Obx(
      () => AppCustomListView<Booking>(
        items: controller.bookings,
        onRefresh: () => controller.getBookings(userId),
        errorIndicatorBuilder: ErrorIndicator(
          error: controller.error.value,
          onTryAgain: () => controller.getBookings(userId),
        ),
        failure: controller.error.value,
        itemBuilder: (BuildContext context, int index) {
          final BookingStatus status =
              convertToBookingStatus(controller.bookings[index].status!);

          if (status == BookingStatus.completed ||
              status == BookingStatus.canceled) {
            return _buildBookingsCard(
              index,
              controller.bookings[index],
              width,
              context,
              convertToBookingStatus(controller.bookings[index].status!),
            );
          }
          return const SizedBox.shrink();
        },
        emptyListIndicatorBuilder: const EmptyListIndicator(),
      ),
    );
  }

  Padding _buildBookingsCard(int index, Booking booking, double width,
      BuildContext context, BookingStatus status) {
    final String image = booking.agent?.image ?? '';
    return Padding(
      padding: AppPaddings.mA,
      child: GestureDetector(
        onTap: () {
          controller.navigateToBookingDetailsScreen(booking);
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
                    child: image.isEmpty
                        ? Image.asset(AppImageAssets.blankProfilePicture)
                        : CachedNetworkImage(
                            imageUrl: image,
                            placeholder: (BuildContext context, String url) =>
                                Image.asset(AppImageAssets.blankProfilePicture),
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
                        '${booking.agent?.firstName ?? ''} ${booking.agent?.lastName ?? ''}',
                        style: context.textTheme.bodyMedium?.copyWith(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Text(booking.service!.title ?? ''),
                      Expanded(
                        child: SizedBox(
                          child: Text(
                            'Ghc ${booking.preliminaryCost ?? '0.0'}',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: PrimaryColor.color),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            DataFormatter.dateToString(booking.endDate ?? ''),
                          ),
                          Icon(
                            status == BookingStatus.pending
                                ? Icons.pending_actions_outlined
                                : status == BookingStatus.requested
                                    ? IconlyBroken.more_circle
                                    : status == BookingStatus.canceled
                                        ? Icons.cancel
                                        : Ionicons.checkmark_circle,
                            color: status == BookingStatus.pending
                                ? const Color(0xffbb8833)
                                : status == BookingStatus.requested
                                    ? Colors.blue
                                    : status == BookingStatus.canceled
                                        ? Colors.red
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
