import 'package:bookme/features/bookme/presentation/tasks/getx/tasks_controller.dart';
import 'package:get/get.dart';

class TasksBindings extends Bindings{
  @override
  void dependencies() {
   Get.put<TasksController>(TasksController());
  }

}