// ignore_for_file: invalid_annotation_target

import 'package:bookme/features/bookme/data/models/response/review/review_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../authentication/data/models/response/user/user_model.dart';


part 'agent_rating_model.freezed.dart';
part 'agent_rating_model.g.dart';

@freezed
class AgentRating with _$AgentRating {
  const factory AgentRating({
  required List<Review> reviews,
    @JsonKey(name: 'average_rating') required double averageRating,
    User? agent,
  }) = _AgentRating;

  const AgentRating._();

  factory AgentRating.fromJson(Map<String, dynamic> json) =>
      _$AgentRatingFromJson(json);

  factory AgentRating.empty() =>  const AgentRating(
    reviews: <Review>[],
    averageRating: 0,
  );
}
