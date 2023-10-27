import 'package:bookme/features/bookme/domain/usecases/favorite/delete_favorite.dart';
import 'package:bookme/features/bookme/domain/usecases/favorite/fetch_favorite.dart';
import 'package:bookme/features/bookme/presentation/favorites/getx/favorites_controller.dart';
import 'package:get/get.dart';

class FavoritesBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<FavoritesController>(
      FavoritesController(
          fetchFavorites: FetchFavorites(
            bookmeRepository: Get.find(),
          ),
          deleteFavorite: DeleteFavorite(
            bookmeRepository: Get.find(),
          )),
    );
  }
}
