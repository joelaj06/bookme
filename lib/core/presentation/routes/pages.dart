import 'package:bookme/core/presentation/routes/app_routes.dart';
import 'package:bookme/features/bookme/presentation/favorites/getx/favorites_bindings.dart';
import 'package:bookme/features/bookme/presentation/favorites/screens/favorite_screen.dart';
import 'package:bookme/features/bookme/presentation/service_agent/getx/service_agent_bindings.dart';
import 'package:bookme/features/bookme/presentation/tasks/getx/tasks_bindings.dart';
import 'package:bookme/features/bookme/presentation/tasks/screens/tasks_screen.dart';
import 'package:bookme/features/bookme/presentation/user_profile/getx/user_profile_bindings.dart';
import 'package:bookme/features/bookme/presentation/user_profile/screens/user_profile_screen.dart';
import 'package:get/get.dart';
import '../../../features/bookme/presentation/presentation.dart';


class Pages {
  static final List<GetPage<AppRoutes>> pages = <GetPage<AppRoutes>>[
    GetPage<AppRoutes>(
      name: AppRoutes.base,
      page: () => const BaseScreen(),
      bindings: <Bindings>[
        ServicesBindings(),
        BookingBindings(),
        UserProfileBindings(),
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
      binding: PromotionBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.serviceDetails,
      page: () => const ServiceDetailsScreen(),
      binding: ServicesBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.bookingDetails,
      page: () => const BookingDetailsScreen(),
      binding: BookingBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.serviceAgent,
      page: () => const ServiceAgentScreen(),
      binding: ServiceAgentBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.favorites,
      page: () => const FavoriteScreen(),
      binding: FavoritesBindings(),
    ),GetPage<AppRoutes>(
      name: AppRoutes.userProfile,
      page: () => const UserProfileScreen(),
      binding: UserProfileBindings(),
    ),GetPage<AppRoutes>(
      name: AppRoutes.tasks,
      page: () => const TasksScreen(),
      binding: TasksBindings(),
    ),
  ];
}
