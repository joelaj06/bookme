import 'package:bookme/features/bookme/presentation/service_agent/getx/service_agent_controller.dart';
import 'package:get/get.dart';

class ServiceAgentBindings extends Bindings{
  @override
  void dependencies() {
    Get.put<ServiceAgentController>(ServiceAgentController(),);
  }

}