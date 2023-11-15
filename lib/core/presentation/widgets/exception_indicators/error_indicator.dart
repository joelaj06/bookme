import 'package:bookme/core/presentation/widgets/exception_indicators/timeout_indicator.dart';
import 'package:flutter/material.dart';

import '../../../errors/failure.dart';
import 'generic_error_indicator.dart';
import 'no_connection_indicator.dart';

class ErrorIndicator extends StatelessWidget {
  const ErrorIndicator({
    required this.error,
    this.onTryAgain,
    Key? key,
  }) : super(key: key);

  final Failure error;
  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) {
    if (error.message.contains('Internet') || error.message.contains('Connection')) {
      return NoConnectionIndicator(
        onTryAgain: onTryAgain,
      );
    } else if (error.message.contains('Timeout')) {
      return RequestTimeoutIndicator(
        onTryAgain: onTryAgain,
      );
    } else {
      return GenericErrorIndicator(
        onTryAgain: onTryAgain,
      );
    }
  }
}
