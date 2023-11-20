import 'package:bookme/features/authentication/data/domain/usecase/signup.dart';
import 'package:bookme/features/authentication/presentation/signup/getx/signup_controller.dart';
import 'package:bookme/features/bookme/domain/usecases/service/add_service.dart';
import 'package:get/get.dart';

class SignUpBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<SignUpController>(
      SignUpController(
        userSignUp: UserSignUp(
          authRepository: Get.find(),
        ), addService: AddService(
        bookmeRepository: Get.find(),
      ),
      ),
    );
  }
}
