import 'package:bookme/features/bookme/domain/usecases/service/fetch_promoted_services.dart';
import 'package:bookme/features/bookme/presentation/services/arguments/service_arguments.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/presentation/routes/app_routes.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../data/models/response/listpage/listpage.dart';
import '../../../data/models/response/service/service_model.dart';

class PromotionsController extends GetxController{
  PromotionsController({required this.fetchPromotedServices});
  final FetchPromotedServices fetchPromotedServices;

  final Rx<TextEditingController> searchQueryTextEditingController =
      TextEditingController().obs;
  RxString query = ''.obs;


  // Paging controller
  final PagingController<int, Service> promotedServicesPagingController =
  PagingController<int, Service>(firstPageKey: 1);

  @override
  void onInit() {
    promotedServicesPagingController.addPageRequestListener((int pageKey) {
      getAllPromotedServices(pageKey);
    });
    super.onInit();
  }

  void getAllPromotedServices(int pageKey) async {
    final Either<Failure, ListPage<Service>> failureOrServices = await fetchPromotedServices(PageParams(
      page: pageKey,
      size: 10,
      query: query.value
    ));
    failureOrServices.fold(
          (Failure failure) {},
          (ListPage<Service> newPage) {
        final int previouslyFetchedItemsCount =
            promotedServicesPagingController.itemList?.length ?? 0;

        final bool isLastPage = newPage.isLastPage(previouslyFetchedItemsCount);
        final List<Service> newItems = newPage.itemList;
        if (isLastPage) {
          promotedServicesPagingController.appendLastPage(newItems);
        } else {
          final int nextPageKey = pageKey + 1;
          promotedServicesPagingController.appendPage(newItems, nextPageKey);
        }
      },
    );
  }

  void navigateToServiceDetailsScreen(Service service) async{
    await Get.toNamed<dynamic>(AppRoutes.serviceDetails,
        arguments: ServiceArgument(service));
  }

  void clearSearchField(){
    query('');
    searchQueryTextEditingController.value.text = '';
    promotedServicesPagingController.refresh();
  }

  void onSearchServiceQuerySubmit(String? value){
    query(value);
    searchQueryTextEditingController.value.text = value ?? '';
    promotedServicesPagingController.refresh();
  }

}