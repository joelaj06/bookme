// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

@freezed
class Category with _$Category {
  const factory Category({
   @JsonKey(name: '_id') required String id,
    required String name,
    required String description,
  }) = _Category;

  const Category._();

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  factory Category.empty() => const Category(
    id: '',
    name: 'All',
    description: ''
  );
}
