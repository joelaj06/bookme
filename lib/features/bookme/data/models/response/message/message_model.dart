// ignore_for_file: invalid_annotation_target

import 'package:bookme/features/bookme/data/models/response/message/message_content_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../authentication/data/models/response/user/user_model.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
class Message with _$Message {
  const factory Message({
   @JsonKey(name: '_id') required String id,
    @JsonKey(name: 'recipient')required User? receiver,
    String? chat,
    String? createdAt,
    String? updatedAt,
    String? type,
    String? status,
    @JsonKey(name: 'content')required  MessageContent message,
  }) = _Message;

  const Message._();

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  factory Message.empty() =>  Message(
     id: '',
    receiver: User.empty(),
    message: MessageContent.empty(),

  );
}
