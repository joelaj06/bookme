// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'initiate_chat_model.freezed.dart';
part 'initiate_chat_model.g.dart';

@freezed
class InitiateChat with _$InitiateChat {
  const factory InitiateChat({
    required bool isNew,
    required String message,
    @JsonKey(name: 'chat_room_id') required String chatRoomId,
  }) = _InitiateChat;

  const InitiateChat._();

  factory InitiateChat.fromJson(Map<String, dynamic> json) =>
      _$InitiateChatFromJson(json);

  factory InitiateChat.empty() => const InitiateChat(
    isNew: false,
    message: '',
    chatRoomId: '',
  );
}
