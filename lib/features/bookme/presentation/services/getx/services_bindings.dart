import 'package:bookme/features/bookme/domain/usecases/favorite/add_favorite.dart';
import 'package:bookme/features/bookme/domain/usecases/service/fetch_services.dart';
import 'package:bookme/features/bookme/domain/usecases/service/fetch_services_by_category.dart';
import 'package:bookme/features/bookme/presentation/services/getx/services_controller.dart';
import 'package:get/get.dart';

class ServicesBindings extends Bindings{
  @override
  void dependencies() {
   Get.put<ServicesController>(ServicesController(
     fetchServices: FetchServices(
       bookmeRepository: Get.find(),
     ), fetchServicesByCategory: FetchServicesByCategory(
     bookmeRepository: Get.find(),
   ), addFavorite: AddFavorite(
     bookmeRepository: Get.find(),
   ),
   ));
  }

}