import 'package:bookme/core/errors/failure.dart';
import 'package:bookme/core/usecase/usecase.dart';
import 'package:bookme/features/bookme/data/models/request/chat/chat_request.dart';
import 'package:bookme/features/bookme/data/models/response/chat/initiate_chat_model.dart';
import 'package:bookme/features/bookme/data/repository/bookme_repository.dart';
import 'package:dartz/dartz.dart';

class InitiateNewChat implements UseCase<InitiateChat,ChatRequest>{
  InitiateNewChat({required this.bookmeRepository});

  final BookmeRepository bookmeRepository;
  @override
  Future<Either<Failure, InitiateChat>> call(ChatRequest request) {
    return bookmeRepository.initiateChat(chatRequest: request);
  }

}