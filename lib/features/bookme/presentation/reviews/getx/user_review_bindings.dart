import 'package:bookme/features/bookme/domain/usecases/review/fetch_agent_review.dart';
import 'package:bookme/features/bookme/presentation/reviews/getx/user_review_controller.dart';
import 'package:get/get.dart';

class UserReviewBindings extends Bindings{
  @override
  void dependencies() {
    Get.put<UserReviewController>(
      UserReviewController(
          fetchAgentReview: FetchAgentReview(
            bookmeRepository: Get.find(),
          ),),
    );
  }

}