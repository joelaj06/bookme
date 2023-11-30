import 'package:bookme/core/presentation/theme/primary_color.dart';
import 'package:bookme/core/presentation/utitls/app_padding.dart';
import 'package:bookme/core/presentation/utitls/app_spacing.dart';
import 'package:bookme/core/presentation/widgets/app_loading_box.dart';
import 'package:bookme/core/presentation/widgets/app_text_input_field.dart';
import 'package:bookme/core/utitls/date_formatter.dart';
import 'package:bookme/features/bookme/presentation/bookings/args/booking_arguments.dart';
import 'package:bookme/features/bookme/presentation/bookings/getx/bookings_controller.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../core/presentation/routes/app_routes.dart';
import '../../../../../core/presentation/theme/hint_color.dart';
import '../../../../../core/presentation/widgets/app_button.dart';
import '../../../../authentication/data/models/response/user/user_model.dart';

class BookingDetailsScreen extends GetView<BookingsController> {
  const BookingDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BookingArgument? args =
        ModalRoute.of(context)?.settings.arguments as BookingArgument?;

    if (args != null) {
      controller.bookingId = args.booking.id;

      final List<DateTime> dates = <DateTime>[];
      dates.add(DateTime.parse(args.booking.startDate ??
          DateTime.now().subtract(const Duration(days: 1)).toString()));
      dates.add(
          DateTime.parse(args.booking.endDate ?? DateTime.now().toString()));
      controller.dialogCalendarPickerValue(dates);

      controller.startDate(args.booking.startDate.toString());
      controller.endDate(args.booking.endDate.toString());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
      ),
      bottomNavigationBar:
          (args?.booking.status == BookingStatus.canceled.name ||
                  args?.booking.status == BookingStatus.completed.name)
              ? const SizedBox.shrink()
              : _buildBottomNavigationItems(context),
      body: Obx(
        () => AppLoadingBox(
          loading: controller.isLoading.value,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: AppPaddings.mA,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Date',
                        style: context.textTheme.headline6?.copyWith(
                          // fontSize: 30,
                          color: HintColor.color.shade800,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          controller.dialogCalendarPickerValue(
                              controller.initialDates);
                        },
                        child: const Text(
                          'Clear',
                        ),
                      )
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          offset: Offset(3, 3),
                          spreadRadius: -8,
                          blurRadius: 10,
                          color: Color.fromRGBO(137, 137, 137, 1),
                        )
                      ],
                    ),
                    child: Obx(
                      () => CalendarDatePicker2(
                        config: CalendarDatePicker2Config(
                          calendarType: CalendarDatePicker2Type.range,
                        ),
                        value: controller.dialogCalendarPickerValue,
                        onValueChanged: controller.onDateDateValueChanged,
                      ),
                    ),
                  ),
                  const AppSpacing(
                    v: 10,
                  ),
                  AppTextInputField(
                    labelText: 'Location',
                    initialValue: args?.booking.location,
                    readOnly: true,
                    onChanged: controller.onLocationInputChanged,
                  ),
                  const AppSpacing(
                    v: 10,
                  ),
                  if (Get.previousRoute == AppRoutes.tasks)
                    _buildUserInfo(args?.booking.user ?? User.empty(), context)
                  else
                    _buildUserInfo(
                        args?.booking.agent ?? User.empty(), context),
                  const AppSpacing(
                    v: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Preliminary Cost',
                        style: context.textTheme.bodySmall?.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.fill,
                        child: Text(
                          DataFormatter.getLocalCurrencyFormatter(context)
                              .format(args?.booking.preliminaryCost ?? 0.0),
                          style: context.textTheme.bodyLarge?.copyWith(
                            fontSize: 16,
                            color: PrimaryColor.color,
                            //fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const AppSpacing(
                    v: 10,
                  ),
                  Text('Job Description: ${args?.booking.notes ?? ''}')
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row _buildUserInfo(User user, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(
              Ionicons.person_circle_outline,
              size: 40,
            ),
            const AppSpacing(
              h: 10,
            ),
            Text(
              '${user.firstName} ${user.lastName}',
              style: context.textTheme.bodyLarge?.copyWith(
                fontSize: 20,
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: PrimaryColor.color,
                  borderRadius: BorderRadius.circular(15)),
              child: IconButton(
                onPressed: () {
                  controller.navigateToChatMessageScreen(user);
                },
                icon: const Icon(
                  Ionicons.chatbox_ellipses_outline,
                  color: Colors.white,
                  //  size: 30,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildBottomNavigationItems(BuildContext context) {
    return Container(
      height: 60,
      padding: AppPaddings.mR,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: AppButton(
              onPressed: () {
                controller.updateTheBooking(BookingStatus.pending);
              },
              text: 'Reschedule',
              fontSize: 16,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.red,
                radius: 25,
                child: IconButton(
                  onPressed: () {
                    controller.onBookingCanceled(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
              const AppSpacing(
                h: 10,
              ),
              if (Get.previousRoute == AppRoutes.tasks)
                const SizedBox.shrink()
              else
                CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 25,
                  child: IconButton(
                    onPressed: () {
                      //  controller.onBookingCanceled(context);
                    },
                    icon: const Icon(
                      Icons.task_alt,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
