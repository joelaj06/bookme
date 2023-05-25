import 'package:bookme/features/bookme/presentation/bookings/getx/bookings_controller.dart';
import 'package:get/get.dart';

class BookingBindings extends Bindings{
  @override
  void dependencies() {
    Get.put<BookingsController>(BookingsController());
  }

}