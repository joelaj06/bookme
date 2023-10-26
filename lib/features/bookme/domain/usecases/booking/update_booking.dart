import 'package:bookme/core/errors/failure.dart';
import 'package:bookme/core/usecase/usecase.dart';
import 'package:bookme/features/bookme/data/models/request/booking/booking_request.dart';
import 'package:bookme/features/bookme/data/repository/bookme_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../data/models/response/booking/booking_model.dart';

class UpdateBooking implements UseCase<Booking, BookingRequest>{
  UpdateBooking({required this.bookmeRepository});

  final BookmeRepository bookmeRepository;
  @override
  Future<Either<Failure, Booking>> call(BookingRequest request) {
   return bookmeRepository.updateBooking(bookingId: request.id!,
       bookingRequest: request,
   );
  }

}