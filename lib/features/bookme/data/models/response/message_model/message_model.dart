// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
class Message with _$Message {
  const factory Message({
    @JsonKey(name: '_id') required String id,
    required String sender,
    required String recipient,
    required String content,

  }) = _Message;

  const Message._();

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  factory Message.empty() => const Message(
      id: '', sender: '', recipient: '', content: '',
  );
}
