import 'package:bookme/core/errors/failure.dart';
import 'package:bookme/core/usecase/usecase.dart';
import 'package:bookme/features/bookme/data/models/response/listpage/listpage.dart';

import 'package:bookme/features/bookme/data/repository/bookme_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../data/models/response/message/message_model.dart';

class FetchMessages implements UseCase<ListPage<Message>, PageParams>{
  FetchMessages({required this.bookmeRepository});

  final BookmeRepository bookmeRepository;

  @override
  Future<Either<Failure, ListPage<Message>>> call(PageParams params) {
    return bookmeRepository.fetchMessages(chatId: params.chatId!);
  }

}