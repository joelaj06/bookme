import 'package:bookme/core/presentation/routes/app_routes.dart';
import 'package:bookme/features/authentication/presentation/login/getx/login_bindings.dart';
import 'package:bookme/features/authentication/presentation/login/screens/login_screen.dart';
import 'package:bookme/features/bookme/presentation/chat/getx/chat_bindings.dart';
import 'package:bookme/features/bookme/presentation/chat/screens/chat_screens.dart';
import 'package:bookme/features/bookme/presentation/favorites/getx/favorites_bindings.dart';
import 'package:bookme/features/bookme/presentation/message/getx/message_bindings.dart';
import 'package:bookme/features/bookme/presentation/message/screens/message_screen.dart';
import 'package:bookme/features/bookme/presentation/reviews/getx/user_review_bindings.dart';
import 'package:bookme/features/bookme/presentation/reviews/screens/user_review_screen.dart';
import 'package:bookme/features/bookme/presentation/service_agent/getx/service_agent_bindings.dart';
import 'package:bookme/features/bookme/presentation/tasks/getx/tasks_bindings.dart';
import 'package:bookme/features/bookme/presentation/tasks/screens/tasks_screen.dart';
import 'package:bookme/features/bookme/presentation/user_profile/getx/user_profile_bindings.dart';
import 'package:bookme/features/bookme/presentation/user_profile/screens/update_job_screen.dart';
import 'package:bookme/features/bookme/presentation/user_profile/screens/user_profile_screen.dart';
import 'package:get/get.dart';

import '../../../features/bookme/presentation/favorites/screens/favorite_screen.dart';
import '../../../features/bookme/presentation/presentation.dart';
import '../../../features/bookme/presentation/user_profile/screens/update_user_screen.dart';


class Pages {
  static final List<GetPage<AppRoutes>> pages = <GetPage<AppRoutes>>[
    GetPage<AppRoutes>(
      name: AppRoutes.base,
      page: () => const BaseScreen(),
      bindings: <Bindings>[
        HomeBindings(),
        ServicesBindings(),
        BookingBindings(),
        UserProfileBindings(),
      ]
    ),
    GetPage<AppRoutes>(
        name: AppRoutes.login,
        page: () => const LoginScreen(),
        binding: LoginBindings()),
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
        binding: BookingBindings(),

    ),
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
    GetPage<AppRoutes>(
      name: AppRoutes.updateUser,
      page: () => const UpdateUserScreen(),
      binding: UserProfileBindings(),
    ),GetPage<AppRoutes>(
      name: AppRoutes.updateJob,
      page: () => const UpdateJobScreen(),
      binding: UserProfileBindings(),
    ),GetPage<AppRoutes>(
      name: AppRoutes.userReview,
      page: () => const UserReviewScreen(),
      binding: UserReviewBindings(),
    ),
    GetPage<AppRoutes>(
      name: AppRoutes.chats,
      page: () => const ChatScreen(),
      binding: ChatBindings(),
    ),  GetPage<AppRoutes>(
      name: AppRoutes.messages,
      page: () => const MessageScreen(),
      bindings:<Bindings>[ ChatBindings(),MessageBindings()],
    ),
  ];
}
