import 'package:bookme/features/bookme/domain/usecases/category/fetch_categories.dart';
import 'package:get/get.dart';

import 'home_controller.dart';
class HomeBindings extends Bindings{
  @override
  void dependencies() {
    Get.put<HomeController>(HomeController(
        fetchCategories: FetchCategories(
          bookmeRepository: Get.find(),
        )),
    );
  }

}