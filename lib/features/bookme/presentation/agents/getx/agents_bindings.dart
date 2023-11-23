import 'package:bookme/features/bookme/domain/usecases/agent/fetch_agents.dart';
import 'package:bookme/features/bookme/presentation/agents/getx/agents_controller.dart';
import 'package:get/get.dart';

class AgentsBindings extends Bindings{
  @override
  void dependencies() {
    Get.put<AgentsController>(
      AgentsController(fetchAgents: FetchAgents(
        bookmeRepository: Get.find(),
      ))
    );
  }

}