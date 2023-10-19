import 'package:bookme/features/authentication/data/domain/usecase/user/fetch_user.dart';
import 'package:bookme/features/authentication/data/domain/usecase/user/update_user.dart';
import 'package:bookme/features/bookme/presentation/user_profile/getx/user_profile_controller.dart';
import 'package:get/get.dart';

class UserProfileBindings extends Bindings{
  @override
  void dependencies() {
   Get.put<UserProfileController>(UserProfileController(
     fetchUser: FetchUser(Get.find()),
     updateUser: UpdateUser(Get.find()),
   ));
  }

}