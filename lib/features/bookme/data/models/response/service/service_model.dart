// ignore_for_file: invalid_annotation_target

import 'package:bookme/features/bookme/data/models/response/category/category_model.dart';
import 'package:bookme/features/bookme/data/models/response/discount/discount_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../authentication/data/models/response/user/user_model.dart';

part 'service_model.freezed.dart';
part 'service_model.g.dart';

@freezed
class Service with _$Service {
  const factory Service({
    @JsonKey(name: 'is_special_offer') bool? isSpecialOffer,
    @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'cover_image') String? coverImage,
    String? location,
    User? user,
    @JsonKey(name: 'user_data') User? userData,
    required List<Category>? categories,
    List<String>? images,
    required String description,
    required String title,
    Discount? discount,
    double? price,
    String? createdAt,
  }) = _Service;

  const Service._();

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);

  factory Service.empty() => const Service(
    id: '',
    title: '',
    categories: <Category>[],
    description: '',
  );
}
