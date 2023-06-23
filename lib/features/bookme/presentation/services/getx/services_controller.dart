import 'package:bookme/core/errors/failure.dart';
import 'package:bookme/core/presentation/routes/app_routes.dart';
import 'package:bookme/core/usecase/usecase.dart';
import 'package:bookme/features/bookme/data/models/response/listpage/listpage.dart';
import 'package:bookme/features/bookme/data/models/response/service/service_model.dart';
import 'package:bookme/features/bookme/domain/usecases/service/fetch_services.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ServicesController extends GetxController {
  ServicesController({
    required this.fetchServices,
  });

  FetchServices fetchServices;

  //reactive variables
  final RxInt selectedCategory = 0.obs;
  final List<String> categories = <String>[
    'All',
    'Beauty and Personal Care',
    'Home Services',
    'Event Services',
    'Health and Wellness',
    'Tutoring and Education',
    'Automotive Services',
    'Pet Services',
    'Fitness and Sports',
    'Travel and Transportation',
    'Fashion and Clothing',
  ];
  final Rx<TextEditingController> searchQueryTextEditingController =
      TextEditingController().obs;
  final RxString query = ''.obs;
  final String company = 'Hermeland Studios';
  final String description = 'Book for all your creative photos, videos and '
      'studio shoots. I do door to door service. I do '
      'Birthday parties, engagements, funerals, picnics';
  final RxInt imageIndex = 0.obs;
  final RxBool isLoading= false.obs;


  // Paging controller
  final PagingController<int, Service> pagingController =
  PagingController<int, Service>(firstPageKey: 1);

  @override
  void onInit() {
    pagingController.addPageRequestListener((int pageKey) {
      print('paging controller called');
      getAllServices(pageKey);
    });

   // getAllServices(1);

    super.onInit();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  void getAllServices(int pageKey) async {
    final Either<Failure, ListPage<Service>> failureOrServices =
        await fetchServices(const PageParams(
      page: 1,
      size: 10,
    ));
    failureOrServices.fold(
      (Failure failure) {},
      (ListPage<Service> newPage) {
        final int previouslyFetchedItemsCount =
            pagingController.itemList?.length ?? 0;

        final bool isLastPage = newPage.isLastPage(previouslyFetchedItemsCount);
        final List<Service> newItems = newPage.itemList;

        if (isLastPage) {
          pagingController.appendLastPage(newItems);

        } else {
          final int nextPageKey = pageKey + 1;
          pagingController.appendPage(newItems, nextPageKey);

        }

      },
    );
  }

  void navigateToServiceAgentScreen() async {
    await Get.toNamed<dynamic>(AppRoutes.serviceAgent);
  }

  void onOtherImagesSelected(int index) {
    imageIndex(index);
  }

  void navigateToServiceDetailsScreen(int index) async {
    await Get.toNamed<dynamic>(AppRoutes.serviceDetails, arguments: index);
  }

  void clearSearchField() {
    query('');
    searchQueryTextEditingController.value.text = '';
  }

  void onSearchServiceQueryChange(String? value) {
    query(value);
    searchQueryTextEditingController.value.text = value ?? '';
  }
}
