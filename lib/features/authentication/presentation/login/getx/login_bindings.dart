import 'package:bookme/features/authentication/data/domain/usecase/login_user.dart';
import 'package:bookme/features/authentication/presentation/login/getx/login_controller.dart';
import 'package:get/get.dart';

class LoginBindings extends Bindings{
  @override
  void dependencies() {
   Get.put<LoginController>(
     LoginController(loginUser: LoginUser(
         authRepository: Get.find(),

     )),
   );
  }

}