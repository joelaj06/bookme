import 'package:bookme/features/authentication/data/datasource/auth_local_data_source.dart';
import 'package:bookme/features/authentication/data/models/response/login/login_response.dart';
import 'package:bookme/features/bookme/domain/usecases/review/fetch_agent_review.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/usecase/usecase.dart';
import '../../../data/models/response/review/agent_rating_model.dart';
import '../../../data/models/response/review/review_model.dart';

class UserReviewController extends GetxController{
  UserReviewController({
    required this.fetchAgentReview,
});
  final FetchAgentReview fetchAgentReview;

  //reactive variables
  Rx<AgentRating> agentRating = AgentRating.empty().obs;
  RxList<Review> reviews = <Review>[].obs;
  RxBool isLoading = false.obs;


  final AuthLocalDataSource _authLocalDataSource = Get.find();


  @override
  void onInit() {
    checkAgent();
    super.onInit();
  }

  // check if user is an agent before fetching review
  Future<void> checkAgent() async{
    final LoginResponse? response = await _authLocalDataSource.getAuthResponse();
    if(response!= null && response.user.isAgent){
      await getAgentReviews(response.user.id, null);
    }
  }
  Future<void> getAgentReviews(String agentId, String? userId) async {
    isLoading(true);
    final Either<Failure, AgentRating> failureOrReview = await fetchAgentReview(
        PageParams(page: 0, size: 0, agentId: agentId, userId: userId));
    failureOrReview.fold(
          (Failure failure) {
            isLoading(false);
          },
          (AgentRating rating) {
            isLoading(false);
        agentRating(rating);
        reviews(rating.reviews);
      },
    );
  }

}