// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../authentication/data/models/response/user/user_model.dart';
import '../service/service_model.dart';

part 'review_model.freezed.dart';
part 'review_model.g.dart';

@freezed
class Review with _$Review {
  const factory Review({
    @JsonKey(name: '_id') required String id,
    User? user,
    User? agent,
    Service? service,
    @JsonKey(name: 'service_data')  Service? serviceData,
    @JsonKey(name: 'user_data')  User? userData,
    @JsonKey(name: 'agent_data')  User? agentData,
    required String comment,
    required double rating,
    double? price,
    String? createdAt,
    String? updatedAt,
  }) = _Review;

  const Review._();

  factory Review.fromJson(Map<String, dynamic> json) =>
      _$ReviewFromJson(json);

  factory Review.empty() =>  const Review(
    id: '',
    comment: '',
    rating:0,
  );
}
