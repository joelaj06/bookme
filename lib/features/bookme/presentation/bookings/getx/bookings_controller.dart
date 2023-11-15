import 'package:bookme/core/presentation/routes/app_routes.dart';
import 'package:bookme/core/presentation/utitls/app_date_picker.dart';
import 'package:bookme/core/presentation/widgets/app_dialog.dart';
import 'package:bookme/core/presentation/widgets/app_snacks.dart';
import 'package:bookme/core/usecase/usecase.dart';
import 'package:bookme/features/authentication/data/models/response/user/user_model.dart';
import 'package:bookme/features/bookme/data/models/request/booking/booking_request.dart';
import 'package:bookme/features/bookme/data/models/response/booking/booking_model.dart';
import 'package:bookme/features/bookme/domain/usecases/booking/fetch_bookings.dart';
import 'package:bookme/features/bookme/domain/usecases/booking/update_booking.dart';
import 'package:bookme/features/bookme/presentation/bookings/args/booking_arguments.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../authentication/data/datasource/auth_local_data_source.dart';
import '../../../../authentication/data/models/response/login/login_response.dart';

class BookingsController extends GetxController {
  BookingsController({
    required this.fetchBookings,
    required this.updateBooking,
  });

  final FetchBookings fetchBookings;
  final UpdateBooking updateBooking;

  // reactive variables
  RxInt pageIndex = 0.obs;

  final RxList<DateTime?> dialogCalendarPickerValue = <DateTime>[
    DateTime.now().subtract(const Duration(days: 1)),
    DateTime.now(),
  ].obs;

  final List<DateTime?> initialDates = <DateTime>[
    DateTime.now().subtract(const Duration(days: 1)),
    DateTime.now(),
  ];

  Rx<TextEditingController> startTimeTextEditingController =
      TextEditingController().obs;
  Rx<TextEditingController> endTimeTextEditingController =
      TextEditingController().obs;
  RxBool isLoading = false.obs;
  RxList<Booking> bookings = <Booking>[].obs;

  //time only
  RxString startTime = ''.obs;
  RxString endTime = ''.obs;

  //time and date
  RxString startDate = ''.obs;
  RxString endDate = ''.obs;
  RxString location = ''.obs;
  Rx<User> user = User.empty().obs;
  Rx<Failure> error = Failure.empty().obs;


  late String bookingId;

  //paging controller
  final PagingController<int, Booking> pagingController =
      PagingController<int, Booking>(firstPageKey: 1);

  PageController pageController = PageController(initialPage: 0);
  final AuthLocalDataSource _authLocalDataSource = Get.find();

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  Future<bool> get isAuthenticated async =>
      _authLocalDataSource.isAuthenticated();

  void updateTheBooking(BookingStatus status) async {
    final String startingDate = '${startDate.value}T$startTime';
    final String endingDate = '${endDate.value}T$endTime';
    final BookingRequest bookingRequest = BookingRequest(
      id: bookingId,
      endDate: endingDate,
      startDate: startingDate,
      status: status.name,
    );
    isLoading(true);

    final Either<Failure, Booking> failureOrBooking =
        await updateBooking(bookingRequest);
    failureOrBooking.fold(
      (Failure failure) {
        isLoading(false);
        //todo handle failure
      },
      (Booking booking) {
        isLoading(false);
        Get.back<dynamic>(result: booking);

      },
    );
  }

  Future<User?> getUser() async {
    final LoginResponse? response = _authLocalDataSource.authResponse ??
        await _authLocalDataSource.getAuthResponse();
    return response?.user;
  }

  Future<void> getBookings(String userId) async {
    error(Failure.empty());
    isLoading(true);
    final Either<Failure, List<Booking>> failureOrBookings =
        await fetchBookings(PageParams(
      page: 0,
      size: 0,
      agentId: null,
      userId: userId,
    ));
    failureOrBookings.fold(
      (Failure failure) {
        error(failure);
        AppSnacks.showError('Bookings', 'Failed to load bookings');
        isLoading(false);
      },
      (List<Booking> allBookings) {
        isLoading(false);
        bookings(allBookings);
      },
    );
  }

  void navigateToLogin() {
    Get.toNamed<dynamic>(AppRoutes.login);
  }

  void onBookingCanceled(BuildContext context) {
    AppDialog().showConfirmationDialog(
      context,
      'Cancel Booking',
      'Are you sure you want to cancel this service?',
      onTapConfirm: () {
        Navigator.pop(context);
        updateTheBooking(BookingStatus.canceled);
      },
    );
  }

  void onLocationInputChanged(String value) {
    location(value);
  }

  void onTimeSelected(BuildContext context, bool isStartTime) async {
    final TimeOfDay? time = await AppDatePicker().showTimePickerDialog(context);
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
    if(values!.length > 1){
     startDate(values[0].toString().split(' ')[0]);
     endDate(values[1].toString().split(' ')[0]);
    }
  }

  void navigateToBookingDetailsScreen(Booking booking) {
    Get.toNamed<dynamic>(
      AppRoutes.bookingDetails,
      arguments: BookingArgument(booking),
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

enum BookingStatus {
  completed,
  pending,
  canceled,
}
