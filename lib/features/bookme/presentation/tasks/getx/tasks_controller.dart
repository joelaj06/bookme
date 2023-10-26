import 'package:bookme/features/bookme/presentation/user_profile/getx/user_profile_controller.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/presentation/routes/app_routes.dart';
import '../../../../../core/presentation/widgets/app_snacks.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../data/models/response/booking/booking_model.dart';
import '../../../domain/usecases/booking/fetch_bookings.dart';

class TasksController extends GetxController{
  TasksController({required this.fetchBookings});

  final FetchBookings fetchBookings;

  RxInt pageIndex = 0.obs;
  RxBool isLoading= false.obs;
  RxList<Booking> bookings = <Booking>[].obs;
  PageController pageController = PageController(initialPage: 0);
  final UserProfileController _userProfileController = Get.find();

  @override
  void onInit() {
    getBookings();
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }



  Future<void> getBookings() async {
    isLoading(true);
    final Either<Failure, List<Booking>> failureOrBookings =
    await fetchBookings( PageParams(
      page: 0,
      size: 0,
      agentId:  _userProfileController.user.value.id,
      userId: null,
    ));
    failureOrBookings.fold(
          (Failure failure) {
        AppSnacks.showError('Bookings', 'Failed to load bookings');
        isLoading(false);
      },
          (List<Booking> allBookings) {
        isLoading(false);
        bookings(allBookings);
      },
    );
  }

  bool isBookingStatusEmpty(String status){
    final List<Booking> bookingList = bookings.where((Booking booking) =>
    booking.status == status).toList();
    if(bookingList.isEmpty){
      return true;
    }
    return false;
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