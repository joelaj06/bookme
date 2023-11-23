import 'package:bookme/features/bookme/domain/usecases/review/fetch_agent_review.dart';
import 'package:bookme/features/bookme/domain/usecases/service/fetch_service_by_user.dart';
import 'package:bookme/features/bookme/presentation/service_agent/getx/service_agent_controller.dart';
import 'package:get/get.dart';

class ServiceAgentProfileBindings extends Bindings{
  @override
  void dependencies() {
    Get.put<ServiceAgentProfileController>(ServiceAgentProfileController(
        fetchAgentReview: FetchAgentReview(
          bookmeRepository: Get.find(),
        ), fetchServiceByUser: FetchServiceByUser(
      bookmeRepository: Get.find(),
    )),);
  }

}