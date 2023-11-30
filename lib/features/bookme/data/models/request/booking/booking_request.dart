// ignore_for_file: invalid_annotation_target

import 'package:bookme/features/bookme/data/models/request/notification/notification.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'booking_request.freezed.dart';
part 'booking_request.g.dart';

@freezed
class BookingRequest with _$BookingRequest {
  const factory BookingRequest({
    @JsonKey(name: '_id') required String? id,
     String? user,
     String? agent,
     String? service,
    @JsonKey(name: 'start_date')String? startDate,
    @JsonKey(name: 'end_date')String? endDate,
    String? location,
    @JsonKey(name: 'preliminary_cost') double? preliminaryCost,
    String? notes,
    String? status,
    @JsonKey(name: 'agent_id')String? agentId,
    @JsonKey(name: 'user_id') String? userId,
    @JsonKey(name: 'fcm_notification') FCMNotification? notification,
  }) = _BookingRequest;

  const BookingRequest._();

  factory BookingRequest.fromJson(Map<String, dynamic> json) =>
      _$BookingRequestFromJson(json);


}
