import 'package:bookme/core/presentation/routes/app_routes.dart';
import 'package:bookme/core/usecase/usecase.dart';
import 'package:bookme/features/bookme/data/models/response/category/category_model.dart';
import 'package:bookme/features/bookme/data/models/response/review/review_model.dart';
import 'package:bookme/features/bookme/domain/usecases/category/fetch_categories.dart';
import 'package:bookme/features/bookme/domain/usecases/service/fetch_popular_services.dart';
import 'package:bookme/features/bookme/domain/usecases/service/fetch_promoted_services.dart';
import 'package:bookme/features/bookme/presentation/services/arguments/service_arguments.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../core/errors/failure.dart';
import '../../../data/models/response/listpage/listpage.dart';
import '../../../data/models/response/service/service_model.dart';

class HomeController extends GetxController {
  HomeController({
    required this.fetchCategories,
    required this.fetchPopularServices,
    required this.fetchPromotedServices,
  });

  final FetchCategories fetchCategories;
  final FetchPopularServices fetchPopularServices;
  final FetchPromotedServices fetchPromotedServices;

  //reactive variables
  final RxInt selectedCategory = 0.obs;
  final RxList<Category> categories = <Category>[].obs;
  final RxList<Review> popularServices = <Review>[].obs;
  final RxList<Service> promotedServices = <Service>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool isPromotedServicesLoading = true.obs;

  @override
  void onInit() {
    getAllCategories();
    getAllPopularServices();
    getPromotedServices();
    super.onInit();
  }

  void getPromotedServices() async {
    isPromotedServicesLoading(true);
    final Either<Failure, ListPage<Service>> failureOrServices =
        await fetchPromotedServices(const PageParams(
      page: 1,
      size: 5,
    ));
    failureOrServices.fold(
      (Failure failure) {
        isPromotedServicesLoading(false);
        debugPrint(failure.message);
      },
      (ListPage<Service> newPage) {
        isPromotedServicesLoading(false);
        final List<Service> newItems = newPage.itemList;
        promotedServices(newItems);
      },
    );
  }

  void getAllPopularServices() async {
    isLoading(true);
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

  void navigateToServiceDetailsScreenReview(Review review) async {
    final Service service =  Service(
      id: review.serviceData!.id,
      title: review.serviceData!.title,
      description: review.serviceData!.description,
      location: review.serviceData!.location,
      user: review.agentData,
      categories: [],
    );

    await Get.toNamed<dynamic>(AppRoutes.serviceDetails,
        arguments: ServiceArgument(service));
  }

  void navigateToServiceDetailsScreen(Service service) async {
    await Get.toNamed<dynamic>(AppRoutes.serviceDetails,
        arguments: ServiceArgument(service));
  }

  void navigateToPromotionsPage() async {
    await Get.toNamed<dynamic>(AppRoutes.promotions);
  }

  void navigateToServicesPage() async {
    await Get.toNamed<dynamic>(AppRoutes.services);
  }
}
