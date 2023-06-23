// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_model.freezed.dart';
part 'chat_model.g.dart';

@freezed
class Chat with _$Chat {
  const factory Chat({
    required String user,
  }) = _Chat;

  const Chat._();

  factory Chat.fromJson(Map<String, dynamic> json) =>
      _$ChatFromJson(json);

  factory Chat.empty() => const Chat(
    user: '',
  );
}
