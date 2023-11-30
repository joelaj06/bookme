import 'package:bookme/core/errors/failure.dart';
import 'package:bookme/core/presentation/routes/app_routes.dart';
import 'package:bookme/core/presentation/widgets/app_snacks.dart';
import 'package:bookme/core/usecase/usecase.dart';
import 'package:bookme/core/utitls/shared_preferences_wrapper.dart';
import 'package:bookme/features/authentication/data/datasource/auth_local_data_source.dart';
import 'package:bookme/features/authentication/data/models/response/login/login_response.dart';
import 'package:bookme/features/bookme/data/models/request/booking/booking_request.dart';
import 'package:bookme/features/bookme/data/models/request/favorite/add_favorite_request.dart';
import 'package:bookme/features/bookme/data/models/request/notification/notification.dart';
import 'package:bookme/features/bookme/data/models/response/favorite/favorite_model.dart';
import 'package:bookme/features/bookme/data/models/response/listpage/listpage.dart';
import 'package:bookme/features/bookme/data/models/response/service/service_model.dart';
import 'package:bookme/features/bookme/domain/usecases/booking/add_booking.dart';
import 'package:bookme/features/bookme/domain/usecases/service/fetch_services.dart';
import 'package:bookme/features/bookme/domain/usecases/service/fetch_services_by_category.dart';
import 'package:bookme/features/bookme/presentation/bookings/getx/bookings_controller.dart';
import 'package:bookme/features/bookme/presentation/home/getx/home_controller.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../../authentication/data/models/response/user/user_model.dart';
import '../../../data/models/response/booking/booking_model.dart';
import '../../../domain/usecases/favorite/add_favorite.dart';
import '../arguments/service_arguments.dart';

class ServicesController extends GetxController {
  ServicesController({
    required this.fetchServices,
    required this.fetchServicesByCategory,
    required this.addFavorite,
    required this.addBooking,
  });

  FetchServices fetchServices;
  FetchServicesByCategory fetchServicesByCategory;
  AddFavorite addFavorite;
  AddBooking addBooking;

  //reactive variables
  final RxInt selectedCategory = 0.obs;

  final Rx<TextEditingController> searchQueryTextEditingController =
      TextEditingController().obs;
  final RxString query = ''.obs;
  final RxInt imageIndex = 0.obs;
  final RxBool isLoading = false.obs;
  final RxString categoryId = ''.obs;
  final RxList<Service> services = <Service>[].obs;
  final RxString startDate = ''.obs;
  final RxString endDate = ''.obs;
  final RxString location = ''.obs;
  final RxString notes = ''.obs;
  final RxList<DateTime?> dialogCalendarPickerValue = <DateTime>[
    DateTime.now(),
    DateTime.now().add(const Duration(days: 1)),
  ].obs;

  // Home controller
  final HomeController homeController = Get.find();
  final AuthLocalDataSource _authLocalDataSource = Get.find();
  final SharedPreferencesWrapper _sharedPreferencesWrapper = Get.find();

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

  //check auth before booking agent
  void bookAgent(Service service, BuildContext context) async {
    checkAuth((User user) => createBooking(service, user.id, context));
  }

  void createBooking(Service service, String user, BuildContext context) async {
    isLoading(true);

    const FCMNotification notification = FCMNotification(
      route: AppRoutes.tasks,
    );
    final BookingRequest bookingRequest = BookingRequest(
        id: null,
        service: service.id,
        user: user,
        userId: user,
        agentId: service.user?.id,
        agent: service.user?.id,
        status: BookingStatus.requested.name,
        startDate: startDate.value,
        endDate: endDate.value,
        location: location.value,
        notes: notes.value,
        notification: notification,
    );
    final Either<Failure, Booking> failureOrBooking =
        await addBooking(bookingRequest);
    failureOrBooking.fold(
      (Failure failure) {
        isLoading(false);
        AppSnacks.showError(
            'Failed', 'Sorry could not book agent. Please try again');
      },
      (Booking booking) {
        isLoading(false);
        Navigator.pop(context);
        AppSnacks.showSuccess('Success', 'Agent booked successfully');
        Get.toNamed<dynamic>(AppRoutes.bookings);
      },
    );
  }

  void navigateToChatsScreen() {
    Get.toNamed<dynamic>(AppRoutes.chats);
  }

  void checkAuth(Function(User) callback) async {
    final LoginResponse? response =
        await _authLocalDataSource.getAuthResponse();
    if (response != null) {
      callback(response.user);
    } else {
      await Get.toNamed<dynamic>(AppRoutes.login);
    }
  }

  //checks before adding to favorites
  void addToFavorites(String serviceId) {
    checkAuth((User user) => createFavorite(serviceId, user.id));
  }

  void createFavorite(String serviceId, String userId) async {
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

  void onLocationInputChanged(String? value) {
    location(value);
  }

  void onDateDateValueChanged(List<DateTime?>? values) {
    if (values!.length > 1) {
      startDate(values[0].toString().split(' ')[0]);
      endDate(values[1].toString().split(' ')[0]);
    }
  }

  void onNotesInputChanged(String? value) {
    notes(value);
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
