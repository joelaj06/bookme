
import 'package:bookme/core/usecase/usecase.dart';
import 'package:bookme/features/bookme/data/models/response/category/category_model.dart';
import 'package:bookme/features/bookme/data/models/response/service/service_model.dart';
import 'package:bookme/features/bookme/domain/usecases/agent/fetch_agents.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/presentation/routes/app_routes.dart';
import '../../../../authentication/data/models/response/user/user_model.dart';
import '../../../data/models/response/listpage/listpage.dart';
import '../../services/arguments/service_arguments.dart';

class AgentsController extends GetxController {
  AgentsController({
    required this.fetchAgents,
  });

  final FetchAgents fetchAgents;

  //reactive variables
  final RxBool isLoading = false.obs;
  final RxList<User> agents = <User>[].obs;
  final Rx<Failure> error = Failure.empty().obs;
  final RxString query = ''.obs;
  final Rx<TextEditingController> searchQueryTextEditingController =
      TextEditingController().obs;

  // Paging controller
  final PagingController<int, User> pagingController =
      PagingController<int, User>(firstPageKey: 1);

  @override
  void onInit() {
    pagingController.addPageRequestListener((int pageKey) {
      getAgents(pageKey);
    });
    super.onInit();
  }

  @override
  void onClose() {
    pagingController.dispose();
    searchQueryTextEditingController.value.dispose();
    super.onClose();
  }

  void navigateToServiceAgentScreen(User user) async {
    final Service service = Service(
        user: user,
        id: '',
        categories: <Category>[],
        description: '',
        title: '',
    );
    await Get.toNamed<dynamic>(AppRoutes.serviceAgent,
        arguments: ServiceArgument(service));
  }

  void getAgents(int pageKey) async {
    isLoading(true);
    final Either<Failure, ListPage<User>> failureOrUsers =
        await fetchAgents(PageParams(
      page: pageKey,
      size: 20,
      query: query.value.isEmpty ? null : query.value,
    ));
    failureOrUsers.fold(
      (Failure failure) {
        isLoading(false);
        pagingController.error = failure.message;
      },
      (ListPage<User> newPage) {
        isLoading(false);
        final int previouslyFetchedItemsCount =
            pagingController.itemList?.length ?? 0;

        final bool isLastPage = newPage.isLastPage(previouslyFetchedItemsCount);
        final List<User> newItems = newPage.itemList;
        agents(newItems);
        if (isLastPage) {
          pagingController.appendLastPage(newItems);
        } else {
          final int nextPageKey = pageKey + 1;
          pagingController.appendPage(newItems, nextPageKey);
        }
      },
    );
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
