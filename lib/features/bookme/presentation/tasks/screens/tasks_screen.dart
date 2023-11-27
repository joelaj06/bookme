import 'package:bookme/core/presentation/widgets/app_loading_box.dart';
import 'package:bookme/core/utitls/date_formatter.dart';
import 'package:bookme/features/bookme/data/models/response/booking/booking_model.dart';
import 'package:bookme/features/bookme/presentation/tasks/getx/tasks_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../core/presentation/theme/hint_color.dart';
import '../../../../../core/presentation/theme/primary_color.dart';
import '../../../../../core/presentation/utitls/app_assets.dart';
import '../../../../../core/presentation/utitls/app_padding.dart';
import '../../../../../core/presentation/utitls/app_spacing.dart';
import '../../../../../core/presentation/widgets/app_custom_listview.dart';
import '../../../../../core/presentation/widgets/exception_indicators/empty_list_indicator.dart';
import '../../../../../core/presentation/widgets/exception_indicators/error_indicator.dart';

class TasksScreen extends GetView<TasksController> {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: Obx(
        () => AppLoadingBox(
          loading: controller.isLoading.value,
          child: Padding(
            padding: AppPaddings.mA,
            child: Column(
              children: <Widget>[
                _buildTabHeader(context),
                Expanded(
                  child: _buildPageView(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageView(BuildContext context) {
    return PageView(
      controller: controller.pageController,
      onPageChanged: controller.onPageChanged,
      children: <Widget>[
        _buildPendingContainer(context),
        _buildCompletedContainer(context)
      ],
    );
  }

  Widget _buildCompletedContainer(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Obx(
      () => AppCustomListView<Booking>(
        items: controller.bookings,
        optionalEmptyListChecker: controller.isBookingStatusEmpty('completed'),
        onRefresh: () => controller.getBookings(),
        errorIndicatorBuilder: ErrorIndicator(
          error: controller.error.value,
          onTryAgain: () => controller.getBookings(),
        ),
        failure: controller.error.value,
        itemBuilder: (BuildContext context, int index) {
          final bool isPending = controller.bookings[index].status == 'pending';
          if (isPending) {
            return const SizedBox.shrink();
          }
          return _buildTaskCard(index, width, context,
              controller.bookings[index], isPending, false);
        },
        emptyListIndicatorBuilder: const EmptyListIndicator(),
      ),
    );
  }

  Widget _buildPendingContainer(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Obx(
      () => AppCustomListView<Booking>(
        items: controller.bookings,
        optionalEmptyListChecker: controller.isBookingStatusEmpty('pending'),
        onRefresh: () => controller.getBookings(),
        errorIndicatorBuilder: ErrorIndicator(
          error: controller.error.value,
          onTryAgain: () => controller.getBookings(),
        ),
        failure: controller.error.value,
        itemBuilder: (BuildContext context, int index) {
          final bool isPending = controller.bookings[index].status == 'pending';
          final bool isCanceled =
              controller.bookings[index].status == 'canceled';
          if (isPending || isCanceled) {
            return _buildTaskCard(index, width, context,
                controller.bookings[index], isPending, isCanceled);
          }
          return const SizedBox.shrink();
        },
        emptyListIndicatorBuilder: const EmptyListIndicator(),
      ),
    );
  }

  Padding _buildTaskCard(int index, double width, BuildContext context,
      Booking booking, bool isPending, bool isCanceled) {
    final String image = booking.service?.coverImage ?? '';
    final String note = booking.notes ?? '';
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
                        ? Image.asset('assets/images/no_image.png')
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
                        '${booking.user!.firstName} ${booking.user?.lastName}',
                        style: context.textTheme.bodyMedium?.copyWith(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        note.isEmpty ? booking.service!.title ?? '' : note,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        child: Text(
                          DataFormatter.getLocalCurrencyFormatter(context)
                              .format(booking.preliminaryCost ?? 0.0),
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: PrimaryColor.color),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              DataFormatter.formatDate(booking.endDate ?? ''),
                            ),
                            Icon(
                              isPending
                                  ? Icons.pending_actions_outlined
                                  : isCanceled
                                      ? Icons.cancel
                                      : Ionicons.checkmark_circle,
                              color: isPending
                                  ? const Color(0xffbb8833)
                                  : isCanceled
                                      ? Colors.red
                                      : Colors.green,
                            )
                          ],
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
                  text: 'Pending',
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
                  text: 'Completed',
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
