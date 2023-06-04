import 'package:bookme/features/bookme/presentation/favorites/getx/favorites_controller.dart';
import 'package:get/get.dart';

class FavoritesBindings extends Bindings{
  @override
  void dependencies() {
     Get.put<FavoritesController>(FavoritesController(),);
  }

}