import 'package:bookme/features/bookme/domain/usecases/service/fetch_promoted_services.dart';
import 'package:bookme/features/bookme/presentation/promotions/getx/promotions_controller.dart';
import 'package:get/get.dart';

class PromotionBindings extends Bindings{
  @override
  void dependencies() {
    Get.put<PromotionsController>(PromotionsController(fetchPromotedServices: FetchPromotedServices(
      bookmeRepository: Get.find(),
    )));
  }

}