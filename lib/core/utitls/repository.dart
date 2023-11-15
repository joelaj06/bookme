import 'dart:async';

import 'package:dartz/dartz.dart';

import '../errors/app_exceptions.dart';
import '../errors/failure.dart';
import 'app_log.dart';

abstract class Repository {



  Future<Either<Failure, T>> makeRequest<T>(
      Future<T> request, {
        Duration? duration,
        Future<T> Function()? onTimeOut,
      }) async {
    try {
      final T response = await request.timeout(
          duration ?? const Duration(seconds: 30), onTimeout: () async {
        if (onTimeOut != null) {
          return onTimeOut();
        }

        throw TimeoutException(null, duration);
      });
      return right(response);
    } on FetchDataException catch (exception) {
      return left(Failure(
          message: exception.message));
    } on TimeoutException catch (_) {

      return left(Failure(message: 'Request Timeout'));
    } on AppException catch (exception) {
      return left(Failure(
          message: exception.message));
    } catch (error, stackTrace) {
      AppLog.e(error, stackTrace);
      return left(
         Failure(message: 'Something went wrong technically.'),
      );
    }
  }

  Future<Either<Failure, T>> makeLocalRequest<T>(
      Future<T?> Function() request) async {
    try {
      final T? response = await request();
      if (response != null) {
        return right(response);
      } else {
        throw CacheException( 'Couldn\'t find cached data.','');
      }
    } on CacheException catch (exception) {
      return left(
        Failure(
          message: exception.message,
        ),
      );
    } catch (error, stackTrace) {
      AppLog.e(
        error.toString(),
        stackTrace,
      );
      return left(
         Failure(message: 'Something went wrong locally.'),
      );
    }
  }

}
