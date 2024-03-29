import 'package:bookme/features/bookme/domain/usecases/category/fetch_categories.dart';
import 'package:bookme/features/bookme/domain/usecases/service/fetch_popular_services.dart';
import 'package:bookme/features/bookme/domain/usecases/service/fetch_promoted_services.dart';
import 'package:get/get.dart';

import 'home_controller.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        fetchCategories: FetchCategories(
          bookmeRepository: Get.find(),
        ),
        fetchPopularServices: FetchPopularServices(
          bookmeRepository: Get.find(),
        ),
        fetchPromotedServices: FetchPromotedServices(
          bookmeRepository: Get.find(),
        ),
      ),
      fenix: true
    );
  }
}
