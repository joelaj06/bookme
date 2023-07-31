// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'discount_model.freezed.dart';
part 'discount_model.g.dart';

@freezed
class Discount with _$Discount {
  const factory Discount({
    required String type,
    required double value,
    String? title,
    @JsonKey(name: 'start_date') String? startDate,
    @JsonKey(name: 'end_date') String? endDate,
  }) = _Discount;

  const Discount._();

  factory Discount.fromJson(Map<String, dynamic> json) =>
      _$DiscountFromJson(json);

  factory Discount.empty() => const Discount(
   type: '',
    value: 0
  );
}
