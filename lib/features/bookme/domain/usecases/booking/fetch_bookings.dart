import 'package:bookme/core/errors/failure.dart';
import 'package:bookme/core/usecase/usecase.dart';
import 'package:bookme/features/bookme/data/models/response/booking/booking_model.dart';
import 'package:bookme/features/bookme/data/repository/bookme_repository.dart';
import 'package:dartz/dartz.dart';

class FetchBookings implements UseCase<List<Booking>, PageParams>{
  FetchBookings({required this.bookmeRepository});

  final BookmeRepository bookmeRepository;

  @override
  Future<Either<Failure, List<Booking>>> call(PageParams params) {
    return bookmeRepository.fetchBookings(userId: params.userId,agentId: params.agentId);
  }
}