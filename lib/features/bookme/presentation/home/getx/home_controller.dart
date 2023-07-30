import 'package:bookme/core/presentation/routes/app_routes.dart';
import 'package:bookme/core/usecase/usecase.dart';
import 'package:bookme/features/bookme/data/models/response/category/category_model.dart';
import 'package:bookme/features/bookme/data/models/response/review/review_model.dart';
import 'package:bookme/features/bookme/domain/usecases/category/fetch_categories.dart';
import 'package:bookme/features/bookme/domain/usecases/service/fetch_popular_services.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../../../core/errors/failure.dart';

class HomeController extends GetxController {
  HomeController({
    required this.fetchCategories,
    required this.fetchPopularServices,
  });

  final FetchCategories fetchCategories;
  final FetchPopularServices fetchPopularServices;

  //reactive variables
  final RxInt selectedCategory = 0.obs;
  final RxList<Category> categories = <Category>[].obs;
  final RxList<Review> popularServices = <Review>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    getAllCategories();
    getAllPopularServices();
    super.onInit();
  }

  void getAllPopularServices() async {
    final Either<Failure, List<Review>> failureOrPopularServices =
        await fetchPopularServices(NoParams());
    failureOrPopularServices.fold(
      (Failure failure) {
        isLoading(false);
      },
      (List<Review> services) {
        isLoading(false);
        popularServices(services);
      },
    );
  }

  void getAllCategories() async {
    final Either<Failure, List<Category>> failureOrCategories =
        await fetchCategories(NoParams());
    failureOrCategories.fold(
      (Failure failure) {},
      (List<Category> cats) {
        categories(cats);
        categories.insert(0, Category.empty());
      },
    );
  }

  void navigateToServiceDetailsScreen(int index) async {
    await Get.toNamed<dynamic>(AppRoutes.serviceDetails, arguments: index);
  }

  void navigateToPromotionsPage() async {
    await Get.toNamed<dynamic>(AppRoutes.promotions);
  }

  void navigateToServicesPage() async {
    await Get.toNamed<dynamic>(AppRoutes.services);
  }
}
