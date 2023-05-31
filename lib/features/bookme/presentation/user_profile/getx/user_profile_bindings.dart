import 'package:bookme/features/bookme/presentation/user_profile/getx/user_profile_controller.dart';
import 'package:get/get.dart';

class UserProfileBindings extends Bindings{
  @override
  void dependencies() {
   Get.put<UserProfileController>(UserProfileController());
  }

}