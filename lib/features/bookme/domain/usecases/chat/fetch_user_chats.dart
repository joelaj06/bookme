import 'package:bookme/core/errors/failure.dart';
import 'package:bookme/core/usecase/usecase.dart';
import 'package:bookme/features/bookme/data/models/response/chat/chat_model.dart';
import 'package:bookme/features/bookme/data/models/response/listpage/listpage.dart';
import 'package:bookme/features/bookme/data/repository/bookme_repository.dart';
import 'package:dartz/dartz.dart';

class FetchUserChats implements UseCase<ListPage<Chat>, NoParams>{
  FetchUserChats({required this.bookmeRepository});

  final BookmeRepository bookmeRepository;

  @override
  Future<Either<Failure, ListPage<Chat>>> call(NoParams params) {
    return bookmeRepository.fetchUserChats();
  }

}