import 'package:bookme/core/errors/failure.dart';
import 'package:bookme/core/usecase/usecase.dart';
import 'package:bookme/features/bookme/data/models/response/review/agent_rating_model.dart';
import 'package:bookme/features/bookme/data/repository/bookme_repository.dart';
import 'package:dartz/dartz.dart';


class FetchAgentReview implements UseCase<AgentRating,PageParams>{
  FetchAgentReview({required this.bookmeRepository});

  final BookmeRepository bookmeRepository;
  @override
  Future<Either<Failure, AgentRating>> call(PageParams params) {
    return bookmeRepository.fetchAgentReviews(agentId: params.agentId!, userId: params.userId);
  }

}