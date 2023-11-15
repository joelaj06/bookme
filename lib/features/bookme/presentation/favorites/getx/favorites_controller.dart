import 'package:bookme/core/presentation/widgets/app_snacks.dart';
import 'package:bookme/features/bookme/data/models/response/favorite/favorite_model.dart';
import 'package:bookme/features/bookme/domain/usecases/favorite/delete_favorite.dart';
import 'package:bookme/features/bookme/domain/usecases/favorite/fetch_favorite.dart';
import 'package:bookme/features/bookme/presentation/user_profile/getx/user_profile_controller.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/presentation/routes/app_routes.dart';
import '../../../data/models/response/service/service_model.dart';
import '../../services/arguments/service_arguments.dart';

class FavoritesController extends GetxController{

  FavoritesController({
    required this.fetchFavorites,
    required this.deleteFavorite,
});
  final DeleteFavorite deleteFavorite;
  final FetchFavorites fetchFavorites;

  // reactive variables
  RxBool isLoading = false.obs;
  RxList<Favorite> favorites = <Favorite>[].obs;
  Rx<Failure> error = Failure.empty().obs;


  final UserProfileController userProfileController = Get.find();


  @override
  void onInit() {
    getFavorites();
    super.onInit();
  }

  Future<void> getFavorites() async{
    error(Failure.empty());
    isLoading(true);
    final Either<Failure, List<Favorite>> failureOrFavorites =
        await fetchFavorites(userProfileController.user.value.id);
    failureOrFavorites.fold((Failure failure) {
      isLoading(false);
      error(failure);
      AppSnacks.showError('Favorite', failure.message);
      }, (List<Favorite> fav) {
      isLoading(false);
      favorites(fav);
    });
  }


  void deleteFav(String favoriteId) async{
    isLoading(true);
    final Either<Failure, Favorite> failureOrFav =
       await deleteFavorite(favoriteId);
    failureOrFav.fold((Failure failure) {
      isLoading(false);
      AppSnacks.showError('Favorite', failure.message);
    }, (Favorite favorite) {
      isLoading(false);
      AppSnacks.showSuccess('Favorites', 'Service removed from favorites');
    },
    );
  }


  void navigateToServiceDetailsScreen(Service service) async{
    await Get.toNamed<dynamic>(AppRoutes.serviceDetails,
        arguments:  ServiceArgument(service));
  }

}