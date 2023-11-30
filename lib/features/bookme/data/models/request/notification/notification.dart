// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';


part 'notification.freezed.dart';
part 'notification.g.dart';

@freezed
class FCMNotification with _$FCMNotification {
  const factory FCMNotification({
    required String route,
  }) = _FCMNotification;

  const FCMNotification._();

  factory FCMNotification.fromJson(Map<String, dynamic> json) =>
      _$FCMNotificationFromJson(json);


}
