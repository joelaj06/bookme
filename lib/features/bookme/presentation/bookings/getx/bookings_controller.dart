import 'package:bookme/core/presentation/routes/app_routes.dart';
import 'package:bookme/core/presentation/utitls/app_date_picker.dart';
import 'package:bookme/core/presentation/widgets/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingsController extends GetxController {
  // reactive variables
  RxInt pageIndex = 0.obs;

  final RxList<DateTime?> dialogCalendarPickerValue = <DateTime>[
    DateTime.now().subtract(const Duration(days: 1)),
    DateTime.now(),
  ].obs;

  Rx<TextEditingController> startTimeTextEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> endTimeTextEditingController =
      TextEditingController().obs;

  //time only
  RxString startTime = ''.obs;
  RxString endTime = ''.obs;

  //time and date
  RxString startDate = ''.obs;
  RxString endDate = ''.obs;
  RxString location = ''.obs;

  PageController pageController = PageController(initialPage: 0);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void onBookingCanceled(BuildContext context) {
    AppDialog().showConfirmationDialog(
      context,
      'Cancel Booking',
      'Are you sure you want to cancel this service?',
      onTapConfirm: () {
        Navigator.pop(context);
      },
    );
  }

  void onLocationInputChanged(String value) {
    location(value);
    print(value);
  }

  void onTimeSelected(BuildContext context, bool isStartTime) async {
    TimeOfDay? time = await AppDatePicker().showTimePickerDialog(context);
    if (time == null) {
      return;
    }
    final String formattedTime = time.format(context);
    if (isStartTime) {
      startTimeTextEditingController.value.text = formattedTime;
      startTime(formattedTime);
    } else {
      endTimeTextEditingController.value.text = formattedTime;
      endTime(formattedTime);
    }
  }

  void onDateDateValueChanged(List<DateTime?>? values) {
    print(values);
  }

  void navigateToBookingDetailsScreen(int index) {
    Get.toNamed<dynamic>(
      AppRoutes.bookingDetails,
      arguments: index,
    );
  }

  void navigatePages(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void onPageChanged(int index) {
    pageIndex(index);
  }
}
