import 'package:bookme/core/presentation/widgets/app_snacks.dart';
import 'package:bookme/features/bookme/data/models/response/review/review_model.dart';
import 'package:bookme/features/bookme/domain/usecases/service/fetch_service_by_user.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/presentation/routes/app_routes.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../../authentication/data/models/response/user/user_model.dart';
import '../../../data/models/response/review/agent_rating_model.dart';
import '../../../data/models/response/service/service_model.dart';
import '../../../domain/usecases/review/fetch_agent_review.dart';
import '../../services/arguments/service_arguments.dart';

class ServiceAgentProfileController extends GetxController {
  ServiceAgentProfileController({
    required this.fetchAgentReview,
    required this.fetchServiceByUser,
  });

  final FetchAgentReview fetchAgentReview;
  final FetchServiceByUser fetchServiceByUser;

  //reactive variables
  Rx<AgentRating> agentReview = AgentRating.empty().obs;
  Rx<User> agent = User.empty().obs;
  RxList<Review> reviews = <Review>[].obs;
  RxList<String> skills = <String>[].obs;
  Rx<Service> service = Service.empty().obs;


  void navigateToServiceDetailsScreen() async {
    await Get.toNamed<dynamic>(AppRoutes.serviceDetails,
        arguments: ServiceArgument(service.value));
  }

  void getServiceByAgent(String agentId) async {
    final Either<Failure, Service> failureOrService = await fetchServiceByUser(
      PageParams(
        page: 0,
        size: 0,
        agentId: agentId,
      ),
    );
    failureOrService.fold(
      (Failure failure) {
        AppSnacks.showError(
            'Failed', 'Failed to load agent service, restart app');
      },
      (Service serv) {
        service(serv);
      },
    );
  }

  void getAgentReviews(String agentId, String? userId) async {
    final Either<Failure, AgentRating> failureOrReview = await fetchAgentReview(
        PageParams(page: 0, size: 0, agentId: agentId, userId: userId));
    failureOrReview.fold(
      (Failure failure) {},
      (AgentRating rating) {
        agentReview(rating);
        skills(rating.agent?.skills);
        reviews(rating.reviews);
        agent(rating.agent);
      },
    );
  }
}
