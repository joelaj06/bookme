import 'package:bookme/core/errors/failure.dart';
import 'package:bookme/core/presentation/routes/app_routes.dart';
import 'package:bookme/core/presentation/widgets/app_snacks.dart';
import 'package:bookme/core/usecase/usecase.dart';
import 'package:bookme/features/authentication/data/datasource/auth_local_data_source.dart';
import 'package:bookme/features/authentication/data/models/response/login/login_response.dart';
import 'package:bookme/features/bookme/data/models/request/favorite/add_favorite_request.dart';
import 'package:bookme/features/bookme/data/models/response/favorite/favorite_model.dart';
import 'package:bookme/features/bookme/data/models/response/listpage/listpage.dart';
import 'package:bookme/features/bookme/data/models/response/service/service_model.dart';
import 'package:bookme/features/bookme/domain/usecases/service/fetch_services.dart';
import 'package:bookme/features/bookme/domain/usecases/service/fetch_services_by_category.dart';
import 'package:bookme/features/bookme/presentation/home/getx/home_controller.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../domain/usecases/favorite/add_favorite.dart';
import '../arguments/service_arguments.dart';

class ServicesController extends GetxController {
  ServicesController({
    required this.fetchServices,
    required this.fetchServicesByCategory,
    required this.addFavorite,
  });

  FetchServices fetchServices;
  FetchServicesByCategory fetchServicesByCategory;
  AddFavorite addFavorite;

  //reactive variables
  final RxInt selectedCategory = 0.obs;

  final Rx<TextEditingController> searchQueryTextEditingController =
      TextEditingController().obs;
  final RxString query = ''.obs;
  final RxInt imageIndex = 0.obs;
  final RxBool isLoading = false.obs;
  final RxString categoryId = ''.obs;
  final RxList<Service> services = <Service>[].obs;

  // Home controller
  final HomeController homeController = Get.find();
  final AuthLocalDataSource _authLocalDataSource = Get.find();

  // Paging controller
  final PagingController<int, Service> pagingController =
      PagingController<int, Service>(firstPageKey: 1);

  @override
  void onInit() {
    pagingController.addPageRequestListener((int pageKey) {
      getAllServices(pageKey);
    });
    super.onInit();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  void navigateToChatsScreen(){
    Get.toNamed<dynamic>(AppRoutes.chats);
  }

  void checkAuth(String serviceId) async {
    final LoginResponse? response =
        await _authLocalDataSource.getAuthResponse();
    if (response != null) {
      addToFavorites(serviceId, response.user.id);
    } else {
      await Get.toNamed<dynamic>(AppRoutes.login);
    }
  }

  void addToFavorites(String serviceId, String userId) async {
    isLoading(true);
    final AddFavoriteRequest addFavoriteRequest = AddFavoriteRequest(
      user: userId,
      service: serviceId,
      userId: userId,
    );
    final Either<Failure, Favorite> failureOrFavorite =
        await addFavorite(addFavoriteRequest);
    failureOrFavorite.fold(
      (Failure failure) {
        isLoading(false);
        AppSnacks.showError('Service', failure.message);
      },
      (Favorite favorite) {
        isLoading(false);
        AppSnacks.showSuccess(
            'Service', 'Service successfully added to favorites');
      },
    );
  }

  void onCategorySelected(String catId, int index) {
    selectedCategory(index);
    categoryId(catId);
    pagingController.refresh();
  }

  void getAllServices(int pageKey) async {
    final Either<Failure, ListPage<Service>> failureOrServices = categoryId
            .value.isEmpty
        ? await fetchServices(PageParams(
            page: pageKey,
            size: 10,
            query: query.value,
          ))
        : await fetchServicesByCategory(
            PageParams(page: pageKey, size: 10, categoryId: categoryId.value));
    failureOrServices.fold(
      (Failure failure) {
        pagingController.error = failure;
      },
      (ListPage<Service> newPage) {
        final int previouslyFetchedItemsCount =
            pagingController.itemList?.length ?? 0;

        final bool isLastPage = newPage.isLastPage(previouslyFetchedItemsCount);
        final List<Service> newItems = newPage.itemList;
        services(newItems);
        if (isLastPage) {
          pagingController.appendLastPage(newItems);
        } else {
          final int nextPageKey = pageKey + 1;
          pagingController.appendPage(newItems, nextPageKey);
        }
      },
    );
  }

  void navigateToServiceAgentScreen(Service service) async {
    await Get.toNamed<dynamic>(AppRoutes.serviceAgent,
        arguments: ServiceArgument(service));
  }

  void onOtherImagesSelected(int index) {
    imageIndex(index);
  }

  void navigateToServiceDetailsScreen(Service service) async {
    await Get.toNamed<dynamic>(AppRoutes.serviceDetails,
        arguments: ServiceArgument(service));
  }

  void clearSearchField() {
    query('');
    searchQueryTextEditingController.value.text = '';
    pagingController.refresh();
  }

  void onSearchServiceQuerySubmit(String? value) {
    query(value);
    pagingController.refresh();
  }
}
