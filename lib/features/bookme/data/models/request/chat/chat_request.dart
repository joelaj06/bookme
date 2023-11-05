// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_request.freezed.dart';
part 'chat_request.g.dart';

@freezed
class ChatRequest with _$ChatRequest {
  const factory ChatRequest({
     required String user,
  }) = _ChatRequest;

  const ChatRequest._();

  factory ChatRequest.fromJson(Map<String, dynamic> json) =>
      _$ChatRequestFromJson(json);

}
