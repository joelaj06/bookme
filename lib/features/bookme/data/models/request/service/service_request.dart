// ignore_for_file: invalid_annotation_target

import 'package:bookme/features/bookme/data/models/response/discount/discount_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'service_request.freezed.dart';
part 'service_request.g.dart';

@freezed
class ServiceRequest with _$ServiceRequest {
  const factory ServiceRequest({
    @JsonKey(name: 'is_special_offer') bool? isSpecialOffer,
    @JsonKey(name: '_id') required String? id,
    @JsonKey(name: 'cover_image') String? coverImage,
    String? location,
    required List<String>? categories,
    List<String>? images,
    required String? description,
    required String? title,
    Discount? discount,
    double? price,
    String? createdAt,
  }) = _ServiceRequest;

  const ServiceRequest._();

  factory ServiceRequest.fromJson(Map<String, dynamic> json) =>
      _$ServiceRequestFromJson(json);


}
