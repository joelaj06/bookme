import 'package:bookme/core/presentation/routes/app_routes.dart';
import 'package:bookme/features/bookme/presentation/base/screen/base_screen.dart';
import 'package:bookme/features/bookme/presentation/bookings/getx/bookings_bindings.dart';
import 'package:bookme/features/bookme/presentation/bookings/screens/bookings_screen.dart';
import 'package:bookme/features/bookme/presentation/home/getx/home_bindings.dart';
import 'package:bookme/features/bookme/presentation/more/screens/more_screen.dart';
import 'package:bookme/features/bookme/presentation/promotions/screens/promotions_screen.dart';
import 'package:bookme/features/bookme/presentation/services/getx/services_bindings.dart';
import 'package:bookme/features/bookme/presentation/services/screens/service_details_screen.dart';
import 'package:bookme/features/bookme/presentation/services/screens/services_screen.dart';
import 'package:get/get.dart';

import '../../../features/bookme/presentation/home/screens/home_screen.dart';

class Pages {
  static final List<GetPage<AppRoutes>> pages = <GetPage<AppRoutes>>[
    GetPage<AppRoutes>(
      name: AppRoutes.base,
      page: () => const BaseScreen(),
      bindings: <Bindings>[
        ServicesBindings(),
      ]
    ),
    GetPage<AppRoutes>(
        name: AppRoutes.home,
        page: () => const HomeScreen(),
        binding: HomeBindings()),
    GetPage<AppRoutes>(
        name: AppRoutes.services,
        page: () => const ServicesScreen(),
        binding: ServicesBindings()),
    GetPage<AppRoutes>(
        name: AppRoutes.bookings,
        page: () => const BookingsScreen(),
        binding: BookingBindings()),
    GetPage<AppRoutes>(
      name: AppRoutes.more,
      page: () => const MoreScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.promotions,
      page: () => const PromotionsScreen(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.serviceDetails,
      page: () => const ServiceDetailsScreen(),
      binding: ServicesBindings(),
    ),
  ];
}
