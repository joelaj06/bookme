// ignore_for_file: invalid_annotation_target

import 'package:bookme/features/authentication/data/models/response/user/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_model.freezed.dart';
part 'chat_model.g.dart';

@freezed
class Chat with _$Chat {
  const factory Chat({
  @JsonKey(name: '_id') required String id,
    required User user,
    User? initiator,
    @JsonKey(name: 'last_message') String? lastMessage,
    String? createdAt,
    String? updatedAt,
  }) = _Chat;

  const Chat._();

  factory Chat.fromJson(Map<String, dynamic> json) =>
      _$ChatFromJson(json);

  factory Chat.empty() =>  Chat(
    id: '',
    user: User.empty(),
  );
}
