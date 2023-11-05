// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_content_model.freezed.dart';
part 'message_content_model.g.dart';

@freezed
class MessageContent with _$MessageContent {
  const factory MessageContent({
    @JsonKey(name: 'message_text') required String text,
  }) = _MessageContent;

  const MessageContent._();

  factory MessageContent.fromJson(Map<String, dynamic> json) =>
      _$MessageContentFromJson(json);

  factory MessageContent.empty() => const MessageContent(
     text: ''
  );
}
