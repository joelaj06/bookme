import 'package:bookme/core/errors/failure.dart';
import 'package:bookme/core/usecase/usecase.dart';
import 'package:bookme/features/bookme/data/models/request/message/message_request.dart';
import 'package:bookme/features/bookme/data/models/response/message/message_model.dart';
import 'package:bookme/features/bookme/data/repository/bookme_repository.dart';
import 'package:dartz/dartz.dart';

class PostMessage implements UseCase<Message, MessageRequest> {
  PostMessage({required this.bookmeRepository});

  final BookmeRepository bookmeRepository;

  @override
  Future<Either<Failure, Message>> call(MessageRequest request) {
    return bookmeRepository.sendMessage(
      chatId: request.chatId!,
      recipient: request.recipient,
      message: request.message,
      notification : request.notification
    );
  }
}
