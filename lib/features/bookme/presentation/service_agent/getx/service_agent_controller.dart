import 'package:bookme/features/bookme/data/models/response/review/review_model.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../../authentication/data/models/response/user/user_model.dart';
import '../../../data/models/response/review/agent_rating_model.dart';
import '../../../domain/usecases/review/fetch_agent_review.dart';

class ServiceAgentController extends GetxController{
  ServiceAgentController({required this.fetchAgentReview,});

  FetchAgentReview fetchAgentReview;


  //reactive variables
  Rx<AgentRating> agentReview = AgentRating.empty().obs;
  Rx<User> agent  = User.empty().obs;
  RxList<Review> reviews = <Review>[].obs;


  RxList<String> skills = <String>[].obs;


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