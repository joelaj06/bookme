import 'package:bookme/features/bookme/domain/usecases/booking/update_booking.dart';
import 'package:bookme/features/bookme/presentation/bookings/getx/bookings_controller.dart';
import 'package:get/get.dart';

import '../../../domain/usecases/booking/fetch_bookings.dart';

class BookingBindings extends Bindings{
  @override
  void dependencies() {
    Get.put<BookingsController>(BookingsController(fetchBookings: FetchBookings(
      bookmeRepository: Get.find(),
    ), updateBooking: UpdateBooking(
      bookmeRepository: Get.find(),
    )));
  }

}