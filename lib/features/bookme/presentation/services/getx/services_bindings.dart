import 'package:bookme/features/bookme/presentation/services/getx/services_controller.dart';
import 'package:get/get.dart';

class ServicesBindings extends Bindings{
  @override
  void dependencies() {
   Get.put<ServicesController>(ServicesController());
  }

}