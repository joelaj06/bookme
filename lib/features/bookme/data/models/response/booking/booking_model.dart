// ignore_for_file: invalid_annotation_target


import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../authentication/data/models/response/user/user_model.dart';
import '../service/service_model.dart';

part 'booking_model.freezed.dart';
part 'booking_model.g.dart';

@freezed
class Booking with _$Booking {
  const factory Booking({
    @JsonKey(name: '_id') required String id,
    required User? user,
    required User? agent,
    required Service? service,
    @JsonKey(name: 'start_date')String? startDate,
    @JsonKey(name: 'end_date')String? endDate,
    String? location,
    @JsonKey(name: 'preliminary_cost') double? preliminaryCost,
    String? notes,
    String? status,
    @JsonKey(name: 'agent_id')String? agentId,
    @JsonKey(name: 'user_id') String? userId,

  }) = _Booking;

  const Booking._();

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);

  factory Booking.empty() =>  Booking(
      id: '',
      user: User.empty(),
     agent: User.empty(),
    service: Service.empty(),
  );
}
