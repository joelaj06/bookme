// ignore_for_file: invalid_annotation_target

import 'package:bookme/features/bookme/data/models/response/message/message_content_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_request.freezed.dart';
part 'message_request.g.dart';

@freezed
class MessageRequest with _$MessageRequest {
  const factory MessageRequest({
    String? chatId,
    required String recipient,
    String? senderId,
    required MessageContent message,
    bool? isRead,
    String? date,
  }) = _MessageRequest;

  const MessageRequest._();

  factory MessageRequest.fromJson(Map<String, dynamic> json) =>
      _$MessageRequestFromJson(json);

}
